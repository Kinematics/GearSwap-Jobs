-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

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


	options.StepModes = {'Box Step', 'Quickstep', 'Feather Step', 'Stutter Step'}
	state.MainStep = 'Box Step'
	state.AltStep = 'Quickstep'
	state.CurrentStep = 'Main'
	state.UseAltStep = false
	state.SelectStepTarget = false
	state.IgnoreTargetting = false
	
	windower.send_command('bind ^= gs c cycle mainstep')
	windower.send_command('bind != gs c cycle altstep')
	windower.send_command('bind ^- gs c toggle selectsteptarget')
	windower.send_command('bind !- gs c toggle usealtstep')


	skillchainPending = false
	
	waltzTPCost = {['Curing Waltz'] = 20,['Curing Waltz II'] = 35,['Curing Waltz III'] = 50,['Curing Waltz IV'] = 65,['Curing Waltz V'] = 80}
	
	
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs

	sets.precast.JA['No Foot Rise'] = {body="Etoile Casaque +2"}

	sets.precast.JA['Trance'] = {head="Etoile Tiara +2"}
	

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {ammo="Sonia's Plectrum",
		head="Etoile Tiara +2",ear1="Roundel Earring",
		body="Maxixi Casaque",hands="Buremte Gloves",
		back="Shadow Mantle",waist="Caudata Belt",legs="Nahtirah Trousers",feet="Maxixi Toeshoes"}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}
	
	sets.precast.Samba = {head="Maxixi Tiara"}

	sets.precast.Jig = {legs="Etoile Tights +2", feet="Maxixi Toeshoes"}

	sets.precast.Step = {}
	sets.precast.Step['Feather Step'] = {feet="Charis Shoes +2"}

	sets.precast.Flourish1 = {}
	sets.precast.Flourish1['Violent Flourish'] = {ear1="Psystorm Earring",ear2="Lifestorm Earring",
		body="Etoile Casaque +2",ring2="Sangoma Ring",feet="Iuitl Gaiters"} -- magic accuracy
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

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {neck="Houyi's Gorget",hands="Iuitl Wristbands",
		ring1="Stormsoul Ring",legs="Nahtirah Trousers"})
	sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {ammo="Honed Tathlum", back="Letalis Mantle"})
	sets.precast.WS['Exenterator'].Mod = set_combine(sets.precast.WS['Exenterator'], {waist="Thunder Belt"})

	sets.precast.WS['Pyrrhic Kleos'] = set_combine(sets.precast.WS, {neck="Soil Gorget",hands="Iuitl Wristbands",feet="Iuitl Gaiters"})
	sets.precast.WS['Pyrrhic Kleos'].Acc = set_combine(sets.precast.WS['Pyrrhic Kleos'], {ammo="Honed Tathlum", back="Letalis Mantle"})
	sets.precast.WS['Pyrrhic Kleos'].Mod = set_combine(sets.precast.WS['Pyrrhic Kleos'], {waist="Soil Belt"})

	sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS, {neck="Soil Gorget",feet="Iuitl Gaiters"})
	sets.precast.WS['Dancing Edge'].Acc = set_combine(sets.precast.WS['Dancing Edge'], {ammo="Honed Tathlum", back="Letalis Mantle"})
	sets.precast.WS['Dancing Edge'].Mod = set_combine(sets.precast.WS['Dancing Edge'], {waist="Soil Belt"})

	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {ammo="Charis Feather",neck="Rancor Collar",feet="Iuitl Gaiters"})
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {ammo="Honed Tathlum", back="Letalis Mantle"})
	sets.precast.WS['Evisceration'].Mod = set_combine(sets.precast.WS['Evisceration'], {waist="Soil Belt"})

	sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {ammo="Charis Feather",neck="Snow Gorget",
		ear1="Brutal Earring",ear2="Moonshade Earring",waist="Snow Belt",feet="Iuitl Gaiters"})
	sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {ammo="Honed Tathlum", back="Letalis Mantle"})
	sets.precast.WS["Rudra's Storm"].Mod = set_combine(sets.precast.WS["Rudra's Storm"], {waist="Soil Belt"})

	sets.precast.WS['Aeolian Edge'] = {ammo="Charis Feather",
		head="Thaumas Hat",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Manibozho Jerkin",hands="Buremte Gloves",ring1="Rajas Ring",ring2="Demon's Ring",
		back="Toro Cape",waist="Thunder Belt",legs="Iuitl Tights",feet="Iuitl Gaiters"}
	
	sets.precast.Skillchain = {hands="Charis Bangles +2"}
	
	
	-- Midcast Sets
	
	sets.midcast.FastRecast = {
		head="Felistris Mask",ear2="Loquacious Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",
		back="Ix Cape",legs="Kaabnax Trousers",feet="Iuitl Gaiters"}
		
	-- Specific spells
	sets.midcast.Utsusemi = {
		head="Felistris Mask",neck="Torero Torque",ear2="Loquacious Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",
		back="Ix Cape",legs="Kaabnax Trousers",feet="Iuitl Gaiters"}

	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",
		ring1="Sheltered Ring",ring2="Paguroidea Ring"}
	sets.ExtraRegen = {head="Ocelomeh Headpiece +1"}
	

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

	sets.idle.Town = {main="Izhiikoh", sub="Atoyac",ammo="Charis Feather",
		head="Whirlpool Mask",neck="Charis Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Charis Casaque +2",hands="Iuitl Wristbands",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Atheling Mantle",waist="Patentia Sash",legs="Kaabnax Trousers",feet="Skadi's Jambeaux +1"}
	
	sets.idle.Field = {ammo="Charis Feather",
		head="Whirlpool Mask",neck="Wiglen Gorget",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Shadow Mantle",waist="Flume Belt",legs="Kaabnax Trousers",feet="Skadi's Jambeaux +1"}

	sets.idle.Weak = {ammo="Charis Feather",
		head="Whirlpool Mask",neck="Wiglen Gorget",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Manibozho Jerkin",hands="Buremte Gloves",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Shadow Mantle",waist="Flume Belt",legs="Kaabnax Trousers",feet="Skadi's Jambeaux +1"}
	
	-- Defense sets

	sets.defense.Evasion = {
		head="Whirlpool Mask",neck="Torero Torque",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Dark Ring",
		back="Ik Cape",waist="Flume Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters"}

	sets.defense.PDT = {ammo="Iron Gobbet",
		head="Whirlpool Mask",neck="Twilight Torque",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Dark Ring",
		back="Shadow Mantle",waist="Flume Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters"}

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
		head="Felistris Mask",neck="Charis Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Charis Casaque +2",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Patentia Sash",legs="Kaabnax Trousers",feet="Manibozho Boots"}
	sets.engaged.Acc = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Charis Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Charis Casaque +2",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Kaabnax Trousers",feet="Manibozho Boots"}
	sets.engaged.Evasion = {ammo="Charis Feather",
		head="Felistris Mask",neck="Torero Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Ik Cape",waist="Patentia Sash",legs="Kaabnax Trousers",feet="Iuitl Gaiters"}
	sets.engaged.Acc.Evasion = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Torero Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Kaabnax Trousers",feet="Iuitl Gaiters"}
	sets.engaged.PDT = {ammo="Charis Feather",
		head="Felistris Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Dark Ring",ring2="Epona's Ring",
		back="Shadow Mantle",waist="Patentia Sash",legs="Kaabnax Trousers",feet="Iuitl Gaiters"}
	sets.engaged.Acc.PDT = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Dark Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Kaabnax Trousers",feet="Iuitl Gaiters"}

	-- Custom melee group: High Haste
	sets.engaged.HighHaste = {ammo="Charis Feather",
		head="Felistris Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Thaumas Coat",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Patentia Sash",legs="Kaabnax Trousers",feet="Manibozho Boots"}
	sets.engaged.HighHaste.Acc = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Kaabnax Trousers",feet="Manibozho Boots"}
	sets.engaged.HighHaste.Evasion = {ammo="Charis Feather",
		head="Felistris Mask",neck="Torero Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Ik Cape",waist="Patentia Sash",legs="Kaabnax Trousers",feet="Iuitl Gaiters"}
	sets.engaged.HighHaste.Acc.Evasion = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Torero Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Kaabnax Trousers",feet="Iuitl Gaiters"}
	sets.engaged.HighHaste.PDT = {ammo="Charis Feather",
		head="Felistris Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Dark Ring",ring2="Epona's Ring",
		back="Shadow Mantle",waist="Patentia Sash",legs="Iuitl Tights",feet="Iuitl Gaiters"}
	sets.engaged.HighHaste.Acc.PDT = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Dark Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Iuitl Tights",feet="Iuitl Gaiters"}

	-- Custom melee group: Max Haste
	sets.engaged.MaxHaste = {ammo="Charis Feather",
		head="Felistris Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Thaumas Coat",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Kaabnax Trousers",feet="Manibozho Boots"}
	sets.engaged.MaxHaste.Acc = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Kaabnax Trousers",feet="Manibozho Boots"}
	sets.engaged.MaxHaste.Evasion = {ammo="Charis Feather",
		head="Felistris Mask",neck="Torero Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Ik Cape",waist="Windbuffet Belt",legs="Kaabnax Trousers",feet="Iuitl Gaiters"}
	sets.engaged.MaxHaste.Acc.Evasion = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Torero Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Kaabnax Trousers",feet="Iuitl Gaiters"}
	sets.engaged.MaxHaste.PDT = {ammo="Charis Feather",
		head="Felistris Mask",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Dark Ring",ring2="Epona's Ring",
		back="Shadow Mantle",waist="Windbuffet Belt",legs="Iuitl Tights",feet="Iuitl Gaiters"}
	sets.engaged.MaxHaste.Acc.PDT = {ammo="Honed Tathlum",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Dark Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs="Iuitl Tights",feet="Iuitl Gaiters"}



	-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	sets.buff['Saber Dance'] = {legs="Etoile Tights +2"}
	sets.buff['Climactic Flourish'] = {legs="Charis Tiara +2"}

	
	set_macro_page(5, 20)
	binds_on_load()

	windower.send_command('bind ^` input /ja "Chocobo Jig" <me>')
	windower.send_command('bind !` input /ja "Chocobo Jig II" <me>')
end

-- Called when this job file is unloaded (eg: job change)
function file_unload()
	--binds_on_unload()
	
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
function job_pretarget(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	if spell.type == 'Waltz' then
		refine_waltz(spell, action, spellMap, eventArgs)
	end
end

function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.type:lower() == "weaponskill" then
		if skillchainPending then
			equip(sets.precast.Skillchain)
		end
	end
end


-- Return true if we handled the aftercast work.  Otherwise it will fall back
-- to the general aftercast() code in Mote-Include.
function job_aftercast(spell, action, spellMap, eventArgs)
	if not spell.interrupted then
		if spell.english == "Wild Flourish" then
			skillchainPending = true
			send_command('wait 7;gs c clear skillchainPending')
		elseif spell.type:lower() == "weaponskill" then
			skillchainPending = not skillchainPending
			send_command('wait 7;gs c clear skillchainPending')
		end
	end
end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
	if player.hpp < 80 then
		idleSet = set_combine(idleSet, sets.ExtraRegen)
	end
	
	return idleSet
end

function customize_melee_set(meleeSet)
	if not state.Defense.Active then
		if buffactive['saber dance'] then
			meleeSet = set_combine(meleeSet, sets.buff['Saber Dance'])
		end
		if buffactive['climactic flourish'] then
			meleeSet = set_combine(meleeSet, sets.buff['Climactic Flourish'])
		end
	end
	
	return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)
	-- If we gain or lose any haste buffs, adjust which gear set we target.
	if S{'haste','march','embrava','haste samba'}:contains(buff:lower()) then
		determine_haste_group()
		handle_equipping_gear(player.status)
	elseif buff == 'Saber Dance' or buff == 'Climactic Flourish' then
		handle_equipping_gear(player.status)
	end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
	if cmdParams[1] == 'clear' and cmdParams[2] == 'skillchainPending' then
		skillchainPending = false
	elseif cmdParams[1] == 'step' then
		if cmdParams[2] == 't' then
			state.IgnoreTargetting = true
		end

		local doStep = state.MainStep
		if state.UseAltStep then
			doStep = state[state.CurrentStep..'Step']
			if state.CurrentStep == 'Main' then
				state.CurrentStep = 'Alt'
			else
				state.CurrentStep = 'Main'
			end
		end
		
		send_command('input /ja "'..doStep..'" <t>')
	end
end


-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
	determine_haste_group()
end

-- Hooks for step mode handling.

-- Job-specific toggles.
function job_toggle(field)
	if field:lower() == 'selectsteptarget' then
		state.SelectStepTarget = not state.SelectStepTarget
		return "Select Step Target", state.SelectStepTarget
	elseif field:lower() == 'usealtstep' then
		state.UseAltStep = not state.UseAltStep
		return "Use Alt Step", state.UseAltStep
	end
end

-- Request job-specific mode tables.
-- Return the list, and the current value for the requested field.
function job_get_mode_list(field)
	if field == 'Mainstep' then
		return options.StepModes, state.MainStep
	elseif field == 'Altstep' then
		return options.StepModes, state.AltStep
	end
end

-- Set job-specific mode values.
-- Return true if we recognize and set the requested field.
function job_set_mode(field, val)
	if field == 'Mainstep' then
		state.MainStep = val
		return true
	elseif field == 'Altstep' then
		state.AltStep = val
		return true
	end
end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)
	if spell.type == 'Step' then
		if state.IgnoreTargetting then
			state.IgnoreTargetting = false
			eventArgs.handled = true
		end
		
		eventArgs.SelectNPCTargets = state.SelectStepTarget
	end
end


-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
	local defenseString = ''
	if state.Defense.Active then
		local defMode = state.Defense.PhysicalMode
		if state.Defense.Type == 'Magical' then
			defMode = state.Defense.MagicalMode
		end

		defenseString = 'Defense: '..state.Defense.Type..' '..defMode..', '
	end
	
	local steps = ''
	if state.UseAltStep then
		steps = ', ['..state.MainStep..'/'..state.AltStep..']'
	else
		steps = ', ['..state.MainStep..']'
	end

	if state.SelectStepTarget then
		steps = steps..' (Targetted)'
	end


	add_to_chat(122,'Melee: '..state.OffenseMode..'/'..state.DefenseMode..', WS: '..state.WeaponskillMode..', '..defenseString..
		'Kiting: '..on_off_names[state.Kiting]..steps)

	eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

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
	
	classes.CustomMeleeGroups:clear()
	
	if buffactive.embrava and (buffactive.haste or buffactive.march) and buffactive['haste samba'] then
		classes.CustomMeleeGroups:append('MaxHaste')
	elseif buffactive.march == 2 and buffactive.haste and buffactive['haste samba'] then
		classes.CustomMeleeGroups:append('MaxHaste')
	elseif buffactive.embrava and (buffactive.haste or buffactive.march or buffactive['haste samba']) then
		classes.CustomMeleeGroups:append('HighHaste')
	elseif buffactive.march == 1 and buffactive.haste and buffactive['haste samba'] then
		classes.CustomMeleeGroups:append('HighHaste')
	elseif buffactive.march == 2 and (buffactive.haste or buffactive['haste samba']) then
		classes.CustomMeleeGroups:append('HighHaste')
	end
end

