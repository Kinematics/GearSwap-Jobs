-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

--[[
	Custom commands:
	
	gs c step
		Uses the currently configured step on the target, with either <t> or <stnpc> depending on setting.

	gs c step t
		Uses the currently configured step on the target, but forces use of <t>.
	
	
	Configuration commands:
	
	gs c cycle mainstep
		Cycles through the available steps to use as the primary step when using one of the above commands.
		
	gs c cycle altstep
		Cycles through the available steps to use for alternating with the configured main step.
		
	gs c toggle usealtstep
		Toggles whether or not to use an alternate step.
		
	gs c toggle selectsteptarget
		Toggles whether or not to use <stnpc> (as opposed to <t>) when using a step.
--]]


-- Initialization function for this job file.
function get_sets()
	-- Load and initialize the include file.
	include('Mote-Include.lua')
end


-- Setup vars that are user-independent.
function job_setup()
	state.Buff['Climactic Flourish'] = buffactive['climactic flourish'] or false

	options.StepModes = {'Box Step', 'Quickstep', 'Feather Step', 'Stutter Step'}
	state.MainStep = 'Box Step'
	state.AltStep = 'Quickstep'
	state.CurrentStep = 'Main'
	state.UseAltStep = false
	state.SelectStepTarget = false
	state.IgnoreTargetting = false
	
	skillchainPending = false

	determine_haste_group()
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	options.OffenseModes = {'Normal', 'Acc', 'iLvl'}
	options.DefenseModes = {'Normal', 'Evasion', 'PDT'}
	options.WeaponskillModes = {'Normal', 'Acc', 'Att', 'Mod'}
	options.IdleModes = {'Normal'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'Evasion', 'PDT'}
	options.MagicalDefenseModes = {'MDT'}

	state.Defense.PhysicalMode = 'Evasion'

	-- Additional local binds
	send_command('bind ^= gs c cycle mainstep')
	send_command('bind != gs c cycle altstep')
	send_command('bind ^- gs c toggle selectsteptarget')
	send_command('bind !- gs c toggle usealtstep')
	send_command('bind ^` input /ja "Chocobo Jig" <me>')
	send_command('bind !` input /ja "Chocobo Jig II" <me>')

	select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()
	if binds_on_unload then
		binds_on_unload()
	end
	
	send_command('unbind ^`')
	send_command('unbind !`')
	send_command('unbind ^=')
	send_command('unbind !=')
	send_command('unbind ^-')
	send_command('unbind !-')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs

	sets.precast.JA['No Foot Rise'] = {body="Horos Casaque"}

	sets.precast.JA['Trance'] = {head="Horos Tiara"}
	

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {ammo="Sonia's Plectrum",
		head="Horos Tiara",ear1="Roundel Earring",
		body="Maxixi Casaque",hands="Buremte Gloves",
		back="Shadow Mantle",waist="Caudata Belt",legs="Nahtirah Trousers",feet="Maxixi Toe Shoes"}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}
	
	sets.precast.Samba = {head="Maxixi Tiara"}

	sets.precast.Jig = {legs="Horos Tights", feet="Maxixi Toe Shoes"}

	sets.precast.Step = {}
	sets.precast.Step['Feather Step'] = {feet="Charis Shoes +2"}

	sets.precast.Flourish1 = {}
	sets.precast.Flourish1['Violent Flourish'] = {ear1="Psystorm Earring",ear2="Lifestorm Earring",
		body="Horos Casaque",hands="Wayfarer Cuffs",ring2="Sangoma Ring",
		legs="Iuitl Tights",feet="Iuitl Gaiters +1"} -- magic accuracy
	sets.precast.Flourish1['Desperate Flourish'] = {ammo="Charis Feather",
		head="Whirlpool Mask",
		body="Manibozho Jerkin",hands="Buremte Gloves",ring1="Beeline Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Kaabnax Trousers",feet="Iuitl Gaiters +1"} -- acc gear

	sets.precast.Flourish2 = {}
	sets.precast.Flourish2['Reverse Flourish'] = {hands="Charis Bangles +2"}

	sets.precast.Flourish3 = {}
	sets.precast.Flourish3['Striking Flourish'] = {body="Charis Casaque +2"}
	sets.precast.Flourish3['Climactic Flourish'] = {head="Charis Tiara +2"}

	-- Fast cast sets for spells
	
	sets.precast.FC = {ammo="Impatiens",head="Haruspex Hat",ear2="Loquacious Earring",hands="Thaumas Gloves",ring1="Prolix Ring"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Thew Bomblet",
		head="Whirlpool Mask",neck=gear.ElementalGorget,ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Manibozho Jerkin",hands="Buremte Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist=gear.ElementalBelt,legs="Manibozho Brais",feet="Iuitl Gaiters +1"}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {ammo="Honed Tathlum", back="Letalis Mantle"})
	
	gear.default.weaponskill_neck = "Asperity Necklace"
	gear.default.weaponskill_waist = "Caudata Belt"

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {neck="Houyi's Gorget",hands="Iuitl Wristbands",
		ring1="Stormsoul Ring",waist="Caudata Belt",legs="Nahtirah Trousers"})
	sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {ammo="Honed Tathlum", back="Letalis Mantle"})
	sets.precast.WS['Exenterator'].Mod = set_combine(sets.precast.WS['Exenterator'], {waist=gear.ElementalBelt})

	sets.precast.WS['Pyrrhic Kleos'] = set_combine(sets.precast.WS, {hands="Iuitl Wristbands"})
	sets.precast.WS['Pyrrhic Kleos'].Acc = set_combine(sets.precast.WS.Acc, {hands="Iuitl Wristbands"})

	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {ammo="Charis Feather",head="Uk'uxkaj Cap",neck="Rancor Collar",waist="Caudata Belt"})
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {ammo="Honed Tathlum", back="Letalis Mantle"})
	sets.precast.WS['Evisceration'].Mod = set_combine(sets.precast.WS['Evisceration'], {waist=gear.ElementalBelt})

	sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {ammo="Charis Feather",ear1="Brutal Earring",ear2="Moonshade Earring"})
	sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {ammo="Honed Tathlum", back="Letalis Mantle"})

	sets.precast.WS['Aeolian Edge'] = {ammo="Charis Feather",
		head="Thaumas Hat",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Manibozho Jerkin",hands="Buremte Gloves",ring1="Rajas Ring",ring2="Demon's Ring",
		back="Toro Cape",waist=gear.ElementalBelt,legs="Iuitl Tights",feet="Iuitl Gaiters +1"}
	
	sets.precast.Skillchain = {hands="Charis Bangles +2"}
	
	
	-- Midcast Sets
	
	sets.midcast.FastRecast = {
		head="Felistris Mask",ear2="Loquacious Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",
		back="Ik Cape",legs="Kaabnax Trousers",feet="Iuitl Gaiters +1"}
		
	-- Specific spells
	sets.midcast.Utsusemi = {
		head="Felistris Mask",neck="Torero Torque",ear2="Loquacious Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",
		back="Fravashi Mantle",legs="Kaabnax Trousers",feet="Iuitl Gaiters +1"}

	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",
		ring1="Sheltered Ring",ring2="Paguroidea Ring"}
	sets.ExtraRegen = {head="Ocelomeh Headpiece +1"}
	

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

	sets.idle.Town = {main="Izhiikoh", sub="Atoyac",ammo="Charis Feather",
		head="Whirlpool Mask",neck="Charis Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Charis Casaque +2",hands="Iuitl Wristbands",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Atheling Mantle",waist="Patentia Sash",legs="Kaabnax Trousers",feet="Skadi's Jambeaux +1"}
	
	sets.idle.Field = {ammo="Charis Feather",
		head="Whirlpool Mask",neck="Wiglen Gorget",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Shadow Mantle",waist="Flume Belt",legs="Kaabnax Trousers",feet="Skadi's Jambeaux +1"}

	sets.idle.Weak = {ammo="Charis Feather",
		head="Whirlpool Mask",neck="Wiglen Gorget",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Manibozho Jerkin",hands="Buremte Gloves",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Shadow Mantle",waist="Flume Belt",legs="Kaabnax Trousers",feet="Skadi's Jambeaux +1"}
	
	-- Defense sets

	sets.defense.Evasion = {
		head="Felistris Mask",neck="Torero Torque",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Dark Ring",
		back="Fravashi Mantle",waist="Flume Belt",legs="Kaabnax Trousers",feet="Iuitl Gaiters +1"}

	sets.defense.PDT = {ammo="Iron Gobbet",
		head="Felistris Mask",neck="Twilight Torque",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Dark Ring",
		back="Shadow Mantle",waist="Flume Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters +1"}

	sets.defense.MDT = {ammo="Demonry Stone",
		head="Wayfarer Circlet",neck="Twilight Torque",
		body="Wayfarer Robe",hands="Wayfarer Cuffs",ring1="Dark Ring",ring2="Shadow Ring",
		back="Engulfer Cape",waist="Flume Belt",legs="Wayfarer Slops",feet="Wayfarer Clogs"}

	sets.Kiting = {feet="Skadi's Jambeaux +1"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {ammo="Charis Feather",
		head="Felistris Mask",neck="Charis Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Charis Casaque +2",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Patentia Sash",legs="Kaabnax Trousers",feet="Manibozho Boots"}
	sets.engaged.iLvl = {ammo="Charis Feather",
		head="Felistris Mask",neck="Charis Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Patentia Sash",legs="Kaabnax Trousers",feet="Manibozho Boots"}
	sets.engaged.Acc = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Charis Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Charis Casaque +2",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Kaabnax Trousers",feet="Manibozho Boots"}
	sets.engaged.Evasion = {ammo="Charis Feather",
		head="Felistris Mask",neck="Torero Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Fravashi Mantle",waist="Patentia Sash",legs="Kaabnax Trousers",feet="Iuitl Gaiters +1"}
	sets.engaged.Acc.Evasion = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Torero Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Kaabnax Trousers",feet="Iuitl Gaiters +1"}
	sets.engaged.PDT = {ammo="Charis Feather",
		head="Felistris Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Patricius Ring",ring2="Epona's Ring",
		back="Shadow Mantle",waist="Patentia Sash",legs="Kaabnax Trousers",feet="Iuitl Gaiters +1"}
	sets.engaged.Acc.PDT = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Patricius Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Kaabnax Trousers",feet="Iuitl Gaiters +1"}

	-- Custom melee group: High Haste
	sets.engaged.HighHaste = {ammo="Charis Feather",
		head="Felistris Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Thaumas Coat",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Patentia Sash",legs="Kaabnax Trousers",feet="Manibozho Boots"}
	sets.engaged.Acc.HighHaste = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Kaabnax Trousers",feet="Manibozho Boots"}
	sets.engaged.Evasion.HighHaste = {ammo="Charis Feather",
		head="Felistris Mask",neck="Torero Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Ik Cape",waist="Patentia Sash",legs="Kaabnax Trousers",feet="Iuitl Gaiters +1"}
	sets.engaged.Acc.Evasion.HighHaste = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Torero Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Kaabnax Trousers",feet="Iuitl Gaiters +1"}
	sets.engaged.PDT.HighHaste = {ammo="Charis Feather",
		head="Felistris Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Patricius Ring",ring2="Epona's Ring",
		back="Shadow Mantle",waist="Patentia Sash",legs="Iuitl Tights",feet="Iuitl Gaiters +1"}
	sets.engaged.Acc.PDT.HighHaste = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Patricius Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Iuitl Tights",feet="Iuitl Gaiters +1"}

	-- Custom melee group: Max Haste
	sets.engaged.MaxHaste = {ammo="Charis Feather",
		head="Felistris Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Thaumas Coat",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Kaabnax Trousers",feet="Manibozho Boots"}
	sets.engaged.Acc.MaxHaste = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Kaabnax Trousers",feet="Manibozho Boots"}
	sets.engaged.Evasion.MaxHaste = {ammo="Charis Feather",
		head="Felistris Mask",neck="Torero Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Ik Cape",waist="Windbuffet Belt",legs="Kaabnax Trousers",feet="Iuitl Gaiters +1"}
	sets.engaged.Acc.Evasion.MaxHaste = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Torero Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Kaabnax Trousers",feet="Iuitl Gaiters +1"}
	sets.engaged.PDT.MaxHaste = {ammo="Charis Feather",
		head="Felistris Mask",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Patricius Ring",ring2="Epona's Ring",
		back="Shadow Mantle",waist="Windbuffet Belt",legs="Iuitl Tights",feet="Iuitl Gaiters +1"}
	sets.engaged.Acc.PDT.MaxHaste = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Patricius Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Iuitl Tights",feet="Iuitl Gaiters +1"}



	-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	sets.buff['Saber Dance'] = {legs="Horos Tights"}
	sets.buff['Climactic Flourish'] = {head="Charis Tiara +2"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	--auto_presto(spell)
	cancel_conflicting_buffs(spell, action, spellMap, eventArgs)

	if spell.type == 'Waltz' and not eventArgs.cancel then
		refine_waltz(spell, action, spellMap, eventArgs)
	end
end


function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.type:lower() == "weaponskill" then
		if state.Buff['Climactic Flourish'] then
			equip(sets.buff['Climactic Flourish'])
		end
		if skillchainPending then
			equip(sets.precast.Skillchain)
		end
	end
end


-- Return true if we handled the aftercast work.  Otherwise it will fall back
-- to the general aftercast() code in Mote-Include.
function job_aftercast(spell, action, spellMap, eventArgs)
	if not spell.interrupted then
		if state.Buff[spell.english] ~= nil then
			state.Buff[spell.english] = true
		end
		if spell.english == "Wild Flourish" then
			skillchainPending = true
			send_command('wait 5;gs c clear skillchainPending')
		elseif spell.type:lower() == "weaponskill" then
			skillchainPending = not skillchainPending
			send_command('wait 5;gs c clear skillchainPending')
		end
	end
end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
	if player.hpp < 80 and not areas.Cities:contains(world.area) then
		idleSet = set_combine(idleSet, sets.ExtraRegen)
	end
	
	return idleSet
end


function customize_melee_set(meleeSet)
	if not state.Defense.Active then
		if buffactive['saber dance'] then
			meleeSet = set_combine(meleeSet, sets.buff['Saber Dance'])
		end
		if state.Buff['Climactic Flourish'] then
			meleeSet = set_combine(meleeSet, sets.buff['Climactic Flourish'])
		end
	end
	
	return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other game events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)
	if state.Buff[buff] ~= nil then
		state.Buff[buff] = gain
	end

	-- If we gain or lose any haste buffs, adjust which gear set we target.
	if S{'haste','march','embrava','haste samba'}:contains(buff:lower()) then
		determine_haste_group()
		handle_equipping_gear(player.status)
	elseif buff == 'Saber Dance' or buff == 'Climactic Flourish' then
		handle_equipping_gear(player.status)
	end
end


-- Called when the player's subjob changes.
function sub_job_change(newSubjob, oldSubjob)
	select_default_macro_book()
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
	if cmdParams[1] == 'clear' and cmdParams[2] and cmdParams[2]:lower() == 'skillchainpending' then
		skillchainPending = false
	elseif cmdParams[1] == 'step' then
		if cmdParams[2] == 't' then
			state.IgnoreTargetting = true
		end

		local doStep = state.MainStep
		if state.UseAltStep then
			doStep = state[state.CurrentStep..'Step']
			if state.CurrentStep == 'Main' then
				state.CurrentStep = 'Alt'
			else
				state.CurrentStep = 'Main'
			end
		end
		
		send_command('@input /ja "'..doStep..'" <t>')
	end
end


-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
	determine_haste_group()
end

-- Hooks for step mode handling.

-- Job-specific toggles.
function job_toggle(field)
	if field:lower() == 'selectsteptarget' then
		state.SelectStepTarget = not state.SelectStepTarget
		return "Select Step Target", state.SelectStepTarget
	elseif field:lower() == 'usealtstep' then
		state.UseAltStep = not state.UseAltStep
		return "Use Alt Step", state.UseAltStep
	end
end

-- Request job-specific mode tables.
-- Return the list, and the current value for the requested field.
function job_get_mode_list(field)
	if field == 'Mainstep' then
		return options.StepModes, state.MainStep
	elseif field == 'Altstep' then
		return options.StepModes, state.AltStep
	end
end

-- Set job-specific mode values.
-- Return true if we recognize and set the requested field.
function job_set_mode(field, val)
	if field == 'Mainstep' then
		state.MainStep = val
		return true
	elseif field == 'Altstep' then
		state.AltStep = val
		return true
	end
end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)
	if spell.type == 'Step' then
		if state.IgnoreTargetting then
			state.IgnoreTargetting = false
			eventArgs.handled = true
		end
		
		eventArgs.SelectNPCTargets = state.SelectStepTarget
	end
end


-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
	local defenseString = ''
	if state.Defense.Active then
		local defMode = state.Defense.PhysicalMode
		if state.Defense.Type == 'Magical' then
			defMode = state.Defense.MagicalMode
		end

		defenseString = 'Defense: '..state.Defense.Type..' '..defMode..', '
	end
	
	local steps = ''
	if state.UseAltStep then
		steps = ', ['..state.MainStep..'/'..state.AltStep..']'
	else
		steps = ', ['..state.MainStep..']'
	end

	if state.SelectStepTarget then
		steps = steps..' (Targetted)'
	end


	add_to_chat(122,'Melee: '..state.OffenseMode..'/'..state.DefenseMode..', WS: '..state.WeaponskillMode..', '..defenseString..
		'Kiting: '..on_off_names[state.Kiting]..steps)

	eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_haste_group()
	-- We have three groups of DW in gear: Charis body, Charis neck + DW earrings, and Patentia Sash.

	-- For high haste, we want to be able to drop one of the 10% groups (body, preferably).
	-- High haste buffs:
	-- 2x Marches + Haste
	-- 2x Marches + Haste Samba
	-- 1x March + Haste + Haste Samba
	-- Embrava + any other haste buff
	
	-- For max haste, we probably need to consider dropping all DW gear.
	-- Max haste buffs:
	-- Embrava + Haste/March + Haste Samba
	-- 2x March + Haste + Haste Samba
	
	classes.CustomMeleeGroups:clear()
	
	if buffactive.embrava and (buffactive.haste or buffactive.march) and buffactive['haste samba'] then
		classes.CustomMeleeGroups:append('MaxHaste')
	elseif buffactive.march == 2 and buffactive.haste and buffactive['haste samba'] then
		classes.CustomMeleeGroups:append('MaxHaste')
	elseif buffactive.embrava and (buffactive.haste or buffactive.march or buffactive['haste samba']) then
		classes.CustomMeleeGroups:append('HighHaste')
	elseif buffactive.march == 1 and buffactive.haste and buffactive['haste samba'] then
		classes.CustomMeleeGroups:append('HighHaste')
	elseif buffactive.march == 2 and (buffactive.haste or buffactive['haste samba']) then
		classes.CustomMeleeGroups:append('HighHaste')
	end
end


-- Automatically use Presto for steps when it's available and we have less than 3 finishing moves
function auto_presto(spell)
	if spell.type == 'Step' then
		local allRecasts = windower.ffxi.get_ability_recasts()
		local prestoCooldown = allRecasts[236]
		local under3FMs = not buffactive['Finishing Move 3'] and not buffactive['Finishing Move 4'] and not buffactive['Finishing Move 5']
		
		if player.main_job_level >= 77 and prestoCooldown < 1 and under3FMs then
			cast_delay(1.1)
			send_command('@input /ja "Presto" <me>')
		end
	end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(3, 20)
	elseif player.sub_job == 'NIN' then
		set_macro_page(1, 20)
	elseif player.sub_job == 'SAM' then
		set_macro_page(2, 20)
	else
		set_macro_page(5, 20)
	end
end

