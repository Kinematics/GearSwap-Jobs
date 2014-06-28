-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
	-- Load and initialize the include file.
	include('Mote-Include.lua')
end

-- Setup vars that are user-independent.
function job_setup()
	state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
	state.Buff['Trick Attack'] = buffactive['trick attack'] or false
	state.Buff['Feint'] = buffactive['feint'] or false

	-- TH mode handling
	options.TreasureModes = {'None','Tag','SATA','Fulltime'}
	state.TreasureMode = 'Tag'

	-- Tracking vars for TH.
	tagged_mobs = T{}
	state.th_gear_is_locked = false

	-- JA IDs for actions that always have TH: Provoke, Animated Flourish
	info.ja_ids = S{35, 204}
	-- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
	info.u_ja_ids = S{201, 202, 203, 205, 207}

	-- Register events to allow us to manage TH application.
	windower.register_event('target change', on_target_change)
	windower.raw_register_event('action', on_action)
	windower.raw_register_event('incoming chunk', on_incoming_chunk)
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	options.OffenseModes = {'Normal', 'Acc', 'Mod'} -- Mod for trivially weak mobs
	options.DefenseModes = {'Normal', 'Evasion', 'PDT'}
	options.RangedModes = {'Normal', 'Acc'}
	options.WeaponskillModes = {'Normal', 'Acc', 'Mod'}
	options.IdleModes = {'Normal'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'Evasion', 'PDT'}
	options.MagicalDefenseModes = {'MDT'}

	state.RangedMode = 'Normal'
	state.Defense.PhysicalMode = 'Evasion'

	gear.default.weaponskill_neck = "Asperity Necklace"
	gear.default.weaponskill_waist = "Caudata Belt"
	
	gear.AugQuiahuiz = {name="Quiahuiz Trousers", augments={'Haste+2','"Snapshot"+2','STR+8'}}

	-- Additional local binds
	send_command('bind ^` input /ja "Flee" <me>')
	send_command('bind ^= gs c cycle treasuremode')
	send_command('bind !- gs c cycle targetmode')

	select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function job_file_unload()
	send_command('unbind ^`')
	send_command('unbind !-')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Special sets
	--------------------------------------

	sets.TreasureHunter = {hands="Plunderer's Armlets +1", waist="Chaac Belt", feet="Raider's Poulaines +2"}
	sets.ExtraRegen = {head="Ocelomeh Headpiece +1"}
	sets.Kiting = {feet="Skadi's Jambeaux +1"}

	sets.buff['Sneak Attack'] = {ammo="Qirmiz Tathlum",
		head="Pillager's Bonnet +1",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Pillager's Vest +1",hands="Pillager's Armlets +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Patentia Sash",legs="Pillager's Culottes +1",feet="Plunderer's Poulaines +1"}

	sets.buff['Trick Attack'] = {ammo="Qirmiz Tathlum",
		head="Pillager's Bonnet +1",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Pillager's Vest +1",hands="Pillager's Armlets +1",ring1="Stormsoul Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Patentia Sash",legs="Pillager's Culottes +1",feet="Plunderer's Poulaines +1"}


	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
	sets.precast.JA['Collaborator'] = {head="Raider's Bonnet +2"}
	sets.precast.JA['Accomplice'] = {head="Raider's Bonnet +2"}
	sets.precast.JA['Flee'] = {feet="Pillager's Poulaines +1"}
	sets.precast.JA['Hide'] = {body="Pillager's Vest +1"}
	sets.precast.JA['Conspirator'] = {} -- {body="Raider's Vest +2"}
	sets.precast.JA['Steal'] = {head="Plunderer's Bonnet",hands="Pillager's Armlets +1",legs="Pillager's Culottes +1",feet="Pillager's Poulaines +1"}
	sets.precast.JA['Despoil'] = {legs="Raider's Culottes +2",feet="Raider's Poulaines +2"}
	sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +1"}
	sets.precast.JA['Feint'] = {} -- {legs="Assassin's Culottes +2"}

	sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
	sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']


	-- Waltz set (chr and vit)
	sets.precast.Waltz = {ammo="Sonia's Plectrum",
		head="Whirlpool Mask",
		body="Pillager's Vest +1",hands="Pillager's Armlets +1",ring1="Asklepian Ring",
		back="Iximulew Cape",waist="Caudata Belt",legs="Pillager's Culottes +1",feet="Plunderer's Poulaines +1"}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- TH actions (steps and flourishes don't add TH by themselves)
	sets.precast.Step = sets.TreasureHunter
	sets.precast.Flourish1 = sets.TreasureHunter
	sets.precast.JA.Provoke = sets.TreasureHunter


	-- Fast cast sets for spells

	sets.precast.FC = {head="Haruspex Hat",ear2="Loquacious Earring",hands="Thaumas Gloves",ring1="Prolix Ring",legs="Enif Cosciales"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


	-- Ranged snapshot gear
	sets.precast.RA = {head="Aurore Beret",hands="Iuitl Wristbands",legs="Nahtirah Trousers",feet="Wurrukatte Boots"}


	-- Weaponskill sets

	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Thew Bomblet",
		head="Whirlpool Mask",neck=gear.ElementalGorget,ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Pillager's Vest +1",hands="Pillager's Armlets +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Caudata Belt",legs="Manibozho Brais",feet="Iuitl Gaiters +1"}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {ammo="Honed Tathlum", back="Letalis Mantle"})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {ring1="Stormsoul Ring",legs="Nahtirah Trousers"})
	sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {ammo="Honed Tathlum", back="Letalis Mantle"})
	sets.precast.WS['Exenterator'].Mod = set_combine(sets.precast.WS['Exenterator'], {head="Felistris Mask",waist=gear.ElementalBelt})
	sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'].Mod, {ammo="Qirmiz Tathlum"})
	sets.precast.WS['Exenterator'].TA = set_combine(sets.precast.WS['Exenterator'].Mod, {ammo="Qirmiz Tathlum"})
	sets.precast.WS['Exenterator'].SATA = set_combine(sets.precast.WS['Exenterator'].Mod, {ammo="Qirmiz Tathlum"})

	sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Dancing Edge'].Acc = set_combine(sets.precast.WS['Dancing Edge'], {ammo="Honed Tathlum", back="Letalis Mantle"})
	sets.precast.WS['Dancing Edge'].Mod = set_combine(sets.precast.WS['Dancing Edge'], {waist=gear.ElementalBelt})
	sets.precast.WS['Dancing Edge'].SA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {ammo="Qirmiz Tathlum"})
	sets.precast.WS['Dancing Edge'].TA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {ammo="Qirmiz Tathlum"})
	sets.precast.WS['Dancing Edge'].SATA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {ammo="Qirmiz Tathlum"})

	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {ammo="Qirmiz Tathlum",
		head="Uk'uxkaj Cap",neck="Rancor Collar",ear1="Brutal Earring",ear2="Moonshade Earring"})
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {ammo="Honed Tathlum", back="Letalis Mantle"})
	sets.precast.WS['Evisceration'].Mod = set_combine(sets.precast.WS['Evisceration'], {back="Kayapa Cape",waist=gear.ElementalBelt})
	sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'].Mod, {})
	sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'].Mod, {})
	sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'].Mod, {})

	sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {head="Pillager's Bonnet +1",ear1="Brutal Earring",ear2="Moonshade Earring"})
	sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {ammo="Honed Tathlum", back="Letalis Mantle"})
	sets.precast.WS["Rudra's Storm"].Mod = set_combine(sets.precast.WS["Rudra's Storm"], {back="Kayapa Cape",waist=gear.ElementalBelt})
	sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {ammo="Qirmiz Tathlum",
		body="Pillager's Vest +1",legs="Pillager's Culottes +1"})
	sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {ammo="Qirmiz Tathlum",
		body="Pillager's Vest +1",legs="Pillager's Culottes +1"})
	sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {ammo="Qirmiz Tathlum",
		body="Pillager's Vest +1",legs="Pillager's Culottes +1"})

	sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {head="Pillager's Bonnet +1",ear1="Brutal Earring",ear2="Moonshade Earring"})
	sets.precast.WS['Shark Bite'].Acc = set_combine(sets.precast.WS['Shark Bite'], {ammo="Honed Tathlum", back="Letalis Mantle"})
	sets.precast.WS['Shark Bite'].Mod = set_combine(sets.precast.WS['Shark Bite'], {back="Kayapa Cape",waist=gear.ElementalBelt})
	sets.precast.WS['Shark Bite'].SA = set_combine(sets.precast.WS['Shark Bite'].Mod, {ammo="Qirmiz Tathlum",
		body="Pillager's Vest +1",legs="Pillager's Culottes +1"})
	sets.precast.WS['Shark Bite'].TA = set_combine(sets.precast.WS['Shark Bite'].Mod, {ammo="Qirmiz Tathlum",
		body="Pillager's Vest +1",legs="Pillager's Culottes +1"})
	sets.precast.WS['Shark Bite'].SATA = set_combine(sets.precast.WS['Shark Bite'].Mod, {ammo="Qirmiz Tathlum",
		body="Pillager's Vest +1",legs="Pillager's Culottes +1"})

	sets.precast.WS['Mandalic Stab'] = set_combine(sets.precast.WS, {head="Pillager's Bonnet +1",ear1="Brutal Earring",ear2="Moonshade Earring"})
	sets.precast.WS['Mandalic Stab'].Acc = set_combine(sets.precast.WS['Mandalic Stab'], {ammo="Honed Tathlum", back="Letalis Mantle"})
	sets.precast.WS['Mandalic Stab'].Mod = set_combine(sets.precast.WS['Mandalic Stab'], {back="Kayapa Cape",waist=gear.ElementalBelt})
	sets.precast.WS['Mandalic Stab'].SA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {ammo="Qirmiz Tathlum",
		body="Pillager's Vest +1",legs="Pillager's Culottes +1"})
	sets.precast.WS['Mandalic Stab'].TA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {ammo="Qirmiz Tathlum",
		body="Pillager's Vest +1",legs="Pillager's Culottes +1"})
	sets.precast.WS['Mandalic Stab'].SATA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {ammo="Qirmiz Tathlum",
		body="Pillager's Vest +1",legs="Pillager's Culottes +1"})

	sets.precast.WS['Aeolian Edge'] = {ammo="Jukukik Feather",
		head="Wayfarer Circlet",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Moonshade Earring",
		body="Wayfarer Robe",hands="Pillager's Armlets +1",ring1="Acumen Ring",ring2="Demon's Ring",
		back="Toro Cape",waist=gear.ElementalBelt,legs="Shneddick Tights +1",feet="Wayfarer Clogs"}

	sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)


	--------------------------------------
	-- Midcast sets
	--------------------------------------

	sets.midcast.FastRecast = {
		head="Whirlpool Mask",ear2="Loquacious Earring",
		body="Pillager's Vest +1",hands="Pillager's Armlets +1",
		back="Canny Cape",legs="Kaabnax Trousers",feet="Iuitl Gaiters +1"}

	-- Specific spells
	sets.midcast.Utsusemi = {
		head="Whirlpool Mask",neck="Ej Necklace",ear2="Loquacious Earring",
		body="Pillager's Vest +1",hands="Pillager's Armlets +1",ring1="Beeline Ring",
		back="Canny Cape",legs="Kaabnax Trousers",feet="Iuitl Gaiters +1"}

	-- Ranged gear
	sets.midcast.RA = {
		head="Whirlpool Mask",neck="Ej Necklace",ear1="Clearview Earring",ear2="Volley Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Hajduk Ring",
		back="Libeccio Mantle",waist="Aquiline Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters +1"}

	sets.midcast.RA.Acc = {
		head="Pillager's Bonnet +1",neck="Ej Necklace",ear1="Clearview Earring",ear2="Volley Earring",
		body="Iuitl Vest",hands="Buremte Gloves",ring1="Beeline Ring",ring2="Hajduk Ring",
		back="Libeccio Mantle",waist="Aquiline Belt",legs="Thurandaut Tights +1",feet="Pillager's Poulaines +1"}


	--------------------------------------
	-- Idle/resting/defense sets
	--------------------------------------

	-- Resting sets
	sets.resting = {head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",
		ring1="Sheltered Ring",ring2="Paguroidea Ring"}


	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

	sets.idle = {ammo="Thew Bomblet",
		head="Pillager's Bonnet +1",neck="Wiglen Gorget",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Pillager's Vest +1",hands="Pillager's Armlets +1",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Shadow Mantle",waist="Flume Belt",legs="Pillager's Culottes +1",feet="Skadi's Jambeaux +1"}

	sets.idle.Town = {main="Izhiikoh", sub="Sabebus",ammo="Thew Bomblet",
		head="Pillager's Bonnet +1",neck="Wiglen Gorget",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Pillager's Vest +1",hands="Pill. Armlets +1",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Shadow Mantle",waist="Patentia Sash",legs="Pillager's Culottes +1",feet="Skadi's Jambeaux +1"}

	sets.idle.Weak = {ammo="Thew Bomblet",
		head="Pillager's Bonnet +1",neck="Wiglen Gorget",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Pillager's Vest +1",hands="Pillager's Armlets +1",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Shadow Mantle",waist="Flume Belt",legs="Pillager's Culottes +1",feet="Skadi's Jambeaux +1"}


	-- Defense sets

	sets.defense.Evasion = {
		head="Pillager's Bonnet +1",neck="Ej Necklace",
		body="Qaaxo Harness",hands="Pillager's Armlets +1",ring1="Defending Ring",ring2="Beeline Ring",
		back="Canny Cape",waist="Flume Belt",legs="Kaabnax Trousers",feet="Iuitl Gaiters +1"}

	sets.defense.PDT = {ammo="Iron Gobbet",
		head="Pillager's Bonnet +1",neck="Twilight Torque",
		body="Iuitl Vest",hands="Pillager's Armlets +1",ring1="Defending Ring",ring2=gear.DarkRing.physical,
		back="Iximulew Cape",waist="Flume Belt",legs="Pillager's Culottes +1",feet="Iuitl Gaiters +1"}

	sets.defense.MDT = {ammo="Demonry Stone",
		head="Pillager's Bonnet +1",neck="Twilight Torque",
		body="Pillager's Vest +1",hands="Pillager's Armlets +1",ring1="Defending Ring",ring2="Shadow Ring",
		back="Engulfer Cape",waist="Flume Belt",legs="Pillager's Culottes +1",feet="Iuitl Gaiters +1"}


	--------------------------------------
	-- Melee sets
	--------------------------------------

	-- Normal melee group
	sets.engaged = {ammo="Thew Bomblet",
		head="Felistris Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Qaaxo Harness",hands="Pillager's Armlets +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Patentia Sash",legs="Pillager's Culottes +1",feet="Plunderer's Poulaines +1"}
	sets.engaged.Acc = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Ej Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Pillager's Vest +1",hands="Pillager's Armlets +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Manibozho Brais",feet="Qaaxo Leggings"}
		
	-- Mod set for trivial mobs (Skadi+1)
	sets.engaged.Mod = {ammo="Thew Bomblet",
		head="Felistris Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Skadi's Cuirie +1",hands="Pillager's Armlets +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Patentia Sash",legs=gear.AugQuiahuiz,feet="Plunderer's Poulaines +1"}

	-- Mod set for trivial mobs (Thaumas)
	sets.engaged.Mod2 = {ammo="Thew Bomblet",
		head="Felistris Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Thaumas Coat",hands="Pillager's Armlets +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Patentia Sash",legs="Pillager's Culottes +1",feet="Plunderer's Poulaines +1"}

	sets.engaged.Evasion = {ammo="Thew Bomblet",
		head="Felistris Mask",neck="Ej Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Qaaxo Harness",hands="Pillager's Armlets +1",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Canny Cape",waist="Patentia Sash",legs="Kaabnax Trousers",feet="Qaaxo Leggings"}
	sets.engaged.Acc.Evasion = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Ej Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Pillager's Vest +1",hands="Pillager's Armlets +1",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Canny Cape",waist="Hurch'lan Sash",legs="Kaabnax Trousers",feet="Qaaxo Leggings"}

	sets.engaged.PDT = {ammo="Thew Bomblet",
		head="Felistris Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Pillager's Armlets +1",ring1="Defending Ring",ring2="Epona's Ring",
		back="Iximulew Cape",waist="Patentia Sash",legs="Iuitl Tights",feet="Qaaxo Leggings"}
	sets.engaged.Acc.PDT = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Pillager's Armlets +1",ring1="Defending Ring",ring2="Epona's Ring",
		back="Canny Cape",waist="Hurch'lan Sash",legs="Iuitl Tights",feet="Qaaxo Leggings"}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
	if state.Buff[spell.english] ~= nil then
		state.Buff[spell.english] = true
	end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.english=='Sneak Attack' or spell.english=='Trick Attack' then
		if state.TreasureMode == 'SATA' or state.TreasureMode == 'Fulltime' then
			equip(sets.TreasureHunter)
		end
	end
