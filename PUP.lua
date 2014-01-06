-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- Last Modified: 1/4/2014 6:07:55 PM

-- IMPORTANT: Make sure to also get the Mote-Include.lua file to go with this.

function get_sets()
	-- Load and initialize the include file that this depends on.
	include('Mote-Include.lua')
	init_include()
	
	-- Options: Override default values
	options.OffenseModes = {'Normal', 'Acc'}
	options.DefenseModes = {'Normal', 'DT'}
	options.WeaponskillModes = {'Normal', 'Att', 'Mod'}
	options.IdleModes = {'Normal'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'PDT', 'Evasion'}
	options.MagicalDefenseModes = {'MDT'}

	state.Defense.PhysicalMode = 'PDT'
	
	options.PetModes = {'Heal','Ranged','Tank','Nuke','Melee'}
	state.PetMode = 'Heal'
	
	petHaste = 0
	petStatus = pet.status
	statusUpdatesStarted = false
	
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	sets.precast = {}

	-- Fast cast sets for spells
	
	sets.precast.FC = {ear2="Loquacious Earring",
		hands="Thaumas Gloves"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

	
	-- Precast sets to enhance JAs
	sets.precast.JA = {}

	sets.precast.JA['Tactical Switch'] = {feet="Cirque Scarpe +2"}
	
	sets.precast.JA['Repair'] = {feet="Puppetry Babouches +1"}

	sets.precast.JA['Maneuver'] = {neck="Buffoon's Collar",body="Cirque Farsetto +2",hands="Puppetry Dastanas +1"}



	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Whirlpool Mask",ear1="Roundel Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Spiral Ring",
		back="Iximulew Cape",legs="Nahtirah Trousers",feet="Thurandaut Boots +1"}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Manibozho Jerkin",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Pantin Cape",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Manibozho Boots"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Stringing Pummel'] = set_combine(sets.precast.WS, {neck="Rancor Collar",ring1="Spiral Ring",waist="Soil Belt"})
	sets.precast.WS['Stringing Pummel'].Mod = set_combine(sets.precast.WS['Stringing Pummel'], {legs="Nahtirah Trousers"})

	sets.precast.WS['Victory Smite'] = set_combine(sets.precast.WS, {neck="Rancor Collar",waist="Thunder Belt"})
	sets.precast.WS['Victory Smite'].Mod = set_combine(sets.precast.WS['Victory Smite'], {waist="Soil Belt"})

	sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {neck="Light Gorget",waist="Light Belt"})
	sets.precast.WS['Shijin Spiral'].Mod = set_combine(sets.precast.WS['Shijin Spiral'], {waist="Soil Belt"})

	
	-- Midcast Sets
	sets.midcast = {}

	sets.midcast.FastRecast = {
		head="Whirlpool Mask",ear2="Loquacious Earring",
		body="Otronif Harness",hands="Thaumas Gloves",
		waist="Twilight Belt",legs="Manibozho Brais",feet="Otronif Boots"}
		
	-- Specific spells
	sets.midcast.Utsusemi = {
		head="Whirlpool Mask",ear2="Loquacious Earring",
		body="Otronif Harness",hands="Thaumas Gloves",
		waist="Black Belt",legs="Nahtirah Trousers",legs="Manibozho Brais",feet="Otronif Boots"}


	-- Midcast sets for pet actions
	sets.midcast.Pet = {}

	sets.midcast.Pet.Cure = {legs="Foire Churidars"}

	sets.midcast.Pet.Weaponskill = {head="Cirque Capello +2"}

	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {head="Foire Taj",neck="Wiglen Gorget",
		ring1="Sheltered Ring",ring2="Paguroidea Ring"}
	

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {}

	sets.idle.Town = {main="Oatixur",range="Eminent Animator",
		head="Whirlpool Mask",neck="Wiglen Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Iximulew Cape",waist="Hurch'lan Sash",legs="Foire Churidars",feet="Hermes' Sandals"}
	
	sets.idle.Field = {
		head="Whirlpool Mask",neck="Wiglen Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Shadow Mantle",waist="Hurch'lan Sash",legs="Foire Churidars",feet="Hermes' Sandals"}

	sets.idle.Weak = {
		head="Whirlpool Mask",neck="Wiglen Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Shadow Mantle",waist="Hurch'lan Sash",legs="Foire Churidars",feet="Hermes' Sandals"}
	
	-- Idle sets to wear while pet is engaged
	sets.idle.Field.PetTank = {
		head="Foire Taj",neck="Wiglen Gorget",ear1="Bladeborn Earring",ear2="Cirque Earring",
		body="Foire Tobe",hands="Pantin Dastanas +2",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Pantin Cape",waist="Hurch'lan Sash",legs="Foire Churidars",feet="Hermes' Sandals"}

	sets.idle.Field.PetMelee = {
		head="Foire Taj",neck="Wiglen Gorget",ear1="Bladeborn Earring",ear2="Cirque Earring",
		body="Foire Tobe",hands="Pantin Dastanas +2",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Pantin Cape",waist="Hurch'lan Sash",legs="Foire Churidars",feet="Hermes' Sandals"}

	sets.idle.Field.PetRanged = {
		head="Foire Taj",neck="Wiglen Gorget",ear1="Bladeborn Earring",ear2="Cirque Earring",
		body="Foire Tobe",hands="Cirque Guanti +2",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Pantin Cape",waist="Hurch'lan Sash",legs="Cirque Pantaloni +2",feet="Hermes' Sandals"}

	sets.idle.Field.PetNuke = {
		head="Foire Taj",neck="Wiglen Gorget",ear1="Bladeborn Earring",ear2="Cirque Earring",
		body="Foire Tobe",hands="Pantin Dastanas +2",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Shadow Mantle",waist="Hurch'lan Sash",legs="Cirque Pantaloni +2",feet="Cirque Scarpe +2"}

	sets.idle.Field.PetHeal = {
		head="Foire Taj",neck="Wiglen Gorget",ear1="Bladeborn Earring",ear2="Cirque Earring",
		body="Foire Tobe",hands="Pantin Dastanas +2",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Shadow Mantle",waist="Hurch'lan Sash",legs="Foire Churidars",feet="Hermes' Sandals"}

	-- Defense sets
	sets.defense = {}

	sets.defense.Evasion = {
		head="Whirlpool Mask",neck="Twilight Torque",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Dark Ring",
		back="Ik Cape",waist="Hurch'lan Sash",legs="Nahtirah Trousers",feet="Otronif Boots"}

	sets.defense.PDT = {
		head="Whirlpool Mask",neck="Twilight Torque",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Beeline Ring",ring2="Dark Ring",
		back="Shadow Mantle",waist="Hurch'lan Sash",legs="Nahtirah Trousers",feet="Otronif Boots"}

	sets.defense.MDT = {
		head="Whirlpool Mask",neck="Twilight Torque",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Dark Ring",ring2="Shadow Ring",
		back="Tuilha Cape",waist="Hurch'lan Sash",legs="Nahtirah Trousers",feet="Otronif Boots"}

	sets.Kiting = {feet="Hermes' Sandals"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Thaumas Coat",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Pantin Cape",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Otronif Boots"}
	sets.engaged.Acc = {
		head="Whirlpool Mask",neck="Peacock Charm",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Thaumas Coat",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Pantin Cape",waist="Hurch'lan Sash",legs="Manibozho Brais",feet="Otronif Boots"}
	sets.engaged.DT = {
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Dark Ring",ring2="Epona's Ring",
		back="Iximulew Cape",waist="Hurch'lan Sash",legs="Manibozho Brais",feet="Otronif Boots"}
	sets.engaged.Acc.DT = {
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Dark Ring",ring2="Beeline Ring",
		back="Iximulew Cape",waist="Hurch'lan Sash",legs="Manibozho Brais",feet="Otronif Boots"}
	sets.engaged.PetHaste5 = {
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Thaumas Coat",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Pantin Cape",waist="Hurch'lan Sash",legs="Manibozho Brais",feet="Otronif Boots"}
	sets.engaged.PetHaste15 = {
		head="Foire Taj",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Thaumas Coat",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Pantin Cape",waist="Hurch'lan Sash",legs="Manibozho Brais",feet="Otronif Boots"}
	sets.engaged.PetHaste20 = {
		head="Foire Taj",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Thaumas Coat",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Pantin Cape",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Otronif Boots"}
	sets.engaged.PetHaste25 = {
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Thaumas Coat",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Pantin Cape",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Otronif Boots"}


	petWeaponskills = S{"Slapstick", "Knockout", "Magic Mortar",
		"Chimera Ripper", "String Clipper",  "Cannibal Blade", "Bone Crusher", "String Shredder",
		"Arcuballista", "Daze", "Armor Piercer", "Armor Shatterer"}

	windower.send_command('input /macro book 9;wait .1;input /macro set 10')
	gearswap_binds_on_load()

	windower.send_command('bind ^- gs c toggle target')
	windower.send_command('bind !- gs c cycle targetmode')

	windower.send_command('bind ^= gs c cycle petmode')
end

-- Called when this job file is unloaded (eg: job change)
function file_unload()
	--spellcast_binds_on_unload()
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

function job_pet_midcast(spell, action, spellMap, eventArgs)
	--add_to_chat(122,'Pet action: '..spell.name)
	if petWeaponskills[spell.english] then
		--add_to_chat(122,'Pet weaponskill')
		classes.CustomClass = "Weaponskill"
	end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if not spell.interrupted and S{'Deploy','Retrieve','Activate','Deactivate'}[spell.english] then
		do_pet_status_change()
		eventArgs.handled = true

		if not statusUpdatesStarted then
			send_command('wait 5; gs c update petstatus')
			statusUpdatesStarted = true
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-- Called before the Include starts constructing melee/idle/resting sets.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)
	classes.CustomMeleeGroups:clear()
	classes.CustomIdleGroups:clear()
	
	if pet.isvalid and pet.status == 'Engaged' and state.OffenseMode == 'Normal' and state.DefenseMode == 'Normal' then
		if player.status == 'Idle' then
			classes.CustomIdleGroups:append('Pet'..state.PetMode)
		elseif player.status == 'Engaged' and S{'Melee','Ranged','Tank','Heal'}[state.PetMode] then
			determine_pet_haste()
			if petHaste > 0 then
				classes.CustomMeleeGroups:append('PetHaste'..tostring(petHaste))
			end
		end
	end
end


-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)

end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if buff == 'Wind Maneuver' then
		handle_equipping_gear(player.status)
	end
end


-- Note: this is a hack, a temporary solution
function pet_status_change(newStatus, oldStatus)
	handle_equipping_gear(player.status)
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
	-- Hack for keeping track of pet status, until raising events for it is implemented
	if cmdParams[1] == 'petstatus' then
		do_pet_status_change()
		send_command('wait 5; gs c update petstatus')
		statusUpdatesStarted = true
		eventArgs.handled = true
	elseif cmdParams[1] == 'user' and not statusUpdatesStarted then
		do_pet_status_change()
		send_command('wait 5; gs c update petstatus')
		statusUpdatesStarted = true
	end
	
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue)
	if stateField == 'PetMode' then
		handle_equipping_gear(player.status)
	end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
	--add_to_chat(122,'Special idle: '..tostring(classes.CustomIdleGroups))
	--add_to_chat(122,'Special melee: '..tostring(classes.CustomMeleeGroups))
	
	local defenseString = ''
	if state.Defense.Active then
		local defMode = state.Defense.PhysicalMode
		if state.Defense.Type == 'Magical' then
			defMode = state.Defense.MagicalMode
		end

		defenseString = 'Defense: '..state.Defense.Type..' '..defMode..', '
	end

	add_to_chat(122,'Melee: '..state.OffenseMode..'/'..state.DefenseMode..', WS: '..state.WeaponskillMode..', '..defenseString..
		'Kiting: '..on_off_names[state.Kiting])

	if pet.isvalid then
		local petInfoString = pet.name..' ['..state.PetMode..']  TP='..tostring(pet.tp)..'  HP%='..tostring(pet.hpp)
		
		if state.PetMode == 'Nuke' or state.PetMode == 'Heal' then
			petInfoString = petInfoString..'  MP%='..tostring(pet.mpp)
		end
		
		add_to_chat(122,petInfoString)
	end

	eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Hooks for pet mode handling.
-------------------------------------------------------------------------------------------------------------------

-- Request job-specific mode tables.
-- Return true on the third returned value to indicate an error: that we didn't recognize the requested field.
function job_get_mode_table(field)
	if field == 'Pet' then
		return options.PetModes, state.PetMode
	end
	
	-- Return an error if we don't recognize the field requested.
	return nil, nil, true
end

-- Set job-specific mode values.
-- Return true if we recognize and set the requested field.
function job_set_mode(field, val)
	if field == 'Pet' then
		state.PetMode = val
		return true
	end
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_pet_haste()
	petHaste = 0
	if pet.isvalid and S{'Melee','Ranged','Tank','Heal'}[state.PetMode] then
		-- assume Turbo Charger is equipped for any non-Nuke auto
		-- possibly change this for healer auto?
		petHaste = 5
		if buffactive['wind maneuver'] then
			petHaste = 10 + 5 * buffactive['wind maneuver']
		end
	end
end

-- Hack to support watching for pet status changes
function do_pet_status_change()
	local oldPetStatus = petStatus
	petStatus = pet.status
	if petStatus ~= oldPetStatus then
		pet_status_change(petStatus, oldPetStatus)
	end
end


