-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file to go with this.

-- Initialization function for this job file.
function get_sets()
	-- Load and initialize the include file.
	include('Mote-Include.lua')
end

-- Setup vars that are user-independent.
function job_setup()
	state.Buff.Sentinel = buffactive.sentinel or false
	state.Buff.Cover = buffactive.cover or false
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	options.OffenseModes = {'Normal'}
	options.DefenseModes = {'Normal', 'Shield'}
	options.WeaponskillModes = {'Normal', 'Acc', 'Att', 'Mod'}
	options.CastingModes = {'Normal'}
	options.IdleModes = {'Normal'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'PDT', 'Reraise', 'HP'}
	options.MagicalDefenseModes = {'MDT', 'Reraise'}

	state.Defense.PhysicalMode = 'PDT'

	physical_darkring1 = {name="Dark Ring",augments={"Physical Damage Taken -6%", "Magic Damage Taken -3%", "Spell Interruption Rate Down 5%"}}
	physical_darkring2 = {name="Dark Ring",augments={"Physical Damage Taken -5%", "Magic Damage Taken -3%"}}
	magic_breath_darkring1 = {name="Dark Ring",augments={"Magic Damage Taken -6%", "Breath Damage Taken -5%"}}
	magic_breath_darkring2 = {name="Dark Ring",augments={"Magic Damage Taken -5%", "Breath Damage Taken -6%"}}


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
	sets.precast.JA['Invincible'] = {legs="Caballarius Breeches"}
	sets.precast.JA['Holy Circle'] = {feet="Reverence Leggings"}
	--sets.precast.JA['Shield Bash'] = {hands="Valor Gauntlets +2"}
	sets.precast.JA['Sentinel'] = {feet="Caballarius Leggings"}
	sets.precast.JA['Rampart'] = {head="Valor Coronet"}
	--sets.precast.JA['Fealty'] = {body="Valor Surcoat +2"}
	--sets.precast.JA['Divine Emblem'] = {feet="Creed Sabatons +2"}

	-- add mnd for Chivalry
	sets.precast.JA['Chivalry'] = {
		head="Yaoyotl Helm",
		body="Reverence Surcoat +1",hands="Buremte Gloves",
		legs="Reverence Breeches +1",feet="Whirlpool Greaves"}
	

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Yaoyotl Helm",
		body="Reverence Surcoat +1",hands="Reverence Gauntlets +1",
		back="Iximulew Cape",waist="Caudata Belt",legs="Reverence Breeches +1",feet="Reverence Leggings"}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	
	sets.precast.FC = {ammo="Incantor Stone",
		head="Cizin Helm",ear2="Loquacious Earring",
		ring1="Prolix Ring",
		legs="Enif Cosciales"}

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

	sets.precast.FC.Cure = set_combine(sets.precast.FC,
		{body="Twilight Mail",hands="Buremte Gloves",ring2="Dark Ring",
		waist="Flume Belt",feet="Karieyh Sollerets +1"})

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Yaoyotl Helm",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Karieyh Haubert +1",hands="Cizin Mufflers",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Atheling Mantle",waist="Caudata Belt",legs="Cizin Breeches",feet="Cizin Greaves"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {neck="Soil Gorget",
		ring1="Aquasoul Ring",ring2="Aquasoul Ring",waist="Soil Belt"})

	sets.precast.WS['Vorpal Blade'] = set_combine(sets.precast.WS, {neck="Soil Gorget",waist="Soil Belt"})

	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {neck="Snow Gorget",waist="Snow Belt"})

	sets.precast.WS['Sanguine Blade'] = {
		head="Yaoyotl Helm",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Reverence Surcoat +1",hands="Cizin Mufflers",
		back="Toro Cape",legs="Reverence Breeches +1",feet="Reverence Leggings"}
	
	
	-- Midcast Sets
	sets.midcast.FastRecast = {
		head="Yaoyotl Helm",
		body="Reverence Surcoat +1",hands="Cizin Mufflers",
		waist="Zoran's Belt",legs="Enif Cosciales",feet="Reverence Leggings"}
		
	sets.midcast.Enmity = {ammo="Iron Gobbet",
		head="Reverence Coronet +1",neck="Invidia Torque",
		body="Reverence Surcoat +1",hands="Reverence Gauntlets +1",ring1="Vexer Ring",
		back="Fierabras's Mantle",waist="Goading Belt",legs="Reverence Breeches +1"}

	sets.midcast.Flash = set_combine(sets.midcast.Enmity, {legs="Enif Cosciales",feet="Cizin Greaves"})
	
	sets.midcast.Stun = sets.midcast.Flash
	
	sets.midcast.Cure = {ammo="Iron Gobbet",
		head="Adaman Barbuta",neck="Invidia Torque",ear1="Hospitaler Earring",ear2="Bloodgem Earring",
		body="Reverence Surcoat +1",hands="Buremte Gloves",ring1="K'ayres Ring",ring2="Meridian Ring",
		back="Fierabras's Mantle",waist="Creed Baudrier",legs="Reverence Breeches +1",feet="Reverence Leggings"}

	sets.midcast['Enhancing Magic'] = {neck="Colossus's Torque",waist="Olympus Sash",legs="Reverence Breeches +1"}
	
	sets.midcast.Protect = {ring1="Sheltered Ring"}
	sets.midcast.Shell = {ring1="Sheltered Ring"}
	
	-- Sets to return to when not performing an action.

	sets.Reraise = {head="Twilight Helm", body="Twilight Mail"}
	
	-- Resting sets
	sets.resting = {head="Twilight Helm",neck="Creed Collar",
		body="Twilight Mail",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		waist="Austerity Belt"}
	

	-- Idle sets
	sets.idle = {ammo="Iron Gobbet",
		head="Reverence Coronet +1",neck="Creed Collar",ear1="Creed Earring",ear2="Bloodgem Earring",
		body="Reverence Surcoat +1",hands="Reverence Gauntlets +1",ring1="Sheltered Ring",ring2="Meridian Ring",
		back="Fierabras's Mantle",waist="Flume Belt",legs="Crimson Cuisses",feet="Reverence Leggings"}

	sets.idle.Town = {main="Buramenk'ah", sub="Killedar Shield",ammo="Incantor Stone",
		head="Reverence Coronet +1",neck="Creed Collar",ear1="Creed Earring",ear2="Bloodgem Earring",
		body="Reverence Surcoat +1",hands="Reverence Gauntlets +1",ring1="Sheltered Ring",ring2="Meridian Ring",
		back="Fierabras's Mantle",waist="Flume Belt",legs="Crimson Cuisses",feet="Reverence Leggings"}
	
	sets.idle.Weak = {ammo="Iron Gobbet",
		head="Reverence Coronet +1",neck="Creed Collar",ear1="Creed Earring",ear2="Bloodgem Earring",
		body="Reverence Surcoat +1",hands="Reverence Gauntlets +1",ring1="Sheltered Ring",ring2="Meridian Ring",
		back="Fierabras's Mantle",waist="Flume Belt",legs="Crimson Cuisses",feet="Reverence Leggings"}
	
	sets.idle.Weak.Reraise = set_combine(sets.idle.Weak, sets.Reraise)
	
	-- Defense sets
	sets.defense.PDT = {ammo="Iron Gobbet",
		head="Reverence Coronet +1",neck="Twilight Torque",ear1="Creed Earring",ear2="Bloodgem Earring",
		body="Reverence Surcoat +1",hands="Cizin Mufflers",ring1="Dark Ring",ring2="Dark Ring",
		back="Shadow Mantle",waist="Flume Belt",legs="Reverence Breeches +1",feet="Reverence Leggings"}
	-- If using Kheshig Blade, have 50% PDT without the second ring:
	sets.defense.PDT['Kheshig Blade'] = set_combine(sets.defense.PDT, {ring2="Meridian Ring"})

	sets.defense.PDT.HP = set_combine(sets.defense.PDT, {ring1="K'ayres Ring",ring2="Meridian Ring",
		back="Fierabras's Mantle",waist="Creed Baudrier"})
	sets.defense.PDT['Kheshig Blade'].HP = set_combine(sets.defense.PDT, {ring1="K'ayres Ring",ring2="Meridian Ring",
		back="Fierabras's Mantle",waist="Creed Baudrier"})

	sets.defense.Reraise = {ammo="Iron Gobbet",
		head="Twilight Helm",neck="Twilight Torque",ear1="Creed Earring",ear2="Bloodgem Earring",
		body="Twilight Mail",hands="Cizin Mufflers",ring1="Dark Ring",ring2="Dark Ring",
		back="Shadow Mantle",waist="Flume Belt",legs="Reverence Breeches +1",feet="Reverence Leggings"}

	sets.defense.MDT = {ammo="Demonry Stone",
		head="Yaoyotl Helm",neck="Twilight Torque",ear1="Creed Earring",ear2="Bloodgem Earring",
		body="Reverence Surcoat +1",hands="Reverence Gauntlets +1",ring1="Dark Ring",ring2="Shadow Ring",
		back="Engulfer Cape",waist="Creed Baudrier",legs="Cizin Breeches",feet="Caballarius Leggings"}

	sets.defense.MDT.Reraise = set_combine(sets.defense.MDT, sets.Reraise)
	sets.defense.MDT.HP = set_combine(sets.defense.PDT, {ring1="Vexer Ring",ring2="Meridian Ring",
		back="Fierabras's Mantle",waist="Creed Baudrier"})
	sets.defense.MDT.Reraise.HP = set_combine(sets.defense.MDT.HP, sets.Reraise)

	sets.defense.HP = {ammo="Iron Gobbet",
		head="Reverence Coronet +1",neck="Lavalier +1",ear1="Creed Earring",ear2="Bloodgem Earring",
		body="Reverence Surcoat +1",hands="Cizin Mufflers",ring1="K'ayres Ring",ring2="Meridian Ring",
		back="Fierabras's Mantle",waist="Creed Baudrier",legs="Reverence Breeches +1",feet="Reverence Leggings"}

	sets.Kiting = {legs="Crimson Cuisses"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {
		head="Yaoyotl Helm",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Karieyh Haubert +1",hands="Cizin Mufflers",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Atheling Mantle",waist="Zoran's Belt",legs="Cizin Breeches",feet="Whirlpool Greaves"}

	sets.engaged.Shield = {
		head="Yaoyotl Helm",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Reverence Surcoat +1",hands="Cizin Mufflers",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Boxer's Mantle",waist="Flume Belt",legs="Reverence Breeches +1",feet="Reverence Leggings"}


	sets.buff.Cover = {head="Reverence Coronet +1", body="Valor Surcoat +2"}
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
	-- Don't gearswap for weaponskills when Defense is on.
	if spell.type:lower() == 'weaponskill' and state.Defense.Active then
		eventArgs.handled = true
	end
end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)

end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)

end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)

end

-- Runs when a pet initiates an action.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_midcast(spell, action, spellMap, eventArgs)

end

-- Run after the default pet midcast() is done.
-- eventArgs is the same one used in job_pet_midcast, in case information needs to be persisted.
function job_pet_post_midcast(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)

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

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, action, spellMap)

end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
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

end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)

end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)

end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)

end

-- Handle notifications of user state values being changed.
function job_state_change(stateField, newValue, oldValue)

end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(5, 2)
	elseif player.sub_job == 'NIN' then
		set_macro_page(4, 2)
	elseif player.sub_job == 'RDM' then
		set_macro_page(3, 2)
	else
		set_macro_page(2, 2)
	end
end

