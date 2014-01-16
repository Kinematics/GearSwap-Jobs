-------------------------------------------------------------------------------------------------------------------
-- Common variables and functions to be included in job scripts.
-- Include this file in the get_sets() function with the command:
-- include('Mote-Include.lua')
--
-- You then MUST run init_include()
--
-- IMPORTANT: This include requires supporting include files:
-- Mote-Utility
-- Mote-Mappings
-- Mote-SelfCommands
-- UserGlobals
--
-- It should be the first command in the get_sets() function, but must at least be executed before
-- any included vars are referenced.
--
-- Included variables and functions are considered to be at the same scope level as
-- the job script itself, and can be used as such.
--
-- This script has access to any vars defined at the job lua's scope, such as player and world.
-------------------------------------------------------------------------------------------------------------------

-- Last Modified: 1/11/2014 3:44:45 PM

-- Define the include module as a table (clean, forwards compatible with lua 5.2).
local MoteInclude = {}


-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines variables to be used.
-- These are accessible at the including job lua script's scope.
-------------------------------------------------------------------------------------------------------------------

-- If the job calling this include provides a version, check to see if that version matches
-- the current api/behavior version of this file.  Provide a warning of the user version
-- falls behind.
function MoteInclude.init_include(version)
	local currentVersion = 1
	if version then
		if version < currentVersion then
			add_to_chat(123,'Warning: Job file specifies version '..tostring(version)..', but current version of main include is '..tostring(currentVersion)..'.')
		end
	end

	-- Load externally-defined information (info that we don't want to change every time this file is updated).

	-- Used to define functions to set the user's desired global binds.
	include('Mote-Utility')
	-- Used to define various types of data mappings.
	include('Mote-Mappings')
	-- Used for all self-command handling.
	include('Mote-SelfCommands')


	-- Var for tracking state values
	state = {}

	-- General melee offense/defense modes, allowing for hybrid set builds, as well as idle/resting/weaponskill.
	state.OffenseMode     = 'Normal'
	state.DefenseMode     = 'Normal'
	state.WeaponskillMode = 'Normal'
	state.CastingMode     = 'Normal'
	state.IdleMode        = 'Normal'
	state.RestingMode     = 'Normal'

	-- All-out defense state, either physical or magical
	state.Defense = {}
	state.Defense.Active       = false
	state.Defense.Type         = 'Physical'
	state.Defense.PhysicalMode = 'PDT'
	state.Defense.MagicalMode  = 'MDT'

	state.Kiting               = false
	state.MaxWeaponskillDistance = 0

	state.SelectNPCTargets     = false
	state.PCTargetMode         = 'default'

	state.Buff = {}


	-- Vars for specifying valid mode values.
	-- Defaults here are just for example. Set them properly in each job file.
	options = {}
	options.OffenseModes = {'Normal', 'Acc','Crit'}
	options.DefenseModes = {'Normal', 'PDT', 'Evasion','Counter'}
	options.WeaponskillModes = {'Normal', 'PDT', 'Evasion','Counter'}
	options.CastingModes = {'Normal'}
	options.IdleModes = {'Normal'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'PDT', 'Evasion'}
	options.MagicalDefenseModes = {'MDT', 'Resist'}

	options.TargetModes = {'default', 'stpc', 'stpt', 'stal'}


	-- Spell mappings to describe a 'type' of spell.  Used when searching for valid sets.
	classes = {}
	-- Basic spell mappings are based on common spell series.
	-- EG: 'Cure' for Cure, Cure II, Cure III, Cure IV, Cure V, or Cure VI.
	classes.spellMappings = spell_maps
	-- List of spells and spell maps that don't benefit from greater skill (though
	-- they may benefit from spell-specific augments, such as improved regen or refresh).
	-- Spells that fall under this category will be skipped when searching for
	-- spell.skill sets.
	classes.NoSkillSpells = S{
		'Haste', 'Refresh', 'Regen', 'Protect', 'Protectra', 'Shell', 'Shellra',
		'Raise', 'Reraise','Cursna'}
	-- Custom, job-defined class, like the generic spell mappings.
	-- Takes precedence over default spell maps.
	-- Is reset at the end of each spell casting cycle (ie: at the end of aftercast).
	classes.CustomClass = nil
	-- Custom groups used for defining melee and idle sets.  Persists long-term.
	classes.CustomMeleeGroups = L{}
	classes.CustomIdleGroups = L{}
	classes.CustomDefenseGroups = L{}

	-- Var for use in melee set construction.
	TPWeapon = 'Normal'

	-- Special var for displaying sets at certain cast times.
	showSet = nil

	-- Display text mapping.
	on_off_names = {[true] = 'on', [false] = 'off'}


	-- Subtables within the sets table that we expect to exist, and are annoying to have to
	-- define within each individual job file.  We can define them here to make sure we don't
	-- have to check for existence.  The job file should be including this before defining
	-- any sets, so any changes it makes will override these anyway.
	sets.precast = {}
	sets.precast.FC = {}
	sets.precast.JA = {}
	sets.precast.WS = {}
	sets.midcast = {}
	sets.midcast.Pet = {}
	sets.idle = {}
	sets.resting = {}
	sets.engaged = {}
	sets.defense = {}
	sets.buff = {}

	-- Include general user globals (eg: the 'gear' table).
	include('UserGlobals')