end

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if state.TreasureMode ~= 'None' then
		if (spell.action_type == 'Ranged Attack' or spell.action_type == 'Magic') and spell.target.type == 'MONSTER' then
			equip(sets.TreasureHunter)
		end
	end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if state.Buff[spell.english] ~= nil then
		state.Buff[spell.english] = not spell.interrupted or buffactive[spell.english]
	end

	-- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
	if spell.type == 'WeaponSkill' and not spell.interrupted then
		state.Buff['Sneak Attack'] = false
		state.Buff['Trick Attack'] = false
		state.Buff['Feint'] = false
	end
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
	-- If SA/TA/Feint are active, put appropriate gear back on (including TH gear).
	check_buff('Sneak Attack')
	check_buff('Trick Attack')
	check_buff('Feint')
end


-- Refactor buff checks from aftercast
function check_buff(buff_name)
	if state.Buff[buff_name] then
		equip(sets.buff[buff_name] or {})
		if state.TreasureMode == 'SATA' or state.TreasureMode == 'Fulltime' then
			equip(sets.TreasureHunter)
		end
	end
end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks.
-------------------------------------------------------------------------------------------------------------------

function get_custom_wsmode(spell, spellMap, defaut_wsmode)
	local wsmode

	if state.Buff['Sneak Attack'] then
		wsmode = 'SA'
	end
	if state.Buff['Trick Attack'] then
		wsmode = (wsmode or '') .. 'TA'
	end

	if spell.english == 'Aeolian Edge' and state.TreasureMode ~= 'None' then
		wsmode = 'TH'
	end

	return wsmode
