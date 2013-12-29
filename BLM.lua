-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- NOTE: This is a work in progress, experimenting.  Expect it to change frequently, and maybe include debug stuff.

-- Last Modified: 12/27/2013 10:22:49 PM

-- IMPORTANT: Make sure to also get the Mote-Include.lua file to go with this.

function get_sets()
	-- Load and initialize the include file.
	include('Mote-Include.lua')
	init_include()
	
	-- Options: Override default values
	options.CastingModes = {'Normal', 'Resistant'}
	options.OffenseModes = {'Normal'}
	options.DefenseModes = {'Normal'}
	options.WeaponskillModes = {'Normal'}
	options.IdleModes = {'Normal', 'PDT'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'PDT'}
	options.MagicalDefenseModes = {'MDT'}

	state.Defense.PhysicalMode = 'PDT'
	
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	sets.precast = {}
	
	-- Precast sets to enhance JAs
	sets.precast.JA = {}
	
	sets.precast.JA.Manafont = {body="Sorcerer's Coat +2"}
	
	-- equip to maximize HP (for Tarus) and minimize MP loss before using convert
	sets.precast.JA.Convert = {}


	-- Fast cast sets for spells

	sets.precast.FC = {
		head="Nahtirah Hat",ear2="Loquacious Earring",
		ring1="Prolix Ring",
		back="Swith Cape",legs="Orvail Pants",feet="Chelona Boots"}

	sets.precast.FC.EnhancingMagic = {
		head="Nahtirah Hat",ear2="Loquacious Earring",
		ring1="Prolix Ring",
		back="Swith Cape",waist="Siegel Sash",legs="Orvail Pants",feet="Chelona Boots"}

	sets.precast.FC.ElementalMagic = {
		head="Nahtirah Hat",neck="Stoicheion Medal",ear2="Loquacious Earring",
		ring1="Prolix Ring",
		back="Swith Cape",waist="Siegel Sash",legs="Orvail Pants",feet="Chelona Boots"}

	sets.precast.FC.Cure = {main="Tamaxchi",sub="Genbu's Shield",
		head="Nahtirah Hat",neck="Colossus's Torque",ear2="Loquacious Earring",
		body="Heka's Kalasiris",hands="Bokwus Gloves",ring1="Prolix Ring",ring2="Sirona's Ring",
		back="Pahtli Cape",waist="Witful Belt",legs="Orvail Pants",feet="Chelona Boots"}

	sets.precast.FC.Curaga = sets.precast.FC.Cure

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Hagondes Hat",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="Icesoul Ring",
		back="Refraction Cape",waist="Cognition Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Vidohunir'] = {ammo="Witchstone",
		head="Hagondes Hat",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Icesoul Ring",ring2="Strendu Ring",
		back="Toro Cape",waist="Thunder Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}
	
	
	-- Midcast Sets
	sets.midcast = {}
	
	sets.midcast.FastRecast = {
		head="Nahtirah Hat",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Bokwus Gloves",ring1="Prolix Ring",
		back="Swith Cape",waist="Goading Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

	sets.midcast.Cure = {main="Tamaxchi",sub="Genbu's Shield",
		head="Nahtirah Hat",neck="Colossus's Torque",ear2="Loquacious Earring",
		body="Heka's Kalasiris",hands="Bokwus Gloves",ring1="Ephedra Ring",ring2="Sirona's Ring",
		back="Pahtli Cape",waist="Witful Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

	sets.midcast.Curaga = sets.midcast.Cure

	sets.midcast.EnhancingMagic = {
		neck="Colossus's Torque",
		body="Manasa Chasuble",hands="Ayao's Gages",
		legs="Portent Pants"}
	
	sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingMagic, {waist="Siegel Sash"})

	sets.midcast.EnfeeblingMagic = {main="Atinian Staff",sub="Mephitis Grip",ammo="Sturm's Report",
		head="Nahtirah Hat",neck="Weike Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
		body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Strendu Ring",ring2="Mediator's Ring",
		back="Refraction Cape",legs="Bokwus Slops",feet="Bokwus Boots"}
		
	sets.midcast.ElementalEnfeeble = sets.midcast.EnfeeblingMagic

	sets.midcast.DarkMagic = {main="Atinian Staff",sub="Mephitis Grip",ammo="Sturm's Report",
		head="Nahtirah Hat",neck="Aesir Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
		body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Strendu Ring",ring2="Mediator's Ring",
		back="Refraction Cape",waist="Goading Belt",legs="Bokwus Slops",feet="Bokwus Boots"}

	sets.midcast.BardSong = {main="Atinian Staff",sub="Mephitis Grip",ammo="Sturm's Report",
		head="Nahtirah Hat",neck="Weike Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
		body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Strendu Ring",ring2="Mediator's Ring",
		back="Refraction Cape",legs="Bokwus Slops",feet="Bokwus Boots"}

	sets.midcast.Drain = {main="Atinian Staff",sub="Mephitis Grip",ammo="Sturm's Report",
		head="Nahtirah Hat",neck="Aesir Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
		body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Excelsis Ring",ring2="Mediator's Ring",
		back="Refraction Cape",waist="Goading Belt",legs="Bokwus Slops",feet="Goetia Sabots +2"}
	
	sets.midcast.Aspir = sets.midcast.Drain

	sets.midcast.Stun = {main="Atinian Staff",sub="Mephitis Grip",ammo="Sturm's Report",
		head="Nahtirah Hat",neck="Weike Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
		body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Strendu Ring",ring2="Mediator's Ring",
		back="Refraction Cape",waist="Witful Belt",legs="Orvail Pants",feet="Bokwus Boots"}


	-- Elemental Magic sets are default for handling low-tier nukes.
	sets.midcast.ElementalMagic = {main="Atinian Staff",sub="Wizzan Grip",ammo="Witchstone",
		head="Hagondes Hat",neck="Stoicheion Medal",ear1="Hecate's Earring",ear2="Friomisi Earring",
		body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Icesoul Ring",ring2="Strendu Ring",
		back="Toro Cape",waist="Cognition Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

	sets.midcast.ElementalMagic.Resistant = {main="Atinian Staff",sub="Wizzan Grip",ammo="Witchstone",
		head="Hagondes Hat",neck="Stoicheion Medal",ear1="Psystorm Earring",ear2="Lifestorm Earring",
		body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Icesoul Ring",ring2="Strendu Ring",
		back="Toro Cape",waist="Cognition Belt",legs="Hagondes Pants",feet="Bokwus Boots"}

	-- Custom classes for high-tier nukes.
	sets.midcast.HighTierNuke = {main="Lehbrailg",sub="Wizzan Grip",ammo="Witchstone",
		head="Hagondes Hat",neck="Stoicheion Medal",ear1="Hecate's Earring",ear2="Friomisi Earring",
		body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Icesoul Ring",ring2="Strendu Ring",
		back="Toro Cape",waist="Cognition Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

	sets.midcast.HighTierNuke.Resistant = {main="Atinian Staff",sub="Wizzan Grip",ammo="Witchstone",
		head="Hagondes Hat",neck="Stoicheion Medal",ear1="Psystorm Earring",ear2="Lifestorm Earring",
		body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Icesoul Ring",ring2="Strendu Ring",
		back="Toro Cape",waist="Cognition Belt",legs="Hagondes Pants",feet="Bokwus Boots"}

	-- Custom classes for high-tier nukes in Adoulin areas (need more general magic accuracy).
	sets.midcast.AdoulinHighTierNuke = {main="Atinian Staff",sub="Wizzan Grip",ammo="Witchstone",
		head="Hagondes Hat",neck="Stoicheion Medal",ear1="Hecate's Earring",ear2="Friomisi Earring",
		body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Icesoul Ring",ring2="Strendu Ring",
		back="Toro Cape",waist="Cognition Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

	sets.midcast.AdoulinHighTierNuke.Resistant = {main="Atinian Staff",sub="Mephitis Grip",ammo="Witchstone",
		head="Hagondes Hat",neck="Stoicheion Medal",ear1="Psystorm Earring",ear2="Lifestorm Earring",
		body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Icesoul Ring",ring2="Strendu Ring",
		back="Toro Cape",waist="Cognition Belt",legs="Hagondes Pants",feet="Bokwus Boots"}

	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {main=staffs.HMP,ammo="Clarus Stone",
		head="Nefer Khat +1",neck="Grandiose Chain",
		body="Heka's Kalasiris",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		waist="Austerity Belt",legs="Nares Trews",feet="Serpentes Sabots"}
	

	-- Idle sets
	sets.idle = {}

	sets.idle.Town = {main="Tamaxchi", sub="Genbu's Shield",ammo="Witchstone",
		head="Hagondes Hat",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Umbra Cape",waist="Hierarch Belt",legs="Nares Trews",feet="Herald's Gaiters"}
	
	sets.idle.Field = {main="Tamaxchi", sub="Genbu's Shield",ammo="Witchstone",
		head="Nefer Khat +1",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Heka's Kalasiris",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Umbra Cape",waist="Hierarch Belt",legs="Nares Trews",feet="Herald's Gaiters"}

	sets.idle.Field.PDT = {main="Tamaxchi", sub="Genbu's Shield",ammo="Witchstone",
		head="Hagondes Hat",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Dark Ring",ring2="Dark Ring",
		back="Umbra Cape",waist="Hierarch Belt",legs="Hagondes Pants",feet="Herald's Gaiters"}
		
	sets.idle.Weak = {main="Tamaxchi",sub="Genbu's Shield",ammo="Witchstone",
		head="Hagondes Hat",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Dark Ring",ring2="Meridian Ring",
		back="Umbra Cape",waist="Hierarch Belt",legs="Nares Trews",feet="Hagondes Sabots"}
	
	-- Defense sets
	sets.defense = {}

	sets.defense.PDT = {main=staffs.PDT,sub="Wizzan Grip",
		head="Nahtirah Hat",neck="Twilight Torque",
		body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Dark Ring",ring2="Dark Ring",
		back="Umbra Cape",waist="Hierarch Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

	sets.defense.MDT = {ammo="Demonry Stone",
		head="Nahtirah Hat",neck="Twilight Torque",
		body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Dark Ring",ring2="Shadow Ring",
		back="Tuilha Cape",waist="Hierarch Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

	sets.Kiting = {feet="Herald's Gaiters"}


	-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	sets.Buff = {}
	
	sets.Buff.Use = {}

	sets.Buff['Mana Wall'] = {feet="Goetia Sabots +2"}
	

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {
		head="Zelus Tiara",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Hagondes Coat",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Atheling Mantle",waist="Goading Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}



	lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
		'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
		'Stone III', 'Water III', 'Aero III', 'Fire III', 'Blizzard III', 'Thunder III',
		'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',
		'Stonega II', 'Waterga II', 'Aeroga II', 'Firaga II', 'Blizzaga II', 'Thundaga II'}


	windower.send_command('input /macro book 15;wait .1;input /macro set 1')
	gearswap_binds_on_load()

	windower.send_command('bind ^- gs c toggle target')
	windower.send_command('bind ^= gs c cycle targetmode')
end

-- Called when this job file is unloaded (eg: job change)
function file_unload()
	spellcast_binds_on_unload()
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	-- Don't allow gear changes for teleports.
	if spell.english == 'Warp' or spellMap == 'Teleport' or (spell.english == 'Warp II' and spell.target.type == 'SELF') then
		eventArgs.handled = true
	elseif spell.skill == 'ElementalMagic' then
		classes.CustomClass = get_nuke_class(spell, action, spellMap)
	end
	
	-- Lock weapon if we have TP (may customize this out more later)
	if player.tp >= 100 then
		disable('main','sub')
	else
		enable('main','sub')
	end
end



-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if action.type == 'Magic' then
		-- Default base equipment layer of fast recast.
		equip(sets.midcast.FastRecast)

		-- If the spells don't get enhanced by skill or whatever, don't bother equipping gear.
		if classes.NoSkillSpells[spell.english] or classes.NoSkillSpells[spellMap] then
			eventArgs.handled = true
		end
	end
end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
	return idleSet
end

function customize_melee_set(meleeSet)
	return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_status_change(newStatus,oldStatus)
	-- Lock weapon if we have TP (may customize this out more later)
	if player.tp >= 100 then
		disable('main','sub')
	else
		-- Disable weapon swaps when engaged
		if newStatus == 'Engaged' then
			disable('main','sub')
		elseif oldStatus == 'Engaged' then
			enable('main','sub')
		end
	end
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain_or_loss == 'gain' or 'loss', depending on the buff state change
function job_buff_change(buff,gain_or_loss)
	if buff == "Mana Wall" then
		if gain_or_loss == 'gain' then
			equip(sets.Buff['Mana Wall'])
			disable('feet')
		else
			enable('feet')
		end
	end
		
	handle_equipping_gear(player.status)
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for direct player commands.
function job_self_command(cmdParams)
	if player.tp >= 100 then
		disable('main','sub')
	else
		enable('main','sub')
	end
end

-- Called by the 'update' self-command.
function job_update(cmdParams)

end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state()
	local defenseString = ''
	if state.Defense.Active then
		local defMode = state.Defense.PhysicalMode
		if state.Defense.Type == 'Magical' then
			defMode = state.Defense.MagicalMode
		end

		defenseString = 'Defense: '..state.Defense.Type..' '..defMode..', '
	end

	add_to_chat(122,'Casting ['..state.CastingMode..'], Idle ['..state.IdleMode..'], '..defenseString..
		'Kiting: '..on_off_names[state.Kiting])

	return true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Function to get the custom class to use for nukes.
function get_nuke_class(spell, action, spellMap)
	if lowTierNukes[spell.english] then
		-- low tier nukes use the default set
		return nil
	-- Areas where more magic accuracy is generally needed, so use Atinian instead of Lehbrailg on high-tier nukes.
	elseif areas.Adoulin[world.area:lower()] then
		return 'AdoulinHighTierNuke'
	else
		return 'HighTierNuke'
	end
end

