-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- NOTE: This is a work in progress, experimenting.  Expect it to change frequently, and maybe include debug stuff.

-- Last Modified: 12/25/2013 6:17:03 AM

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
	
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	sets.precast = {}
	
	-- Precast sets to enhance JAs
	sets.precast.JA = {}

	sets.precast.JA['No Foot Rise'] = {body="Etoile Casaque +2"}
	

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {ammo="Sonia's Plectrum",
		head="Etoile Tiara +2",ear1="Roundel Earring",
		body="Maxixi Casaque",hands="Buremte Gloves",
		back="Iximulew Cape",legs="Nahtirah Trousers",feet="Maxixi Toeshoes"}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}
	
	sets.precast.Samba = {head="Charis Tiara +2"}

	sets.precast.Jig = {legs="Etoile Tights +2", feet="Maxixi Toeshoes"}

	sets.precast.Step = {}
	sets.precast.Step['Feather Step'] = {feet="Charis Shoes +2"}

	sets.precast.Flourish1 = {}
	sets.precast.Flourish1['Violent Flourish'] = {body="Etoile Casaque +2"}
	sets.precast.Flourish1['Desperate Flourish'] = {} -- acc gear

	sets.precast.Flourish2 = {}
	sets.precast.Flourish2['Reverse Flourish'] = {hands="Charis Bangles +2"}

	sets.precast.Flourish3 = {}
	sets.precast.Flourish3['Striking Flourish'] = {body="Charis Casaque +2"}
	sets.precast.Flourish3['Climactic Flourish'] = {head="Charis Tiara +2"}

	-- Fast cast sets for spells
	
	sets.precast.FC = {ear2="Loquacious Earring",
		hands="Thaumas Gloves"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Thew Bomblet",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Manibozho Jerkin",hands="Buremte Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Caudata Belt",legs="Manibozho Brais",feet="Manibozho Boots"}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {ammo="Honed Tathlum", back="Letalis Mantle"})

	add_to_chat(123,'1')
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Exenterator'] = {ammo="Thew Bomblet",
		head="Whirlpool Mask",neck="Houyi's Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Manibozho Jerkin",hands="Iuitl Wristbands",ring1="Stormsoul Ring",ring2="Epona's Ring",
		back="Atheling Mangle",waist="Caudata Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters"}
	sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {ammo="Honed Tathlum", back="Letalis Mantle"})
	sets.precast.WS['Exenterator'].Mod = set_combine(sets.precast.WS['Exenterator'], {waist="Thunder Belt"})
	add_to_chat(123,'2')

	sets.precast.WS['Pyrrhic Kleos'] = {ammo="Thew Bomblet",
		head="Whirlpool Mask",neck="Soil Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Manibozho Jerkin",hands="Buremte Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mangle",waist="Caudata Belt",legs="Manibozho Brais",feet="Iuitl Gaiters"}
	sets.precast.WS['Pyrrhic Kleos'].Acc = set_combine(sets.precast.WS['Pyrrhic Kleos'], {ammo="Honed Tathlum", back="Letalis Mantle"})
	sets.precast.WS['Pyrrhic Kleos'].Mod = set_combine(sets.precast.WS['Pyrrhic Kleos'], {waist="Soil Belt"})

	sets.precast.WS['Dancing Edge'] = {ammo="Thew Bomblet",
		head="Whirlpool Mask",neck="Soil Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Manibozho Jerkin",hands="Buremte Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mangle",waist="Caudata Belt",legs="Manibozho Brais",feet="Iuitl Gaiters"}
	sets.precast.WS['Dancing Edge'].Acc = set_combine(sets.precast.WS['Dancing Edge'], {ammo="Honed Tathlum", back="Letalis Mantle"})
	sets.precast.WS['Dancing Edge'].Mod = set_combine(sets.precast.WS['Dancing Edge'], {waist="Soil Belt"})

	sets.precast.WS['Evisceration'] = {ammo="Charis Feather",
		head="Whirlpool Mask",neck="Rancor Collar",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Manibozho Jerkin",hands="Buremte Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mangle",waist="Caudata Belt",legs="Manibozho Brais",feet="Iuitl Gaiters"}
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {ammo="Honed Tathlum", back="Letalis Mantle"})
	sets.precast.WS['Evisceration'].Mod = set_combine(sets.precast.WS['Evisceration'], {waist="Soil Belt"})

	sets.precast.WS['Aeolian Edge'] = {ammo="Charis Feather",
		head="Thaumas Hat",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Manibozho Jerkin",hands="Buremte Gloves",ring1="Rajas Ring",ring2="Demon's Ring",
		back="Toro Cape",waist="Thunder Belt",legs="Iuitl Tights",feet="Iuitl Gaiters"}
	
	sets.precast.Skillchain = {hands="Charis Bangles +2"}
	
	
	-- Midcast Sets
	sets.midcast = {}
	
	sets.midcast.FastRecast = {
		head="Whirlpool Mask",ear2="Loquacious Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",
		back="Ix Cape",waist="Twilight Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters"}
		
	-- Specific spells
	sets.midcast.Utsusemi = {
		head="Whirlpool Mask",neck="Torero Torque",ear2="Loquacious Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",
		back="Ix Cape",waist="Twilight Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters"}

	
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
	
	-- Normal melee group
	sets.engaged = {ammo="Charis Feather",
		head="Whirlpool Mask",neck="Charis Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Charis Casaque +2",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Patentia Sash",legs="Kaabnax Trousers",feet="Manibozho Boots"}
	sets.engaged.Acc = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Charis Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Charis Casaque +2",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Kaabnax Trousers",feet="Manibozho Boots"}
	sets.engaged.Evasion = {ammo="Charis Feather",
		head="Whirlpool Mask",neck="Torero Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Ik Cape",waist="Patentia Sash",legs="Kaabnax Trousers",feet="Iuitl Gaiters"}
	sets.engaged.Acc.Evasion = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Torero Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Kaabnax Trousers",feet="Iuitl Gaiters"}
	sets.engaged.PDT = {ammo="Charis Feather",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Dark Ring",ring2="Epona's Ring",
		back="Iximulew Cape",waist="Patentia Sash",legs="Kaabnax Trousers",feet="Iuitl Gaiters"}
	sets.engaged.Acc.PDT = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Dark Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Kaabnax Trousers",feet="Iuitl Gaiters"}

	-- Custom melee group: High Haste
	sets.engaged.HighHaste = {ammo="Charis Feather",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Thaumas Coat",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Patentia Sash",legs="Kaabnax Trousers",feet="Manibozho Boots"}
	sets.engaged.HighHaste.Acc = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Kaabnax Trousers",feet="Manibozho Boots"}
	sets.engaged.HighHaste.Evasion = {ammo="Charis Feather",
		head="Whirlpool Mask",neck="Torero Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Ik Cape",waist="Patentia Sash",legs="Kaabnax Trousers",feet="Iuitl Gaiters"}
	sets.engaged.HighHaste.Acc.Evasion = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Torero Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Kaabnax Trousers",feet="Iuitl Gaiters"}
	sets.engaged.HighHaste.PDT = {ammo="Charis Feather",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Dark Ring",ring2="Epona's Ring",
		back="Iximulew Cape",waist="Patentia Sash",legs="Iuitl Tights",feet="Iuitl Gaiters"}
	sets.engaged.HighHaste.Acc.PDT = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Dark Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Iuitl Tights",feet="Iuitl Gaiters"}

	-- Custom melee group: Max Haste
	sets.engaged.MaxHaste = {ammo="Charis Feather",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Thaumas Coat",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Kaabnax Trousers",feet="Manibozho Boots"}
	sets.engaged.MaxHaste.Acc = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Kaabnax Trousers",feet="Manibozho Boots"}
	sets.engaged.MaxHaste.Evasion = {ammo="Charis Feather",
		head="Whirlpool Mask",neck="Torero Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Ik Cape",waist="Windbuffet Belt",legs="Kaabnax Trousers",feet="Iuitl Gaiters"}
	sets.engaged.MaxHaste.Acc.Evasion = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Torero Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Kaabnax Trousers",feet="Iuitl Gaiters"}
	sets.engaged.MaxHaste.PDT = {ammo="Charis Feather",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Dark Ring",ring2="Epona's Ring",
		back="Iximulew Cape",waist="Windbuffet Belt",legs="Iuitl Tights",feet="Iuitl Gaiters"}
	sets.engaged.MaxHaste.Acc.PDT = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Dark Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Iuitl Tights",feet="Iuitl Gaiters"}



	sets.engaged['Saber Dance'] = {legs="Etoile Tights +2"}
	sets.engaged['Climactic Flourish'] = {legs="Charis Tiara +2"}

	skillchainPending = false
	
	waltzTPCost = {['Curing Waltz'] = 20,['Curing Waltz II'] = 35,['Curing Waltz III'] = 50,['Curing Waltz IV'] = 65,['Curing Waltz V'] = 80}
	
	
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

