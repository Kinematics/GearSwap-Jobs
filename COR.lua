-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file to go with this.

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
	self_initialize()

	-- Default macro set/book
	set_macro_page(1, 19)

	-- Global default binds
	binds_on_load()
	
	-- Additional local binds

	-- Cor doesn't use hybrid defense mode; using that for ranged mode adjustments.
	windower.send_command('bind ^f9 gs c cycle RangedMode')

	windower.send_command('bind ^` input /ja "Double-up" <me>')
	windower.send_command('bind !` input /ja "Bolter\'s Roll" <me>')
end

-- Called when this job file is unloaded (eg: job change)
function file_unload()
	binds_on_unload()
	windower.send_command('unbind ^`')
	windower.send_command('unbind !`')
end

-- Define sets and vars used by this job file.
function self_initialize()
	-- Options: Override default values
	options.OffenseModes = {'Normal', 'Acc'}
	options.RangedModes = {'Normal', 'Acc'}
	options.WeaponskillModes = {'Normal', 'Acc', 'Att', 'Mod'}
	options.CastingModes = {'Normal'}
	options.IdleModes = {'Normal'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'PDT'}
	options.MagicalDefenseModes = {'MDT'}

	state.Defense.PhysicalMode = 'PDT'
	
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs
	sets.precast.JA['No Foot Rise'] = {body="Etoile Casaque +2"}
	

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	
	sets.precast.FC = {ear2="Loquacious Earring"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Aeolian Edge'] = {ammo="Charis Feather",
		head="Thaumas Hat",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Manibozho Jerkin",hands="Buremte Gloves",ring1="Rajas Ring",ring2="Demon's Ring",
		back="Toro Cape",waist="Thunder Belt",legs="Iuitl Tights",feet="Iuitl Gaiters"}
	
	
	-- Midcast Sets
	sets.midcast.FastRecast = {}
		
	-- Specific spells
	sets.midcast.Utsusemi = {}

	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",
		ring1="Sheltered Ring",ring2="Paguroidea Ring"}
	

	-- Idle sets
	sets.idle = {}

	sets.idle.Town = {main="Izhiikoh", sub="Atoyac",ammo="Charis Feather",
		head="Whirlpool Mask",neck="Charis Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Charis Casaque +2",hands="Iuitl Wristbands",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Atheling Mantle",waist="Patentia Sash",legs="Kaabnax Trousers",feet="Skadi's Jambeaux +1"}
	
	sets.idle.Weak = {ammo="Charis Feather",
		head="Whirlpool Mask",neck="Wiglen Gorget",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Manibozho Jerkin",hands="Buremte Gloves",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Iximulew Cape",waist="Flume Belt",legs="Kaabnax Trousers",feet="Skadi's Jambeaux +1"}
	
	-- Defense sets
	sets.defense.PDT = {}

	sets.defense.MDT = {}

	sets.Kiting = {feet="Skadi's Jambeaux +1"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {}
	sets.engaged.Acc = {}

	define_roll_values()
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

end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if spell.type == 'CorsairRoll' and not spell.interrupted then
		display_roll_info(spell)
	end
end

-- Run after the default aftercast() is done.
-- eventArgs is the same one used in job_aftercast, in case information needs to be persisted.
function job_post_aftercast(spell, action, spellMap, eventArgs)

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

function define_roll_values()
	rolls = {
		"Corsair's Roll"   = {lucky=5, unlucky=9, bonus="Experience Points"},
		"Ninja Roll"       = {lucky=4, unlucky=8, bonus="Evasion"},
		"Hunter's Roll"    = {lucky=4, unlucky=8, bonus="Accuracy"},
		"Chaos Roll"       = {lucky=4, unlucky=8, bonus="Attack"},
		"Magus's Roll"     = {lucky=2, unlucky=6, bonus="Magic Defense"},
		"Healer's Roll"    = {lucky=3, unlucky=7, bonus="Cure Potency Received"},
		"Puppet Roll"      = {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
		"Choral Roll"      = {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
		"Monk's Roll"      = {lucky=3, unlucky=7, bonus="Subtle Blow"},
		"Beast Roll"       = {lucky=4, unlucky=8, bonus="Pet Attack"},
		"Samurai Roll"     = {lucky=2, unlucky=6, bonus="Store TP"},
		"Evoker's Roll"    = {lucky=5, unlucky=9, bonus="Refresh"},
		"Rogue's Roll"     = {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
		"Warlock's Roll"   = {lucky=4, unlucky=8, bonus="Magic Accuracy"},
		"Fighter's Roll"   = {lucky=5, unlucky=9, bonus="Double Attack Rate"},
		"Drachen Roll"     = {lucky=3, unlucky=7, bonus="Pet Accuracy"},
		"Gallant's Roll"   = {lucky=3, unlucky=7, bonus="Defense"},
		"Wizard's Roll"    = {lucky=5, unlucky=9, bonus="Magic Attack"},
		"Dancer's Roll"    = {lucky=3, unlucky=7, bonus="Regen"},
		"Scholar's Roll"   = {lucky=2, unlucky=6, bonus="Conserve MP"},
		"Bolter's Roll"    = {lucky=3, unlucky=9, bonus="Movement Speed"},
		"Caster's Roll"    = {lucky=2, unlucky=7, bonus="Fast Cast"},
		"Courser's Roll"   = {lucky=3, unlucky=9, bonus="Snapshot"},
		"Blitzer's Roll"   = {lucky=4, unlucky=9, bonus="Attack Delay"},
		"Tactician's Roll" = {lucky=5, unlucky=8, bonus="Regain"},
		"Allies's Roll"    = {lucky=3, unlucky=10, bonus="Skillchain Damage"},
		"Miser's Roll"     = {lucky=5, unlucky=7, bonus="Save TP"},
		"Companion's Roll" = {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
		"Avenger's Roll"   = {lucky=4, unlucky=8, bonus="Counter Rate"},
	}
end

function display_roll_info(spell)
	rollinfo = rolls[spell.english]
	if rollinfo then
		add_to_chat(104, spell.english..' provides a bonus to '..rollinfo.bonus..'. Lucky roll is '..
			tostring(rollinfo.lucky)..', Unlucky roll is '..tostring(rollinfo.unlucky)..'.'
	end
end


