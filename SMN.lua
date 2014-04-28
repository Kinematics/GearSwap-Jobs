-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and it's supplementary files) to go with this.

-- Also, you'll need the Shortcuts addon to handle the auto-targetting of the custom pact commands.

--[[
	Custom commands:
	
	gs c petweather
		Automatically casts the storm appropriate for the current avatar, if possible.
	
	gs c siphon
		Automatically run the process to: dismiss the current avatar; cast appropriate
		weather; summon the appropriate spirit; Elemental Siphon; release the spirit;
		and re-summon the avatar.
		
		Will not cast weather you do not have access to.
		Will not re-summon the avatar if one was not out in the first place.
		Will not release the spirit if it was out before the command was issued.
		
	gs c pact [PactType]
		Attempts to use the indicated pact type for the current avatar.
		PactType can be one of:
			cure
			curaga
			buffOffense
			buffDefense
			buffSpecial
			debuff1
			debuff2
			sleep
			nuke2
			nuke4
			bp70
			bp75 (merits and lvl 75-80 pacts)
			astralflow

--]]


-- Initialization function for this job file.
function get_sets()
	-- Load and initialize the include file.
	include('Mote-Include.lua')
end

-- Setup vars that are user-independent.
function job_setup()
	state.Buff["Avatar's Favor"] = buffactive["Avatar's Favor"] or false

	spirits = S{"LightSpirit", "DarkSpirit", "FireSpirit", "EarthSpirit", "WaterSpirit", "AirSpirit", "IceSpirit", "ThunderSpirit"}
	avatars = S{"Carbuncle", "Fenrir", "Diabolos", "Ifrit", "Titan", "Leviathan", "Garuda", "Shiva", "Ramuh", "Odin", "Alexander", "Cait Sith"}

	magicalRagePacts = S{
		'Inferno','Earthen Fury','Tidal Wave','Aerial Blast','Diamond Dust','Judgement Bolt','Searing Light','Howling Moon','Ruinous Omen',
		'Fire II','Stone II','Water II','Aero II','Blizzard II','Thunder II',
		'Fire IV','Stone IV','Water IV','Aero IV','Blizzard IV','Thunder IV',
		'Thunderspark','Burning Strike','Meteorite','Nether Blast','Flaming Crush',
		'Meteor Strike','Heavenly Strike','Wind Blade','Geocrush','Grand Fall','Thunderstorm',
		'Holy Mist','Lunar Bay','Night Terror','Level ? Holy'}


	pacts = {}
	pacts.cure = {['Carbuncle']='Healing Ruby'}
	pacts.curaga = {['Carbuncle']='Healing Ruby II', ['Garuda']='Whispering Wind', ['Leviathan']='Spring Water'}
	pacts.buffoffense = {['Carbuncle']='Glittering Ruby', ['Ifrit']='Crimson Howl', ['Garuda']='Hastega', ['Ramuh']='Rolling Thunder',
		['Fenrir']='Ecliptic Growl'}
	pacts.buffdefense = {['Carbuncle']='Shining Ruby', ['Shiva']='Frost Armor', ['Garuda']='Aerial Armor', ['Titan']='Earthen Ward',
		['Ramuh']='Lightning Armor', ['Fenrir']='Ecliptic Howl', ['Diabolos']='Noctoshield', ['Cait Sith']='Reraise II'}
	pacts.buffspecial = {['Ifrit']='Inferno Howl', ['Garuda']='Fleet Wind', ['Titan']='Earthen Armor', ['Diabolos']='Dream Shroud',
		['Carbuncle']='Soothing Ruby', ['Fenrir']='Heavenward Howl', ['Cait Sith']='Raise II'}
	pacts.debuff1 = {['Shiva']='Diamond Storm', ['Ramuh']='Shock Squall', ['Leviathan']='Tidal Roar', ['Fenrir']='Lunar Cry',
		['Diabolos']='Pavor Nocturnus', ['Cait Sith']='Eerie Eye'}
	pacts.debuff2 = {['Shiva']='Sleepga', ['Leviathan']='Slowga', ['Fenrir']='Lunar Roar', ['Diabolos']='Somnolence'}
	pacts.sleep = {['Shiva']='Sleepga', ['Diabolos']='Nightmare', ['Cait Sith']='Mewing Lullaby'}
	pacts.nuke2 = {['Ifrit']='Fire II', ['Shiva']='Blizzard II', ['Garuda']='Aero II', ['Titan']='Stone II',
		['Ramuh']='Thunder II', ['Leviathan']='Water II'}
	pacts.nuke4 = {['Ifrit']='Fire IV', ['Shiva']='Blizzard IV', ['Garuda']='Aero IV', ['Titan']='Stone IV',
		['Ramuh']='Thunder IV', ['Leviathan']='Water IV'}
	pacts.bp70 = {['Ifrit']='Flaming Crush', ['Shiva']='Rush', ['Garuda']='Predator Claws', ['Titan']='Mountain Buster',
		['Ramuh']='Chaotic Strike', ['Leviathan']='Spinning Dive', ['Carbuncle']='Meteorite', ['Fenrir']='Eclipse Bite',
		['Diabolos']='Nether Blast'}
	pacts.bp75 = {['Ifrit']='Meteor Strike', ['Shiva']='Heavenly Strike', ['Garuda']='Wind Blade', ['Titan']='Geocrush',
		['Ramuh']='Thunderstorm', ['Leviathan']='Grand Fall', ['Carbuncle']='Holy Mist', ['Fenrir']='Lunar Bay',
		['Diabolos']='Night Terror', ['Cait Sith']='Level ? Holy'}
	pacts.astralflow = {['Ifrit']='Inferno', ['Shiva']='Diamond Dust', ['Garuda']='Aerial Blast', ['Titan']='Earthen Fury',
		['Ramuh']='Judgment Bolt', ['Leviathan']='Tidal Wave', ['Carbuncle']='Searing Light', ['Fenrir']='Howling Moon',
		['Diabolos']='Ruinous Omen', ['Cait Sith']="Altana's Favor"}
	
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
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

	-- Durations for wards we want to create custom timers for.
	durations = {}
	durations['Earthen Armor'] = 232
	durations['Shining Ruby'] = 340
	durations['Dream Shroud'] = 352
	durations['Noctoshield'] = 352
	durations['Inferno Howl'] = 232
	durations['Hastega'] = 352
	
	-- Icons to use for the timers (from plugins/icons directory)
	timer_icons = {}
	-- 00054 for stoneskin, or 00299 for Titan
	timer_icons['Earthen Armor'] = 'spells/00299.png'
	-- 00043 for protect, or 00296 for Carby
	timer_icons['Shining Ruby'] = 'spells/00043.png'
	-- 00304 for Diabolos
	timer_icons['Dream Shroud'] = 'spells/00304.png'
	-- 00106 for phalanx, or 00304 for Diabolos
	timer_icons['Noctoshield'] = 'spells/00106.png'
	-- 00100 for enfire, or 00298 for Ifrit
	timer_icons['Inferno Howl'] = 'spells/00298.png'
	-- 00358 for hastega, or 00301 for Garuda
	timer_icons['Hastega'] = 'spells/00358.png'


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
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Astral Flow'] = {head="Glyphic Horn"}
	
	sets.precast.JA['Elemental Siphon'] = {feet="Caller's Pigaches +2"} -- back="Conveyance Cape"

	sets.precast.JA['Mana Cede'] = {hands="Caller's Bracers +2"}

	-- Pact delay reduction gear
	sets.precast.BloodPactWard = {ammo="Eminent Sachet",head="Convoker's Horn",body="Convoker's Doublet",hands="Glyphic Bracers"}

	sets.precast.BloodPactRage = sets.precast.BloodPactWard

	-- Fast cast sets for spells
	
	sets.precast.FC = {
		head="Nahtirah Hat",ear2="Loquacious Earring",
		body="Vanir Cotehardie",ring1="Prolix Ring",
		back="Swith Cape",waist="Witful Belt",legs="Orvail Pants +1",feet="Chelona Boots +1"}

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Nahtirah Hat",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Pahtli Cape",waist="Cascade Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Myrkr'] = {
		head="Nahtirah Hat",ear1="Gifted Earring",ear2="Loquacious Earring",
		body="Convoker's Doublet",hands="Caller's Bracers +2",ring1="Evoker's Ring",ring2="Sangoma Ring",
		back="Pahtli Cape",waist="Hierarch Belt",legs="Nares Trews",feet="Chelona Boots +1"}

	
	-- Midcast Sets
	sets.midcast.FastRecast = {
		head="Nahtirah Hat",ear2="Loquacious Earring",
		body="Vanir Cotehardie",hands="Bokwus Gloves",ring1="Prolix Ring",
		back="Swith Cape",waist="Witful Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

	sets.midcast.Cure = {main="Tamaxchi",sub="Genbu's Shield",
		head="Nahtirah Hat",ear2="Loquacious Earring",
		body="Heka's Kalasiris",hands="Bokwus Gloves",ring1="Prolix Ring",ring2="Sirona's Ring",
		back="Swith Cape",waist="Witful Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

	sets.midcast.Stoneskin = {waist="Siegel Sash"}

	sets.midcast.Pet.BloodPactWard = {main="Soulscourge",ammo="Eminent Sachet",
		head="Convoker's Horn",neck="Caller's Pendant",
		body="Caller's Doublet +2",hands="Glyphic Bracers",ring1="Evoker's Ring",ring2="Fervor Ring",
		waist="Diabolos's Rope",legs="Marduk's Shalwar +1"}
	
	sets.midcast.Pet.PhysicalBloodPactRage = {main="Soulscourge",ammo="Eminent Sachet",
		head="Convoker's Horn",neck="Caller's Pendant",
		body="Convoker's Doublet",hands="Glyphic Bracers",ring1="Evoker's Ring",ring2="Fervor Ring",
		waist="Diabolos's Rope",legs="Convoker's Spats",feet="Convoker's Pigaches"}

	sets.midcast.Pet.MagicalBloodPactRage = {main="Eminent Pole",ammo="Eminent Sachet",
		head="Glyphic Horn",neck="Caller's Pendant",
		body="Convoker's Doublet",hands="Glyphic Bracers",ring1="Evoker's Ring",ring2="Fervor Ring",
		back="Tiresias' Cape",waist="Diabolos's Rope",legs="Caller's Spats +2",feet="Hagondes Sabots"}

	sets.midcast.Pet.Spirit = set_combine(sets.midcast.Pet.BloodPactRage, {legs="Summoner's Spats"})

	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {main=gear.Staff.HMP,ammo="Eminent Sachet",
		head="Convoker's Horn",neck="Wiglen Gorget",ear1="Gifted Earring",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Pahtli Cape",waist="Austerity Belt",legs="Nares Trews",feet="Chelona Boots +1"}
	
	-- Idle sets
	sets.idle = {main="Bolelabunga",sub="Genbu's Shield",ammo="Eminent Sachet",
		head="Convoker's Horn",neck="Wiglen Gorget",ear1="Gifted Earring",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Sangoma Ring",
		back="Umbra Cape",waist="Hierarch Belt",legs="Nares Trews",feet="Herald's Gaiters"}

	sets.idle.PDT = {main=gear.Staff.PDT,sub="Achaq Grip",ammo="Eminent Sachet",
		head="Convoker's Horn",neck="Twilight Torque",ear1="Gifted Earring",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Dark Ring",ring2="Sangoma Ring",
		back="Umbra Cape",waist="Hierarch Belt",legs="Hagondes Pants",feet="Herald's Gaiters"}

	-- perp costs:
	-- spirits: 7
	-- carby: 11 (5 with mitts)
	-- fenrir: 13
	-- others: 15
	-- avatar's favor: -4/tick
	
	-- -perp gear:
	-- Patriarch Cane: -3
	-- Glyphic Horn: -4
	-- Caller's Doublet +2: -4
	-- Evoker's Ring: -1
	-- Convoker's Pigaches: -4
	-- total: -16
	
	sets.idle.Avatar = {main="Patriarch Cane",sub="Genbu's Shield",ammo="Eminent Sachet",
		head="Glyphic Horn",neck="Caller's Pendant",ear1="Gifted Earring",ear2="Loquacious Earring",
		body="Caller's Doublet +2",hands="Serpentes Cuffs",ring1="Evoker's Ring",ring2="Sangoma Ring",
		back="Umbra Cape",waist="Hierarch Belt",legs="Nares Trews",feet="Convoker's Pigaches"}

	sets.idle.Spirit = {main="Patriarch Cane",sub="Genbu's Shield",ammo="Eminent Sachet",
		head="Convoker's Horn",neck="Caller's Pendant",ear1="Gifted Earring",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Serpentes Cuffs",ring1="Evoker's Ring",ring2="Sangoma Ring",
		back="Tiresias' Cape",waist="Hierarch Belt",legs="Summoner's Spats",feet="Convoker's Pigaches"}

	sets.idle.Town = {main="Bolelabunga",sub="Genbu's Shield",ammo="Eminent Sachet",
		head="Convoker's Horn",neck="Wiglen Gorget",ear1="Gifted Earring",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Sangoma Ring",
		back="Umbra Cape",waist="Hierarch Belt",legs="Nares Trews",feet="Herald's Gaiters"}

	-- Favor can trade the -4 perp of Glyphic Horn for +2 refresh of Caller's Horn (plus enhance favor).
	sets.idle.Avatar.Favor = {head="Caller's Horn +2"}
	sets.idle.Avatar.Melee = {hands="Regimen Mittens",waist="Kuku Stone",legs="Convoker's Spats"}
		
	sets.perp = {}
	sets.perp.Day = {hands="Caller's Bracers +2"}
	sets.perp.Weather = {neck="Caller's Pendant",hands="Caller's Bracers +2"}
	-- Carby: Mitts+Conv.feet+Ev.Ring = 0/tick perp.  Everything else should be +refresh
	sets.perp.Carbuncle = {main="Bolelabunga",sub="Genbu's Shield",
		head="Convoker's Horn",body="Hagondes Coat",hands="Carbuncle Mitts",legs="Nares Trews",feet="Convoker's Pigaches"}
	-- Fenrir: doesn't need full -perp set; trade body for +refresh
	sets.perp.Fenrir = {body="Hagondes Coat"}
	sets.perp.Diabolos = {waist="Diabolos's Rope"}
	sets.perp.Alexander = sets.midcast.Pet.BloodPactWard
	
	-- Defense sets
	sets.defense.PDT = {main=gear.Staff.PDT,
		head="Hagondes Hat",neck="Wiglen Gorget",ear1="Gifted Earring",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Dark Ring",ring2="Dark Ring",
		back="Umbra Cape",waist="Hierarch Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

	sets.defense.MDT = {
		head="Hagondes Hat",neck="Twilight Torque",ear1="Gifted Earring",ear2="Loquacious Earring",
		body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Dark Ring",ring2="Shadow Ring",
		back="Umbra Cape",waist="Hierarch Belt",legs="Bokwus Slops",feet="Hagondes Sabots"}

	sets.Kiting = {feet="Herald's Gaiters"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {ammo="Eminent Sachet",
		head="Zelus Tiara",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Vanir Cotehardie",hands="Bokwus Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Umbra Cape",waist="Goading Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		equip(sets.midcast.FastRecast)
	end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if not spell.interrupted then
		if state.Buff[spell.name] ~= nil then
			state.Buff[spell.name] = true
		end
	end
end


-- Runs when a pet initiates an action.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_midcast(spell, action, spellMap, eventArgs)
	if spirits:contains(pet.name) then
		classes.CustomClass = 'Spirit'
	end
end


-- Runs when pet completes an action.
function job_pet_aftercast(spell, action, spellMap, eventArgs)
	if not spell.interrupted then
		create_pact_timer(spell)
	end
end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	if pet.isvalid then
		if pet.element == world.day_element then
			idleSet = set_combine(idleSet, sets.perp.Day)
		end
		if pet.element == world.weather_element then
			idleSet = set_combine(idleSet, sets.perp.Weather)
		end
		if sets.perp[pet.name] then
			idleSet = set_combine(idleSet, sets.perp[pet.name])
		end
		if state.Buff["Avatar's Favor"] and avatars:contains(pet.name) then
			idleSet = set_combine(idleSet, sets.idle.Avatar.Favor)
		end
		if pet.status == 'Engaged' then
			idleSet = set_combine(idleSet, sets.idle.Avatar.Melee)
		end
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
		handle_equipping_gear(player.status)
	elseif storms:contains(buff) then
		handle_equipping_gear(player.status)
	end
end


-- Called when the player's pet's status changes.
-- This is also called after pet_change after a pet is released.  Check for pet validity.
function job_pet_status_change(newStatus, oldStatus, eventArgs)
	if pet.isvalid and not midaction() and not pet_midaction() and (newStatus == 'Engaged' or oldStatus == 'Engaged') then
		handle_equipping_gear(player.status, newStatus)
	end
end


-- Called when a player gains or loses a pet.
-- pet == pet structure
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(petparam, gain)
	classes.CustomIdleGroups:clear()
	if gain then
		if avatars:contains(pet.name) then
			classes.CustomIdleGroups:append('Avatar')
		elseif spirits:contains(pet.name) then
			classes.CustomIdleGroups:append('Spirit')
		end
	else
		select_default_macro_book()
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
	classes.CustomIdleGroups:clear()
	if pet.isvalid then
		if avatars:contains(pet.name) then
			classes.CustomIdleGroups:append('Avatar')
		elseif spirits:contains(pet.name) then
			classes.CustomIdleGroups:append('Spirit')
		end
	end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell)
	if spell.type == 'BloodPactRage' then
		if magicalRagePacts:contains(spell.english) then
			return 'MagicalBloodPactRage'
		else
			return 'PhysicalBloodPactRage'
		end
	end
end


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
		add_to_chat(122, 'You do not have access to '..elements.storm_of[element]..'.')
		return
	end	
	
	local storm = elements.storm_of[element]
	
	if storm then
		send_command('@input /ma "'..elements.storm_of[element]..'" <me>')
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
			if world.weather_element == elements.weak_to[world.day_element] and
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
	elseif world.weather_element ~= 'None' and world.weather_element ~= elements.weak_to[world.day_element] then
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
		command = command..'input /ma "'..elements.storm_of[stormElementToUse]..'" <me>;wait 4;'
		releaseWait = releaseWait - 4
	end
	
	if not (pet.isvalid and spirits:contains(pet.name)) then
		command = command..'input /ma "'..elements.spirit_of[siphonElement]..'" <me>;wait 4;'
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
	if areas.Cities:contains(world.area) then
		add_to_chat(122, 'You cannot use pacts in town.')
		return
	end

	if not pet.isvalid then
		add_to_chat(122,'No avatar currently available. Returning to macro set 4.')
		set_macro_page(4)
		return
	end

	if spirits:contains(pet.name) then
		add_to_chat(122,'Cannot use pacts with spirits.')
		return
	end

	if not cmdParams[2] then
		add_to_chat(123,'No pact type given.')
		return
	end
	
	local pact = cmdParams[2]:lower()
	
	if not pacts[pact] then
		add_to_chat(123,'Unknown pact type: '..tostring(pact))
		return
	end
	
	if pacts[pact][pet.name] then
		if pact == 'astralflow' and not buffactive['astral flow'] then
			add_to_chat(122,'Cannot use Astral Flow pacts without 2hr active.')
			return
		end
		
		-- Leave out target; let Shortcuts auto-determine it.
		send_command('@input /pet "'..pacts[pact][pet.name]..'"')
	else
		add_to_chat(122,pet.name..' does not have a pact of type ['..pact..'].')
	end
end


function create_pact_timer(spell)
	-- Create custom timers for ward pacts.
	if durations and durations[spell.english] then
		local timer_cmd = 'timers c "'..spell.english..'" '..tostring(durations[spell.english])..' down'
		
		if timer_icons[spell.english] then
			timer_cmd = timer_cmd..' '..timer_icons[spell.english]
		end
		
		send_command(timer_cmd)
	end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	set_macro_page(4, 16)
end