end

function customize_idle_set(idleSet)
	if player.hpp < 80 then
		idleSet = set_combine(idleSet, sets.ExtraRegen)
	end

	return idleSet
end

function customize_melee_set(meleeSet)
	if state.TreasureMode == 'Fulltime' then
		meleeSet = set_combine(meleeSet, sets.TreasureHunter)
	end

	return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for change events.
-------------------------------------------------------------------------------------------------------------------

-- Called if we change any user state fields.
function job_state_change(stateField, newValue, oldValue)
	if stateField == 'TreasureMode' then
		if newValue == 'None' then
			if _settings.debug_mode then add_to_chat(123,'TH Mode set to None. Unlocking gear.') end
			unlock_TH()
		elseif oldValue == 'None' then
			TH_for_first_hit()
		end
	end
end


-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if state.Buff[buff] ~= nil then
		state.Buff[buff] = gain
		handle_equipping_gear(player.status)
	end
end


-- On engaging a mob, attempt to add TH gear.  For any other status change, unlock TH gear slots.
function job_status_change(newStatus, oldStatus, eventArgs)
	if newStatus == 'Engaged' then
		if _settings.debug_mode then add_to_chat(123,'Engaging '..player.target.id..'.') end
		TH_for_first_hit()
	elseif oldStatus == 'Engaged' then
		if _settings.debug_mode and state.th_gear_is_locked then add_to_chat(123,'Disengaging. Unlocking TH.') end
		unlock_TH()
	end