-- Handle spell changes before attempting any precast stuff.
-- Returns two values on completion:
-- 1) bool of whether the original spell was cancelled
-- 2) bool of whether the spell was changed to something new
function job_handle_spell_change(spell, action, spellMap)
	if spell.type == 'Waltz' then
		return refine_waltz(spell, action, spellMap)
	end
end

-- Return true if we handled the precast work.  Otherwise it will fall back
-- to the general precast() code in Mote-Include.
function job_precast(spell, action, spellMap)

end

function job_post_precast(spell, action, spellMap)
	if spell.type == "Weaponskill" then
		if skillchainPending then
			equip(sets.precast.Skillchain)
		else
			skillchainPending = true
			send_command('wait 7;gs c clear skillchainPending')
		end
	end
end


-- Return true if we handled the midcast work.  Otherwise it will fall back
-- to the general midcast() code in Mote-Include.
function job_midcast(spell, action, spellMap)

end

-- Return true if we handled the aftercast work.  Otherwise it will fall back
-- to the general aftercast() code in Mote-Include.
function job_aftercast(spell, action)
	if not spell.interrupted then
		if spell.english == "Wild Flourish" then
			skillchainPending = true
			send_command('wait 7;gs c clear skillchainPending')
		end
	end
	
	if spell.type == "Weaponskill" then
		skillchainPending = false
	end
	
	return false