end


-------------------------------------------------------------------------------------------------------------------
-- Generalized functions for handling precast/midcast/aftercast for player-initiated actions.
-- This depends on proper set naming.
-- Each job can override any amount of these general functions using job_xxx() hooks.
-------------------------------------------------------------------------------------------------------------------

-- Pretarget is called when GearSwap intercepts the original text input, but
-- before the game has done any processing on it.  In particular, it hasn't
-- initiated target selection for <st*> target types.
-- This is the only function where it will be valid to use change_target().
function MoteInclude.pretarget(spell,action)
	local spellMap = classes.spellMappings[spell.english]

	-- init a new eventArgs
	local eventArgs = {handled = false, cancel = false}

	-- Allow the job to handle it.
	if job_pretarget then
		job_pretarget(spell, action, spellMap, eventArgs)
	end

	if eventArgs.cancel then
		cancel_spell()
		return
	end

	-- If the job didn't handle things themselves, continue..
	if not eventArgs.handled then
		-- Handle optional target conversion.
		auto_change_target(spell, action, spellMap)
	end
end


-- Called after the text command has been processed (and target selected), but
-- before the packet gets pushed out.
-- Equip any gear that should be on before the spell or ability is used.
-- Define the set to be equipped at this point in time based on the type of action.
function MoteInclude.precast(spell, action)
	-- Get the spell mapping, since we'll be passing it to various functions and checks.
	local spellMap = classes.spellMappings[spell.english]

	-- init a new eventArgs
	local eventArgs = {handled = false, cancel = false}

	-- Allow jobs to have first shot at setting up the precast gear.
	if job_precast then
		job_precast(spell, action, spellMap, eventArgs)
	end

	if eventArgs.cancel then
		cancel_spell()
		return
	end

	-- Perform default equips if the job didn't handle it.
	if not eventArgs.handled then
		equip(get_default_precast_set(spell, action, spellMap, eventArgs))
	end

	-- Allow followup code to add to what was done here
	if job_post_precast then
		job_post_precast(spell, action, spellMap, eventArgs)
	end
end


-- Called immediately after precast() so that we can build the midcast gear set which
-- will be sent out at the same time (packet contains precastgear:action:midcastgear).
-- Midcast gear selected should be for potency, recast, etc.  It should take effect
-- regardless of the spell cast speed.
function MoteInclude.midcast(spell,action)
	-- If we have showSet active for precast, don't try to equip midcast gear.
	if showSet == 'precast' then
		add_to_chat(122, 'Show Sets: Stopping at precast.')
		return
	end

	local spellMap = classes.spellMappings[spell.english]

	-- init a new eventArgs
	local eventArgs = {handled = false}

	-- Allow jobs to override this code
	if job_midcast then
		job_midcast(spell, action, spellMap, eventArgs)
	end

	-- Perform default equips if the job didn't handle it.
	if not eventArgs.handled then
		equip(get_default_midcast_set(spell, action, spellMap, eventArgs))
	end

	-- Allow followup code to add to what was done here
	if job_post_midcast then
		job_post_midcast(spell, action, spellMap, eventArgs)
	end
end