end


-- On changing targets, attempt to add TH gear.
function on_target_change(target_index)
	-- Only care about changing targets while we're engaged, either manually or via current target death.
	if player.status == 'Engaged' then
		-- If current player.target.index isn't the same as the target_index parameter,
		-- that indicates that the sub-target cursor is being used.  Ignore it.
		if player.target.index == target_index then
			if _settings.debug_mode then add_to_chat(123,'Changing target to '..player.target.id..'.') end
			TH_for_first_hit()
			handle_equipping_gear(player.status)
		end
	end
end


-- Clear out the entire tagged mobs table when zoning.
function on_zone_change(new_zone, old_zone)
	if _settings.debug_mode then add_to_chat(123,'Zoning. Clearing tagged mobs table.') end
	tagged_mobs:clear()
end


-------------------------------------------------------------------------------------------------------------------
-- Various update events.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
	if player.status ~= 'Engaged' or cmdParams[1] == 'tagged' then
		unlock_TH()
	elseif player.status == 'Engaged' and cmdParams[1] == 'user' then
		TH_for_first_hit()
	end

	if _settings.debug_mode and cmdParams[1] == 'user' then
		print_set(tagged_mobs, 'Tagged mobs')
	end
end

-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
	-- Check that ranged slot is locked, if necessary
	check_range_lock()

	-- Don't allow normal gear equips if SA/TA/Feint is active.
	if state.Buff['Sneak Attack'] or state.Buff['Trick Attack'] or state.Buff['Feint'] then
		eventArgs.handled = true
	end
