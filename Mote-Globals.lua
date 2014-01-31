-------------------------------------------------------------------------------------------------------------------
-- Tables and functions for commonly-referenced gear that job files may need, but
-- doesn't belong in the global Mote-Include file since they'd get clobbered on each
-- update.
-- Creates the 'gear' table for reference in other files.
--
-- Note: Function and table definitions should be added to user, but references to
-- the contained tables via functions (such as for the obi function, below) use only
-- the 'gear' table.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- Modify the sets table.  Any gear sets that are added to the sets table need to
-- be defined within this function, because sets isn't available until after the
-- include is complete.  It is called at the end of basic initialization in Mote-Include.
-------------------------------------------------------------------------------------------------------------------

function define_global_sets()
	-- Special gear info that may be useful across jobs.

	-- Staffs
	gear.Staff = {}
	gear.Staff.HMP = 'Chatoyant Staff'
	gear.Staff.PDT = 'Earth Staff'
	
	-- Default items for utility gear values.
	gear.default.weaponskill_neck = "Asperity Necklace"
	gear.default.weaponskill_waist = "Caudata Belt"
	gear.default.obi_waist = "Cognition Belt"
	gear.default.obi_back = "Toro Cape"
	gear.default.obi_ring = "Strendu Ring"
	gear.default.fastcast_staff = ""
	gear.default.recast_staff = ""
end

-------------------------------------------------------------------------------------------------------------------
-- Functions to set user-specified binds, generally on load and unload.
-- Kept separate from the main include so as to not get clobbered when the main is updated.
-------------------------------------------------------------------------------------------------------------------

-- Function to bind GearSwap binds when loading a GS script.
function binds_on_load()
	send_command('bind f9 gs c cycle OffenseMode')
	send_command('bind ^f9 gs c cycle DefenseMode')
	send_command('bind !f9 gs c cycle WeaponskillMode')
	send_command('bind f10 gs c activate PhysicalDefense')
	send_command('bind ^f10 gs c cycle PhysicalDefenseMode')
	send_command('bind !f10 gs c toggle kiting')
	send_command('bind f11 gs c activate MagicalDefense')
	send_command('bind ^f11 gs c cycle CastingMode')
	send_command('bind !f11 gs c set CastingMode Dire')
	send_command('bind f12 gs c update user')
	send_command('bind ^f12 gs c cycle IdleMode')
	send_command('bind !f12 gs c reset defense')

	send_command('bind ^- gs c toggle target')
	send_command('bind ^= gs c cycle targetmode')
end

-- Function to re-bind Spellcast binds when unloading GearSwap.
function binds_on_unload()
	-- Commented out for now.
	--[[
	send_command('bind f9 input /ma CombatMode Cycle(Offense)')
	send_command('bind ^f9 input /ma CombatMode Cycle(Defense)')
	send_command('bind !f9 input /ma CombatMode Cycle(WS)')
	send_command('bind f10 input /ma PhysicalDefense .On')
	send_command('bind ^f10 input /ma PhysicalDefense .Cycle')
	send_command('bind !f10 input /ma CombatMode Toggle(Kite)')
	send_command('bind f11 input /ma MagicalDefense .On')
	send_command('bind ^f11 input /ma CycleCastingMode')
	send_command('bind !f11 input /ma CastingMode Dire')
	send_command('bind f12 input /ma Update .Manual')
	send_command('bind ^f12 input /ma CycleIdleMode')
	send_command('bind !f12 input /ma Reset .Defense')
	--]]

	send_command('unbind ^-')
	send_command('unbind ^=')
end


-------------------------------------------------------------------------------------------------------------------
-- Global event-handling functions.
-------------------------------------------------------------------------------------------------------------------

-- Global intercept on user status change.
function user_status_change(newStatus, oldStatus, eventArgs)
	-- Create a timer when we gain weakness.  Remove it when weakness is gone.
	if oldStatus == 'Dead' then
		send_command('timers create "Weakness" 300 up abilities/00255.png')
	end
end


function user_buff_change(buff, gain, eventArgs)
	-- Create a timer when we gain weakness.  Remove it when weakness is gone.
	if buff == 'Weakness' then
		if not gain then
			send_command('timers delete "Weakness"')
		end
	end
end


-------------------------------------------------------------------------------------------------------------------
-- Test function to use to avoid modifying Mote-SelfCommands.
-------------------------------------------------------------------------------------------------------------------

function user_test(params)

end

