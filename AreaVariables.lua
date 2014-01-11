-------------------------------------------------------------------------------------------------------------------
-- Tables to specify general area groupings.  Creates the 'areas' table to be referenced in job files.
-- Zone names provided by world.area/world.zone are currently in all-caps, so defining the same way here.
-------------------------------------------------------------------------------------------------------------------

local areasInclude = {}

areasInclude.areas = {}

-- City areas for town gear and behavior.
areasInclude.areas.Cities = S{
	"RU'LUDE GARDENS",
	'UPPER JEUNO',
	'LOWER JEUNO',
	'PORT JEUNO',
	'PORT WINDURST',
	'WINDURST WATERS',
	'WINDURST WOODS',
	'WINDURST WALLS',
	'HEAVENS TOWER',
	"PORT SAN D'ORIA",
	"NORTHERN SAN D'ORIA",
	"SOUTHERN SAN D'ORIA",
	'PORT BASTOK',
	'BASTOK MARKETS',
	'BASTOK MINES',
	'METALWORKS',
	'AHT URHGAN WHITEGATE',
	'TAVANAZIAN SAFEHOLD',
	'NASHMAU',
	'SELBINA',
	'MHAURA',
	'NORG',
	'EASTERN ADOULIN',
	'WESTERN ADOULIN',
	'KAZHAM'
}
-- Adoulin areas, where Ionis will grant special stat bonuses.
areasInclude.areas.Adoulin = S{
	'YAHSE HUNTING GROUNDS',
	'CEIZAK BATTLEGROUNDS',
	'FORET DE HENNETIEL',
	'MORIMAR BASALT FIELDS',
	'YORCIA WEALD',
	'YORCIA WEALD [U]',
	'CIRDAS CAVERNS',
	'CIRDAS CAVERNS [U]',
	'MARJAMI RAVINE',
	'KAMIHR DRIFTS',
	'SIH GATES',
	'MOH GATES',
	'DHO GATES',
	'WOH GATES',
	'RALA WATERWAYS',
	'RALA WATERWAYS [U]' -- TODO: Validate whether this one is valid
}

return areasInclude
