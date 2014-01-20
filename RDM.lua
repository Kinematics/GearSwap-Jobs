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
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()
	binds_on_unload()

	if user_unload then
		user_unload()
	end
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	-- Default macro set/book
	set_macro_page(3, 4)
	
	-- Options: Override default values
	options.OffenseModes = {'Normal'}
	options.DefenseModes = {'Normal'}
	options.WeaponskillModes = {'Normal'}
	options.CastingModes = {'Normal'}
	options.IdleModes = {'Normal'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'PDT'}
	options.MagicalDefenseModes = {'MDT'}

	state.Defense.PhysicalMode = 'PDT'
	
	state.Buff.Saboteur = buffactive.saboteur or false
	
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Chainspell'] = {body="Duelist's Tabard +2"}
	

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Atrophy Chapeau +1",
		body="Atrophy Tabard +1",hands="Yaoyotl Gloves",
		back="Refraction Cape",legs="Hagondes Pants",feet="Hagondes Sabots"}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	
	-- 80% Fast Cast (including trait) for all spells, plus 5% quick cast
	-- No other FC sets necessary.
	sets.precast.FC = {ammo="Impatiens",
		head="Atrophy Chapeau +1",ear2="Loquacious Earring",
		body="Duelist's Tabard +2",hands="Gendewitha Gages",ring1="Prolix Ring",
		back="Swith Cape",waist="Witful Belt",legs="Orvail Pants +1",feet="Chelona Boots +1"}

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Atrophy Chapeau +1",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Atheling Mantle",waist="Caudata Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, 
		{neck="Soil Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		ring1="Aquasoul Ring",ring2="Aquasoul Ring",waist="Soil Belt"})

	sets.precast.WS['Sanguine Blade'] = {ammo="Witchstone",
		head="Hagondes Hat",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Icesoul Ring",ring2="Strendu Ring",
		back="Toro Cape",legs="Hagondes Pants",feet="Hagondes Sabots"}

	
	-- Midcast Sets
	
	sets.midcast.FastRecast = {
		head="Atrophy Chapeau +1",ear2="Loquacious Earring",
		body="Duelist's Tabard +2",hands="Gendewitha Gages",ring1="Prolix Ring",
		back="Swith Cape",waist="Witful Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

	sets.midcast.Cure = {
		head="Gendewitha Caubeen",ear2="Loquacious Earring",
		body="Heka's Kalasiris",hands="Bokwus Gloves",ring1="Ephedra Ring",ring2="Sirona's Ring",
		back="Swith Cape",waist="Witful Belt",legs="Nares Trews",feet="Hagondes Sabots"}
		
	sets.midcast.Curaga = sets.midcast.Cure

	sets.midcast.EnhancingMagic = {
		head="Atrophy Chapeau +1",neck="Colossus's Torque",
		body="Duelist's Tabard +2",hands="Atrophy Gloves",ring1="Prolix Ring",
		back="Estoqueur's Cape",waist="Olympus Sash",legs="Portent Pants",feet="Estoqueur's Houseaux +2"}

	sets.midcast.Refresh = {legs="Estoqueur's Fuseau +2"}

	sets.midcast.Stoneskin = {waist="Siegel Sash"}
	
	sets.midcast.EnfeeblingMagic = {ammo="Impatiens",
		head="Atrophy Chapeau +1",neck="Weike Torque",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Atrophy Tabard +1",hands="Yaoyotl Gloves",ring1="Aquasoul Ring",ring2="Sangoma Ring",
		back="Refraction Cape",waist="Cascade Belt",legs="Bokwus Slops",feet="Bokwus Boots"}

	sets.midcast['Dia III'] = set_combine(sets.midcast.EnfeeblingMagic, {head="Duelist's Chapeau +2"})

	sets.midcast['Slow II'] = set_combine(sets.midcast.EnfeeblingMagic, {head="Duelist's Chapeau +2"})
	
	sets.midcast.ElementalMagic = {
		head="Hagondes Hat",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Icesoul Ring",ring2="Strendu Ring",
		back="Toro Cape",waist="Witful Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

	sets.midcast.DarkMagic = {
		head="Atrophy Chapeau +1",neck="Weike Torque",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Atrophy Tabard +1",hands="Yaoyotl Gloves",ring1="Prolix Ring",ring2="Sangoma Ring",
		back="Refraction Cape",waist="Goading Belt",legs="Bokwus Slops",feet="Bokwus Boots"}

	--sets.midcast.Drain = set_combine(sets.midcast.DarkMagic, {ring2="Excelsis Ring"})

	--sets.midcast.Aspir = sets.midcast.Drain


	-- Sets for special buff conditions on spells.

	sets.midcast.EnhancingDuration = {hands="Atrophy Gloves",back="Estoqueur's Cape",feet="Estoqueur's Houseaux +2"}
		
	sets.buff.ComposureOther = {head="Estoqueur's Chappel +2",
		body="Estoqueur's Sayon +2",hands="Estoqueur's Gantherots +2",
		legs="Estoqueur's Fuseau +2",feet="Estoqueur's Houseaux +2"}

	sets.buff.Saboteur = {hands="Estoqueur's Gantherots"}
	

	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {main="Chatoyant Staff",
		head="Duelist's Chapeau +2",neck="Wiglen Gorget",
		body="Atrophy Tabard +1",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		waist="Austerity Belt",legs="Nares Trews",feet="Chelona Boots +1"}
	

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle.Town = {ammo="Impatiens",
		head="Atrophy Chapeau +1",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Atrophy Tabard +1",hands="Atrophy Gloves",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Shadow Mantle",waist="Flume Belt",legs="Crimson Cuisses",feet="Hagondes Sabots"}
	
	sets.idle.Field = {ammo="Impatiens",
		head="Duelist's Chapeau +2",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Shadow Mantle",waist="Flume Belt",legs="Crimson Cuisses",feet="Hagondes Sabots"}

	sets.idle.Weak = {ammo="Impatiens",
		head="Duelist's Chapeau +2",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Atrophy Tabard +1",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Shadow Mantle",waist="Flume Belt",legs="Crimson Cuisses",feet="Hagondes Sabots"}
	
	-- Defense sets
	sets.defense.PDT = {
		head="Atrophy Chapeau +1",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Gendewitha Gages",ring1="Dark Ring",ring2="Dark Ring",
		back="Shadow Mantle",waist="Flume Belt",legs="Hagondes Pants",feet="Gendewitha Galoshes"}

	sets.defense.MDT = {ammo="Demonry Stone",
		head="Atrophy Chapeau +1",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Atrophy Tabard +1",hands="Yaoyotl Gloves",ring1="Dark Ring",ring2="Shadow Ring",
		back="Engulfer Cape",waist="Flume Belt",legs="Hagondes Pants",feet="Gendewitha Galoshes"}

	sets.Kiting = {legs="Crimson Cuisses"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	MeleeWeapons = S{"Buramenk'ah"}
	
	-- Normal melee group
	sets.engaged = {
		head="Atrophy Chapeau +1",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Atrophy Tabard +1",hands="Atrophy Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Atheling Mantle",waist="Goading Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		-- Default base equipment layer of fast recast.
		equip(sets.midcast.FastRecast)
	end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.skill == 'EnfeeblingMagic' and state.Buff.Saboteur then
		equip(sets.buff.Saboteur)
	elseif spell.skill == 'EnhancingMagic' then
		if buffactive.composure and spell.target.type == 'PLAYER' then
			equip(sets.buff.ComposureOther)
		elseif spell.target.type == 'SELF' then
			equip(sets.midcast.EnhancingDuration)
		end
	end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if not spell.interrupted then
		if state.Buff[spell.english] ~= nil then
			state.Buff[spell.english] = true
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------


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

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
	if MeleeWeapons:contains(player.equipment.main) then
		disable('main', 'sub')
	else
		enable('main', 'sub')
	end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

