-------------------------------------------------------------------------------------------------------------------
-- Tables and functions for commonly-referenced gear that job files may need, but
-- doesn't belong in the global Mote-Include file since they'd get clobbered on each
-- update.
-- Creates the 'gear' table for reference in other files.
--
-- Note: Function and table definitions should be added to gearInclude, but references to
-- the contained tables via functions (such as for the obi function, below) use only
-- the base 'gear' table.
-------------------------------------------------------------------------------------------------------------------

local gearInclude = {}

-- Special gear info that may be useful across jobs.
gearInclude.gear = {}


-- Obis
gearInclude.gear.Obi = {}
gearInclude.gear.Obi.Light = "Korin Obi"
--gearInclude.gear.Obi.Dark = "Anrin Obi"
gearInclude.gear.Obi.Fire = "Karin Obi"
gearInclude.gear.Obi.Ice = "Hyorin Obi"
--gearInclude.gear.Obi.Wind = "Furin Obi"
--gearInclude.gear.Obi.Earth = "Dorin Obi"
gearInclude.gear.Obi.Lightning = "Rairin Obi"
--gearInclude.gear.Obi.Water = "Suirin Obi"


-- Staffs
gearInclude.gear.Staff = {}
gearInclude.gear.Staff.HMP = 'Chatoyant Staff'
gearInclude.gear.Staff.PDT = 'Earth Staff'


-- Add the obi for the given element if it matches either the current weather or day.
function gearInclude.add_obi(spell_element)
	if gear.Obi[spell_element] and (world.weather_element == spell_element or world.day_element == spell_element) then
		equip({waist=gear.Obi[spell_element]})
	end
end


return gearInclude