end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)

end

function customize_melee_set(meleeSet)
	if buffactive['saber dance'] and not state.Defense.Active then
		meleeSet = set_combine(meleeSet, sets.engaged['Saber Dance'])
	elseif buffactive['climactic flourish'] and not state.Defense.Active then
		meleeSet = set_combine(meleeSet, sets.engaged['Climactic Flourish'])
	end
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
	-- If we gain or lose any haste buffs, adjust which gear set we target.
	if S{'haste','march','embrava','haste samba'}[buff:lower()] then
		determine_haste_group()
		handle_equipping_gear(player.status)
	elseif buff == 'Saber Dance' or buff == 'Climactic Flourish' then
		handle_equipping_gear(player.status)
	end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for direct player commands.
function job_self_command(cmdParams)
	if cmdParams[1] == 'clear' and cmdParams[2] == 'skillchainPending' then
		skillchainPending = false
	elseif cmdParams[1] == 'update' then
		determine_haste_group()
	end
end


-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state()

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Handle spell changes before attempting any precast stuff.
-- Returns two values on completion:
-- 1) bool of whether the original spell was cancelled
-- 2) bool of whether the spell was changed to something new
function refine_waltz(spell, action, spellMap)
	local newWaltz = ''
	local tpCost = 0
	local wasCancelled = false
	local wasChanged = false

	-- Don't modify anything for Healing Waltz or Divine Waltzes
	if spell.name == "Healing Waltz" or spell.name == "Divine Waltz" or spell.name == "Divine Waltz II" then
		return wasCancelled, wasChanged
	end
	
	
	-- Can only calculate healing amounts for ourself.
	if spell.target.type == "SELF" then
		local missingHP = player.max_hp - player.hp
		
		if missingHP < 40 then
			add_to_chat(122,'Full HP!')
		elseif missingHP < 200 then
			newWaltz = 'Curing Waltz'
		elseif missingHP < 500 then
			newWaltz = 'Curing Waltz II'
		elseif missingHP < 900 then
			newWaltz = 'Curing Waltz III'
		elseif missingHP < 1200 then
			newWaltz = 'Curing Waltz IV'
		else
			newWaltz = 'Curing Waltz V'
		end
		
		if newWaltz ~= '' then
			add_to_chat(122,'Using '..newWaltz..' for ['..tostring(missingHP)..' HP]')
			
			if newWaltz ~= spell.english then
				wasChanged = true
			end
		end
	end
	
	if newWaltz ~= '' then
		tpCost = waltzTPCost[newWaltz]
	end
	
	-- Downgrade the spell to what we can afford
	if player.tp < tpCost and not buffactive.trance and newWaltz ~= '' then
		--[[ Costs:
			Curing Waltz:     20 TP
			Curing Waltz II:  35 TP
			Curing Waltz III: 50 TP
			Curing Waltz IV:  65 TP
			Curing Waltz V:   80 TP
			Divine Waltz:     40 TP
			Divine Waltz II:  80 TP
		]]
		
		if player.tp < 20 then
			add_to_chat(122, 'Insufficient TP ['..tostring(player.tp)..']. Cancelling.')
		elseif player.tp < 35 then
			newWaltz = 'Curing Waltz'
		elseif player.tp < 50 then
			newWaltz = 'Curing Waltz II'
		elseif player.tp < 65 then
			newWaltz = 'Curing Waltz III'
		elseif player.tp < 80 then
			newWaltz = 'Curing Waltz IV'
		end
		
		if newWaltz ~= '' then
			add_to_chat(122, 'Insufficient TP ['..tostring(player.tp)..']. Downgrading to '..newWaltz)
			
			if newWaltz ~= spell.english then
				wasChanged = true
				send_command('wait 0.05;input /ja "'..newWaltz..'" '..spell.target.raw)
			end
		end
	end
	
	if newWaltz ~= spell.english then
		cancel_spell()
		wasCancelled = true
	end
	
	return wasCancelled, wasChanged