-- Called when an action has been completed (eg: spell finished casting, or failed to cast).
function MoteInclude.aftercast(spell,action)
	-- If we have showSet active for precast or midcast, don't try to equip aftercast gear.
	if showSet == 'midcast' then
		add_to_chat(122, 'Show Sets: Stopping at midcast.')
		return
	elseif showSet == 'precast' then
		return
	end

	-- Ignore the Unknown Interrupt
	if spell.name == 'Unknown Interrupt' then
		--add_to_chat(123, 'aftercast trace: Unknown Interrupt.  interrupted='..tostring(spell.interrupted))
		return
	end

	local spellMap = classes.spellMappings[spell.english]

	-- init a new eventArgs
	local eventArgs = {handled = false}

	-- Allow jobs to override this code
	if job_aftercast then
		job_aftercast(spell, action, spellMap, eventArgs)
	end

	if not eventArgs.handled and not pet_midaction() then
		if spell.interrupted then
			-- Wait a half-second to update so that aftercast equip will actually be worn.
			windower.send_command('wait 0.6;gs c update')
		else
			handle_equipping_gear(player.status)
		end
	end

	-- Allow followup code to add to what was done here
	if job_post_aftercast then
		job_post_aftercast(spell, action, spellMap, eventArgs)
	end

	-- Reset after all possible precast/midcast/aftercast/job-specific usage of the value.
	if not pet_midaction() then
		classes.CustomClass = nil
	end
end


-- Called when the pet readies an action.
function MoteInclude.pet_midcast(spell,action)
	-- If we have showSet active for precast, don't try to equip midcast gear.
	if showSet == 'precast' then
		add_to_chat(122, 'Show Sets: Stopping at precast.')
		return
	end

	local spellMap = classes.spellMappings[spell.english]

	-- init a new eventArgs
	local eventArgs = {handled = false}

	-- Allow jobs to override this code
	if job_pet_midcast then
		job_pet_midcast(spell, action, spellMap, eventArgs)
	end

	-- Perform default equips if the job didn't handle it.
	if not eventArgs.handled then
		equip(get_default_pet_midcast_set(spell, action, spellMap, eventArgs))
	end

	-- Allow followup code to add to what was done here
	if job_post_pet_midcast then
		job_post_pet_midcast(spell, action, spellMap, eventArgs)
	end
end


-- Called when the pet's action is complete.
function MoteInclude.pet_aftercast(spell,action)
	-- If we have showSet active for precast or midcast, don't try to equip aftercast gear.
	if showSet == 'midcast' then
		add_to_chat(122, 'Show Sets: Stopping at midcast.')
		return
	elseif showSet == 'precast' then
		return
	end

	local spellMap = classes.spellMappings[spell.english]

	-- init a new eventArgs
	local eventArgs = {handled = false}

	-- Allow jobs to override this code
	if job_pet_aftercast then
		job_pet_aftercast(spell, action, spellMap, eventArgs)
	end

	if not eventArgs.handled then
		if spell.interrupted then
			-- Wait a half-second to update so that aftercast equip will actually be worn.
			windower.send_command('wait 0.6;gs c update')
		else
			handle_equipping_gear(player.status)
		end
	end

	-- Allow followup code to add to what was done here
	if job_post_pet_aftercast then
		job_post_pet_aftercast(spell, action, spellMap, eventArgs)
	end

	-- Reset after all possible precast/midcast/aftercast/job-specific usage of the value.
	classes.CustomClass = nil
end


-------------------------------------------------------------------------------------------------------------------
-- Hooks for non-action events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function MoteInclude.status_change(newStatus, oldStatus)
	-- init a new eventArgs
	local eventArgs = {handled = false}

	-- Allow jobs to override this code
	if job_status_change then
		job_status_change(newStatus, oldStatus, eventArgs)
	end


	-- Create a timer when we gain weakness.  Remove it when weakness is gone.
	if oldStatus == 'Dead' then
		send_command('timers create "Weakness" 300 up abilities/00255.png')
	end

	-- Equip default gear if not handled by the job.
	if not eventArgs.handled then
		handle_equipping_gear(newStatus)
	end
end


-- Called when the player's status changes.
function MoteInclude.pet_status_change(newStatus, oldStatus)
	-- init a new eventArgs
	local eventArgs = {handled = false}

	-- Allow jobs to override this code
	if job_pet_status_change then
		job_pet_status_change(newStatus, oldStatus, eventArgs)
	end

	-- Equip default gear if not handled by the job.
	if not eventArgs.handled then
		handle_equipping_gear(player.status, newStatus)
	end
