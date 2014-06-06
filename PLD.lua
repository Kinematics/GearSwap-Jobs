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
    state.Buff.Sentinel = buffactive.sentinel or false
    state.Buff.Cover = buffactive.cover or false
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    options.OffenseModes = {'Normal', 'Acc'}
    options.DefenseModes = {'Normal', 'Shield'}
    options.WeaponskillModes = {'Normal', 'Acc'}
    options.CastingModes = {'Normal'}
    options.IdleModes = {'Normal'}
    options.RestingModes = {'Normal'}
    options.PhysicalDefenseModes = {'PDT', 'Shield', 'HP'}
    options.MagicalDefenseModes = {'MDT'}

    options.HybridDefenseModes = {'None', 'Repulse', 'Reraise', 'RepulseReraise'}

    state.Defense.PhysicalMode = 'PDT'
    state.HybridDefenseMode = 'None'

    physical_darkring1 = {name="Dark Ring",augments={'Magic dmg. taken -3%','Spell interruption rate down -5%','Phys. dmg. taken -6%'}}
    physical_darkring2 = {name="Dark Ring",augments={'Magic dmg. taken -3%','Phys. dmg. taken -5%'}}
    magic_breath_darkring1 = {name="Dark Ring", augments={'Magic dmg. taken -6%','Breath dmg. taken -5%'}}
    magic_breath_darkring2 = {name="Dark Ring",augments={"Magic dmg. taken -5%", "Breath dmg. taken -6%"}}
    vexer_ring = {name="Vexer Ring"}
    
	send_command('bind !f11 gs c cycle HybridDefenseMode')

    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()
    if binds_on_unload then
        binds_on_unload()
    end

	send_command('unbind !f11')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = {legs="Caballarius Breeches"}
    sets.precast.JA['Holy Circle'] = {feet="Reverence Leggings"}
    --sets.precast.JA['Shield Bash'] = {hands="Valor Gauntlets +2"}
    sets.precast.JA['Sentinel'] = {feet="Caballarius Leggings"}
    sets.precast.JA['Rampart'] = {head="Valor Coronet"}
    --sets.precast.JA['Fealty'] = {body="Valor Surcoat +2"}
    --sets.precast.JA['Divine Emblem'] = {feet="Creed Sabatons +2"}
    sets.precast.JA['Cover'] = {head="Reverence Coronet +1"}

    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {
        head="Yaoyotl Helm",
        body="Reverence Surcoat +1",hands="Buremte Gloves",ring1="Aquasoul Ring",
        legs="Reverence Breeches +1",feet="Whirlpool Greaves"}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Yaoyotl Helm",
        body="Reverence Surcoat +1",hands="Reverence Gauntlets +1",
        back="Iximulew Cape",waist="Caudata Belt",legs="Reverence Breeches +1",feet="Reverence Leggings"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Incantor Stone",
        head="Cizin Helm",ear2="Loquacious Earring",
        ring1="Prolix Ring",
        legs="Enif Cosciales"}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC,
        {body="Twilight Mail",hands="Buremte Gloves",ring2="Dark Ring",
        waist="Flume Belt",feet="Karieyh Sollerets +1"})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Yaoyotl Helm",neck=gear.ElementalGorget,ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Karieyh Haubert +1",hands="Cizin Mufflers",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Atheling Mantle",waist=gear.ElementalBelt,legs="Cizin Breeches",feet="Cizin Greaves"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {ring1="Aquasoul Ring",ring2="Aquasoul Ring"})

    sets.precast.WS['Sanguine Blade'] = {
        head="Yaoyotl Helm",neck="Eddy Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Reverence Surcoat +1",hands="Cizin Mufflers",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Toro Cape",waist="Caudata Belt",legs="Reverence Breeches +1",feet="Reverence Leggings"}
    
    
    -- Midcast Sets
    sets.midcast.FastRecast = {
        head="Yaoyotl Helm",
        body="Reverence Surcoat +1",hands="Cizin Mufflers",
        waist="Zoran's Belt",legs="Enif Cosciales",feet="Reverence Leggings"}
        
    sets.midcast.Enmity = {ammo="Iron Gobbet",
        head="Reverence Coronet +1",neck="Invidia Torque",
        body="Reverence Surcoat +1",hands="Reverence Gauntlets +1",ring1="Vexer Ring",
        back="Fierabras's Mantle",waist="Goading Belt",legs="Reverence Breeches +1"}

    sets.midcast.Flash = set_combine(sets.midcast.Enmity, {legs="Enif Cosciales",feet="Cizin Greaves"})
    
    sets.midcast.Stun = sets.midcast.Flash
    
    sets.midcast.Cure = {ammo="Iron Gobbet",
        head="Adaman Barbuta",neck="Invidia Torque",ear1="Hospitaler Earring",ear2="Bloodgem Earring",
        body="Reverence Surcoat +1",hands="Buremte Gloves",ring1="Kunaji Ring",ring2="Meridian Ring",
        back="Fierabras's Mantle",waist="Creed Baudrier",legs="Reverence Breeches +1",feet="Reverence Leggings"}

    sets.midcast['Enhancing Magic'] = {neck="Colossus's Torque",waist="Olympus Sash",legs="Reverence Breeches +1"}
    
    sets.midcast.Protect = {ring1="Sheltered Ring"}
    sets.midcast.Shell = {ring1="Sheltered Ring"}
    
    -- Sets to return to when not performing an action.

    sets.Reraise = {head="Twilight Helm", body="Twilight Mail"}
    
    -- Resting sets
    sets.resting = {head="Twilight Helm",neck="Creed Collar",
        body="Twilight Mail",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        waist="Austerity Belt"}
    

    -- Idle sets
    sets.idle = {ammo="Iron Gobbet",
        head="Reverence Coronet +1",neck="Creed Collar",ear1="Creed Earring",ear2="Bloodgem Earring",
        body="Reverence Surcoat +1",hands="Reverence Gauntlets +1",ring1="Sheltered Ring",ring2="Meridian Ring",
        back="Fierabras's Mantle",waist="Flume Belt",legs="Crimson Cuisses",feet="Reverence Leggings"}

    sets.idle.Town = {main="Anahera Sword",ammo="Incantor Stone",
        head="Reverence Coronet +1",neck="Creed Collar",ear1="Creed Earring",ear2="Bloodgem Earring",
        body="Reverence Surcoat +1",hands="Reverence Gauntlets +1",ring1="Sheltered Ring",ring2="Meridian Ring",
        back="Fierabras's Mantle",waist="Flume Belt",legs="Crimson Cuisses",feet="Reverence Leggings"}
    
    sets.idle.Weak = {ammo="Iron Gobbet",
        head="Reverence Coronet +1",neck="Creed Collar",ear1="Creed Earring",ear2="Bloodgem Earring",
        body="Reverence Surcoat +1",hands="Reverence Gauntlets +1",ring1="Sheltered Ring",ring2="Meridian Ring",
        back="Fierabras's Mantle",waist="Flume Belt",legs="Crimson Cuisses",feet="Reverence Leggings"}
    
    sets.idle.Weak.Reraise = set_combine(sets.idle.Weak, sets.Reraise)
    
    
    --   Physical
    --     PDT
    --     Shield
    -- Defense sets
    --     HP
    --   Magical
    --     MDT
    --   Hybrid (on top of either physical or magical)
    --     Repulse
    --     Reraise
    --     RepulseReraise
    --   Custom
    --     Kheshig Blade
    
    sets.Repulse = {back="Repulse Mantle"}
    
    sets.defense.PDT = {ammo="Iron Gobbet",
        head="Reverence Coronet +1",neck="Twilight Torque",ear1="Creed Earring",ear2="Bloodgem Earring",
        body="Reverence Surcoat +1",hands="Cizin Mufflers",ring1=physical_darkring1,ring2=physical_darkring2,
        back="Shadow Mantle",waist="Flume Belt",legs="Reverence Breeches +1",feet="Whirlpool Greaves"}
    sets.defense.Shield = {main="Anahera Sword",ammo="Iron Gobbet",
        head="Reverence Coronet +1",neck="Twilight Torque",ear1="Creed Earring",ear2="Bloodgem Earring",
        body="Reverence Surcoat +1",hands="Cizin Mufflers",ring1=physical_darkring1,ring2=physical_darkring2,
        back="Weard Mantle",waist="Flume Belt",legs="Reverence Breeches +1",feet="Reverence Leggings"}
    sets.defense.HP = {ammo="Iron Gobbet",
        head="Reverence Coronet +1",neck="Lavalier +1",ear1="Creed Earring",ear2="Bloodgem Earring",
        body="Reverence Surcoat +1",hands="Reverence Gauntlets +1",ring1="K'ayres Ring",ring2="Meridian Ring",
        back="Weard Mantle",waist="Creed Baudrier",legs="Reverence Breeches +1",feet="Reverence Leggings"}
    -- To cap MDT with Shell IV (52/256), need 76/256 in gear. Current gear set is 77/256.
    -- Shellra V can provide 75/256. Could drop 9% from this set.  Dark Ring > Vexer Ring
    -- magic_breath_darkring1 vs vexer_ring
    sets.defense.MDT = {main="Anahera Sword",ammo="Demonry Stone",
        head="Reverence Coronet +1",neck="Twilight Torque",ear1="Creed Earring",ear2="Bloodgem Earring",
        body="Reverence Surcoat +1",hands="Reverence Gauntlets +1",ring1=vexer_ring,ring2="Shadow Ring",
        back="Engulfer Cape",waist="Creed Baudrier",legs="Reverence Breeches +1",feet="Caballarius Leggings"}

    sets.defense.PDT.Repulse = set_combine(sets.defense.PDT, sets.Repulse)
    sets.defense.Shield.Repulse = set_combine(sets.defense.Shield, sets.Repulse)
    sets.defense.HP.Repulse = set_combine(sets.defense.HP, sets.Repulse)
    sets.defense.MDT.Repulse = set_combine(sets.defense.MDT, sets.Repulse)

    sets.defense.PDT.Reraise = set_combine(sets.defense.PDT, sets.Reraise)
    sets.defense.Shield.Reraise = set_combine(sets.defense.Shield, sets.Reraise)
    sets.defense.HP.Reraise = set_combine(sets.defense.HP, sets.Reraise, {neck="Twilight Torque"})
    sets.defense.MDT.Reraise = set_combine(sets.defense.MDT, sets.Reraise, {ring1=magic_breath_darkring1})

    sets.defense.PDT.RepulseReraise = set_combine(sets.defense.PDT, sets.Reraise, sets.Repulse)
    sets.defense.Shield.RepulseReraise = set_combine(sets.defense.PDT, sets.Reraise, sets.Repulse)
    sets.defense.HP.RepulseReraise = set_combine(sets.defense.PDT, sets.Reraise, sets.Repulse, {neck="Twilight Torque"})
    sets.defense.MDT.RepulseReraise = set_combine(sets.defense.PDT, sets.Reraise, sets.Repulse, {ring1=magic_breath_darkring1})

    -- If using Kheshig Blade, have 50% PDT without the second ring:
    sets.defense.PDT['Kheshig Blade'] = set_combine(sets.defense.PDT, {ring2="Meridian Ring"})
    sets.defense.PDT.Repulse['Kheshig Blade'] = set_combine(sets.defense.PDT.Repulse)
    sets.defense.PDT.Reraise['Kheshig Blade'] = set_combine(sets.defense.PDT.Reraise)
    sets.defense.PDT.RepulseReraise['Kheshig Blade'] = set_combine(sets.defense.PDT.RepulseReraise)
    
    
    sets.Kiting = {legs="Crimson Cuisses"}

	sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        head="Yaoyotl Helm",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Karieyh Haubert +1",hands="Cizin Mufflers",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Atheling Mantle",waist="Zoran's Belt",legs="Cizin Breeches",feet="Whirlpool Greaves"}

    sets.engaged.Acc = {
        head="Yaoyotl Helm",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Cizin Mail",hands="Buremte Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Weard Mantle",waist="Zoran's Belt",legs="Cizin Breeches",feet="Whirlpool Greaves"}

    sets.engaged.Shield = {
        head="Yaoyotl Helm",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Reverence Surcoat +1",hands="Reverence Gauntlets +1",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Weard Mantle",waist="Flume Belt",legs="Reverence Breeches +1",feet="Reverence Leggings"}

    sets.engaged.DW = {
        head="Yaoyotl Helm",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Karieyh Haubert +1",hands="Cizin Mufflers",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Atheling Mantle",waist="Zoran's Belt",legs="Cizin Breeches",feet="Whirlpool Greaves"}

    sets.engaged.DW.Acc = {
        head="Yaoyotl Helm",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Cizin Mail",hands="Buremte Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Weard Mantle",waist="Zoran's Belt",legs="Cizin Breeches",feet="Whirlpool Greaves"}


    sets.buff.Cover = {head="Reverence Coronet +1", body="Valor Surcoat +2"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Don't gearswap for weaponskills when Defense is on.
    if spell.type == 'WeaponSkill' and state.Defense.Active then
        eventArgs.handled = true
    end

	if state.Buff[spell.english] ~= nil then
		state.Buff[spell.english] = true
	end
end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)

end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if state.Buff[spell.english] ~= nil then
		state.Buff[spell.english] = not spell.interrupted or buffactive[spell.english]
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	if player.mpp < 51 then
	    idleSet = set_combine(idleSet, sets.latent_refresh)
	end
	
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for change events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
    if field == 'HybridDefenseMode' then
        classes.CustomDefenseGroups:clear()
        classes.CustomDefenseGroups:append(new_value)
    end
end


-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if state.Buff[buff] ~= nil then
		state.Buff[buff] = gain
	end
end


-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_defense_mode()
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_defense_mode()
    if player.equipment.main == 'Kheshig Blade' and not classes.CustomDefenseGroups:contains('Kheshig Blade') then
        classes.CustomDefenseGroups:append('Kheshig Blade')
    end
    
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        if player.equipment.sub and not player.equipment.sub:endswith('Shield') and
           player.equipment.sub ~= 'Aegis' and player.equipment.sub ~= 'Ochain' then
            state.CombatForm = 'DW'
        else
            state.CombatForm = nil
        end
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(5, 2)
    elseif player.sub_job == 'NIN' then
        set_macro_page(4, 2)
    elseif player.sub_job == 'RDM' then
        set_macro_page(3, 2)
    else
        set_macro_page(2, 2)
    end
end

