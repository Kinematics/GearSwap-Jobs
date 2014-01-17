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
end

-- Function to re-bind Spellcast binds when unloading GearSwap.
function user.binds_on_unload()
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
end


-- Special gear info that may be useful across jobs.
user.gear = {}


-- Obis
user.gear.Obi = {}
user.gear.Obi.Light = "Korin Obi"
--user.gear.Obi.Dark = "Anrin Obi"
user.gear.Obi.Fire = "Karin Obi"
user.gear.Obi.Ice = "Hyorin Obi"
--user.gear.Obi.Wind = "Furin Obi"
--user.gear.Obi.Earth = "Dorin Obi"
user.gear.Obi.Lightning = "Rairin Obi"
--user.gear.Obi.Water = "Suirin Obi"


-- Staffs
user.gear.Staff = {}
user.gear.Staff.HMP = 'Chatoyant Staff'
user.gear.Staff.PDT = 'Earth Staff'


user.gear.Gorget = {}
user.gear.Gorget.Light = "Light Gorget"
--user.gear.Gorget.Dark = "Shadow Gorget"
--user.gear.Gorget.Fire = "Flame Gorget"
user.gear.Gorget.Ice = "Snow Gorget"
--user.gear.Gorget.Wind = "Wind Gorget"
user.gear.Gorget.Earth = "Soil Gorget"
user.gear.Gorget.Lightning = "Thunder Gorget"
--user.gear.Gorget.Water = "Aqua Gorget"

user.gear.Gorget.Ordering = L{'Earth','Lightning','Ice','Light','Dark'}
user.gear.Gorget.DefaultItem = "Asperity Necklace"
user.gear.ElementalGorget = {name=""}

user.gear.Belt = {}
user.gear.Belt.Light = "Light Belt"
user.gear.Belt.Dark = "Shadow Belt"
user.gear.Belt.Fire = "Flame Belt"
user.gear.Belt.Ice = "Snow Belt"
user.gear.Belt.Wind = "Wind Belt"
user.gear.Belt.Earth = "Soil Belt"
user.gear.Belt.Lightning = "Thunder Belt"
user.gear.Belt.Water = "Aqua Belt"

user.gear.Belt.Ordering = L{'Earth','Lightning','Ice','Light','Dark'}
user.gear.Belt.DefaultItem = "Caudata Belt"
user.gear.ElementalBelt = {name=""}


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


function user.user_test(params)

end


return user
