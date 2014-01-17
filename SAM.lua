-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
	-- Load and initialize the include file.
	include('Mote-Include.lua')
	init_include()
	
	-- UserGlobals may define additional sets to be added to the local ones.
	if define_global_sets then
		define_global_sets()
	end

	-- Define sets and vars used by this job file.
	self_initialize()

	-- Default macro set/book
	set_macro_page(2, 11)
	
	-- Global default binds
	binds_on_load()
	
	-- Additional local binds
	windower.send_command('bind ^` input /ja "Hasso" <me>')
	windower.send_command('bind !` input /ja "Seigan" <me>')
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()
	binds_on_unload()
	windower.send_command('unbind ^`')
	windower.send_command('unbind !`')
end


-- Define sets and vars used by this job file.
function self_initialize()
	-- Options: Override default values
	options.OffenseModes = {'Normal', 'Acc'}
	options.DefenseModes = {'Normal', 'PDT', 'Reraise'}
	options.WeaponskillModes = {'Normal', 'Acc', 'Att', 'Mod'}
	options.CastingModes = {'Normal'}
	options.IdleModes = {'Normal'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'PDT', 'Reraise'}
	options.MagicalDefenseModes = {'MDT'}

	state.Defense.PhysicalMode = 'PDT'
	
	state.Buff.Sekkanoki = buffactive.sekkanoki or false
	state.Buff.Sengikori = buffactive.sengikori or false
	state.Buff['Meikyou Shisui'] = buffactive['Meikyou Shisui'] or false
	
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	-- Precast sets to enhance JAs
	sets.precast.JA.Meditate = {head="Myochin Kabuto",hands="Saotome Kote +2"}
	sets.precast.JA['Warding Circle'] = {head="Myochin Kabuto"}
	sets.precast.JA['Blade Bash'] = {hands="Saotome Kote +2"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {ammo="Sonia's Plectrum",
		head="Yaoyotl Helm",
		body="Otronif Harness",hands="Buremte Gloves",ring1="Spiral Ring",
		back="Iximulew Cape",waist="Caudata Belt",legs="Karieyh Brayettes +1",feet="Otronif Boots"}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Thew Bomblet",
		head="Yaoyotl Helm",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Phorcys Korazin",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Spiral Ring",
		back="Atheling Mantle",waist="Caudata Belt",legs="Karieyh Brayettes +1",feet="Karieyh Sollerets +1"}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {back="Letalis Mantle"})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS, {neck="Snow Gorget"})
	sets.precast.WS['Tachi: Fudo'].Acc = set_combine(sets.precast.WS.Acc, {neck="Snow Gorget"})
	sets.precast.WS['Tachi: Fudo'].Mod = set_combine(sets.precast.WS['Tachi: Fudo'], {waist="Snow Belt"})

	sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {neck="Thunder Gorget"})
	sets.precast.WS['Tachi: Shoha'].Acc = set_combine(sets.precast.WS.Acc, {neck="Thunder Gorget"})
	sets.precast.WS['Tachi: Shoha'].Mod = set_combine(sets.precast.WS['Tachi: Shoha'], {waist="Thunder Belt"})

	sets.precast.WS['Tachi: Rana'] = set_combine(sets.precast.WS, {neck="Snow Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",})
	sets.precast.WS['Tachi: Rana'].Acc = set_combine(sets.precast.WS.Acc, {neck="Snow Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",})
	sets.precast.WS['Tachi: Rana'].Mod = set_combine(sets.precast.WS['Tachi: Rana'], {waist="Snow Belt"})

	sets.precast.WS['Tachi: Kasha'] = set_combine(sets.precast.WS, {neck="Light Gorget",waist="Light Belt"})

	sets.precast.WS['Tachi: Gekko'] = set_combine(sets.precast.WS, {neck="Snow Gorget",waist="Snow Belt"})

	sets.precast.WS['Tachi: Yukikaze'] = set_combine(sets.precast.WS, {neck="Snow Gorget",waist="Snow Belt"})

	sets.precast.WS['Tachi: Ageha'] = set_combine(sets.precast.WS, {neck="Soil Gorget",waist="Soil Belt"})

	sets.precast.WS['Tachi: Jinpu'] = set_combine(sets.precast.WS, {neck="Soil Gorget",waist="Soil Belt"})


	-- Midcast Sets
	sets.midcast.FastRecast = {
		head="Yaoyotl Helm",
		body="Otronif Harness",hands="Otronif Gloves",
		legs="Phorcys Dirs",feet="Otronif Boots"}

	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {neck="Wiglen Gorget",ring1="Sheltered Ring",ring2="Paguroidea Ring"}
	

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle.Town = {main="Tsurumaru", sub="Pole Grip",ammo="Thew Bomblet",
		head="Yaoyotl Helm",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Atheling Mantle",waist="Flume Belt",legs="Phorcys Dirs",feet="Danzo Sune-ate"}
	
	sets.idle.Field = {
		head="Yaoyotl Helm",neck="Wiglen Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Shadow Mantle",waist="Flume Belt",legs="Karieyh Brayettes +1",feet="Danzo Sune-ate"}

	sets.idle.Weak = {
		head="Twilight Helm",neck="Wiglen Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Twilight Mail",hands="Buremte Gloves",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Shadow Mantle",waist="Flume Belt",legs="Karieyh Brayettes +1",feet="Danzo Sune-ate"}
	
	-- Defense sets
	sets.defense.PDT = {ammo="Iron Gobbet",
		head="Yaoyotl Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Dark Ring",ring2="Dark Ring",
		back="Shadow Mantle",waist="Flume Belt",legs="Karieyh Brayettes +1",feet="Otronif Boots"}

	sets.defense.Reraise = {
		head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Twilight Mail",hands="Buremte Gloves",ring1="Dark Ring",ring2="Paguroidea Ring",
		back="Shadow Mantle",waist="Flume Belt",legs="Karieyh Brayettes +1",feet="Otronif Boots"}

	sets.defense.MDT = {ammo="Demonry Stone",
		head="Yaoyotl Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Engulfer Cape",waist="Flume Belt",legs="Karieyh Brayettes +1",feet="Otronif Boots"}

	sets.Kiting = {feet="Danzo Sune-ate"}

	sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	-- Delay 450 GK, 25 Save TP => 65 Store TP for a 5-hit (25 Store TP in gear)
	sets.engaged = {ammo="Thew Bomblet",
		head="Yaoyotl Helm",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Karieyh Haubert +1",hands="Otronif Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Atheling Mantle",waist="Goading Belt",legs="Unkai Haidate +2",feet="Otronif Boots"}
	sets.engaged.Acc = {ammo="Thew Bomblet",
		head="Yaoyotl Helm",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Karieyh Haubert +1",hands="Otronif Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Letalis Mantle",waist="Goading Belt",legs="Unkai Haidate +2",feet="Otronif Boots"}
	sets.engaged.PDT = {ammo="Thew Bomblet",
		head="Yaoyotl Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Dark Ring",ring2="K'ayres Ring",
		back="Iximulew Cape",waist="Goading Belt",legs="Unkai Haidate +2",feet="Otronif Boots"}
	sets.engaged.Acc.PDT = {ammo="Honed Tathlum",
		head="Yaoyotl Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Dark Ring",ring2="K'ayres Ring",
		back="Letalis Mantle",waist="Goading Belt",legs="Unkai Haidate +2",feet="Otronif Boots"}
	sets.engaged.Reraise = {ammo="Thew Bomblet",
		head="Twilight Helm",neck="Torero Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Twilight Mail",hands="Otronif Gloves",ring1="Beeline Ring",ring2="K'ayres Ring",
		back="Ik Cape",waist="Goading Belt",legs="Unkai Haidate +2",feet="Otronif Boots"}
	sets.engaged.Acc.Reraise = {ammo="Thew Bomblet",
		head="Twilight Helm",neck="Torero Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Twilight Mail",hands="Otronif Gloves",ring1="Beeline Ring",ring2="K'ayres Ring",
		back="Letalis Mantle",waist="Goading Belt",legs="Unkai Haidate +2",feet="Otronif Boots"}
		
	-- Melee sets for in Adoulin, which has an extra 10 Save TP for weaponskills.
	-- Delay 450 GK, 35 Save TP => 89 Store TP for a 4-hit (49 Store TP in gear), 2 Store TP for a 5-hit
	sets.engaged.Adoulin = {ammo="Thew Bomblet",
		head="Yaoyotl Helm",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Karieyh Haubert +1",hands="Otronif Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Takaha Mantle",waist="Goading Belt",legs="Unkai Haidate +2",feet="Otronif Boots"}
	sets.engaged.Adoulin.Acc = {ammo="Thew Bomblet",
		head="Yaoyotl Helm",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Unkai Domaru +2",hands="Otronif Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Letalis Mantle",waist="Goading Belt",legs="Unkai Haidate +2",feet="Otronif Boots"}
	sets.engaged.Adoulin.PDT = {ammo="Thew Bomblet",
		head="Yaoyotl Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Dark Ring",ring2="K'ayres Ring",
		back="Iximulew Cape",waist="Goading Belt",legs="Unkai Haidate +2",feet="Otronif Boots"}
	sets.engaged.Adoulin.Acc.PDT = {ammo="Honed Tathlum",
		head="Yaoyotl Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Otronif Harness",hands="Otronif Gloves",ring1="Dark Ring",ring2="K'ayres Ring",
		back="Letalis Mantle",waist="Goading Belt",legs="Unkai Haidate +2",feet="Otronif Boots"}
	sets.engaged.Adoulin.Reraise = {ammo="Thew Bomblet",
		head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Twilight Mail",hands="Otronif Gloves",ring1="Beeline Ring",ring2="K'ayres Ring",
		back="Ik Cape",waist="Goading Belt",legs="Unkai Haidate +2",feet="Otronif Boots"}
	sets.engaged.Adoulin.Acc.Reraise = {ammo="Thew Bomblet",
		head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Twilight Mail",hands="Otronif Gloves",ring1="Beeline Ring",ring2="K'ayres Ring",
		back="Letalis Mantle",waist="Goading Belt",legs="Unkai Haidate +2",feet="Otronif Boots"}


	sets.buff.Sekkanoki = {hands="Unkai Kote +2"}
	sets.buff.Sengikori = {feet="Unkai Sune-ate +2"}
	sets.buff['Meikyou Shisui'] = {feet="Saotome Sune-ate +2"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
	if spell.type:lower() == 'weaponskill' then
		-- Change any GK weaponskills to polearm weaponskill if we're using a polearm.
		if player.equipment.main=='Quint Spear' or player.equipment.main=='Quint Spear' then
			if spell.english:startswith("Tachi:") then
				send_command('input /ws "Penta Thrust" '..spell.target.raw)
				eventArgs.cancel = true
			end
		end
	end
end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.type:lower() == 'weaponskill' then
		if state.Buff.Sekkanoki then
			equip(sets.buff.Sekkanoki)
		end
		if state.Buff.Sengikori then
			equip(sets.buff.Sengikori)
		end
		if state.Buff['Meikyou Shisui'] then
			equip(sets.buff['Meikyou Shisui'])
		end
	end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		equip(sets.midcast.FastRecast)
	end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	-- Effectively lock these items in place.
	if state.DefenseMode == 'Reraise' or
		(state.Defense.Active and state.Defense.Type == 'Physical' and state.Defense.PhysicalMode == 'Reraise') then
		equip(sets.Reraise)
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
	classes.CustomMeleeGroups:clear()
	if areas.Adoulin:contains(world.area) and buffactive.ionis then
		classes.CustomMeleeGroups:append('Adoulin')
	end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

