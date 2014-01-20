-------------------------------------------------------------------------------------------------------------------
-- Mappings, lists and sets to describe game relationships that aren't easily determinable otherwise.
-------------------------------------------------------------------------------------------------------------------

local mappings = {}


-------------------------------------------------------------------------------------------------------------------
-- Elemental mappings for element relationships and certian types of spells.
-------------------------------------------------------------------------------------------------------------------

mappings.elements = {}

mappings.elements.list = L{'Light','Dark','Fire','Ice','Wind','Earth','Lightning','Water'}

mappings.elements.weak_to = {['Light']='Dark', ['Dark']='Light', ['Fire']='Ice', ['Ice']='Wind', ['Wind']='Earth', ['Earth']='Lightning',
		['Lightning']='Water', ['Water']='Fire'}

mappings.elements.strong_to = {['Light']='Dark', ['Dark']='Light', ['Fire']='Water', ['Ice']='Fire', ['Wind']='Ice', ['Earth']='Wind',
		['Lightning']='Earth', ['Water']='Lightning'}

mappings.elements.storm_of = {['Light']="Aurorastorm", ['Dark']="Voidstorm", ['Fire']="Firestorm", ['Earth']="Sandstorm",
		['Water']="Rainstorm", ['Wind']="Windstorm", ['Ice']="Hailstorm", ['Lightning']="Thunderstorm"}

mappings.elements.spirit_of = {['Light']="Light Spirit", ['Dark']="Dark Spirit", ['Fire']="Fire Spirit", ['Earth']="Earth Spirit",
		['Water']="Water Spirit", ['Wind']="Air Spirit", ['Ice']="Ice Spirit", ['Lightning']="Thunder Spirit"}



mappings.storms = S{"Aurorastorm", "Voidstorm", "Firestorm", "Sandstorm", "Rainstorm", "Windstorm", "Hailstorm", "Thunderstorm"}


mappings.skillchain_elements = {}
mappings.skillchain_elements.Light = S{'Light','Fire','Wind','Lightning'}
mappings.skillchain_elements.Dark = S{'Dark','Ice','Earth','Water'}
mappings.skillchain_elements.Fusion = S{'Light','Fire'}
mappings.skillchain_elements.Fragmentation = S{'Wind','Lightning'}
mappings.skillchain_elements.Distortion = S{'Ice','Water'}
mappings.skillchain_elements.Gravitation = S{'Dark','Earth'}
mappings.skillchain_elements.Transfixion = S{'Light'}
mappings.skillchain_elements.Compression = S{'Dark'}
mappings.skillchain_elements.Liquification = S{'Fire'}
mappings.skillchain_elements.Induration = S{'Ice'}
mappings.skillchain_elements.Detonation = S{'Wind'}
mappings.skillchain_elements.Scission = S{'Earth'}
mappings.skillchain_elements.Impaction = S{'Lightning'}
mappings.skillchain_elements.Reverberation = S{'Water'}



-- list of weaponskills that use ammo
mappings.bow_gun_weaponskills = S{"Flaming Arrow", "Piercing Arrow", "Dulling Arrow", "Sidewinder", "Blast Arrow",
	"Arching Arrow", "Empyreal Arrow", "Refulgent Arrow", "Apex Arrow", "Namas Arrow", "Jishnu's Radiance",
	"Hot Shot", "Split Shot", "Sniper Shot", "Slug Shot", "Blast Shot", "Heavy Shot", "Detonator",
	"Numbing Shot", "Last Stand", "Coronach", "Trueflight", "Leaden Salute", "Wildfire"}

-- list of weaponskills that can be used at greater than melee range
mappings.ranged_weaponskills = S{"Flaming Arrow", "Piercing Arrow", "Dulling Arrow", "Sidewinder", "Arching Arrow",
	"Empyreal Arrow", "Refulgent Arrow", "Apex Arrow", "Namas Arrow", "Jishnu's Radiance",
	"Hot Shot", "Split Shot", "Sniper Shot", "Slug Shot", "Heavy Shot", "Detonator", "Last Stand",
	"Coronach", "Trueflight", "Leaden Salute", "Wildfire",
	"Myrkr"}


-------------------------------------------------------------------------------------------------------------------
-- Spell mappings allow defining a general category or description that each of sets of related
-- spells all fall under.
-------------------------------------------------------------------------------------------------------------------