end


-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
	local defenseString = ''
	if state.Defense.Active then
		local defMode = state.Defense.PhysicalMode
		if state.Defense.Type == 'Magical' then
			defMode = state.Defense.MagicalMode
		end

		defenseString = 'Defense: '..state.Defense.Type..' '..defMode..'  '
	end

	add_to_chat(122,'Melee: '..state.OffenseMode..'/'..state.DefenseMode..'  WS: '..state.WeaponskillMode..'  '..
		defenseString..'Kiting: '..on_off_names[state.Kiting]..'  TH: '..state.TreasureMode)

	eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Function to lock the ranged slot if we have a ranged weapon equipped.
function check_range_lock()
	if player.equipment.range ~= 'empty' then
		disable('range', 'ammo')
	else
		enable('range', 'ammo')
	end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(2, 5)
	elseif player.sub_job == 'WAR' then
		set_macro_page(3, 5)
	elseif player.sub_job == 'NIN' then
		set_macro_page(4, 5)
	else
		set_macro_page(2, 5)
	end
end


-------------------------------------------------------------------------------------------------------------------
-- Functions and events to support TH handling.
-------------------------------------------------------------------------------------------------------------------

-- Set locked TH flag to true, and disable relevant gear slots.
function lock_TH()
	state.th_gear_is_locked = true
	for slot,item in pairs(sets.TreasureHunter) do
		disable(slot)
	end
