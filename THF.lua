-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- NOTE: This is a work in progress, experimenting.  Expect it to change frequently, and maybe include debug stuff.

-- Last Modified: 12/25/2013 6:17:03 AM

-- IMPORTANT: Make sure to also get the Mote-Include.lua file to go with this.

function get_sets()
	-- Load and initialize the include file.
	include('Mote-Include.lua')
	init_include()
	
	-- Options: Override default values
	options.OffenseModes = {'Normal', 'Acc', 'Crit'}
	options.DefenseModes = {'Normal', 'Evasion', 'PDT'}
	options.WeaponskillModes = {'Normal', 'Acc', 'Att', 'Mod'}
	options.IdleModes = {'Normal'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'Evasion', 'PDT'}
	options.MagicalDefenseModes = {'MDT'}

	state.Defense.PhysicalMode = 'Evasion'
	
	-- TH mode handling
	options.THModes = {'None','Tag','SATA','Fulltime'}
	state.THMode = 'Tag'
	
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	sets.TreasureHunter = {hands="Assassin's Armlets +2", feet="Raider's Poulaines +2"}
	
	-- Precast Sets
	sets.precast = {}
	
	-- Precast sets to enhance JAs
	sets.precast.JA = {}

	sets.precast.JA['Collaborator'] = {head="Raider's Bonnet +2"}
	sets.precast.JA['Accomplice'] = {head="Raider's Bonnet +2"}
	sets.precast.JA['Flee'] = {feet="Pillager's Poulaines"}
	sets.precast.JA['Hide'] = {body="Rogue's Vest +1"}
	sets.precast.JA['Conspirator'] = {} -- {body="Raider's Vest +2"}
	sets.precast.JA['Steal'] = {head="Assassin's Bonnet +2",hands="Pillager's Armlets",feet="Pillager's Poulaines"}
	sets.precast.JA['Despoil'] = {legs="Raider's Culottes +2",feet="Raider's Poulaines +2"}
	sets.precast.JA['Perfect Dodge'] = {hands="Assassin's Armlets +2"}
	sets.precast.JA['Feint'] = {} -- {legs="Assassin's Culottes +2"}
	

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {ammo="Sonia's Plectrum",
		head="Whirlpool Mask",
		body="Iuitl Vest",hands="Buremte Gloves",
		back="Iximulew Cape",legs="Nahtirah Trousers",feet="Iuitl Gaiters"}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}
	
	sets.precast.Step = sets.TreasureHunter
	sets.precast.Flourish1 = sets.TreasureHunter

	-- Fast cast sets for spells
	
	sets.precast.FC = {ear2="Loquacious Earring",hands="Thaumas Gloves",ring1="Prolix Ring",legs="Enif Cosciales"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Thew Bomblet",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Manibozho Jerkin",hands="Buremte Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Caudata Belt",legs="Manibozho Brais",feet="Manibozho Boots"}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {ammo="Honed Tathlum", back="Letalis Mantle"})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Exenterator'] = {ammo="Thew Bomblet",
		head="Whirlpool Mask",neck="Houyi's Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Manibozho Jerkin",hands="Iuitl Wristbands",ring1="Stormsoul Ring",ring2="Epona's Ring",
		back="Atheling Mangle",waist="Caudata Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters"}
	sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {ammo="Honed Tathlum", back="Letalis Mantle"})
	sets.precast.WS['Exenterator'].Mod = set_combine(sets.precast.WS['Exenterator'], {waist="Thunder Belt"})

	sets.precast.WS['Dancing Edge'] = {ammo="Thew Bomblet",
		head="Whirlpool Mask",neck="Soil Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Manibozho Jerkin",hands="Buremte Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mangle",waist="Caudata Belt",legs="Manibozho Brais",feet="Iuitl Gaiters"}
	sets.precast.WS['Dancing Edge'].Acc = set_combine(sets.precast.WS['Dancing Edge'], {ammo="Honed Tathlum", back="Letalis Mantle"})
	sets.precast.WS['Dancing Edge'].Mod = set_combine(sets.precast.WS['Dancing Edge'], {waist="Soil Belt"})

	sets.precast.WS['Evisceration'] = {ammo="Charis Feather",
		head="Whirlpool Mask",neck="Rancor Collar",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Manibozho Jerkin",hands="Buremte Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mangle",waist="Caudata Belt",legs="Manibozho Brais",feet="Iuitl Gaiters"}
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {ammo="Honed Tathlum", back="Letalis Mantle"})
	sets.precast.WS['Evisceration'].Mod = set_combine(sets.precast.WS['Evisceration'], {waist="Soil Belt"})

	sets.precast.WS['Mandalic Stab'] = {ammo="Thew Bomblet",
		head="Whirlpool Mask",neck="Soil Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Manibozho Jerkin",hands="Buremte Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mangle",waist="Caudata Belt",legs="Manibozho Brais",feet="Iuitl Gaiters"}
	sets.precast.WS['Pyrrhic Kleos'].Acc = set_combine(sets.precast.WS['Pyrrhic Kleos'], {ammo="Honed Tathlum", back="Letalis Mantle"})
	sets.precast.WS['Pyrrhic Kleos'].Mod = set_combine(sets.precast.WS['Pyrrhic Kleos'], {waist="Soil Belt"})

	sets.precast.WS['Aeolian Edge'] = {ammo="Charis Feather",
		head="Thaumas Hat",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Manibozho Jerkin",hands="Buremte Gloves",ring1="Rajas Ring",ring2="Demon's Ring",
		back="Toro Cape",waist="Thunder Belt",legs="Iuitl Tights",feet="Iuitl Gaiters"}
	
	
	-- Midcast Sets
	sets.midcast = {}
	
	sets.midcast.FastRecast = {
		head="Whirlpool Mask",ear2="Loquacious Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",
		back="Ix Cape",waist="Twilight Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters"}
		
	-- Specific spells
	sets.midcast.Utsusemi = {
		head="Whirlpool Mask",neck="Torero Torque",ear2="Loquacious Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",
		back="Ix Cape",waist="Twilight Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters"}

	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",
		ring1="Sheltered Ring",ring2="Paguroidea Ring"}
	

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {}

	sets.idle.Town = {main="Izhiikoh", sub="Atoyac",ammo="Charis Feather",
		head="Whirlpool Mask",neck="Charis Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Charis Casaque +2",hands="Iuitl Wristbands",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Atheling Mantle",waist="Patentia Sash",legs="Kaabnax Trousers",feet="Skadi's Jambeaux +1"}
	
	sets.idle.Field = {ammo="Charis Feather",
		head="Whirlpool Mask",neck="Wiglen Gorget",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Iximulew Cape",waist="Flume Belt",legs="Kaabnax Trousers",feet="Skadi's Jambeaux +1"}

	sets.idle.Weak = {ammo="Charis Feather",
		head="Whirlpool Mask",neck="Wiglen Gorget",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Manibozho Jerkin",hands="Buremte Gloves",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Iximulew Cape",waist="Flume Belt",legs="Kaabnax Trousers",feet="Skadi's Jambeaux +1"}
	
	-- Defense sets
	sets.defense = {}

	sets.defense.Evasion = {
		head="Whirlpool Mask",neck="Torero Torque",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Dark Ring",
		back="Ik Cape",waist="Flume Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters"}

	sets.defense.PDT = {ammo="Iron Gobbet",
		head="Whirlpool Mask",neck="Twilight Torque",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Dark Ring",
		back="Iximulew Cape",waist="Flume Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters"}

	sets.defense.MDT = {ammo="Demonry Stone",
		head="Whirlpool Mask",neck="Twilight Torque",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Dark Ring",ring2="Shadow Ring",
		back="Engulfer Cape",waist="Flume Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters"}

	sets.Kiting = {feet="Skadi's Jambeaux +1"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {ammo="Charis Feather",
		head="Whirlpool Mask",neck="Charis Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Charis Casaque +2",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Patentia Sash",legs="Kaabnax Trousers",feet="Manibozho Boots"}
	sets.engaged.Acc = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Charis Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Charis Casaque +2",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Kaabnax Trousers",feet="Manibozho Boots"}
	sets.engaged.Evasion = {ammo="Charis Feather",
		head="Whirlpool Mask",neck="Torero Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Ik Cape",waist="Patentia Sash",legs="Kaabnax Trousers",feet="Iuitl Gaiters"}
	sets.engaged.Acc.Evasion = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Torero Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Kaabnax Trousers",feet="Iuitl Gaiters"}
	sets.engaged.PDT = {ammo="Charis Feather",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Dark Ring",ring2="Epona's Ring",
		back="Iximulew Cape",waist="Patentia Sash",legs="Kaabnax Trousers",feet="Iuitl Gaiters"}
	sets.engaged.Acc.PDT = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Dark Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Kaabnax Trousers",feet="Iuitl Gaiters"}

	-- Custom melee group: High Haste
	sets.engaged.HighHaste = {ammo="Charis Feather",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Thaumas Coat",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Patentia Sash",legs="Kaabnax Trousers",feet="Manibozho Boots"}
	sets.engaged.HighHaste.Acc = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Kaabnax Trousers",feet="Manibozho Boots"}
	sets.engaged.HighHaste.Evasion = {ammo="Charis Feather",
		head="Whirlpool Mask",neck="Torero Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Ik Cape",waist="Patentia Sash",legs="Kaabnax Trousers",feet="Iuitl Gaiters"}
	sets.engaged.HighHaste.Acc.Evasion = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Torero Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Kaabnax Trousers",feet="Iuitl Gaiters"}
	sets.engaged.HighHaste.PDT = {ammo="Charis Feather",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Dark Ring",ring2="Epona's Ring",
		back="Iximulew Cape",waist="Patentia Sash",legs="Iuitl Tights",feet="Iuitl Gaiters"}
	sets.engaged.HighHaste.Acc.PDT = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Dark Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Iuitl Tights",feet="Iuitl Gaiters"}

	-- Custom melee group: Max Haste
	sets.engaged.MaxHaste = {ammo="Charis Feather",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Thaumas Coat",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Kaabnax Trousers",feet="Manibozho Boots"}
	sets.engaged.MaxHaste.Acc = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Kaabnax Trousers",feet="Manibozho Boots"}
	sets.engaged.MaxHaste.Evasion = {ammo="Charis Feather",
		head="Whirlpool Mask",neck="Torero Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Ik Cape",waist="Windbuffet Belt",legs="Kaabnax Trousers",feet="Iuitl Gaiters"}
	sets.engaged.MaxHaste.Acc.Evasion = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Torero Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Kaabnax Trousers",feet="Iuitl Gaiters"}
	sets.engaged.MaxHaste.PDT = {ammo="Charis Feather",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Dark Ring",ring2="Epona's Ring",
		back="Iximulew Cape",waist="Windbuffet Belt",legs="Iuitl Tights",feet="Iuitl Gaiters"}
	sets.engaged.MaxHaste.Acc.PDT = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Dark Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Iuitl Tights",feet="Iuitl Gaiters"}



	windower.send_command('input /macro book 20;wait .1;input /macro set 10')
	gearswap_binds_on_load()

	windower.send_command('bind ^- gs c toggle target')
	windower.send_command('bind ^= gs c cycle targetmode')

	windower.send_command('bind ^` input /ja "Flee" <me>')
end

-- Called when this job file is unloaded (eg: job change)
function file_unload()
	spellcast_binds_on_unload()
	
	windower.send_command('unbind ^`')
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Return true if we handled the precast work.  Otherwise it will fall back
-- to the general precast() code in Mote-Include.
function job_precast(spell, action, spellMap)

end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap)

end


-- Return true if we handled the midcast work.  Otherwise it will fall back
-- to the general midcast() code in Mote-Include.
function job_midcast(spell, action, spellMap)

end

-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap)

end

-- Return true if we handled the aftercast work.  Otherwise it will fall back
-- to the general aftercast() code in Mote-Include.
function job_aftercast(spell, action)

end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)

