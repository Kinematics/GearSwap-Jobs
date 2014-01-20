-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
	-- Load and initialize the include file.
	include('Mote-Include.lua')
	init_include()
	
	-- UserGlobals may define additional sets to be added to the local ones.
	if define_global_sets then
		define_global_sets()
	end

	-- Define sets and vars used by this job file.
	if not load_user_gear(player.main_job) then
		init_gear_sets()
	end

	-- Global default binds
	binds_on_load()
	
	determine_haste_group()
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()
	binds_on_unload()

	if unload_user_gear then
		unload_user_gear()
	end
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	-- Default macro set/book
	set_macro_page(1, 3)
	
	-- Options: Override default values
	options.OffenseModes = {'Normal', 'Acc'}
	options.DefenseModes = {'Normal', 'Evasion', 'PDT'}
	options.WeaponskillModes = {'Normal', 'Acc', 'Att', 'Mod'}
	options.CastingModes = {'Normal'}
	options.IdleModes = {'Normal'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'PDT', 'Evasion'}
	options.MagicalDefenseModes = {'MDT'}

	state.Defense.PhysicalMode = 'PDT'
	
	state.Buff.Migawari = buffactive.migawari or false
	state.Buff.Doom = buffactive.doom or false
	
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets

	-- Precast sets to enhance JAs

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {ammo="Sonia's Plectrum",
		head="Whirlpool Mask",
		body="Otronif Harness",hands="Buremte Gloves",
		back="Iximulew Cape",waist="Caudata Belt",legs="Nahtirah Trousers",feet="Otronif Boots"}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Set for acc on steps, since Yonin drops acc a fair bit
	sets.precast.Step = {
		head="Whirlpool Mask",neck="Peacock Charm",
		body="Manibozho Jerkin",hands="Otronif Gloves",ring1="Beeline Ring",
		back="Letalis Mantle",waist="Anguinus Belt",legs="Manibozho Brais",feet="Otronif Boots"}

	-- Fast cast sets for spells
	
	sets.precast.FC = {ammo="Impatiens",ear2="Loquacious Earring",hands="Thaumas Gloves"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Manibozho Jerkin",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Caudata Belt",legs="Manibozho Brais",feet="Otronif Boots"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Blade: Jin'] = set_combine(sets.precast.WS, {neck="Rancor Collar",ear1="Brutal Earring",ear2="Moonshade Earring",
		waist="Soil Belt"})

	sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS, {neck="Rancor Collar",ear1="Brutal Earring",ear2="Moonshade Earring",
		hands="Hachiya Tekko",ring1="Stormsoul Ring",legs="Nahtirah Trousers"})
	sets.precast.WS['Blade: Hi'].Mod = set_combine(sets.precast.WS['Blade: Hi'], {back="Ik Cape",waist="Soil Belt"})

	sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS, {neck="Thunder Gorget",waist="Thunder Belt"})

	sets.precast.WS['Blade: Kamu'] = set_combine(sets.precast.WS, {neck="Thunder Gorget"})
	sets.precast.WS['Blade: Kamu'].Mod = set_combine(sets.precast.WS['Blade: Kamu'], {waist="Thunder Belt"})

	sets.precast.WS['Blade: Ku'] = set_combine(sets.precast.WS, {neck="Soil Gorget"})
	sets.precast.WS['Blade: Ku'].Mod = set_combine(sets.precast.WS['Blade: Ku'], {waist="Soil Belt"})

	sets.precast.WS['Aeolian Edge'] = {
		head="Thaumas Hat",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Manibozho Jerkin",hands="Buremte Gloves",ring1="Rajas Ring",ring2="Demon's Ring",
		back="Toro Cape",waist="Thunder Belt",legs="Manibozho Brais",feet="Otronif Boots"}
	
	
	-- Midcast Sets
	sets.midcast.FastRecast = {
		head="Whirlpool Mask",ear2="Loquacious Earring",
		body="Hachiya Chainmail",hands="Otronif Gloves",
		waist="Twilight Belt",legs="Nahtirah Trousers",feet="Otronif Boots"}
		
	-- any ninjutsu cast on self
	sets.midcast.SelfNinjutsu = set_combine(sets.midcast.FastRecast, {neck="Torero Torque",ring1="Beeline Ring",back="Ix Cape"})

	-- any ninjutsu cast on enemies
	sets.midcast.Ninjutsu = {
		head="Hachiya Hatsuburi",neck="Stoicheion Medal",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		--ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Icesoul Ring",
		back="Toro Cape",waist="Twilight Belt",legs="Nahtirah Troursers",feet="Hachiya Kyahan"}

	--sets.midcast.Ninjutsu.Resistant = set_combine(sets.midcast.Ninjutsu, {ear1="Lifestorm Earring",ear2="Psystorm Earring"})

	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",
		ring1="Sheltered Ring",ring2="Paguroidea Ring"}
	

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {
		head="Whirlpool Mask",neck="Wiglen Gorget",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hachiya Chainmail",hands="Otronif Gloves",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Atheling Mantle",waist="Patentia Sash",legs="Hachiya Hakama",feet="Danzo sune-ate"}

	sets.idle.Town = {
		head="Whirlpool Mask",neck="Wiglen Gorget",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hachiya Chainmail",hands="Otronif Gloves",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Atheling Mantle",waist="Patentia Sash",legs="Hachiya Hakama",feet="Danzo sune-ate"}
	
	sets.idle.Weak = {
		head="Whirlpool Mask",neck="Wiglen Gorget",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hachiya Chainmail",hands="Otronif Gloves",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Iximulew Cape",waist="Patentia Sash",legs="Hachiya Hakama",feet="Danzo sune-ate"}
	
	-- Defense sets
	sets.defense.Evasion = {
		head="Whirlpool Mask",neck="Torero Torque",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Dark Ring",
		back="Ik Cape",waist="Flume Belt",legs="Nahtirah Trousers",feet="Otronif Boots"}

	sets.defense.PDT = {ammo="Iron Gobbet",
		head="Whirlpool Mask",neck="Torero Torque",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Dark Ring",ring2="Dark Ring",
		back="Iximulew Cape",waist="Flume Belt",legs="Nahtirah Trousers",feet="Otronif Boots"}

	sets.defense.MDT = {ammo="Demonry Stone",
		head="Whirlpool Mask",neck="Torero Torque",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Dark Ring",ring2="Shadow Ring",
		back="Engulfer Cape",waist="Flume Belt",legs="Nahtirah Trousers",feet="Otronif Boots"}


	sets.DayMovement = {feet="Danzo sune-ate"}

	sets.NightMovement = {feet="Hachiya Kyahan"}

	sets.Kiting = select_movement()


	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {ammo="Qirmiz Tathlum",
		head="Iga Zukin +2",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hachiya Chainmail",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Patentia Sash",legs="Hachiya Hakama",feet="Manibozho Boots"}
	sets.engaged.Acc = {ammo="Qirmiz Tathlum",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hachiya Chainmail",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Hachiya Hakama",feet="Manibozho Boots"}
	sets.engaged.Evasion = {ammo="Qirmiz Tathlum",
		head="Whirlpool Mask",neck="Torero Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hachiya Chainmail",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Ik Cape",waist="Patentia Sash",legs="Hachiya Hakama",feet="Otronif Boots"}
	sets.engaged.Acc.Evasion = {ammo="Qirmiz Tathlum",
		head="Whirlpool Mask",neck="Torero Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Hachiya Hakama",feet="Otronif Boots"}
	sets.engaged.PDT = {ammo="Qirmiz Tathlum",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Dark Ring",ring2="Epona's Ring",
		back="Iximulew Cape",waist="Patentia Sash",legs="Hachiya Hakama",feet="Otronif Boots"}
	sets.engaged.Acc.PDT = {ammo="Qirmiz Tathlum",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Dark Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Hachiya Hakama",feet="Otronif Boots"}

	-- Custom melee group: High Haste (~20% DW)
	sets.engaged.HighHaste = {ammo="Qirmiz Tathlum",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hachiya Chainmail",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Patentia Sash",legs="Hachiya Hakama",feet="Manibozho Boots"}
	sets.engaged.HighHaste.Acc = {ammo="Qirmiz Tathlum",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hachiya Chainmail",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Hachiya Hakama",feet="Manibozho Boots"}
	sets.engaged.HighHaste.Evasion = {ammo="Qirmiz Tathlum",
		head="Whirlpool Mask",neck="Torero Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hachiya Chainmail",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Ik Cape",waist="Patentia Sash",legs="Hachiya Hakama",feet="Otronif Boots"}
	sets.engaged.HighHaste.Acc.Evasion = {ammo="Qirmiz Tathlum",
		head="Whirlpool Mask",neck="Torero Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Hachiya Hakama",feet="Otronif Boots"}
	sets.engaged.HighHaste.PDT = {ammo="Qirmiz Tathlum",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Dark Ring",ring2="Epona's Ring",
		back="Iximulew Cape",waist="Patentia Sash",legs="Hachiya Hakama",feet="Otronif Boots"}
	sets.engaged.HighHaste.Acc.PDT = {ammo="Qirmiz Tathlum",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Dark Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Hachiya Hakama",feet="Otronif Boots"}

	-- Custom melee group: Embrava Haste (7% DW)
	sets.engaged.EmbravaHaste = {ammo="Qirmiz Tathlum",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Thaumas Coat",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Manibozho Boots"}
	sets.engaged.EmbravaHaste.Acc = {ammo="Qirmiz Tathlum",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Manibozho Brais",feet="Manibozho Boots"}
	sets.engaged.EmbravaHaste.Evasion = {ammo="Qirmiz Tathlum",
		head="Whirlpool Mask",neck="Torero Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Ik Cape",waist="Windbuffet Belt",legs="Hachiya Hakama",feet="Otronif Boots"}
	sets.engaged.EmbravaHaste.Acc.Evasion = {ammo="Qirmiz Tathlum",
		head="Whirlpool Mask",neck="Torero Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Hachiya Hakama",feet="Otronif Boots"}
	sets.engaged.EmbravaHaste.PDT = {ammo="Qirmiz Tathlum",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Dark Ring",ring2="Epona's Ring",
		back="Iximulew Cape",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Otronif Boots"}
	sets.engaged.EmbravaHaste.Acc.PDT = {ammo="Qirmiz Tathlum",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Dark Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Manibozho Brais",feet="Otronif Boots"}

	-- Custom melee group: Max Haste (0% DW)
	sets.engaged.MaxHaste = {ammo="Qirmiz Tathlum",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Thaumas Coat",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Manibozho Boots"}
	sets.engaged.MaxHaste.Acc = {ammo="Qirmiz Tathlum",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Manibozho Brais",feet="Manibozho Boots"}
	sets.engaged.MaxHaste.Evasion = {ammo="Qirmiz Tathlum",
		head="Whirlpool Mask",neck="Torero Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Ik Cape",waist="Windbuffet Belt",legs="Hachiya Hakama",feet="Otronif Boots"}
	sets.engaged.MaxHaste.Acc.Evasion = {ammo="Qirmiz Tathlum",
		head="Whirlpool Mask",neck="Torero Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Hachiya Hakama",feet="Otronif Boots"}
	sets.engaged.MaxHaste.PDT = {ammo="Qirmiz Tathlum",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Dark Ring",ring2="Epona's Ring",
		back="Iximulew Cape",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Otronif Boots"}
	sets.engaged.MaxHaste.Acc.PDT = {ammo="Qirmiz Tathlum",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Dark Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Manibozho Brais",feet="Otronif Boots"}


	sets.buff.Migawari = {body="Iga Ningi"}
	sets.buff.Doom = {ring2="Saida Ring"}
	sets.buff.Yonin = {}
	sets.buff.Innin = {}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	if spell.skill == "Ninjutsu" and spell.target.type:lower() == 'self' then
		classes.CustomClass = "SelfNinjutsu"
	end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		-- Default base equipment layer of fast recast.
		equip(sets.midcast.FastRecast)
	end
end

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if state.Buff.Doom then
		equip(sets.buff.Doom)
	end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if not spell.interrupted and spell.english == "Migawari: Ichi" then
		state.Buff.Migawari = true
	end
end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)
	sets.Kiting = select_movement()
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	idleSet = set_combine(idleSet, select_movement())
	if state.Buff.Migawari then
		idleSet = set_combine(idleSet, sets.buff.Migawari)
	end
	if state.Buff.Doom then
		idleSet = set_combine(idleSet, sets.buff.Doom)
	end
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	if state.Buff.Migawari then
		meleeSet = set_combine(meleeSet, sets.buff.Migawari)
	end
	if state.Buff.Doom then
		meleeSet = set_combine(meleeSet, sets.buff.Doom)
	end
	return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	-- If we gain or lose any haste buffs, adjust which gear set we target.
	if S{'haste','march','embrava','haste samba'}:contains(buff:lower()) then
		determine_haste_group()
		handle_equipping_gear(player.status)
	elseif state.Buff[buff] ~= nil then
		state.Buff[buff] = gain
		handle_equipping_gear(player.status)
	end
end

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
	determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function select_movement()
	-- world.time is given in minutes into each day
	-- 7:00 AM would be 420 minutes
	-- 17:00 PM would be 1020 minutes
	if world.time >= 1020 or world.time <= 420 then
		return sets.NightMovement
	else
		return sets.DayMovement
	end
end

function determine_haste_group()
	-- We have three groups of DW in gear: Hachiya body/legs, Iga head + Patentia Sash, and DW earrings
	
	-- Standard gear set reaches near capped delay with just Haste (77%-78%, depending on HQs)

	-- For high haste, we want to be able to drop one of the 10% groups.
	-- Basic gear hits capped delay (roughly) with:
	-- 1 March + Haste
	-- 2 March
	-- Haste + Haste Samba
	-- 1 March + Haste Samba
	-- Embrava
	
	-- High haste buffs:
	-- 2x Marches + Haste Samba == 19% DW in gear
	-- 1x March + Haste + Haste Samba == 22% DW in gear
	-- Embrava + Haste or 1x March == 7% DW in gear
	
	-- For max haste (capped magic haste + 25% gear haste), we can drop all DW gear.
	-- Max haste buffs:
	-- Embrava + Haste+March or 2x March
	-- 2x Marches + Haste
	
	-- So we want four tiers:
	-- Normal DW
	-- 20% DW -- High Haste
	-- 7% DW (earrings) - Embrava Haste (specialized situation with embrava and haste, but no marches)
	-- 0 DW - Max Haste
	
	classes.CustomMeleeGroups:clear()
	
	if buffactive.embrava and (buffactive.march == 2 or (buffactive.march and buffactive.haste)) then
		classes.CustomMeleeGroups:append('MaxHaste')
	elseif buffactive.march == 2 and buffactive.haste then
		classes.CustomMeleeGroups:append('MaxHaste')
	elseif buffactive.embrava and (buffactive.haste or buffactive.march) then
		classes.CustomMeleeGroups:append('EmbravaHaste')
	elseif buffactive.march == 1 and buffactive.haste and buffactive['haste samba'] then
		classes.CustomMeleeGroups:append('HighHaste')
	elseif buffactive.march == 2 then
		classes.CustomMeleeGroups:append('HighHaste')
	end
end


