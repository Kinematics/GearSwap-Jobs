-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file to go with this.

-- Initialization function for this job file.
function get_sets()
	-- Load and initialize the include file.
	include('Mote-Include.lua')
end


-- Setup vars that are user-independent.
function job_setup()
        state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
        state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
        state.Buff.Convergence = buffactive.Convergence or false
        state.Buff.Diffusion = buffactive.Diffusion or false
        state.Buff.Efflux = buffactive.Efflux or false
        
        state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false


	blue_magic_maps = {}
	
	-- Mappings for gear sets to use for various blue magic spells.
	-- While Str isn't listed for each, it's generally assumed as being at least
	-- moderately signficant, even for spells with other mods.
	
	-- Physical Spells --
	
	-- Physical spells with no particular (or known) stat mods
	blue_magic_maps.Physical = S{
		'Bilgestorm'
	}

	-- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
	blue_magic_maps.PhysicalAcc = S{
		'Heavy Strike',
	}

	-- Physical spells with Str stat mod
	blue_magic_maps.PhysicalStr = S{
		'Battle Dance','Bloodrake','Death Scissors','Dimensional Death',
		'Empty Thrash','Quadrastrike','Spinal Cleave',
		'Uppercut','Vertical Cleave'
	}
		
	-- Physical spells with Dex stat mod
	blue_magic_maps.PhysicalDex = S{
		'Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone','Disseverment',
		'Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad',
		'Seedspray','Sickle Slash','Smite of Rage','Terror Touch','Vanity Dive'
	}
		
	-- Physical spells with Vit stat mod
	blue_magic_maps.PhysicalVit = S{
		'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
		'Power Attack','Quad. Continuum','Sprout Smack','Sub-zero Smash'
	}
		
	-- Physical spells with Agi stat mod
	blue_magic_maps.PhysicalAgi = S{
		'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream',
		'Pinecone Bomb','Spiral Spin','Wild Oats'
	}

	-- Physical spells with Int stat mod
	blue_magic_maps.PhysicalInt = S{
		'Mandibular Bite','Queasyshroom'
	}

	-- Physical spells with Mnd stat mod
	blue_magic_maps.PhysicalMnd = S{
		'Ram Charge','Screwdriver','Tourbillion'
	}

	-- Physical spells with Chr stat mod
	blue_magic_maps.PhysicalChr = S{
		'Bludgeon'
	}

	-- Physical spells with HP stat mod
	blue_magic_maps.PhysicalHP = S{
		'Final Sting'
	}

	-- Magical Spells --

	-- Magical spells with the typical Int mod
	blue_magic_maps.Magical = S{
		'Blastbomb','Blazing Bound','Bomb Toss','Cursed Sphere','Dark Orb','Death Ray',
		'Droning Whirlwind','Embalming Earth','Firespit','Foul Waters','Ice Break',
		'Leafstorm','Maelstrom','Regurgitation','Rending Deluge','Retinal Glare',
		'Tem. Upheaval','Water Bomb'
	}

	-- Magical spells with a primary Mnd mod
	blue_magic_maps.MagicalMnd = S{
		'Acrid Stream','Evryone. Grudge','Magic Hammer','Mind Blast'
	}

	-- Magical spells with a primary Chr mod
	blue_magic_maps.MagicalChr = S{
		'Eyes On Me','Mysterious Light'
	}

	-- Magical spells with a Vit stat mod (on top of Int)
	blue_magic_maps.MagicalVit = S{
		'Thermal Pulse'
	}

	-- Magical spells with a Dex stat mod (on top of Int)
	blue_magic_maps.MagicalDex = S{
		'Charged Whisker','Gates of Hades'
	}
			
	-- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
	-- Add Int for damage where available, though.
	blue_magic_maps.MagicAccuracy = S{
		'1000 Needles','Absolute Terror','Actinic Burst','Auroral Drape','Awful Eye',
		'Blank Gaze','Blistering Roar','Blood Drain','Blood Saber','Chaotic Eye',
		'Cimicine Discharge','Cold Wave','Corrosive Ooze','Demoralizing Roar','Digest',
		'Dream Flower','Enervation','Feather Tickle','Filamented Hold','Frightful Roar',
		'Geist Wall','Hecatomb Wave','Infrasonics','Jettatura','Light of Penance',
		'Lowing','Mind Blast','Mortal Ray','MP Drainkiss','Osmosis','Reaving Wind',
		'Sandspin','Sandspray','Sheep Song','Soporific','Sound Blast','Stinking Gas',
		'Sub-zero Smash','Venom Shell','Voracious Trunk','Yawn'
	}
		
	-- Breath-based spells
	blue_magic_maps.Breath = S{
		'Bad Breath','Flying Hip Press','Frost Breath','Heat Breath',
		'Hecatomb Wave','Magnetite Cloud','Poison Breath','Radiant Breath','Self-Destruct',
		'Thunder Breath','Vapor Spray','Wind Breath'
	}

	-- Stun spells
	blue_magic_maps.Stun = S{
		'Blitzstrahl','Frypan','Head Butt','Sudden Lunge','Tail slap','Temporal Shift',
		'Thunderbolt','Whirl of Rage'
	}
		
	-- Healing spells
	blue_magic_maps.Healing = S{
		'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','White Wind',
		'Wild Carrot'
	}
	
	-- Buffs that depend on blue magic skill
	blue_magic_maps.SkillBasedBuff = S{
		'Diamondhide','Metallic Body',
	}

        -- Buff spells where Blue Magic Skill matters (need verification)
        --['Metallic Body']='BuffSkill',['Diamondhide']='BuffSkill',['Reactor Cool']='BuffSkill',['Plasma Charge']='BuffSkill',
        --['Magic Barrier']='BuffSkill',['Barrier Tusk']='BuffSkill',['Orcish Counterstance']='BuffSkill',['Pyric Bulwark']='BuffSkill',
        --['Nature\'s Meditation']='BuffSkill',['Carcharian Verve']='BuffSkill',

	-- Other general buffs
	blue_magic_maps.Buff = S{
		'Amplification','Animating Wail','Barrier Tusk','Battery Charge',
		'Carcharian Verve','Cocoon','Exuviation','Fantod','Feather Barrier','Harden Shell',
		'Magic Barrier','Memento Mori','Nat. Meditation','Occultation','Orcish Counterstance',
		'Plasma Charge','Pyric Bulwark','Reactor Cool','Refueling','Regeneration',
		'Saline Coat','Triumphant Roar','Warm-Up','Winds of Promyvion','Zephyr Mantle'
	}
	
	
	-- Spells that require Unbridled Learning to cast.
        unbridled_spells = S{
		'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve',
		'Droning Whirlwind','Gates of Hades','Harden Shell','Pyric Bulwark','Thunderbolt',
		'Tourbillion'
	}
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	options.OffenseModes = {'Normal', 'Acc', 'Learning'}
	options.DefenseModes = {'Normal'}
	options.WeaponskillModes = {'Normal', 'Acc', 'Att', 'Mod'}
	options.CastingModes = {'Normal', 'Resistant'}
	options.IdleModes = {'Normal', 'Learning'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'PDT'}
	options.MagicalDefenseModes = {'MDT'}

	state.Defense.PhysicalMode = 'PDT'

	-- Additional local binds
	send_command('bind ^` input /ja "Chain Affinity" <me>')
	send_command('bind !` input /ja "Burst Affinity" <me>')

	select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()
	if binds_on_unload then
		binds_on_unload()
	end
