-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- NOTE: This is a work in progress, experimenting.  Expect it to change frequently, and maybe include debug stuff.

-- Last Modified: 12/24/2013 7:29:26 PM

-- IMPORTANT: Make sure to also get the Mote-Include.lua file to go with this.

function get_sets()
	-- Load and initialize the include file.
	include('Mote-Include.lua')
	init_include()
	
	-- Options: Override default values
	options.OffenseModes = {'Normal', 'Acc'}
	options.DefenseModes = {'Normal', 'Evasion', 'PDT'}
	options.WeaponskillModes = {'Normal', 'Acc', 'Att', 'Mod'}
	options.IdleModes = {'Normal'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'Evasion', 'PDT'}
	options.MagicalDefenseModes = {'MDT'}

	state.Defense.PhysicalMode = 'Evasion'
	
	
	--leftDarkRing = {name="Dark Ring",augments={"Physical Damage Taken -6%", "Magical Damage Taken -3%", "Spell Interruption Rate Down 5%"}}
	--rightDarkRing = {name="Dark Ring",augments={"Physical Damage Taken -5%", "Magical Damage Taken -3%"}}

	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	sets.precast = {}
	
	-- Precast sets to enhance JAs
	sets.precast.JA = {}
	
	sets.precast.JA.Benediction = {feet="Cleric's Briault +2"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Nahtirah Hat",ear1="Roundel Earring",
		body="Gendewitha Bliaut",hands="Yaoyotl Gloves",
		back="Refraction Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
	
	-- Fast cast sets for spells
	
	-- default fast cast
	sets.precast.FC = {head="Nahtirah Hat",neck="Orison Locket",ear2="Loquacious Earring",
		hands="Gendewitha Gages",ring1="Prolix Ring",
		back="Swith Cape",legs="Orvail Pants",feet="Chelona Boots +1"}
		
	sets.precast.FC.CureSolace = {main="Tamaxchi",sub="Genbu's Shield",ammo="Incantor's Stone",
		head="Theophany Cap",neck="Aceso's Choker",ear1="Orison Earring",ear2="Loquacious Earring",
		body="Orison Bliaud +2",hands="Bokwus Gloves",ring1="Prolix Ring",ring2="Mediator's Ring",
		back="Pahtli Cape",waist="Witful Belt",legs="Orison Pantaloons +2",feet="Cure Clogs"}

	sets.precast.FC.Cure = {main="Tamaxchi",sub="Genbu's Shield",ammo="Impatiens",
		head="Nahtirah Hat",neck="Orison Locket",ear1="Orison Earring",ear2="Loquacious Earring",
		body="Heka's Kalasiris",hands="Bokwus Gloves",ring1="Prolix Ring",ring2="Mediator's Ring",
		back="Pahtli Cape",waist="Witful Belt",legs="Orison Pantaloons +2",feet="Gendewitha Galoshes"}

	sets.precast.FC.Curaga = {main="Tamaxchi",sub="Genbu's Shield",ammo="Impatiens",
		head="Nahtirah Hat",neck="Orison Locket",ear1="Orison Earring",ear2="Loquacious Earring",
		body="Heka's Kalasiris",hands="Bokwus Gloves",ring1="Prolix Ring",ring2="Mediator's Ring",
		back="Pahtli Cape",waist="Witful Belt",legs="Orison Pantaloons +2",feet="Gendewitha Galoshes"}

	sets.precast.FC.CureMelee = {ammo="Incantor Stone",
		head="Gendewitha Caubeen",neck="Aceso's Choker",ear1="Orison Earring",ear2="Loquacious Earring",
		body="Heka's Kalasiris",hands="Bokwus Gloves",ring1="Prolix Ring",ring2="Mediator's Ring",
		back="Pahtli Cape",waist="Witful Belt",legs="Orison Pantaloons +2",feet="Gendewitha Galoshes"}

	sets.precast.FC.EnhancingMagic = {head="Nahtirah Hat",neck="Orison Locket",ear2="Loquac. Earring",
		hands="Gendewitha Gages",ring1="Prolix Ring",
		back="Swith Cape",waist="Siegel Sash",legs="Orvail Pants",feet="Chelona Boots +1"}

	sets.precast.FC.HealingMagic = {main="Beneficus",sub="Genbu's Shield",
		neck="Colossus's Torque",
		body="Orison Bliaud +2",hands="Healer's Mitts",ring1="Sirona's Ring",ring2="Ephedra Ring",
		back="Tempered Cape",legs="Cleric's Pantaloons +2"}
		

       
	-- Magian staves with cast time reduction, by element
	--sets.precast.FC.Thunder = {main='Apamajas I'}
	--sets.precast.FC.Fire = {main='Atar I'}
	
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Nahtirah Hat",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Gendewitha Bliaut",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Tuilha Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Hexa Strike'] = {
		head="Nahtirah Hat",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Gendewitha Bliaut",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Tuilha Cape",waist="Light Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}

	sets.precast.WS['Mystic Boon'] = {
		head="Nahtirah Hat",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Gendewitha Bliaut",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Tuilha Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}

	sets.precast.WS['Flash Nova'] = {
		head="Nahtirah Hat",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Bokwus Robe",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="Strendu Ring",
		back="Toro Cape",waist="Thunder Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
	
	
	-- Midcast Sets
	sets.midcast = {}
	
	sets.midcast.FastRecast = {
		head="Nahtirah Hat",ear2="Loquacious Earring",
		body="Goliard Saio",hands="Gendewitha Gages",ring1="Prolix Ring",
		back="Swith Cape",waist="Goading Belt",legs="Theophany Pantaloons",feet="Gendewitha Galoshes"}
		
	-- Specific spells
	sets.midcast.Cursna = {
		head="Orison Cap +2",neck="Malison Medallion",
		hands="Hieros Mittens",ring1="Ephedra Ring",
		legs="Theophany Pantaloons",feet="Gendewitha Galoshes"}

	sets.midcast.Stoneskin = {
		head="Nahtirah Hat",neck="Orison Locket",ear2="Loquacious Earring",
		body="Gendewitha Bliaut",hands="Gendewitha Gages",
		back="Swith Cape",waist="Siegel Sash",feet="Gendewitha Galoshes"}

	sets.midcast.Auspice = {feet="Orison Duckbills +2"}

	-- Spell classes
	sets.midcast.Barspell = {main="Beneficus",sub="Genbu's Shield",
		head="Orison Cap +2",neck="Colossus's Torque",
		body="Orison Bliaud +2",hands="Orison Mitts +2",
		waist="Cascade Belt",legs="Cleric's Pantaloons +2",feet="Orison Duckbills +2"}

	sets.midcast.Regen = {
		body="Cleric's Briault",hands="Orison Mitts +2",
		legs="Theophany Pantaloons"}

	sets.midcast.StatusRemoval = {
		head="Orison Cap +2",legs="Orison Pantaloons +2"}

	sets.midcast['Divine Caress'] = {hands="Orison Mitts +2"}

	sets.midcast.Protectra = {ring1="Sheltered Ring"}

	sets.midcast.Shellra = {ring1="Sheltered Ring",legs="Cleric's Pantaloons +2"}

	-- Spell skill categories
	sets.midcast.EnhancingMagic = {main="Beneficus",sub="Genbu's Shield",
		neck="Colossus's Torque",
		body="Manasa Chasuble",hands="Ayao's Gages",
		waist="Cascade Belt",legs="Cleric's Pantaloons +2",feet="Orison Duckbills +2"}

	sets.midcast.DivineMagic = {main="Tamaxchi",sub="Genbu's Shield",
		head="Nahtirah Hat",neck="Colossus's Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
		body="Manasa Chasuble",hands="Yaoyotl Gloves",ring2="Mediator's Ring",
		back="Refraction Cape",waist="Demonry Sash",legs="Theophany Pantaloons +2",feet="Orison Duckbills +2"}

	sets.midcast.DarkMagic = {main="Tamaxchi", sub="Genbu's Shield",
		head="Nahtirah Hat",neck="Aesir Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
		body="Manasa Chasuble",hands="Yaoyotl Gloves",ring1="Strendu Ring",ring2="Mediator's Ring",
		back="Refraction Cape",waist="Demonry Sash",legs="Portent Pants",feet="Bokwus Boots"}


	-- Custom spell classes
	sets.midcast.MndEnfeebles = {main="Tamaxchi", sub="Genbu's Shield",
		head="Nahtirah Hat",neck="Weike Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
		body="Manasa Chasuble",hands="Yaoyotl Gloves",ring1="Aquasoul Ring",ring2="Mediator's Ring",
		back="Refraction Cape",waist="Demonry Sash",legs="Gendewitha Spats",feet="Bokwus Boots"}

	sets.midcast.IntEnfeebles = {main="Tamaxchi", sub="Genbu's Shield",
		head="Nahtirah Hat",neck="Weike Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
		body="Manasa Chasuble",hands="Yaoyotl Gloves",ring1="Icesoul Ring",ring2="Mediator's Ring",
		back="Refraction Cape",waist="Demonry Sash",legs="Orvail Pants",feet="Bokwus Boots"}

	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",
		ring1="Sheltered Ring",ring2="Paguroidea Ring"}
	

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {}

	sets.idle.Town = {main="Izhiikoh", sub="Atoyac",ammo="Charis Feather",
		head="Whirlpool Mask",neck="Charis Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Charis Casaque +2",hands="Iuitl Wristbands",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Atheling Mantle",waist="Patentia Sash",legs="Kaabnax Trousers",feet="Skadi's Jambeaux +1"}
	
	sets.idle.Field = {ammo="Charis Feather",
		head="Whirlpool Mask",neck="Wiglen Gorget",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Iximulew Cape",waist="Flume Belt",legs="Kaabnax Trousers",feet="Skadi's Jambeaux +1"}

	sets.idle.Weak = {ammo="Charis Feather",
		head="Whirlpool Mask",neck="Wiglen Gorget",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Manibozho Jerkin",hands="Buremte Gloves",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Iximulew Cape",waist="Flume Belt",legs="Kaabnax Trousers",feet="Skadi's Jambeaux +1"}
	
	-- Defense sets
	sets.defense = {}

	sets.defense.Evasion = {
		head="Whirlpool Mask",neck="Torero Torque",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Dark Ring",
		back="Ik Cape",waist="Flume Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters"}

	sets.defense.PDT = {ammo="Iron Gobbet",
		head="Whirlpool Mask",neck="Twilight Torque",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Dark Ring",
		back="Iximulew Cape",waist="Flume Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters"}

	sets.defense.MDT = {ammo="Demonry Stone",
		head="Whirlpool Mask",neck="Twilight Torque",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Dark Ring",ring2="Shadow Ring",
		back="Engulfer Cape",waist="Flume Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters"}

	sets.Kiting = {feet="Skadi's Jambeaux +1"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Basic set for if no TP weapon is defined.
	sets.engaged = {
		head="Zelus Tiara",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Gendewitha Bliaut",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Umbra Cape",waist="Goading Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}

	-- Sets with weapons defined.
	sets.engaged.Acc = {
		head="Nahtirah Hat",neck="Peacock Charm",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Gendewitha Bliaut",hands="Buremte Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Umbra Cape",waist="Goading Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}


	windower.send_command('input /macro book 20;wait .1;input /macro set 10')
	gearswap_binds_on_load()

	windower.send_command('bind ^- gs c toggle target')
	windower.send_command('bind ^= gs c cycle targetmode')

	windower.send_command('bind ^` input /ja "Chocobo Jig" <me>')
	windower.send_command('bind !` input /ja "Chocobo Jig II" <me>')
end

-- Called when this job file is unloaded (eg: job change)
function file_unload()
	--spellcast_binds_on_unload()
	
	windower.send_command('unbind ^`')
	windower.send_command('unbind !`')
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Return true if we handled the precast work.  Otherwise it will fall back
-- to the general precast() code in Mote-Include.
function job_precast(spell, action, spellMap)

end


-- Return true if we handled the midcast work.  Otherwise it will fall back
-- to the general midcast() code in Mote-Include.
function job_midcast(spell, action, spellMap)

end

-- Return true if we handled the aftercast work.  Otherwise it will fall back
-- to the general aftercast() code in Mote-Include.
function job_aftercast(spell, action)
	return false
end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)

end


-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function status_change(newStatus,oldStatus)

end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain_or_loss == 'gain' or 'loss', depending on the buff state change
function buff_change(buff,gain_or_loss)

end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for direct player commands.
function job_self_command(cmdParams)

end


-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state()

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

