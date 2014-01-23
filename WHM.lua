-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
	-- Load and initialize the include file.
	include('Mote-Include.lua')
	init_include()

	-- Global default binds
	binds_on_load()
	
	-- UserGlobals may define additional sets to be added to the local ones.
	if define_global_sets then
		define_global_sets()
	end

	-- Optional: load a sidecar version of the init and unload functions.
	load_user_gear(player.main_job)
	
	init_gear_sets()
end

-- Called when this job file is unloaded (eg: job change)
function file_unload()
	binds_on_unload()
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	-- Default macro set/book
	set_macro_page(4, 14)
	
	-- Options: Override default values
	options.OffenseModes = {'None', 'Normal'}
	options.DefenseModes = {'Normal'}
	options.WeaponskillModes = {'Normal'}
	options.CastingModes = {'Normal', 'Resistant', 'Dire'}
	options.IdleModes = {'Normal', 'PDT'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'PDT'}
	options.MagicalDefenseModes = {'MDT'}
	
	state.Defense.PhysicalMode = 'PDT'
	state.OffenseMode = 'None'
	
	state.Buff['Afflatus Solace'] = buffactive['afflatus solace'] or false

	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Precast Sets

	-- Fast cast sets for spells
	sets.precast.FC = {main=gear.FastcastStaff,ammo="Incantor Stone",
		head="Nahtirah Hat",neck="Orison Locket",ear2="Loquacious Earring",
		hands="Gendewitha Gages",ring1="Prolix Ring",
		back="Swith Cape",legs="Orvail Pants +1",feet="Chelona Boots +1"}
		
	sets.precast.FC.EnhancingMagic = set_combine(sets.precast.FC, {waist="Siegel Sash"})

	sets.precast.FC.HealingMagic = set_combine(sets.precast.FC, {legs="Orison Pantaloons +2"})

	sets.precast.FC.StatusRemoval = sets.precast.FC.HealingMagic

	sets.precast.FC.Cure = set_combine(sets.precast.FC.HealingMagic, {
		ammo="Impatiens",
		head="Theophany Cap +1",
		body="Heka's Kalasiris",
		back="Pahtli Cape",waist="Witful Belt",feet="Cure Clogs"})

	sets.precast.FC.Curaga = sets.precast.FC.Cure
	
	-- Precast sets to enhance JAs
	sets.precast.JA.Benediction = {body="Cleric's Briault +2"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Nahtirah Hat",ear1="Roundel Earring",
		body="Gendewitha Bliaut",hands="Yaoyotl Gloves",
		back="Refraction Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
	
	
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Nahtirah Hat",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Gendewitha Bliaut",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Tuilha Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Hexa Strike'] = {
		head="Nahtirah Hat",neck=gear.ElementalGorget,ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Gendewitha Bliaut",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Tuilha Cape",waist="Light Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}

	sets.precast.WS['Mystic Boon'] = {
		head="Nahtirah Hat",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Gendewitha Bliaut",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Tuilha Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}

	sets.precast.WS['Flash Nova'] = {
		head="Nahtirah Hat",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Bokwus Robe",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="Strendu Ring",
		back="Toro Cape",waist="Thunder Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
	
	
	-- Midcast Sets
	
	sets.midcast.FastRecast = {
		head="Nahtirah Hat",ear2="Loquacious Earring",
		body="Goliard Saio",hands="Gendewitha Gages",ring1="Prolix Ring",
		back="Swith Cape",waist="Goading Belt",legs="Theophany Pantaloons",feet="Gendewitha Galoshes"}
	
	-- Cure sets
	sets.midcast.CureSolace = {main="Tamaxchi",sub="Genbu's Shield",ammo="Incantor Stone",
		head="Theophany Cap +1",neck="Orison Locket",ear1="Orison Earring",ear2="Loquacious Earring",
		body="Orison Bliaud +2",hands="Bokwus Gloves",ring1="Prolix Ring",ring2="Sangoma Ring",
		back=gear.ElementalCape,waist=gear.ElementalBelt,legs="Orison Pantaloons +2",feet="Gendewitha Galoshes"}

	sets.midcast.Cure = {main="Tamaxchi",sub="Genbu's Shield",ammo="Incantor Stone",
		head="Nahtirah Hat",neck="Orison Locket",ear1="Lifestorm Earring",ear2="Loquacious Earring",
		body="Heka's Kalasiris",hands="Bokwus Gloves",ring1="Prolix Ring",ring2="Sangoma Ring",
		back=gear.ElementalCape,waist=gear.ElementalBelt,legs="Orison Pantaloons +2",feet="Gendewitha Galoshes"}

	sets.midcast.Curaga = {main="Tamaxchi",sub="Genbu's Shield",ammo="Incantor Stone",
		head="Nahtirah Hat",neck="Orison Locket",ear1="Lifestorm Earring",ear2="Loquacious Earring",
		body="Heka's Kalasiris",hands="Bokwus Gloves",ring1="Prolix Ring",ring2="Sangoma Ring",
		back=gear.ElementalCape,waist=gear.ElementalBelt,legs="Orison Pantaloons +2",feet="Gendewitha Galoshes"}

	sets.midcast.CureMelee = {ammo="Incantor Stone",
		head="Nahtirah Hat",neck="Orison Locket",ear1="Lifestorm Earring",ear2="Loquacious Earring",
		body="Heka's Kalasiris",hands="Bokwus Gloves",ring1="Prolix Ring",ring2="Sangoma Ring",
		back=gear.ElementalCape,waist=gear.ElementalBelt,legs="Orison Pantaloons +2",feet="Gendewitha Galoshes"}

	
	sets.midcast.Cursna = {
		head="Orison Cap +2",neck="Malison Medallion",
		hands="Hieros Mittens",ring1="Ephedra Ring",
		legs="Theophany Pantaloons",feet="Gendewitha Galoshes"}

	sets.midcast.Stoneskin = {
		head="Nahtirah Hat",neck="Orison Locket",ear2="Loquacious Earring",
		body="Gendewitha Bliaut",hands="Gendewitha Gages",
		back="Swith Cape",waist="Siegel Sash",feet="Gendewitha Galoshes"}

	sets.midcast.Auspice = {feet="Orison Duckbills +2"}

	sets.midcast.Barspell = {main="Beneficus",sub="Genbu's Shield",
		head="Orison Cap +2",neck="Colossus's Torque",
		body="Orison Bliaud +2",hands="Orison Mitts +2",
		waist="Olympus Sash",legs="Cleric's Pantaloons +2",feet="Orison Duckbills +2"}

	sets.midcast.Regen = {
		body="Cleric's Briault",hands="Orison Mitts +2",
		legs="Theophany Pantaloons"}

	sets.midcast.StatusRemoval = {
		head="Orison Cap +2",legs="Orison Pantaloons +2"}

	sets.midcast.Protectra = {ring1="Sheltered Ring"}

	sets.midcast.Shellra = {ring1="Sheltered Ring",legs="Cleric's Pantaloons +2"}

	-- Spell skill categories
	sets.midcast.EnhancingMagic = {main="Beneficus",sub="Genbu's Shield",
		body="Manasa Chasuble",hands="Dynasty Mitts",
		waist="Olympus Sash",legs="Cleric's Pantaloons +2",feet="Orison Duckbills +2"}

	sets.midcast.DivineMagic = {main="Tamaxchi",sub="Genbu's Shield",
		head="Nahtirah Hat",neck="Colossus's Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
		body="Manasa Chasuble",hands="Yaoyotl Gloves",ring2="Sangoma Ring",
		back=gear.ElementalCape,waist=gear.ElementalBelt,legs="Theophany Pantaloons",feet="Orison Duckbills +2"}

	sets.midcast.DarkMagic = {main="Tamaxchi", sub="Genbu's Shield",
		head="Nahtirah Hat",neck="Aesir Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
		body="Manasa Chasuble",hands="Yaoyotl Gloves",ring1="Strendu Ring",ring2="Sangoma Ring",
		back="Refraction Cape",waist="Demonry Sash",legs="Bokwus Slops",feet="Bokwus Boots"}

	sets.midcast.Stun = set_combine(sets.midcast.DarkMagic, {main=gear.RecastStaff})

	-- Custom spell classes
	sets.midcast.MndEnfeebles = {main="Tamaxchi", sub="Genbu's Shield",
		head="Nahtirah Hat",neck="Weike Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
		body="Manasa Chasuble",hands="Yaoyotl Gloves",ring1="Aquasoul Ring",ring2="Sangoma Ring",
		back="Refraction Cape",waist="Demonry Sash",legs="Gendewitha Spats",feet="Bokwus Boots"}

	sets.midcast.IntEnfeebles = {main="Tamaxchi", sub="Genbu's Shield",
		head="Nahtirah Hat",neck="Weike Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
		body="Manasa Chasuble",hands="Yaoyotl Gloves",ring1="Icesoul Ring",ring2="Sangoma Ring",
		back="Refraction Cape",waist="Demonry Sash",legs="Orvail Pants +1",feet="Bokwus Boots"}

	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {main=gear.Staff.HMP, 
		head="Nefer Khat +1",
		body="Heka's Kalasiris",hands="Serpentes Cuffs",
		waist="Austerity Belt",legs="Nares Trews",feet="Chelona Boots +1"}
	

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {main="Tamaxchi", sub="Genbu's Shield",ammo="Incantor Stone",
		head="Nefer Khat +1",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Heka's Kalasiris",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Umbra Cape",waist="Witful Belt",legs="Nares Trews",feet="Herald's Gaiters"}

	sets.idle.PDT = {main="Tamaxchi", sub="Genbu's Shield",ammo="Incantor Stone",
		head="Gendewitha Caubeen",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Gendewitha Bliaut",hands="Gendewitha Gages",ring1="Dark Ring",ring2="Dark Ring",
		back="Umbra Cape",waist="Witful Belt",legs="Gendewitha Spats",feet="Herald's Gaiters"}

	sets.idle.Town = {main="Tamaxchi", sub="Genbu's Shield",ammo="Incantor Stone",
		head="Gendewitha Caubeen",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Gendewitha Bliaut",hands="Gendewitha Gages",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Umbra Cape",waist="Witful Belt",legs="Nares Trews",feet="Herald's Gaiters"}
	
	sets.idle.Weak = {main="Tamaxchi",sub="Genbu's Shield",ammo="Incantor Stone",
		head="Gendewitha Caubeen",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Gendewitha Bliaut",hands="Yaoyotl Gloves",ring1="Dark Ring",ring2="Meridian Ring",
		back="Umbra Cape",waist="Witful Belt",legs="Nares Trews",feet="Gendewitha Galoshes"}
	
	sets.Owleyes = {main="Owleyes", sub="Genbu's Shield"}
	
	-- Defense sets

	sets.defense.PDT = {main=gear.Staff.PDT,sub="Achaq Grip",
		head="Gendewitha Caubeen",neck="Twilight Torque",
		body="Gendewitha Bliaut",hands="Gendewitha Gages",ring1=leftDarkRing,ring2=rightDarkRing,
		back="Umbra Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}

	sets.defense.MDT = {main=gear.Staff.PDT,sub="Achaq Grip",
		head="Theophany Cap +1",neck="Twilight Torque",
		body="Gendewitha Bliaut",hands="Yaoyotl Gloves",ring1=leftDarkRing,ring2="Shadow Ring",
		back="Tuilha Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}

	sets.Kiting = {feet="Herald's Gaiters"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Basic set for if no TP weapon is defined.
	sets.engaged = {
		head="Zelus Tiara",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Gendewitha Bliaut",hands="Dynasty Mitts",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Umbra Cape",waist="Goading Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}


	-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	sets.buff['Divine Caress'] = {hands="Orison Mitts +2"}


	gear.default.obi_waist = "Goading Belt"
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	if spell.english == "Paralyna" and buffactive.Paralyzed then
		-- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
		eventArgs.handled = true
	else
		classes.CustomClass = get_spell_class(spell, action, spellMap)
	end
	
	if spell.skill == 'HealingMagic' then
		gear.default.obi_back = "Refraction Cape"
	else
		gear.default.obi_back = "Toro Cape"
	end
end


function job_post_precast(spell, action, spellMap, eventArgs)
	-- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
	if eventArgs.useMidcastGear then
		if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
			equip(sets.buff['Divine Caress'])
		end
	end
	
	-- Ionis gives us an extra 3% fast cast, so we can drop Incantor Stone for Impatiens.
	--if (classes.CustomClass == 'CureSolace' or classes.CustomClass == 'CureMelee') and
	--	buffactive.ionis and areas.Adoulin[world.area:lower()] then
	--	equip({ammo="Impatiens"})
	--end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		-- Default base equipment layer of fast recast.
		equip(sets.midcast.FastRecast)
	end
	
	classes.CustomClass = get_spell_class(spell, action, spellMap)
end

function job_post_midcast(spell, action, spellMap, eventArgs)
	-- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
	if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
		equip(sets.buff['Divine Caress'])
	end
end

-- Return true if we handled the aftercast work.  Otherwise it will fall back
-- to the general aftercast() code in Mote-Include.
function job_aftercast(spell, action, spellMap, eventArgs)
	if not spell.interrupted then
		if state.Buff[spell.name] ~= nil then
			state.Buff[spell.name] = true
		elseif spell.name == "Afflatus Misery" then
			state.Buff['Afflatus Solace'] = false
		end
	end
end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
	if player.mpp < 90 and state.IdleMode == "Normal" and state.Defense.Active == false then
		idleSet = set_combine(idleSet, sets.Owleyes)
	end
	
	return idleSet
end


-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if state.Buff[buff] ~= nil then
		state.Buff[buff] = gain
	end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
	if cmdParams[1] == 'user' and not areas.Cities:contains(world.area) then
		local needsArts = player.sub_job:lower() == 'sch' and
			not buffactive['Light Arts'] and not buffactive['Addendum: White'] and
			not buffactive['Dark Arts'] and not buffactive['Addendum: Black']
			
		if not buffactive['Afflatus Solace'] and not buffactive['Afflatus Misery'] then
			if needsArts then
				windower.send_command('input /ja "Afflatus Solace" <me>;wait 1.2;input /ja "Light Arts" <me>')
			else
				windower.send_command('input /ja "Afflatus Solace" <me>')
			end
		end
	end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue)
	if stateField == 'OffenseMode' then
		if newValue == 'Normal' then
			disable('main','sub')
		else
			enable('main','sub')
		end
	elseif stateField == 'Reset' then
		if state.OffenseMode == 'None' then
			enable('main','sub')
		end
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

		defenseString = 'Defense: '..state.Defense.Type..' '..defMode..', '
	end

	add_to_chat(122,'Casting ['..state.CastingMode..'], Idle ['..state.IdleMode..'], '..defenseString..
		'Kiting: '..on_off_names[state.Kiting])

	eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function get_spell_class(spell, action, spellMap)
	if spell.action_type == 'Magic' then
		if spell.skill == "EnfeeblingMagic" then
			if spell.type == "WhiteMagic" then
				return "MndEnfeebles"
			else
				return "IntEnfeebles"
			end
		else
			if spellMap == 'Cure' and state.Buff['Afflatus Solace'] then
				return "CureSolace"
			elseif (spellMap == 'Cure' or spellMap == "Curaga") and player.status == 'Engaged' and player.equipment.main == 'Mondaha Cudgel' then
				return "CureMelee"
			end
		end
	end
	
	return nil
end