end

function customize_melee_set(meleeSet)

end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function status_change(newStatus,oldStatus)

end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain_or_loss == 'gain' or 'loss', depending on the buff state change
function buff_change(buff,gain_or_loss)
	-- If we gain or lose any haste buffs, adjust which gear set we target.
	if S{'haste','march','embrava','haste samba'}[buff:lower()] then
		determine_haste_group()
		handle_equipping_gear(player.status)
	end
end


-------------------------------------------------------------------------------------------------------------------
-- Hooks for TH mode handling.
-------------------------------------------------------------------------------------------------------------------

-- Request job-specific mode tables.
-- Return true on the third returned value to indicate an error: that we didn't recognize the requested field.
function job_get_mode_table(field)
	if field == 'TH' then
		return options.THModes, state.THMode
	end
	
	-- Return an error if we don't recognize the field requested.
	return nil, nil, true
end

-- Set job-specific mode values.
-- Return true if we recognize and set the requested field.
function job_set_mode(field, val)
	if field == 'TH' then
		state.THMode = val
		return true
	end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for direct player commands.
function job_self_command(cmdParams)
	if cmdParams[1] == 'update' then
		determine_haste_group()
	end
end


-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state()

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
	
	if buffactive.embrava and (buffactive.haste or buffactive.march) and buffactive['haste samba'] then
		CustomMeleeGroup = 'MaxHaste'
	elseif buffactive.march == 2 and buffactive.haste and buffactive['haste samba'] then
		CustomMeleeGroup = 'MaxHaste'
	elseif buffactive.embrava and (buffactive.haste or buffactive.march or buffactive['haste samba']) then
		CustomMeleeGroup = 'HighHaste'
	elseif buffactive.march == 1 and buffactive.haste and buffactive['haste samba'] then
		CustomMeleeGroup = 'HighHaste'
	elseif buffactive.march == 2 and (buffactive.haste or buffactive['haste samba']) then
		CustomMeleeGroup = 'HighHaste'
	else
		CustomMeleeGroup = 'Normal'
	end
end

