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

local user = {}

-------------------------------------------------------------------------------------------------------------------
-- Define globally-accessible tables here.  EG: user.gear defines the gear table, which
-- any job will be able to access.
-------------------------------------------------------------------------------------------------------------------

-- Special gear info that may be useful across jobs.
user.gear = {}

-- Staffs
user.gear.Staff = {}
user.gear.Staff.HMP = 'Chatoyant Staff'
user.gear.Staff.PDT = 'Earth Staff'

user.gear.ElementalGorget = {name=""}
user.gear.ElementalBelt = {name=""}
user.gear.ElementalObi = {name=""}
user.gear.ElementalCape = {name=""}
user.gear.ElementalRing = {name=""}

user.gear.default = {}
user.gear.default.weaponskill_neck = "Asperity Necklace"
user.gear.default.weaponskill_waist = "Caudata Belt"
user.gear.default.obi_waist = "Cognition Belt"
user.gear.default.obi_back = "Toro Cape"
user.gear.default.obi_ring = "Strendu Ring"



-------------------------------------------------------------------------------------------------------------------
-- Modify the sets table.  Any gear sets that are added to the sets table need to
-- be defined within this function, because sets isn't available until after the
-- include is complete.  It is called at the end of basic initialization in Mote-Include.
-------------------------------------------------------------------------------------------------------------------

function user.define_global_sets()
	sets.precast.FC.Ice = {main="Vourukasha I",sub="Achaq Grip"}
end

-------------------------------------------------------------------------------------------------------------------
-- Functions to set user-specified binds, generally on load and unload.
-- Kept separate from the main include so as to not get clobbered when the main is updated.
-------------------------------------------------------------------------------------------------------------------

-- Function to bind GearSwap binds when loading a GS script.
function user.binds_on_load()
	windower.send_command('bind f9 gs c cycle OffenseMode')
	windower.send_command('bind ^f9 gs c cycle DefenseMode')
	windower.send_command('bind !f9 gs c cycle WeaponskillMode')
	windower.send_command('bind f10 gs c activate PhysicalDefense')
	windower.send_command('bind ^f10 gs c cycle PhysicalDefenseMode')
	windower.send_command('bind !f10 gs c toggle kiting')
	windower.send_command('bind f11 gs c activate MagicalDefense')
	windower.send_command('bind ^f11 gs c cycle CastingMode')
	windower.send_command('bind !f11 gs c set CastingMode Dire')
	windower.send_command('bind f12 gs c update user')
	windower.send_command('bind ^f12 gs c cycle IdleMode')
	windower.send_command('bind !f12 gs c reset defense')

	windower.send_command('bind ^- gs c toggle target')
	windower.send_command('bind ^= gs c cycle targetmode')
end

-- Function to re-bind Spellcast binds when unloading GearSwap.
function user.binds_on_unload()
	-- Commented out for now.
	--[[
	windower.send_command('bind f9 input /ma CombatMode Cycle(Offense)')
	windower.send_command('bind ^f9 input /ma CombatMode Cycle(Defense)')
	windower.send_command('bind !f9 input /ma CombatMode Cycle(WS)')
	windower.send_command('bind f10 input /ma PhysicalDefense .On')
	windower.send_command('bind ^f10 input /ma PhysicalDefense .Cycle')
	windower.send_command('bind !f10 input /ma CombatMode Toggle(Kite)')
	windower.send_command('bind f11 input /ma MagicalDefense .On')
	windower.send_command('bind ^f11 input /ma CycleCastingMode')
	windower.send_command('bind !f11 input /ma CastingMode Dire')
	windower.send_command('bind f12 input /ma Update .Manual')
	windower.send_command('bind ^f12 input /ma CycleIdleMode')
	windower.send_command('bind !f12 input /ma Reset .Defense')
	--]]

	windower.send_command('unbind ^-')
	windower.send_command('unbind ^=')
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

function user.user_test(params)

end


return user