mappings.spell_maps = {
	['Cure']='Cure',['Cure II']='Cure',['Cure III']='Cure',['Cure IV']='Cure',['Cure V']='Cure',['Cure VI']='Cure',
	['Cura']='Curaga',['Cura II']='Curaga',['Cura III']='Curaga',
	['Curaga']='Curaga',['Curaga II']='Curaga',['Curaga III']='Curaga',['Curaga IV']='Curaga',['Curaga V']='Curaga',
	-- Status Removal doesn't include Esuna or Sacrifice, since they work differently than the rest
	['Poisona']='StatusRemoval',['Paralyna']='StatusRemoval',['Silena']='StatusRemoval',['Blindna']='StatusRemoval',['Cursna']='StatusRemoval',
	['Stona']='StatusRemoval',['Viruna']='StatusRemoval',['Erase']='StatusRemoval',
	['Barfire']='Barspell',['Barstone']='Barspell',['Barwater']='Barspell',['Baraero']='Barspell',['Barblizzard']='Barspell',['Barthunder']='Barspell',
	['Barfira']='Barspell',['Barstonra']='Barspell',['Barwatera']='Barspell',['Baraera']='Barspell',['Barblizzara']='Barspell',['Barthundra']='Barspell',
	['Raise']='Raise',['Raise II']='Raise',['Raise III']='Raise',['Arise']='Raise',
	['Reraise']='Reraise',['Reraise II']='Reraise',['Reraise III']='Reraise',
	['Protect']='Protect',['Protect II']='Protect',['Protect III']='Protect',['Protect IV']='Protect',['Protect V']='Protect',
	['Shell']='Shell',['Shell II']='Shell',['Shell III']='Shell',['Shell IV']='Shell',['Shell V']='Shell',
	['Protectra']='Protectra',['Protectra II']='Protectra',['Protectra III']='Protectra',['Protectra IV']='Protectra',['Protectra V']='Protectra',
	['Shellra']='Shellra',['Shellra II']='Shellra',['Shellra III']='Shellra',['Shellra IV']='Shellra',['Shellra V']='Shellra',
	['Regen']='Regen',['Regen II']='Regen',['Regen III']='Regen',['Regen IV']='Regen',['Regen V']='Regen',
	['Refresh']='Refresh',['Refresh II']='Refresh',
	['Teleport-Holla']='Teleport',['Teleport-Dem']='Teleport',['Teleport-Mea']='Teleport',['Teleport-Altep']='Teleport',['Teleport-Yhoat']='Teleport',
	['Teleport-Vahzl']='Teleport',['Recall-Pashh']='Teleport',['Recall-Meriph']='Teleport',['Recall-Jugner']='Teleport',
	['Valor Minuet']='Minuet',['Valor Minuet II']='Minuet',['Valor Minuet III']='Minuet',['Valor Minuet IV']='Minuet',['Valor Minuet V']='Minuet',
	["Knight's Minne"]='Minne',["Knight's Minne II"]='Minne',["Knight's Minne III"]='Minne',["Knight's Minne IV"]='Minne',["Knight's Minne V"]='Minne',
	['Advancing March']='March',['Victory March']='March',
	['Sword Madrigal']='Madrigal',['Blade Madrigal']='Madrigal',
	["Mage's Ballad"]='Ballad',["Mage's Ballad II"]='Ballad',["Mage's Ballad III"]='Ballad',
	["Army's Paeon"]='Paeon',["Army's Paeon II"]='Paeon',["Army's Paeon III"]='Paeon',["Army's Paeon IV"]='Paeon',["Army's Paeon V"]='Paeon',["Army's Paeon VI"]='Paeon',
	['Fire Carol']='Carol',['Ice Carol']='Carol',['Wind Carol']='Carol',['Earth Carol']='Carol',['Lightning Carol']='Carol',['Water Carol']='Carol',['Light Carol']='Carol',['Dark Carol']='Carol',
	['Fire Carol II']='Carol',['Ice Carol II']='Carol',['Wind Carol II']='Carol',['Earth Carol II']='Carol',['Lightning Carol II']='Carol',['Water Carol II']='Carol',['Light Carol II']='Carol',['Dark Carol II']='Carol',
	['Foe Lullaby']='Lullaby',['Foe Lullaby II']='Lullaby',['Horde Lullaby']='Lullaby',['Horde Lullaby II']='Lullaby',
	['Fire Threnody']='Threnody',['Ice Threnody']='Threnody',['Wind Threnody']='Threnody',['Earth Threnody']='Threnody',['Lightning Threnody']='Threnody',['Water Threnody']='Threnody',['Light Threnody']='Threnody',['Dark Threnody']='Threnody',
	['Utsusemi: Ichi']='Utsusemi',['Utsusemi: Ni']='Utsusemi',
	['Banish']='Banish',['Banish II']='Banish',['Banish III']='Banish',['Banishga']='Banish',['Banishga II']='Banish',
	['Holy']='Holy',['Holy II']='Holy',
	['Burn']='ElementalEnfeeble',['Frost']='ElementalEnfeeble',['Choke']='ElementalEnfeeble',['Rasp']='ElementalEnfeeble',['Shock']='ElementalEnfeeble',['Drown']='ElementalEnfeeble',
	['Pyrohelix']='Helix',['Cryohelix']='Helix',['Anemohelix']='Helix',['Geohelix']='Helix',['Ionohelix']='Helix',['Hydrohelix']='Helix',['Luminohelix']='Helix',['Noctohelix']='Helix',
	['Firestorm']='Storm',['Hailstorm']='Storm',['Windstorm']='Storm',['Sandstorm']='Storm',['Thunderstorm']='Storm',['Rainstorm']='Storm',['Aurorastorm']='Storm',['Voidstorm']='Storm',
	['Fire Maneuver']='Maneuver',['Ice Maneuver']='Maneuver',['Wind Maneuver']='Maneuver',['Earth Maneuver']='Maneuver',['Thunder Maneuver']='Maneuver',
	['Water Maneuver']='Maneuver',['Light Maneuver']='Maneuver',['Dark Maneuver']='Maneuver',
}