end


-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function MoteInclude.buff_change(buff, gain)
	-- Global actions on buff effects

	-- Create a timer when we gain weakness.  Remove it when weakness is gone.
	if buff == 'Weakness' then
		if not gain then
			send_command('timers delete "Weakness"')
		end
	end

	-- Any job-specific handling.
	if job_buff_change then
		job_buff_change(buff, gain)
	end
end


-------------------------------------------------------------------------------------------------------------------
-- Generalized functions for selecting and equipping gear sets.
-------------------------------------------------------------------------------------------------------------------

-- Central point to call to equip gear based on status.
-- Status - Player status that we're using to define what gear to equip.
function MoteInclude.handle_equipping_gear(playerStatus, petStatus)
	-- init a new eventArgs
	local eventArgs = {handled = false}

	-- Allow jobs to override this code
	if job_handle_equipping_gear then
		job_handle_equipping_gear(playerStatus, eventArgs)
	end

	-- Equip default gear if job didn't handle it.
	if not eventArgs.handled then
		equip_gear_by_status(playerStatus)
	end
end


-- Function to wrap logic for equipping gear on aftercast, status change, or user update.
-- @param status : The current or new player status that determines what sort of gear to equip.
function MoteInclude.equip_gear_by_status(status)
	if _global.debug_mode then add_to_chat(123,'Debug: Equip gear for status ['..tostring(status)..'], HP='..tostring(player.hp)) end

	-- If status not defined, treat as idle.
	-- Be sure to check for positive HP to make sure they're not dead.
	if status == nil or status == '' then
		if player.hp > 0 then
			equip(get_current_idle_set())
		end
	elseif status == 'Idle' then
		equip(get_current_idle_set())
	elseif status == 'Engaged' then
		equip(get_current_melee_set())
	elseif status == 'Resting' then
		equip(get_current_resting_set())
	end
end


-------------------------------------------------------------------------------------------------------------------
-- Functions for constructing default sets.
-------------------------------------------------------------------------------------------------------------------

-- Get the default precast gear set.
function MoteInclude.get_default_precast_set(spell, action, spellMap, eventArgs)
	local equipSet = {}

	if spell.action_type == 'Magic' then
		-- Call this to break 'precast.FC' into a proper set.
		equipSet = sets.precast.FC

		-- Set determination ordering:
		-- Custom class
		-- Class mapping
		-- Specific spell name
		-- Skill
		-- Spell type
		if classes.CustomClass and equipSet[classes.CustomClass] then
			equipSet = equipSet[classes.CustomClass]
		elseif equipSet[spell.english] then
			equipSet = equipSet[spell.english]
		elseif spellMap and equipSet[spellMap] then
			equipSet = equipSet[spellMap]
		elseif equipSet[spell.skill] then
			equipSet = equipSet[spell.skill]
		elseif equipSet[spell.type] then
			equipSet = equipSet[spell.type]
		end

		-- Check for specialized casting modes for any given set selection.
		if equipSet[state.CastingMode] then
			equipSet = equipSet[state.CastingMode]
		end

		-- Magian staves with fast cast on them
		if sets.precast.FC[tostring(spell.element)] then
			equipSet = set_combine(equipSet, baseSet[tostring(spell.element)])
		end
	elseif spell.type:lower() == 'weaponskill' then
		local modeToUse = state.WeaponskillMode
		local job_wsmode = nil

		-- Allow the job file to specify a weaponskill mode
		if get_job_wsmode then
			job_wsmode = get_job_wsmode(spell, action, spellMap)
		end

		-- If the job file returned a weaponskill mode, use that.
		if job_wsmode then
			modeToUse = job_wsmode
		elseif state.WeaponskillMode == 'Normal' then
			-- If a particular weaponskill mode isn't specified, see if we have a weaponskill mode
			-- corresponding to the current offense mode.  If so, use that.
			if state.OffenseMode ~= 'Normal' and S(options.WeaponskillModes)[state.OffenseMode] then
				modeToUse = state.OffenseMode
			end
		end

		if sets.precast.WS[spell.english] then
			if sets.precast.WS[spell.english][modeToUse] then
				equipSet = sets.precast.WS[spell.english][modeToUse]
			else
				equipSet = sets.precast.WS[spell.english]
			end
		elseif classes.CustomClass and sets.precast.WS[classes.CustomClass] then
			if sets.precast.WS[classes.CustomClass][modeToUse] then
				equipSet = sets.precast.WS[classes.CustomClass][modeToUse]
			else
				equipSet = sets.precast.WS[classes.CustomClass]
			end
		else
			if sets.precast.WS[modeToUse] then
				equipSet = sets.precast.WS[modeToUse]
			else
				equipSet = sets.precast.WS
			end
		end
	elseif spell.type:lower() == 'jobability' then
		if sets.precast.JA[spell.english] then
			equipSet = sets.precast.JA[spell.english]
		end
	-- Other types, such as Waltz, Jig, Scholar, etc.
	elseif sets.precast[spell.type] then
		if sets.precast[spell.type][spell.english] then
			equipSet = sets.precast[spell.type][spell.english]
		else
			equipSet = sets.precast[spell.type]
		end
	-- Also check custom class on its own.
	elseif classes.CustomClass and sets.precast[classes.CustomClass] then
		equipSet = sets.precast[classes.CustomClass]
	-- And spell mapping on its own.
	elseif spellMap and sets.precast[spellMap] then
		equipSet = sets.precast[spellMap]
	end

	return equipSet
