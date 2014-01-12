-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and it's supplementary files) to go with this.

function get_sets()
	-- Load and initialize the include file that this depends on.
	include('Mote-Include.lua')
	init_include()
	
	-- Options: Override default values
	options.OffenseModes = {'Normal'}
	options.DefenseModes = {'Normal'}
	options.WeaponskillModes = {'Normal'}
	options.CastingModes = {'Normal'}
	options.IdleModes = {'Normal', 'PDT'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'PDT'}
	options.MagicalDefenseModes = {'MDT'}

	state.Defense.PhysicalMode = 'PDT'

	state.Buff["Avatar's Favor"] = buffactive["Avatar's Favor"] or false
	state.Buff.Pet = pet.isvalid or false
	
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Astral Flow'] = {head="Summoner's Horn +2"}
	
	sets.precast.JA['Elemental Siphon'] = {head="Caller's Pigaches +2"} -- back="Conveyance Cape"

	sets.precast.JA['Mana Cede'] = {hands="Caller's Bracers +2"}

	-- Pact delay reduction gear
	sets.precast.BloodPactWard = {ammo="Eminent Sachet",head="Convoker's Horn",body="Convoker's Doublet",hands="Summoner's Bracers"}

	sets.precast.BloodPactRage = sets.precast.BloodPactWard

	-- Fast cast sets for spells
	
	sets.precast.FC = {
		head="Nahtirah Hat",ear2="Loquacious Earring",
		ring1="Prolix Ring",
		back="Swith Cape",waist="Witful Belt",legs="Orvail Pants +1",feet="Chelona Boots +1"}

	sets.precast.FC.EnhancingMagic = set_combine(sets.precast.FC, {waist="Siegel Sash"})

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Nahtirah Hat",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Convoker's Doublet",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Pahtli Cape",waist="Cascade Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Myrkr'] = {
		head="Nahtirah Hat",ear1="Gifted Earring",ear2="Loquacious Earring",
		body="Convoker's Doublet",hands="Caller's Bracers +2",ring1="Evoker's Ring",ring2="Sangoma Ring",
		back="Pahtli Cape",waist="Hierarch Belt",legs="Nares Trews",feet="Chelona Boots +1"}

	
	-- Midcast Sets
	sets.midcast.FastRecast = {
		head="Nahtirah Hat",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Bokwus Gloves",ring1="Prolix Ring",
		back="Swith Cape",waist="Witful Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

	sets.midcast.Cure = {main="Tamaxchi",sub="Genbu's Shield",
		head="Nahtirah Hat",ear2="Loquacious Earring",
		body="Heka's Kalasiris",hands="Bokwus Gloves",ring1="Prolix Ring",ring2="Sirona's Ring",
		back="Pahtli Cape",waist="Witful Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

	sets.midcast.Stoneskin = {waist="Siegel Sash"}

	sets.midcast.Pet.BloodPactWard = {main="Soulscourge",ammo="Eminent Sachet",
		head="Convoker's Horn",neck="Caller's Pendant",
		body="Caller's Doublet +2",hands="Summoner's Bracers",ring1="Evoker's Ring",ring2="Fervor Ring",
		waist="Diabolos's Rope",legs="Marduk's Shalwar +1"}
	
	sets.midcast.Pet.PhysicalBloodPactRage = set_combine(sets.midcast.Pet.BloodPactWard,
		{head="Bokwus Circlet",body="Convoker's Doublet",
		back="Tiresias' Cape",legs="Caller's Spats +2",feet="Summoner's Pigaches"})

	sets.midcast.Pet.MagicalBloodPactRage = set_combine(sets.midcast.Pet.BloodPactWard,
		{main="Uffrat +1",head="Bokwus Circlet",body="Convoker's Doublet",
		back="Tiresias' Cape",legs="Caller's Spats +2",feet="Hagondes Sabots"})
	
	sets.midcast.Pet.Spirit = set_combine(sets.midcast.Pet.BloodPactRage, {legs="Summoner's Spats"})

	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {main=gear.Staff.HMP,ammo="Eminent Sachet",
		head="Convoker's Horn",neck="Wiglen Gorget",ear1="Gifted Earring",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Pahtli Cape",waist="Austerity Belt",legs="Nares Trews",feet="Chelona Boots +1"}
	

	-- Idle sets
	sets.idle = {main="Owleyes",sub="Genbu's Shield",ammo="Eminent Sachet",
		head="Convoker's Horn",neck="Wiglen Gorget",ear1="Gifted Earring",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Umbra Cape",waist="Hierarch Belt",legs="Nares Trews",feet="Herald's Gaiters"}

	sets.idle.PDT = {main=gear.Staff.PDT,sub="Achaq Grip",ammo="Eminent Sachet",
		head="Convoker's Horn",neck="Twilight Torque",ear1="Gifted Earring",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Dark Ring",ring2="Paguroidea Ring",
		back="Umbra Cape",waist="Hierarch Belt",legs="Hagondes Pants",feet="Herald's Gaiters"}

	sets.idle.Pet = {main="Patriarch Cane",sub="Genbu's Shield",ammo="Eminent Sachet",
		head="Convoker's Horn",neck="Wiglen Gorget",ear1="Gifted Earring",ear2="Loquacious Earring",
		body="Caller's Doublet +2",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Umbra Cape",waist="Hierarch Belt",legs="Nares Trews",feet="Caller's Pigaches +2"}

	sets.idle.PDT.Pet = {main="Patriarch Cane",sub="Genbu's Shield",ammo="Eminent Sachet",
		head="Convoker's Horn",neck="Wiglen Gorget",ear1="Gifted Earring",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Dark Ring",ring2="Paguroidea Ring",
		back="Umbra Cape",waist="Hierarch Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

	sets.idle.Town = {main="Patriarch Cane",sub="Genbu's Shield",ammo="Eminent Sachet",
		head="Convoker's Horn",neck="Wiglen Gorget",ear1="Gifted Earring",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Umbra Cape",waist="Hierarch Belt",legs="Nares Trews",feet="Herald's Gaiters"}

	sets.idle.Pet.Favor = {head="Caller's Horn +2"}
	sets.idle.Pet.Melee = {hands="Summoner's Bracers",waist="Kuku Stone",legs="Convoker's Spats"}
		
	sets.perp = {}
	sets.perp.Day = {hands="Caller's Bracers +2"}
	sets.perp.Weather = {neck="Caller's Pendant",hands="Caller's Bracers +2"}
	sets.perp.Carbuncle = {hands="Carbuncle Mitts"}
	sets.perp.Diabolos = {waist="Diabolos's Rope"}
	
	-- Defense sets
	sets.defense.PDT = {main=gear.Staff.PDT,
		head="Hagondes Hat",neck="Wiglen Gorget",ear1="Gifted Earring",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Umbra Cape",waist="Hierarch Belt",legs="Nares Trews",feet="Hagondes Sabots"}

	sets.defense.MDT = {
		head="Hagondes Hat",neck="Twilight Torque",ear1="Gifted Earring",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Umbra Cape",waist="Hierarch Belt",legs="Nares Trews",feet="Hagondes Sabots"}

	sets.Kiting = {feet="Herald's Gaiters"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {ammo="Eminent Sachet",
		head="Zelus Tiara",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Hagondes Coat",hands="Bokwus Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Umbra Cape",waist="Goading Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}


	spirits = S{"Light Spirit", "Dark Spirit", "Fire Spirit", "Earth Spirit", "Water Spirit", "Air Spirit", "Ice Spirit", "Thunder Spirit"}
	avatars = S{"Carbuncle", "Fenrir", "Diabolos", "Ifrit", "Titan", "Leviathan", "Garuda", "Shiva", "Ramuh", "Odin", "Alexander"}

	magicalRagePacts = S{
		'Inferno','Earthen Fury','Tidal Wave','Aerial Blast','Diamond Dust','Judgement Bolt','Searing Light','Howling Moon','Ruinous Omen',
		'Fire II','Stone II','Water II','Aero II','Blizzard II','Thunder II',
		'Fire IV','Stone IV','Water IV','Aero IV','Blizzard IV','Thunder IV',
		'Thunderspark','Burning Strike','Meteorite','Nether Blast','Flaming Crush',
		'Meteor Strike','Heavenly Strike','Wind Blade','Geocrush','Grand Fall','Thunderstorm',
		'Holy Mist','Lunar Bay','Night Terror'}

	set_macro_page(1, 16)
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

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)

end


-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)

end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		equip(sets.midcast.FastRecast)
	end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)

end

-- Runs when a pet initiates an action.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_midcast(spell, action, spellMap, eventArgs)
	if spirits:contains(pet.name) then
		classes.CustomClass = 'Spirit'
	elseif magicalRagePacts:contains(spell.english) then
		classes.CustomClass = 'MagicalBloodPactRage'
	else
		classes.CustomClass = 'PhysicalBloodPactRage'
	end
end

-- Run after the default pet midcast() is done.
-- eventArgs is the same one used in job_pet_midcast, in case information needs to be persisted.
function job_pet_post_midcast(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if not spell.interrupted then
		if state.Buff[spell.name] ~= nil then
			state.Buff[spell.name] = true
		elseif spell.type == 'SummonerPact' then
			state.Buff.Pet = true
		elseif spell.english == 'Release' then
			state.Buff.Pet = false
		end
	end
end

-- Run after the default aftercast() is done.
-- eventArgs is the same one used in job_aftercast, in case information needs to be persisted.
function job_post_aftercast(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_aftercast(spell, action, spellMap, eventArgs)

end

-- Run after the default pet aftercast() is done.
-- eventArgs is the same one used in job_pet_aftercast, in case information needs to be persisted.
function job_pet_post_aftercast(spell, action, spellMap, eventArgs)

end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)

end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	if state.Buff.Pet or pet.isvalid then
		if pet.element == world.day_element then
			idleSet = set_combine(idleSet, sets.perp.Day)
		end
		if pet.element == world.weather_element then
			idleSet = set_combine(idleSet, sets.perp.Weather)
		end
		if sets.perp[pet.name] then
			idleSet = set_combine(idleSet, sets.perp[pet.name])
		end
		if state.Buff["Avatar's Favor"] then
			idleSet = set_combine(idleSet, sets.idle.Pet.Favor)
		end
		if pet.status == 'Engaged' then
			idleSet = set_combine(idleSet, sets.idle.Pet.Melee)
		end
	end
	
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)

end

-- Called when the player's pet's status changes.
function job_pet_status_change(newStatus, oldStatus, eventArgs)
	if newStatus == 'Engaged dead' then
		state.Buff.Pet = false
	elseif newStatus == 'Engaged' or oldStatus == 'Engaged' and not midaction() then
		handle_equipping_gear(player.status, newStatus)
	end
end


-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if state.Buff[buff] ~= nil then
		state.Buff[buff] = gain
	elseif storms:contains(buff) then
		handle_equipping_gear(player.status)
	end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
	if cmdParams[1]:lower() == 'petweather' then
		handle_petweather()
		eventArgs.handled = true
	elseif cmdParams[1]:lower() == 'siphon' then
		handle_siphoning()
		eventArgs.handled = true
	elseif cmdParams[1]:lower() == 'pact' then
		handle_pacts(cmdParams)
		eventArgs.handled = true
	end
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
	state.Buff.Pet = pet.isvalid
end

-- Handle notifications of user state values being changed.
function job_state_change(stateField, newValue)

end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Cast the appopriate storm for the currently summoned avatar, if possible.
function handle_petweather()
	if player.sub_job ~= 'SCH' then
		add_to_chat(122, "You can not cast storm spells")
		return
	end
		
	if not pet.isvalid then
		add_to_chat(122, "You do not have an active avatar.")
		return
	end
	
	local element = pet.element
	if element == 'Thunder' then
		element = 'Lightning'
	end
	
	if S{'Light','Dark','Lightning'}:contains(element) then
		add_to_chat(122, 'You do not have access to '..storm_by_element[element]..'.')
		return
	end	
	
	local storm = storm_by_element[element]
	
	if storm then
		send_command('input /ma "'..storm_by_element[element]..'" <me>')
	else
		add_to_chat(123, 'Error: Unknown element ('..tostring(element)..')')
	end
end


-- Custom uber-handling of Elemental Siphon
function handle_siphoning()
	if areas.Cities:contains(world.area) then
		add_to_chat(122, 'Cannot use Elemental Siphon in a city area.')
		return
	end

	local siphonElement
	local stormElementToUse
	local releasedAvatar
	local dontRelease
	
	-- If we already have a spirit out, just use that.
	if pet.isvalid and spirits:contains(pet.name) then
		siphonElement = pet.element
		dontRelease = true
		-- If current weather doesn't match the spirit, but the spirit matches the day, try to cast the storm.
		if player.sub_job == 'SCH' and pet.element == world.day_element and pet.element ~= world.weather_element then
			if not S{'Light','Dark','Lightning'}:contains(pet.element) then
				stormElementToUse = pet.element
			end
		end
	-- If we're subbing /sch, there are some conditions where we want to make sure specific weather is up.
	-- If current (single) weather is opposed by the current day, we want to change the weather to match
	-- the current day, if possible.
	elseif player.sub_job == 'SCH' and world.weather_element ~= 'None' then
		local intense = get_weather_intensity()
		-- We can override single-intensity weather; leave double weather alone, since even if
		-- it's partially countered by the day, it's not worth changing.
		if intense == 1 then
			-- If current weather is weak to the current day, it cancels the benefits for
			-- siphon.  Change it to the day's weather if possible (+0 to +20%), or any non-weak
			-- weather if not.
			-- If the current weather matches the current avatar's element (being used to reduce
			-- perpetuation), don't change it; just accept the penalty on Siphon.
			if world.weather_element == weak_by_element[world.day_element] and
				(not pet.isvalid or world.weather_element ~= pet.element) then
				-- We can't cast lightning/dark/light weather, so use a neutral element
				if S{'Light','Dark','Lightning'}:contains(world.day_element) then
					stormElementToUse = 'Wind'
				else
					stormElementToUse = world.day_element
				end
			end
		end
	end
	
	-- If we decided to use a storm, set that as the spirit element to cast.
	if stormElementToUse then
		siphonElement = stormElementToUse
	elseif world.weather_element ~= 'None' and world.weather_element ~= weak_by_element[world.day_element] then
		siphonElement = world.weather_element
	else
		siphonElement = world.day_element
	end
	
	local command = ''
	local releaseWait = 0
	
	if pet.isvalid and avatars:contains(pet.name) then
		command = command..'input /pet "Release" <me>;wait 1.1;'
		releasedAvatar = pet.name
		releaseWait = 10
	end
	
	if stormElementToUse then
		command = command..'input /ma "'..storm_by_element[stormElementToUse]..'" <me>;wait 4;'
		releaseWait = releaseWait - 4
	end
	
	if not (pet.isvalid and spirits:contains(pet.name)) then
		command = command..'input /ma "'..spirit_by_element[siphonElement]..'" <me>;wait 4;'
		releaseWait = releaseWait - 4
	end
	
	command = command..'input /ja "Elemental Siphon" <me>;'
	releaseWait = releaseWait - 1
	releaseWait = releaseWait + 0.1
	
	if not dontRelease then
		if releaseWait > 0 then
			command = command..'wait '..tostring(releaseWait)..';'
		else
			command = command..'wait 1.1;'
		end
		
		command = command..'input /pet "Release" <me>;'
	end
	
	if releasedAvatar then
		command = command..'wait 1.1;input /ma "'..releasedAvatar..'" <me>'
	end
	
	send_command(command)
end


-- Handles executing blood pacts in a generic, avatar-agnostic way.
-- cmdParams is the split of the self-command.
-- gs c [pact] [pacttype]
function handle_pacts(cmdParams)
	if not pet.isvalid then
		add_to_chat(123,'No avatar currently available.')
		return
	end

	if spirits:contains(pet.name) then
		add_to_chat(123,'Cannot use pacts with spirits.')
		return
	end

	
end
