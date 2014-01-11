-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- Last Modified: 1/5/2014 2:40:57 AM

-- IMPORTANT: Make sure to also get the Mote-Include.lua file to go with this.

function get_sets()
	-- Load and initialize the include file.
	include('Mote-Include.lua')
	init_include()
	
	-- Options: Override default values
	options.OffenseModes = {'Normal', 'Acc', 'Mod'}
	options.DefenseModes = {'Normal', 'PDT', 'HP', 'Counter'}
	options.WeaponskillModes = {'Normal', 'Acc', 'Att', 'Mod'}
	options.IdleModes = {'Normal'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'PDT', 'HP'}
	options.MagicalDefenseModes = {'MDT'}

	state.Defense.PhysicalMode = 'PDT'
	
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs on use
	sets.precast.JA['Hundred Fists'] = {legs="Melee Hose +2"}

	sets.precast.JA['Boost'] = {hands="Anchorite's Gloves"}

	sets.precast.JA['Dodge'] = {feet="Temple Gaiters +1"}

	sets.precast.JA['Focus'] = {head="Anchorite's Crown"}

	sets.precast.JA['Counterstance'] = {feet="Melee Gaiters +2"}

	sets.precast.JA['Chi Blast'] = {
		head="Melee Crown +2",
		body="Otronif Harness",hands="Otronif Gloves",
		back="Tuilha Cape",legs="Nahtirah Trousers",feet="Thurandaut Boots +1"}

	sets.precast.JA['Footwork'] = {feet="Tantra Gaiters +2"}

	sets.precast.JA['Formless Strikes'] = {body="Melee Cylcas +2"}

	sets.precast.JA['Mantra'] = {feet="Melee Gaiters +2"}

	sets.precast.JA['Chakra'] = {ammo="Iron Gobbet",
		head="Whirlpool Mask",
		body="Anchorite's Cyclas",hands="Melee Gloves +2",ring1="Spiral Ring",
		back="Iximulew Cape",waist="Caudata Belt",legs="Nahtirah Trousers",feet="Thurandaut Boots +1"}

	

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {ammo="Sonia's Plectrum",
		head="Whirlpool Mask",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Spiral Ring",
		back="Iximulew Cape",waist="Caudata Belt",legs="Nahtirah Trousers",feet="Thurandaut Boots +1"}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	
	sets.precast.FC = {ear2="Loquacious Earring",
		hands="Thaumas Gloves"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Thew Bomblet",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Manibozho Jerkin",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Caudata Belt",legs="Manibozho Brais",feet="Manibozho Boots"}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {ammo="Honed Tathlum", back="Letalis Mantle"})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS["Victory Smite"]     = set_combine(sets.precast.WS, {neck="Rancor Collar",ear1="Brutal Earring",ear2="Moonshade Earring",hands="Anchorite's Gloves"})
	sets.precast.WS["Victory Smite"].Acc = set_combine(sets.precast.WS.Acc, {neck="Rancor Collar",ear1="Brutal Earring",ear2="Moonshade Earring",hands="Anchorite's Gloves"})
	sets.precast.WS["Victory Smite"].Mod = set_combine(sets.precast.WS["Victory Smite"], {waist="Thunder Belt",feet="Otronif Boots"})

	sets.precast.WS['Shijin Spiral']     = set_combine(sets.precast.WS, {neck="Light Gorget"})
	sets.precast.WS['Shijin Spiral'].Acc = set_combine(sets.precast.WS.Acc, {neck="Light Gorget"})
	sets.precast.WS['Shijin Spiral'].Mod = set_combine(sets.precast.WS['Shijin Spiral'], {waist="Light Belt",feet="Otronif Boots"})

	sets.precast.WS['Asuran Fists']     = set_combine(sets.precast.WS, {neck="Soil Gorget",ring2="Spiral Ring"})
	sets.precast.WS['Asuran Fists'].Acc = set_combine(sets.precast.WS.Acc, {neck="Soil Gorget",ring2="Spiral Ring"})
	sets.precast.WS['Asuran Fists'].Mod = set_combine(sets.precast.WS['Asuran Fists'], {waist="Soil Belt",feet="Otronif Boots"})

	sets.precast.WS["Ascetic's Fury"]     = set_combine(sets.precast.WS, {neck="Rancor Collar",ear1="Brutal Earring",ear2="Moonshade Earring",ring1="Spiral Ring"})
	sets.precast.WS["Ascetic's Fury"].Acc = set_combine(sets.precast.WS.Acc, {neck="Rancor Collar",ear1="Brutal Earring",ear2="Moonshade Earring",ring1="Spiral Ring"})
	sets.precast.WS["Ascetic's Fury"].Mod = set_combine(sets.precast.WS["Ascetic's Fury"], {waist="Soil Belt",feet="Otronif Boots"})

	sets.precast.WS['Cataclysm'] = {
		head="Thaumas Hat",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Manibozho Jerkin",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Demon's Ring",
		back="Toro Cape",waist="Thunder Belt"}
	
	
	-- Midcast Sets
	sets.midcast.FastRecast = {
		head="Whirlpool Mask",ear2="Loquacious Earring",
		body="Otronif Harness",hands="Thaumas Gloves",
		waist="Black Belt",feet="Otronif Boots"}
		
	-- Specific spells
	sets.midcast.Utsusemi = {
		head="Whirlpool Mask",ear2="Loquacious Earring",
		body="Otronif Harness",hands="Thaumas Gloves",
		waist="Black Belt",legs="Nahtirah Trousers",feet="Otronif Boots"}

	
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
		back="Shadow Mantle",waist="Black Belt",legs="Nahtirah Trousers",feet="Otronif Boots"}

	sets.defense.HP = {ammo="Iron Gobbet",
		head="Whirlpool Mask",neck="Lavalier +1",ear1="Brutal Earring",ear2="Bloodgem Earring",
		body="Melee Cyclas +2",hands="Melee Gloves +2",ring1="K'ayres Ring",ring2="Meridian Ring",
		back="Shadow Mantle",waist="Black Belt",legs="Melee Hose +2",feet="Melee Gaiters +2"}

	sets.defense.MDT = {ammo="Demonry Stone",
		head="Whirlpool Mask",neck="Twilight Torque",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Dark Ring",ring2="Shadow Ring",
		back="Engulfer Cape",waist="Black Belt",legs="Nahtirah Trousers",feet="Otronif Boots"}

	sets.Kiting = {feet="Herald's Gaiters"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {ammo="Thew Bomblet",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Thaumas Coat",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Otronif Boots"}
	sets.engaged.Acc = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Anguinus Belt",legs="Manibozho Brais",feet="Manibozho Boots"}
	sets.engaged.Mod = {ammo="Thew Bomblet",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Thaumas Coat",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Quiahuiz Leggings",feet="Manibozho Boots"}
	sets.engaged.PDT = {ammo="Thew Bomblet",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Dark Ring",ring2="Epona's Ring",
		back="Iximulew Cape",waist="Windbuffet Belt",legs="Quiahuiz Leggings",feet="Otronif Boots"}
	sets.engaged.Acc.PDT = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Dark Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Anguinus Belt",legs="Manibozho Brais",feet="Otronif Boots"}
	sets.engaged.HP = {ammo="Thew Bomblet",
		head="Whirlpool Mask",neck="Lavalier +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="K'ayres Ring",ring2="Epona's Ring",
		back="Iximulew Cape",waist="Windbuffet Belt",legs="Quiahuiz Leggings",feet="Otronif Boots"}
	sets.engaged.Acc.HP = {ammo="Thew Bomblet",
		head="Whirlpool Mask",neck="Lavalier +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Iximulew Cape",waist="Windbuffet Belt",legs="Quiahuiz Leggings",feet="Otronif Boots"}
	sets.engaged.Counter = {ammo="Thew Bomblet",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Anchorite's Hose",feet="Otronif Boots"}
	sets.engaged.Acc.Counter = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Anguinus Belt",legs="Anchorite's Hose",feet="Otronif Boots"}

	-- Footwork melee group
	sets.engaged.Footwork = {ammo="Thew Bomblet",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Thaumas Coat",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Anchorite's Gaiters"}
	sets.engaged.Footwork.Acc = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Thaumas Coat",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Anguinus Belt",legs="Manibozho Brais",feet="Anchorite's Gaiters"}

	-- Hundred Fists melee group
	sets.engaged.HF = {ammo="Thew Bomblet",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Thaumas Coat",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Manibozho Boots"}
	sets.engaged.HF.Acc = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Thaumas Coat",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Anguinus Belt",legs="Manibozho Brais",feet="Manibozho Boots"}
	sets.engaged.HF.PDT = {ammo="Thew Bomblet",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Dark Ring",ring2="Epona's Ring",
		back="Iximulew Cape",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Otronif Boots"}
	sets.engaged.HF.Acc.PDT = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Dark Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Anguinus Belt",legs="Manibozho Brais",feet="Otronif Boots"}
	sets.engaged.HF.Impetus = {ammo="Thew Bomblet",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Tantra Cyclas +2",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Manibozho Boots"}
	sets.engaged.HF.Impetus.Acc = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Tantra Cyclas +2",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Anguinus Belt",legs="Manibozho Brais",feet="Manibozho Boots"}
	sets.engaged.HF.Impetus.PDT = {ammo="Thew Bomblet",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Tantra Cyclas +2",hands="Otronif Gloves",ring1="Dark Ring",ring2="Epona's Ring",
		back="Iximulew Cape",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Otronif Boots"}
	sets.engaged.HF.Impetus.Acc.PDT = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Tantra Cyclas +2",hands="Otronif Gloves",ring1="Dark Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Anguinus Belt",legs="Manibozho Brais",feet="Otronif Boots"}


	set_macro_page(1, 2)
	binds_on_load()

	windower.send_command('bind ^- gs c toggle target')
	windower.send_command('bind ^= gs c cycle targetmode')
end

-- Called when this job file is unloaded (eg: job change)
function file_unload()
	--binds_on_unload()
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
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if buff == "Hundred Fists" or buff == "Impetus" or buff == "Footwork" then
		local adjMeleeSet = ''
	
		classes.CustomMeleeGroups:clear()
		
		if (buff == "Hundred Fists" and gain) or buffactive['hundred fists'] then
			classes.CustomMeleeGroups:append('HF')
		elseif buffactive.footwork then
			classes.CustomMeleeGroups:append('Footwork')
		end
		
		if (buff == "Impetus" and gain) or buffactive.impetus then
			classes.CustomMeleeGroups:append('Impetus')
		end
	
		handle_equipping_gear(player.status)
	end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
	classes.CustomMeleeGroups:clear()
	
	if buffactive['hundred fists'] then
		classes.CustomMeleeGroups:append('HF')
	elseif buffactive.footwork then
		classes.CustomMeleeGroups:append('Footwork')
	end
	
	if buffactive.impetus then
		classes.CustomMeleeGroups:append('Impetus')
	end
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