end

-- Set locked TH flag to false, and enable relevant gear slots.
function unlock_TH()
	state.th_gear_is_locked = false
	for slot,item in pairs(sets.TreasureHunter) do
		enable(slot)
	end
end

-- For any active TH mode, if we haven't already tagged this target, equip TH gear and lock slots until we manage to hit it.
function TH_for_first_hit()
	if state.TreasureMode == 'None' then
		unlock_TH()
	elseif not tagged_mobs[player.target.id] then
		if _settings.debug_mode then add_to_chat(123,'Prepping for first hit on '..player.target.id..'.') end
		equip(sets.TreasureHunter)
		lock_TH()
	elseif state.th_gear_is_locked then
		if _settings.debug_mode then add_to_chat(123,'Prepping for first hit on '..player.target.id..'.  Target has already been tagged.') end
		unlock_TH()
	end
end


-- On any action event, mark mobs that we tag with TH.  Also, update the last time tagged mobs were acted on.
function on_action(action)
	--add_to_chat(123,'cat='..action.category..',param='..action.param)
	-- If player takes action, adjust TH tagging information
	if action.actor_id == player.id and state.TreasureMode ~= 'None' then
		-- category == 1=melee, 2=ranged, 3=weaponskill, 4=spell, 6=job ability, 14=unblinkable JA
		if state.TreasureMode == 'Fulltime' or
		   (state.TreasureMode == 'SATA' and (state.Buff['Sneak Attack'] or state.Buff['Trick Attack']) and (action.category == 1 or action.category == 3)) or
		   (state.TreasureMode == 'Tag' and action.category == 1 and state.th_gear_is_locked) or -- Tagging with a melee hit
		   (action.category == 2 or action.category == 4) or -- Any ranged or magic action
		   (action.category == 3 and action.param == 30) or -- Aeolian Edge
		   (action.category == 6 and info.ja_ids:contains(action.param)) or -- Provoke, Animated Flourish
		   (action.category == 14 and info.u_ja_ids:contains(action.param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
		   then
			for index,target in pairs(action.targets) do
				if not tagged_mobs[target.id] and _settings.debug_mode then
					add_to_chat(123,'Mob '..target.id..' hit. Adding to tagged mobs table.')
				end
				tagged_mobs[target.id] = os.time()
			end

			if state.th_gear_is_locked then
				send_command('gs c update tagged')
			end
		end
	elseif tagged_mobs[action.actor_id] then
		-- If mob acts, keep an update of last action time for TH bookkeeping
		tagged_mobs[action.actor_id] = os.time()
	else
		-- If anyone else acts, check if any of the targets are our tagged mobs
		for index,target in pairs(action.targets) do
			if tagged_mobs[target.id] then
				tagged_mobs[target.id] = os.time()
			end
		end
	end

	cleanup_tagged_mobs()
end


-- Need to use this event handler to listen for deaths in case Battlemod is loaded,
-- because Battlemod blocks the 'action message' event.
--
-- This function removes mobs from our tracking table when they die.
function on_incoming_chunk(id, data, modified, injected, blocked)
    if id == 0x29 then
        local target_id = data:unpack('I',0x09)
        local message_id = data:unpack('H',0x19)%32768

		-- Remove mobs that die from our tagged mobs list.
		if tagged_mobs[target_id] then
			-- 6 == actor defeats target
			-- 20 == target falls to the ground
			if message_id == 6 or message_id == 20 then
				if _settings.debug_mode then add_to_chat(123,'Mob '..target_id..' died. Removing from tagged mobs table.') end
				tagged_mobs[target_id] = nil
			end
		end
	end
end


-- Remove mobs that we've marked as tagged with TH if we haven't seen any activity from or on them
-- for over 3 minutes.  This is to handle deagros, player deaths, or other random stuff where the
-- mob is lost, but doesn't die.
function cleanup_tagged_mobs()
	-- If it's been more than 3 minutes since an action on or by a tagged mob,
	-- remove them from the tagged mobs list.
	local current_time = os.time()
	local remove_mobs = S{}
	-- Search list and flag old entries.
	for target_id,action_time in pairs(tagged_mobs) do
		local time_since_last_action = current_time - action_time
		if time_since_last_action > 180 then
			remove_mobs:add(target_id)
			if _settings.debug_mode then add_to_chat(123,'Over 3 minutes since last action on mob '..target_id..'. Removing from tagged mobs list.') end
		end
	end
	-- Clean out mobs flagged for removal.
	for mob_id,_ in pairs(remove_mobs) do
		tagged_mobs[mob_id] = nil
	end
end


