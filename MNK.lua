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
	state.CombatForm = get_combat_form()
	update_melee_groups()
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	options.OffenseModes = {'Normal', 'Acc', 'Mod', 'iLvl'}
	options.DefenseModes = {'Normal', 'PDT', 'HP', 'Counter'}
	options.WeaponskillModes = {'Normal', 'Acc', 'Att', 'Mod'}
	options.IdleModes = {'Normal'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'PDT', 'HP'}
	options.MagicalDefenseModes = {'MDT'}

	state.Defense.PhysicalMode = 'PDT'

	select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()
	if binds_on_unload then
		binds_on_unload()
	end
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs on use
	sets.precast.JA['Hundred Fists'] = {legs="Hesychast's Hose"}

	sets.precast.JA['Boost'] = {hands="Anchorite's Gloves +1"}

	sets.precast.JA['Dodge'] = {feet="Anchorite's Gaiters"}

	sets.precast.JA['Focus'] = {head="Anchorite's Crown"}

	sets.precast.JA['Counterstance'] = {feet="Hesychast's Gaiters"}

	sets.precast.JA['Chi Blast'] = {
		head="Melee Crown +2",
		body="Otronif Harness",hands="Otronif Gloves",
		back="Tuilha Cape",legs="Nahtirah Trousers",feet="Thurandaut Boots +1"}

	sets.precast.JA['Footwork'] = {feet="Tantra Gaiters +2"}

	sets.precast.JA['Formless Strikes'] = {body="Melee Cyclas +2"}

	sets.precast.JA['Mantra'] = {feet="Hesychast's Gaiters"}

	sets.precast.JA['Chakra'] = {ammo="Iron Gobbet",
		head="Whirlpool Mask",
		body="Anchorite's Cyclas",hands="Hesychast's Gloves",ring1="Spiral Ring",
		back="Iximulew Cape",waist="Caudata Belt",legs="Nahtirah Trousers",feet="Thurandaut Boots +1"}

	

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {ammo="Sonia's Plectrum",
		head="Whirlpool Mask",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Spiral Ring",
		back="Iximulew Cape",waist="Caudata Belt",legs="Nahtirah Trousers",feet="Thurandaut Boots +1"}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	
	sets.precast.FC = {head="Haruspex hat",ear2="Loquacious Earring",hands="Thaumas Gloves"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Thew Bomblet",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Manibozho Jerkin",hands="Anchorite's Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Caudata Belt",legs="Manibozho Brais",feet="Manibozho Boots"}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {ammo="Honed Tathlum", back="Letalis Mantle"})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS["Victory Smite"]     = set_combine(sets.precast.WS, {neck="Rancor Collar",ear1="Brutal Earring",ear2="Moonshade Earring"})
	sets.precast.WS["Victory Smite"].Acc = set_combine(sets.precast.WS.Acc, {neck="Rancor Collar",ear1="Brutal Earring",ear2="Moonshade Earring"})
	sets.precast.WS["Victory Smite"].Mod = set_combine(sets.precast.WS["Victory Smite"], {waist=gear.ElementalBelt,feet="Otronif Boots +1"})

	sets.precast.WS['Shijin Spiral']     = set_combine(sets.precast.WS, {neck=gear.ElementalGorget})
	sets.precast.WS['Shijin Spiral'].Acc = set_combine(sets.precast.WS.Acc, {neck=gear.ElementalGorget})
	sets.precast.WS['Shijin Spiral'].Mod = set_combine(sets.precast.WS['Shijin Spiral'], {waist=gear.ElementalBelt,feet="Otronif Boots +1"})

	sets.precast.WS['Asuran Fists']     = set_combine(sets.precast.WS, {neck=gear.ElementalGorget,ring2="Spiral Ring"})
	sets.precast.WS['Asuran Fists'].Acc = set_combine(sets.precast.WS.Acc, {neck=gear.ElementalGorget,ring2="Spiral Ring"})
	sets.precast.WS['Asuran Fists'].Mod = set_combine(sets.precast.WS['Asuran Fists'], {waist=gear.ElementalBelt,feet="Otronif Boots +1"})

	sets.precast.WS["Ascetic's Fury"]     = set_combine(sets.precast.WS, {neck="Rancor Collar",ear1="Brutal Earring",ear2="Moonshade Earring",ring1="Spiral Ring"})
	sets.precast.WS["Ascetic's Fury"].Acc = set_combine(sets.precast.WS.Acc, {neck="Rancor Collar",ear1="Brutal Earring",ear2="Moonshade Earring",ring1="Spiral Ring"})
	sets.precast.WS["Ascetic's Fury"].Mod = set_combine(sets.precast.WS["Ascetic's Fury"], {waist=gear.ElementalBelt,feet="Otronif Boots +1"})

	sets.precast.WS['Cataclysm'] = {
		head="Thaumas Hat",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Manibozho Jerkin",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Demon's Ring",
		back="Toro Cape",waist="Thunder Belt"}
	
	
	-- Midcast Sets
	sets.midcast.FastRecast = {
		head="Whirlpool Mask",ear2="Loquacious Earring",
		body="Otronif Harness",hands="Thaumas Gloves",
		waist="Black Belt",feet="Otronif Boots +1"}
		
	-- Specific spells
	sets.midcast.Utsusemi = {ammo="Impatiens",
		head="Whirlpool Mask",ear2="Loquacious Earring",
		body="Otronif Harness",hands="Thaumas Gloves",
		waist="Black Belt",legs="Nahtirah Trousers",feet="Otronif Boots +1"}

	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",
		body="Melee Cyclas +2",ring1="Sheltered Ring",ring2="Paguroidea Ring"}
	

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {main="Oatixur",ammo="Thew Bomblet",
		head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Melee Cyclas +2",hands="Otronif Gloves",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Iximulew Cape",waist="Black Belt",legs="Nahtirah Trousers",feet="Herald's Gaiters"}

	sets.idle.Town = {main="Oatixur",ammo="Thew Bomblet",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Atheling Mantle",waist="Black Belt",legs="Nahtirah Trousers",feet="Herald's Gaiters"}
	
	sets.idle.Weak = {main="Oatixur",ammo="Thew Bomblet",
		head="Whirlpool Mask",neck="Wiglen Gorget",ear1="Brutal Earring",ear2="Bloodgem Earring",
		body="Melee Cyclas +2",hands="Otronif Gloves",ring1="Sheltered Ring",ring2="Meridian Ring",
		back="Iximulew Cape",waist="Black Belt",legs="Nahtirah Trousers",feet="Herald's Gaiters"}
	
	-- Defense sets
	sets.defense.PDT = {ammo="Iron Gobbet",
		head="Whirlpool Mask",neck="Twilight Torque",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Dark Ring",ring2="Dark Ring",
		back="Shadow Mantle",waist="Black Belt",legs="Nahtirah Trousers",feet="Otronif Boots +1"}

	sets.defense.HP = {ammo="Iron Gobbet",
		head="Whirlpool Mask",neck="Lavalier +1",ear1="Brutal Earring",ear2="Bloodgem Earring",
		body="Melee Cyclas +2",hands="Hesychast's Gloves",ring1="K'ayres Ring",ring2="Meridian Ring",
		back="Shadow Mantle",waist="Black Belt",legs="Hesychast's Hose",feet="Hesychast's Gaiters"}

	sets.defense.MDT = {ammo="Demonry Stone",
		head="Haruspex hat",neck="Twilight Torque",
		body="Otronif Harness",hands="Anchorite's Gloves +1",ring1="Dark Ring",ring2="Shadow Ring",
		back="Engulfer Cape",waist="Black Belt",legs="Nahtirah Trousers",feet="Otronif Boots +1"}

	sets.Kiting = {feet="Herald's Gaiters"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee sets
	sets.engaged = {ammo="Thew Bomblet",
		head="Felistris Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Thaumas Coat",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Otronif Boots +1"}
	sets.engaged.HF = set_combine(sets.engaged, {feet="Manibozho Boots"})
	sets.engaged.Impetus = set_combine(sets.engaged, {body="Tantra Cyclas +2"})
	sets.engaged.HF.Impetus = set_combine(sets.engaged.HF, {body="Tantra Cyclas +2",feet="Manibozho Boots"})
	sets.engaged.Acc = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Peacock Charm",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Manibozho Jerkin",hands="Hesychast's Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Anguinus Belt",legs="Manibozho Brais",feet="Manibozho Boots"}
	sets.engaged.Acc.HF = set_combine(sets.engaged.Acc, {neck="Asperity Necklace",body="Thaumas Coat"})
	sets.engaged.Acc.HF.Impetus = set_combine(sets.engaged.Acc.HF, {body="Tantra Cyclas +2"})
	sets.engaged.Mod = {ammo="Thew Bomblet",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Thaumas Coat",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Quiahuiz Trousers",feet="Manibozho Boots"}
	sets.engaged.iLvl = {ammo="Thew Bomblet",
		head="Felistris Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Quiahuiz Trousers",feet="Otronif Boots +1"}
	sets.engaged.PDT = {ammo="Thew Bomblet",
		head="Felistris Mask",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Dark Ring",ring2="Epona's Ring",
		back="Iximulew Cape",waist="Windbuffet Belt",legs="Quiahuiz Trousers",feet="Otronif Boots +1"}
	sets.engaged.PDT.HF = sets.engaged.PDT
	sets.engaged.PDT.HF.Impetus = set_combine(sets.engaged.PDT, {body="Tantra Cyclas +2"})
	sets.engaged.Acc.PDT = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Dark Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Anguinus Belt",legs="Manibozho Brais",feet="Otronif Boots +1"}
	sets.engaged.Acc.PDT.HF = sets.engaged.Acc.PDT
	sets.engaged.Acc.PDT.HF.Impetus = set_combine(sets.engaged.Acc.PDT, {body="Tantra Cyclas +2"})
	sets.engaged.HP = {ammo="Thew Bomblet",
		head="Whirlpool Mask",neck="Lavalier +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Hesychast's Gloves",ring1="K'ayres Ring",ring2="Beeline Ring",
		back="Iximulew Cape",waist="Windbuffet Belt",legs="Quiahuiz Trousers",feet="Otronif Boots +1"}
	sets.engaged.HP.HF = sets.engaged.HP
	sets.engaged.HP.HF.Impetus = set_combine(sets.engaged.HP, {body="Tantra Cyclas +2"})
	sets.engaged.Acc.HP = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Lavalier +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Hesychast's Gloves",ring1="K'ayres Ring",ring2="Beeline Ring",
		back="Iximulew Cape",waist="Windbuffet Belt",legs="Quiahuiz Trousers",feet="Otronif Boots +1"}
	sets.engaged.Acc.HP.HF = sets.engaged.Acc.HP
	sets.engaged.Acc.HP.HF.Impetus = set_combine(sets.engaged.Acc.HP, {body="Tantra Cyclas +2"})
	sets.engaged.Counter = {ammo="Thew Bomblet",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="K'ayres Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Anchorite's Hose",feet="Otronif Boots +1"}
	sets.engaged.Counter.HF = sets.engaged.Counter
	sets.engaged.Counter.HF.Impetus = set_combine(sets.engaged.Counter, {body="Tantra Cyclas +2"})
	sets.engaged.Acc.Counter = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Hesychast's Gloves",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Anguinus Belt",legs="Anchorite's Hose",feet="Otronif Boots +1"}
	sets.engaged.Acc.Counter.HF = sets.engaged.Acc.Counter
	sets.engaged.Acc.Counter.HF.Impetus = set_combine(sets.engaged.Acc.Counter, {body="Tantra Cyclas +2"})

	-- Footwork combat form
	sets.engaged.Footwork = {ammo="Thew Bomblet",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Thaumas Coat",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Hesychast's Hose",feet="Anchorite's Gaiters"}
	sets.engaged.Footwork.Acc = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Thaumas Coat",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Anguinus Belt",legs="Hesychast's Hose",feet="Anchorite's Gaiters"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	-- Don't gearswap for weaponskills when Defense is on.
	if spell.type:lower() == 'weaponskill' and state.Defense.Active then
		eventArgs.handled = true
	elseif spell.type == 'Waltz' then
		refine_waltz(spell, action, spellMap, eventArgs)
	end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.type:lower() == 'weaponskill' and not state.Defense.Active then
		if buffactive.impetus and (spell.english == "Ascetic's Fury" or spell.english == "Victory Smite") then
			equip({body="Tantra Cyclas +2"})
		elseif buffactive.footwork and (spell.english == "Dragon's Kick" or spell.english == "Tornado Kick") then
			equip({feet="Anchorite's Gaiters"})
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other game events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	-- Set Footwork as combat form any time it's active and Hundred Fists is not.
	if buff == 'Footwork' and gain and not buffactive['hundred fists'] then
		state.CombatForm = 'Footwork'
	elseif buff == "Hundred Fists" and not gain and buffactive.footwork then
		state.CombatForm = 'Footwork'
	else
		state.CombatForm = nil
	end
	
	-- Hundred Fists and Impetus modify the custom melee groups
	if buff == "Hundred Fists" or buff == "Impetus" then
		classes.CustomMeleeGroups:clear()
		
		if (buff == "Hundred Fists" and gain) or buffactive['hundred fists'] then
			classes.CustomMeleeGroups:append('HF')
		end
		
		if (buff == "Impetus" and gain) or buffactive.impetus then
			classes.CustomMeleeGroups:append('Impetus')
		end
	end

	-- Update gear if any of the above changed
	if buff == "Hundred Fists" or buff == "Impetus" or buff == "Footwork" then
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

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
	state.CombatForm = get_combat_form()
	update_melee_groups()
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function get_combat_form()
	if buffactive.footwork and not buffactive['hundred fists'] then
		return 'Footwork'
	end
end

function update_melee_groups()
	classes.CustomMeleeGroups:clear()
	
	if buffactive['hundred fists'] then
		classes.CustomMeleeGroups:append('HF')
	end
	
	if buffactive.impetus then
		classes.CustomMeleeGroups:append('Impetus')
	end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(8, 1)
	elseif player.sub_job == 'NIN' then
		set_macro_page(2, 1)
	elseif player.sub_job == 'THF' then
		set_macro_page(4, 1)
	else
		set_macro_page(3, 1)
	end
end