end

function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	sets.buff['Burst Affinity'] = {feet="Mavi Basmak +2"}
	sets.buff['Chain Affinity'] = {head="Mavi Kavuk +2"} --, feet="Assimilator's Charuqs"}
	sets.buff.Convergence = {head="Mirage Keffiyeh +2"}
	sets.buff.Diffusion = {feet="Mirage Charuqs +2"}
	sets.buff.Enchainment = {body="Mirage Jubbah +2"}
	sets.buff.Efflux = {legs="Mavi Tayt +2"}

	
	-- Precast Sets
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Azure Lore'] = {hands="Mirage Bazubands +2"}


	-- Waltz set (chr and vit)
	sets.precast.Waltz = {ammo="Sonia's Plectrum",
		head="Uk'uxkaj Cap",
		body="Vanir Cotehardie",hands="Buremte Gloves",ring1="Spiral Ring",
		back="Iximulew Cape",waist="Caudata Belt",legs="Hagondes Pants",feet="Iuitl Gaiters +1"}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	
	sets.precast.FC = {ammo="Impatiens",
		head="Haruspex Hat",ear2="Loquacious Earring",
		body="Vanir Cotehardie",hands="Thaumas Gloves",ring1="Prolix Ring",
		back="Swith Cape",waist="Witful Belt",legs="Enif Cosciales",feet="Chelona Boots +1"}
		
	sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body="Mavi Mintan +2"})

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Whirlpool Mask",neck=gear.ElementalGorget,ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Qaaxo Harness",hands="Assimilator's Bazubands +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist=gear.ElementalBelt,legs="Manibozho Brais",feet="Iuitl Gaiters +1"}
	
	sets.precast.WS.acc = set_combine(sets.precast.WS, {hands="Buremte Gloves"})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Sanguine Blade'] = {
		head="Hagondes Hat",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Hagondes Coat",hands="Mavi Bazubands +2",ring1="Demon's Ring",ring2="Strendu Ring",
		back="Toro Cape",legs="Hagondes Pants",feet="Iuitl Gaiters +1"}
	
	
	-- Midcast Sets
	sets.midcast.FastRecast = {
		head="Haruspex Hat",ear2="Loquacious Earring",
		body="Vanir Cotehardie",hands="Mavi Bazubands +2",ring1="Prolix Ring",
		back="Swith Cape",waist="Goading Belt",legs="Enif Cosciales",feet="Iuitl Gaiters +1"}
		
	sets.midcast['Blue Magic'] = {}
	
	-- Physical Spells --
	
	sets.midcast['Blue Magic'].Physical = {ammo="Mavi Tathlum",
		head="Whirlpool Mask",neck="Ej Necklace",ear1="Heartseeker Earring",ear2="Steelflash Earring",
		body="Vanir Cotehardie",hands="Buremte Gloves",ring1="Rajas Ring",ring2="Spiral Ring",
		back="Letalis Mantle",waist="Caudata Belt",legs="Nahtirah Trousers",feet="Qaaxo Leggings"}

	sets.midcast['Blue Magic'].PhysicalAcc = {ammo="Jukukik Feather",
		head="Whirlpool Mask",neck="Ej Necklace",ear1="Heartseeker Earring",ear2="Steelflash Earring",
		body="Iuitl Vest",hands="Buremte Gloves",ring1="Rajas Ring",ring2="Patricius Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Manibozho Brais",feet="Qaaxo Leggings"}

	sets.midcast['Blue Magic'].PhysicalStr = {ammo="Mavi Tathlum",
		head="Whirlpool Mask",neck="Ej Necklace",ear1="Heartseeker Earring",ear2="Steelflash Earring",
		body="Iuitl Vest",hands="Assimilator's Bazubands +1",ring1="Rajas Ring",ring2="Spiral Ring",
		back="Letalis Mantle",waist="Caudata Belt",legs="Nahtirah Trousers",feet="Qaaxo Leggings"}

	sets.midcast['Blue Magic'].PhysicalDex = {ammo="Jukukik Feather",
		head="Whirlpool Mask",neck="Ej Necklace",ear1="Heartseeker Earring",ear2="Steelflash Earring",
		body="Iuitl Vest",hands="Assimilator's Bazubands +1",ring1="Rajas Ring",ring2="Spiral Ring",
		back="Letalis Mantle",waist="Chaac Belt",legs="Manibozho Brais",feet="Qaaxo Leggings"}

	sets.midcast['Blue Magic'].PhysicalVit = {ammo="Iron Gobbet",
		head="Whirlpool Mask",neck="Ej Necklace",ear1="Heartseeker Earring",ear2="Steelflash Earring",
		body="Vanir Cotehardie",hands="Assimilator's Bazubands +1",ring1="Rajas Ring",ring2="Spiral Ring",
		back="Iximulew Cape",waist="Caudata Belt",legs="Nahtirah Trousers",feet="Qaaxo Leggings"}

	sets.midcast['Blue Magic'].PhysicalAgi = {ammo="Mavi Tathlum",
		head="Whirlpool Mask",neck="Ej Necklace",ear1="Heartseeker Earring",ear2="Steelflash Earring",
		body="Vanir Cotehardie",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="Stormsoul Ring",
		back="Letalis Mantle",waist="Chaac Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters +1"}

	sets.midcast['Blue Magic'].PhysicalInt = {ammo="Mavi Tathlum",
		head="Whirlpool Mask",neck="Ej Necklace",ear1="Heartseeker Earring",ear2="Steelflash Earring",
		body="Vanir Cotehardie",hands="Assimilator's Bazubands +1",ring1="Rajas Ring",ring2="Icesoul Ring",
		back="Toro Cape",waist="Caudata Belt",legs="Nahtirah Trousers",feet="Hagondes Sabots"}

	sets.midcast['Blue Magic'].PhysicalMnd = {ammo="Mavi Tathlum",
		head="Whirlpool Mask",neck="Ej Necklace",ear1="Heartseeker Earring",ear2="Steelflash Earring",
		body="Vanir Cotehardie",hands="Assimilator's Bazubands +1",ring1="Rajas Ring",ring2="Aquasoul Ring",
		back="Pahtli Cape",waist="Caudata Belt",legs="Nahtirah Trousers",feet="Qaaxo Leggings"}

	sets.midcast['Blue Magic'].PhysicalChr = {ammo="Mavi Tathlum",
		head="Whirlpool Mask",neck="Ej Necklace",ear1="Heartseeker Earring",ear2="Steelflash Earring",
		body="Vanir Cotehardie",hands="Assimilator's Bazubands +1",ring1="Rajas Ring",ring2="Spiral Ring",
		back="Letalis Mantle",waist="Chaac Belt",legs="Nahtirah Trousers",feet="Qaaxo Leggings"}

	sets.midcast['Blue Magic'].PhysicalHP = {ammo="Mavi Tathlum",
		head="Whirlpool Mask",neck="Ej Necklace",ear1="Heartseeker Earring",ear2="Steelflash Earring",
		body="Vanir Cotehardie",hands="Assimilator's Bazubands +1",ring1="Rajas Ring",ring2="Spiral Ring",
		back="Letalis Mantle",waist="Chaac Belt",legs="Nahtirah Trousers",feet="Qaaxo Leggings"}

	-- Magical Spells --
	
	sets.midcast['Blue Magic'].Magical = {ammo="Mavi Tathlum",
		head="Hagondes Hat",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Hagondes Coat",hands="Mavi Bazubands +2",ring1="Icesoul Ring",ring2="Strendu Ring",
		back="Toro Cape",waist="Caudata Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

	sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical,
		{body="Vanir Cotehardie",ring1="Sangoma Ring",
		legs="Iuitl Tights",feet="Mavi Basmak +2"})
	
	sets.midcast['Blue Magic'].MagicalMnd = {ammo="Mavi Tathlum",
		head="Hagondes Hat",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Hagondes Coat",hands="Mavi Bazubands +2",ring1="Icesoul Ring",ring2="Strendu Ring",
		back="Toro Cape",waist="Caudata Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

	sets.midcast['Blue Magic'].MagicalChr = {ammo="Mavi Tathlum",
		head="Hagondes Hat",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Hagondes Coat",hands="Mavi Bazubands +2",ring1="Icesoul Ring",ring2="Strendu Ring",
		back="Toro Cape",waist="Caudata Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

	sets.midcast['Blue Magic'].MagicalVit = {ammo="Mavi Tathlum",
		head="Hagondes Hat",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Hagondes Coat",hands="Mavi Bazubands +2",ring1="Icesoul Ring",ring2="Strendu Ring",
		back="Toro Cape",waist="Caudata Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

	sets.midcast['Blue Magic'].MagicalDex = {ammo="Mavi Tathlum",
		head="Hagondes Hat",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Hagondes Coat",hands="Mavi Bazubands +2",ring1="Icesoul Ring",ring2="Strendu Ring",
		back="Toro Cape",waist="Caudata Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

	sets.midcast['Blue Magic'].MagicAccuracy = {ammo="Mavi Tathlum",
		head="Mirage Keffiyeh +2",neck="Ej Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Vanir Cotehardie",ring2="Sangoma Ring",
		back="Mirage Mantle",feet="Iuitl Gaiters +1"}

	-- Breath Spells --
	
	sets.midcast['Blue Magic'].Breath = {ammo="Mavi Tathlum",
		head="Mirage Keffiyeh +2",neck="Ej Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Vanir Cotehardie",hands="Assimilator's Bazubands +1",ring1="K'ayres Ring",ring2="Beeline Ring",
		back="Refraction Cape",legs="Enif Cosciales",feet="Iuitl Gaiters +1"}

	-- Other Types --
	
	sets.midcast['Blue Magic'].Stun = {ammo="Mavi Tathlum",
		back="Mirage Mantle"}
		
	sets.midcast['Blue Magic'].Healing = {
		head="Uk'uxkaj Cap",ear1="Lifestorm Earring",ear2="Loquacious Earring",
		body="Vanir Cotehardie",hands="Buremte Gloves",ring1="Aquasoul Ring",ring2="Sirona's Ring",
		back="Pahtli Cape",legs="Hagondes Pants",feet="Hagondes Sabots"}

	sets.midcast['Blue Magic'].SkillBasedBuff = {ammo="Mavi Tathlum",
		head="Mirage Keffiyeh +2",
		body="Magus Jubbah",
		legs="Mavi Tayt +2"}

	sets.midcast['Blue Magic'].Buff = {}

	
	
	-- Sets to return to when not performing an action.

	-- Gear for learning spells: +skill and AF hands.
	sets.Learning = {ammo="Mavi Tathlum",
		head="Mirage Keffiyeh +2",	
		body="Magus Jubbah",hands="Assimilator's Bazubands +1",
		legs="Mavi Tayt +2",feet="Mirage Charuqs +2"}


	
	-- Resting sets
	sets.resting = {
		head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",
		body="Hagondes Coat",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		waist="Austerity Belt",feet="Chelona Boots +1"}
	
	-- Idle sets
	sets.idle = {ammo="Impatiens",
		head="Whirlpool Mask",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Shadow Mantle",waist="Flume Belt",legs="Crimson Cuisses",feet="Serpentes Sabots"}

	sets.idle.Learning = set_combine(sets.idle, sets.Learning)

	sets.idle.PDT = {ammo="Impatiens",
		head="Whirlpool Mask",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Iuitl Wristbands",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Shadow Mantle",waist="Flume Belt",legs="Crimson Cuisses",feet="Iuitl Gaiters +1"}

	sets.idle.Town = {main="Buramenk'ah",ammo="Impatiens",
		head="Mavi Kavuk +2",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Mavi Mintan +2",hands="Iuitl Wristbands",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Atheling Mantle",waist="Flume Belt",legs="Crimson Cuisses",feet="Mavi Basmak +2"}
	
	-- Defense sets
	sets.defense.PDT = {ammo="Iron Gobbet",
		head="Whirlpool Mask",neck="Wiglen Gorget",ear1="Bloodgem Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Patricius Ring",ring2="Dark Ring",
		back="Shadow Mantle",waist="Flume Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters +1"}

	sets.defense.MDT = {ammo="Demonry Stone",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Bloodgem Earring",
		body="Hagondes Coat",hands="Iuitl Wristbands",ring1="Dark Ring",ring2="Dark Ring",
		back="Engulfer Cape",waist="Flume Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters +1"}

	sets.Kiting = {legs="Crimson Cuisses"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {ammo="Jukukik Feather",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Qaaxo Harness",hands="Buremte Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Iuitl Gaiters +1"}
		--back="Atheling Mantle",waist="Hurch'lan Sash",legs="Manibozho Brais",feet="Mirage Charuqs +2"}

	sets.engaged.DW = {ammo="Jukukik Feather",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Heartseeker Earring",ear2="Dudgeon Earring",
		body="Qaaxo Harness",hands="Buremte Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Iuitl Gaiters +1"}

	sets.engaged.Acc = {ammo="Jukukik Feather",
		head="Whirlpool Mask",neck="Ej Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Iuitl Vest",hands="Buremte Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Manibozho Brais",feet="Qaaxo Leggings"}

	sets.engaged.DW.Acc = {ammo="Jukukik Feather",
		head="Whirlpool Mask",neck="Ej Necklace",ear1="Heartseeker Earring",ear2="Dudgeon Earring",
		body="Iuitl Vest",hands="Buremte Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Manibozho Brais",feet="Qaaxo Leggings"}

	sets.engaged.Learning = set_combine(sets.engaged, sets.Learning, {waist="Hurch'lan Sash"})
	sets.engaged.DW.Learning = set_combine(sets.engaged.DW, sets.Learning, {waist="Hurch'lan Sash"})


end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	if unbridled_spells:contains(spell.english) and not state.Buff['Unbridled Learning'] then
		eventArgs.cancel = true
		windower.send_command('@input /ja "Unbridled Learning" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
	end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		-- Default base equipment layer for spells.
		equip(sets.midcast.FastRecast)
	end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	-- Add enhancement gear for Chain Affinity, etc.
	if spell.skill == 'Blue Magic' then
		for buff,active in pairs(state.Buff) do
			if active and sets.buff[buff] then
				equip(sets.buff[buff])
			end
		end
	end

	-- If in learning mode, keep on gear intended to help with that, regardless of action.
	if state.OffenseMode == 'Learning' then
		equip(sets.Learning)
	end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if not spell.interrupted then
		if state.Buff[spell.english] ~= nil then
			state.Buff[spell.english] = true
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
	if spell.skill == 'Blue Magic' then
		for category,spell_list in pairs(blue_magic_maps) do
			if spell_list:contains(spell.english) then
				return category
			end
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if state.Buff[buff] ~= nil then
		state.Buff[buff] = gain
	end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
	state.CombatForm = get_combat_form()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
	local dwString  = ''
	if state.CombatForm == 'DW' then
		dwString = ' (DW)'
	end
	
	local defenseString = ''
	if state.Defense.Active then
		local defMode = state.Defense.PhysicalMode
		if state.Defense.Type == 'Magical' then
			defMode = state.Defense.MagicalMode
		end

		defenseString = 'Defense: '..state.Defense.Type..' '..defMode..', '
	end
	
	local pcTarget = ''
	if state.PCTargetMode ~= 'default' then
		pcTarget = ', Target PC: '..state.PCTargetMode
	end

	local npcTarget = ''
	if state.SelectNPCTargets then
		pcTarget = ', Target NPCs'
	end
	

	add_to_chat(122,'Melee'..dwString..': '..state.OffenseMode..'/'..state.DefenseMode..', WS: '..state.WeaponskillMode..', '..defenseString..
		'Kiting: '..on_off_names[state.Kiting]..pcTarget..npcTarget)

	eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function get_combat_form()
	if not (player.equipment.sub == "Genbu's Shield" or player.equipment.sub == 'empty') then
		return 'DW'
	end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(1, 7)
	else
		set_macro_page(1, 7)
	end
end



