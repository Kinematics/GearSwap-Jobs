-------------------------------------------------------------------------------------------------------------------
-- Tables and functions for commonly-referenced gear that job files may need, but
-- doesn't belong in the global Mote-Include file since they'd get clobbered on each
-- update.
-- Creates the 'gear' table for reference in other files.
--
-- Note: Function and table definitions should be added to userInclude, but references to
-- the contained tables via functions (such as for the obi function, below) use only
-- the base 'gear' table.
-------------------------------------------------------------------------------------------------------------------

local userInclude = {}

-- Special gear info that may be useful across jobs.
userInclude.gear = {}


-- Obis
userInclude.gear.Obi = {}
userInclude.gear.Obi.Light = "Korin Obi"
--userInclude.gear.Obi.Dark = "Anrin Obi"
userInclude.gear.Obi.Fire = "Karin Obi"
userInclude.gear.Obi.Ice = "Hyorin Obi"
--userInclude.gear.Obi.Wind = "Furin Obi"
--userInclude.gear.Obi.Earth = "Dorin Obi"
userInclude.gear.Obi.Lightning = "Rairin Obi"
--userInclude.gear.Obi.Water = "Suirin Obi"


-- Staffs
userInclude.gear.Staff = {}
userInclude.gear.Staff.HMP = 'Chatoyant Staff'
userInclude.gear.Staff.PDT = 'Earth Staff'


-- Add the obi for the given element if it matches either the current weather or day.
function userInclude.add_obi(spell_element)
	if gear.Obi[spell_element] and (world.weather_element == spell_element or world.day_element == spell_element) then
		equip({waist=gear.Obi[spell_element]})
	end
end


return userInclude