end


-- Get the default midcast gear set.
function MoteInclude.get_default_midcast_set(spell, action, spellMap, eventArgs)
	local equipSet = {}

	-- Set selection ordering:
	-- Custom class
	-- Specific spell name
	-- Class mapping
	-- Skill
	-- Spell type (which also checks class, name, and mapping)

	if classes.CustomClass and sets.midcast[classes.CustomClass] then
		equipSet = sets.midcast[classes.CustomClass]
	elseif sets.midcast[spell.english] then
		equipSet = sets.midcast[spell.english]
	elseif spellMap and sets.midcast[spellMap] then
		equipSet = sets.midcast[spellMap]
	elseif sets.midcast[spell.skill] and not (classes.NoSkillSpells[spell.english] or classes.NoSkillSpells[spellMap]) then
		equipSet = sets.midcast[spell.skill]
	elseif sets.midcast[spell.type] then
		if classes.CustomClass and sets.midcast[spell.type][classes.CustomClass] then
			equipSet = sets.midcast[spell.type][classes.CustomClass]
		elseif sets.midcast[spell.type][spell.english] then
			equipSet = sets.midcast[spell.type][spell.english]
		elseif spellMap and sets.midcast[spell.type][spellMap] then
			equipSet = sets.midcast[spell.type][spellMap]
		else
			equipSet = sets.midcast[spell.type]
		end
	else
		equipSet = sets.midcast
	end

	-- Check for specialized casting modes for magic spells.
	if spell.action_type == 'Magic' and equipSet[state.CastingMode] then
		equipSet = equipSet[state.CastingMode]
	end

	return equipSet
end


-- Get the default pet midcast gear set.
function MoteInclude.get_default_pet_midcast_set(spell, action, spellMap, eventArgs)
	local equipSet = {}

	-- TODO: examine possible values in pet actions

	-- Set selection ordering:
	-- Custom class
	-- Specific spell name
	-- Class mapping
	-- Skill
	-- Spell type
	if sets.midcast.Pet then
		if classes.CustomClass and sets.midcast.Pet[classes.CustomClass] then
			equipSet = sets.midcast.Pet[classes.CustomClass]
		elseif sets.midcast.Pet[spell.english] then
			equipSet = sets.midcast.Pet[spell.english]
		elseif spellMap and sets.midcast.Pet[spellMap] then
			equipSet = sets.midcast.Pet[spellMap]
		elseif sets.midcast.Pet[spell.skill] then
			equipSet = sets.midcast.Pet[spell.skill]
		elseif sets.midcast.Pet[spell.type] then
			equipSet = sets.midcast.Pet[spell.type]
		else
			equipSet = sets.midcast.Pet
		end
	end

	-- Check for specialized casting modes for any given set selection.
	if equipSet[state.CastingMode] then
		equipSet = equipSet[state.CastingMode]
	end

	return equipSet
end