end

function determine_haste_group()
	-- We have three groups of DW in gear: Charis body, Charis neck + DW earrings, and Patentia Sash.

	-- For high haste, we want to be able to drop one of the 10% groups (body, preferably).
	-- High haste buffs:
	-- 2x Marches + Haste
	-- 2x Marches + Haste Samba
	-- 1x March + Haste + Haste Samba
	-- Embrava + any other haste buff
	
	-- For max haste, we probably need to consider dropping all DW gear.
	-- Max haste buffs:
	-- Embrava + Haste/March + Haste Samba
	-- 2x March + Haste + Haste Samba
	
	if buffactive.embrava and (buffactive.haste or buffactive.march) and buffactive['haste samba'] then
		CustomMeleeGroup = 'MaxHaste'
	elseif buffactive.march == 2 and buffactive.haste and buffactive['haste samba'] then
		CustomMeleeGroup = 'MaxHaste'
	elseif buffactive.embrava and (buffactive.haste or buffactive.march or buffactive['haste samba']) then
		CustomMeleeGroup = 'HighHaste'
	elseif buffactive.march == 1 and buffactive.haste and buffactive['haste samba'] then
		CustomMeleeGroup = 'HighHaste'
	elseif buffactive.march == 2 and (buffactive.haste or buffactive['haste samba']) then
		CustomMeleeGroup = 'HighHaste'
	else
		CustomMeleeGroup = 'Normal'
	end
end

