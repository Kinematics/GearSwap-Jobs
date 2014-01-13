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
	options.OffenseModes = {'Normal'}
	options.DefenseModes = {'Normal'}
	options.WeaponskillModes = {'Normal', 'Acc', 'Att', 'Mod'}
	options.CastingModes = {'Normal'}
	options.IdleModes = {'Normal'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'PDT', 'Reraise', 'HP'}
	options.MagicalDefenseModes = {'MDT', 'Reraise'}

	state.Defense.PhysicalMode = 'PDT'

	state.Buff.Sentinel = buffactive.sentinel or false
	state.Buff.Cover = buffactive.cover or false
	
	physical_darkring1 = {name="Dark Ring",augments={"Physical Damage Taken -6%", "Magic Damage Taken -3%", "Spell Interruption Rate Down 5%"}}
	physical_darkring2 = {name="Dark Ring",augments={"Physical Damage Taken -5%", "Magic Damage Taken -3%"}}
	magic_breath_darkring1 = {name="Dark Ring",augments={"Magic Damage Taken -6%", "Breath Damage Taken -5%"}}
	magic_breath_darkring2 = {name="Dark Ring",augments={"Magic Damage Taken -5%", "Breath Damage Taken -6%"}}
	
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Invincible'] = {legs="Valor Breeches +2"}
	sets.precast.JA['Holy Circle'] = {feet="Reverence Leggings"}
	sets.precast.JA['Shield Bash'] = {hands="Valor Gauntlets +2"}
	sets.precast.JA['Sentinel'] = {feet="Valor Leggings"}
	sets.precast.JA['Rampart'] = {head="Valor Coronet"}
	sets.precast.JA['Fealty'] = {body="Valor Surcoat +2"}
	sets.precast.JA['Chivalry'] = {hands="Valor Gauntlets +2"}
	sets.precast.JA['Divine Emblem'] = {} -- {feet="Creed Sabatons +2"}
	

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	
	sets.precast.FC = {ammo="Incantor Stone",
		head="Cizin Helm",ear2="Loquacious Earring"
		legs="Enif Cosciales"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {body="Phorcys Korazin"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Aeolian Edge'] = {
		neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
		back="Toro Cape",waist="Thunder Belt"}
	
	
	-- Midcast Sets
	sets.midcast.FastRecast = {}
		
	-- Specific spells
	sets.midcast.Utsusemi = {}

	sets.midcast.Enmity = {ammo="Iron Gobbet",
		head="Reverence Coronet",neck="Invidia Torque",
		body="Reverence Surcoat",hands="Reverence Gauntlets",
		legs="Reverence Breeches"}
	
	-- Sets to return to when not performing an action.

	sets.Reraise = {head="Twilight Helm", body="Twilight Mail"}
	
	-- Resting sets
	sets.resting = {}
	

	-- Idle sets
	sets.idle = {ammo="Iron Gobbet",
		neck="Creed Collar"}

	sets.idle.Town = {main="Buramenk'ah", sub="Killedar Shield",ammo="Incantor Stone",
		head="Reverence Coronet",neck="Creed Collar",ear1="Creed Earring",ear2="Bloodgem Earring",
		body="Reverence Surcoat",hands="Reverence Gauntlets",
		legs="Crimson Cuisses"}
	
	sets.idle.Weak = {ammo="Iron Gobbet"}
	
	sets.idle.Weak.Reraise = set_combine(sets.idle.Weak, sets.Reraise)
	
	-- Defense sets
	sets.defense.PDT = {ammo="Iron Gobbet",
		head="Reverence Coronet",neck="Twilight Torque",ear1="Creed Earring",ear2="Bloodgem Earring",
		body="Reverence Surcoat",hands="Cizin Mufflers",ring1="Dark Ring",ring2="Dark Ring",
		back="Shadow Mantle",waist="Flume Belt",legs="Reverence Breeches",feet="Reverence Leggings"}
	-- If using Kheshig Blade, have 50% PDT without the second ring:
	sets.defense.PDT['Kheshig Blade'] = set_combine(sets.defense.PDT, {ring2="Meridian Ring"})

	sets.defense.PDT.HP = set_combine(sets.defense.PDT, {ring1="K'ayres Ring",ring2="Meridian Ring",
		back="Fierabras's Mantle",waist="Creed Baudrier"})
	sets.defense.PDT['Kheshig Blade'].HP = set_combine(sets.defense.PDT, {ring1="K'ayres Ring",ring2="Meridian Ring",
		back="Fierabras's Mantle",waist="Creed Baudrier"})

	sets.defense.Reraise = {ammo="Iron Gobbet",
		head="Twilight Helm",neck="Twilight Torque",ear1="Creed Earring",ear2="Bloodgem Earring",
		body="Twilight Mail",hands="Cizin Mufflers",ring1="Dark Ring",ring2="Dark Ring",
		back="Shadow Mantle",waist="Flume Belt",legs="Reverence Breeches",feet="Reverence Leggings"}

	sets.defense.MDT = {ammo="Demonry Stone",
		head="Yaoyotl Helm",neck="Twilight Torque",ear1="Creed Earring",ear2="Bloodgem Earring",
		body="Reverence Surcoat",hands="Reverence Gauntlets",ring1="Dark Ring",ring2="Shadow Ring",
		back="Engulfer Cape",waist="Creed Baudrier",legs="Cizin Breeches",feet="Whirlpool Greaves"}

	sets.defense.MDT.Reraise = set_combine(sets.defense.MDT, sets.Reraise)
	sets.defense.MDT.HP = set_combine(sets.defense.PDT, {ring1="Vexer Ring",ring2="Meridian Ring",
		back="Fierabras's Mantle",waist="Creed Baudrier"})
	sets.defense.MDT.Reraise.HP = set_combine(sets.defense.MDT.HP, sets.Reraise)

	sets.defense.HP = {ammo="Iron Gobbet",
		head="Reverence Coronet",neck="Lavalier +1",ear1="Creed Earring",ear2="Bloodgem Earring",
		body="Reverence Surcoat",hands="Cizin Mufflers",ring1="K'ayres Ring",ring2="Meridian Ring",
		back="Fierabras's Mantle",waist="Creed Baudrier",legs="Reverence Breeches",feet="Reverence Leggings"}

	sets.Kiting = {legs="Crimson Cuisses"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {}
	
	sets.engaged.Acc = {}

	sets.buff.Cover = {head="Reverence Coronet", body="Valor Surcoat +2"}
	


	-- default: set 1 of book 20
	set_macro_page(1, 20)
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

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_job_wsmode(spell, action, spellMap)

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
function job_state_change(stateField, newValue)

end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