-- Returns the appropriate idle set based on current state.
function MoteInclude.get_current_idle_set()
	local idleScope = ''
	local idleSet = sets.idle
	
	if buffactive.weakness then
		idleScope = 'Weak'
	elseif areas.Cities[world.area] then
		idleScope = 'Town'
	else
		idleScope = 'Field'
	end

	if _global.debug_mode then add_to_chat(123,'Debug: Idle scope for '..world.area..' is '..idleScope) end

	if idleSet[idleScope] then
		idleSet = idleSet[idleScope]
	end

	if idleSet[state.IdleMode] then
		idleSet = idleSet[state.IdleMode]
	end
	
	if (pet.isvalid or state.Buff.Pet) and idleSet.Pet then
		idleSet = idleSet.Pet
	end

	for i = 1,#classes.CustomIdleGroups do
		if idleSet[classes.CustomIdleGroups[i]] then
			idleSet = idleSet[classes.CustomIdleGroups[i]]
		end
	end

	idleSet = apply_defense(idleSet)
	idleSet = apply_kiting(idleSet)

	if customize_idle_set then
		idleSet = customize_idle_set(idleSet)
	end

	--if _global.debug_mode then print_set(idleSet, 'Final Idle Set') end

	return idleSet
end


-- Returns the appropriate melee set based on current state.
-- Set construction order (all sets after sets.engaged are optional):
--   sets.engaged[classes.CustomMeleeGroups (any number)][TPWeapon][state.OffenseMode][state.DefenseMode]
function MoteInclude.get_current_melee_set()
	local meleeSet = sets.engaged

	for i = 1,#classes.CustomMeleeGroups do
		if meleeSet[classes.CustomMeleeGroups[i]] then
			meleeSet = meleeSet[classes.CustomMeleeGroups[i]]
		end
	end

	if meleeSet[TPWeapon] then
		meleeSet = meleeSet[TPWeapon]
	end

	if meleeSet[state.OffenseMode] then
		meleeSet = meleeSet[state.OffenseMode]
	end

	if meleeSet[state.DefenseMode] then
		meleeSet = meleeSet[state.DefenseMode]
	end

	meleeSet = apply_defense(meleeSet)
	meleeSet = apply_kiting(meleeSet)

	if customize_melee_set then
		meleeSet = customize_melee_set(meleeSet)
	end

	--if _global.debug_mode then print_set(meleeSet, 'Melee set') end

	return meleeSet
end


-- Returns the appropriate resting set based on current state.
function MoteInclude.get_current_resting_set()
	local restingSet = {}

	if sets.resting[state.RestingMode] then
		restingSet = sets.resting[state.RestingMode]
	else
		restingSet = sets.resting
	end

	--if _global.debug_mode then print_set(restingSet, 'Resting Set') end

	return restingSet
end


-- Function to apply any active defense set on top of the supplied set
-- @param baseSet : The set that any currently active defense set will be applied on top of. (gear set table)
function MoteInclude.apply_defense(baseSet)
	if state.Defense.Active then
		local defenseSet = {}
		local defMode = ''

		if state.Defense.Type == 'Physical' then
			defMode = state.Defense.PhysicalMode

			if sets.defense[state.Defense.PhysicalMode] then
				defenseSet = sets.defense[state.Defense.PhysicalMode]
			else
				defenseSet = sets.defense
			end
		else
			defMode = state.Defense.MagicalMode

			if sets.defense[state.Defense.MagicalMode] then
				defenseSet = sets.defense[state.Defense.MagicalMode]
			else
				defenseSet = sets.defense
			end
		end
		
		for i = 1,#classes.CustomDefenseGroups do
			if defenseSet[classes.CustomDefenseGroups[i]] then
				defenseSet = defenseSet[classes.CustomDefenseGroups[i]]
			end
		end

		baseSet = set_combine(baseSet, defenseSet)
	end

	return baseSet
end


-- Function to add kiting gear on top of the base set if kiting state is true.
-- @param baseSet : The set that the kiting gear will be applied on top of. (gear set table)
function MoteInclude.apply_kiting(baseSet)
	if state.Kiting then
		if sets.Kiting then
			baseSet = set_combine(baseSet, sets.Kiting)
		end
	end

	return baseSet
end



-- Done with defining the module.  Return the table.
return MoteInclude