mappings.no_skill_spells_list = S{'Haste', 'Refresh', 'Regen', 'Protect', 'Protectra', 'Shell', 'Shellra',
		'Raise', 'Reraise', 'Cursna'}


-------------------------------------------------------------------------------------------------------------------
-- Tables to specify general area groupings.  Creates the 'areas' table to be referenced in job files.
-- Zone names provided by world.area/world.zone are currently in all-caps, so defining the same way here.
-------------------------------------------------------------------------------------------------------------------

mappings.areas = {}

-- City areas for town gear and behavior.
mappings.areas.Cities = S{
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
mappings.areas.Adoulin = S{
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


-------------------------------------------------------------------------------------------------------------------
-- Lists of certain NPCs.
-------------------------------------------------------------------------------------------------------------------

mappings.npcs = {}
mappings.npcs.Trust = S{'Ayame','Naji','Nanaa Mihgo','Tenzen','Volker','Zeid',
	'Ajido-Marujido','Shantotto','Curilla','Excenmille','Trion','Valaineral',
	'Kupipi','Mihli Aliapoh','Joachim','Lion'}


-------------------------------------------------------------------------------------------------------------------
-- Mappings for elemental gear
-------------------------------------------------------------------------------------------------------------------

mappings.gear_map = {}

mappings.gear_map.Obi = {['Light']='Korin Obi', ['Dark']='Anrin Obi', ['Fire']='Karin Obi', ['Ice']='Hyorin Obi', ['Wind']='Furin Obi',
	 ['Earth']='Dorin Obi', ['Lightning']='Rairin Obi', ['Water']='Suirin Obi'}

mappings.gear_map.Gorget = {['Light']='Light Gorget', ['Dark']='Shadow Gorget', ['Fire']='Flame Gorget', ['Ice']='Snow Gorget',
	['Wind']='Wind Gorget', ['Earth']='Soil Gorget', ['Lightning']='Thunder Gorget', ['Water']='Aqua Gorget'}

mappings.gear_map.Belt = {['Light']='Light Belt', ['Dark']='Shadow Belt', ['Fire']='Flame Belt', ['Ice']='Snow Belt',
	['Wind']='Wind Belt', ['Earth']='Soil Belt', ['Lightning']='Thunder Belt', ['Water']='Aqua Belt'}

mappings.gear_map.FastcastStaff = {['Light']='Arka I', ['Dark']='Xsaeta I', ['Fire']='Atar I', ['Ice']='Vourukasha I',
	['Wind']='Vayuvata I', ['Earth']='Vishrava I', ['Lightning']='Apamajas I', ['Water']='Haoma I', ['Thunder']='Apamajas I'}

mappings.gear_map.RecastStaff = {['Light']='Arka II', ['Dark']='Xsaeta II', ['Fire']='Atar II', ['Ice']='Vourukasha II',
	['Wind']='Vayuvata II', ['Earth']='Vishrava II', ['Lightning']='Apamajas II', ['Water']='Haoma II', ['Thunder']='Apamajas II'}

return mappings

