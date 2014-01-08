-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- NOTE: This is a work in progress, experimenting.  Expect it to change frequently, and maybe include debug stuff.

-- Last Modified: 12/31/2013 4:51:33 AM

-- IMPORTANT: Make sure to also get the Mote-Include.lua file to go with this.

function get_sets()
	-- Load and initialize the include file.
	include('Mote-Include.lua')
	init_include()
	
	-- Options: Override default values
	options.OffenseModes = {'Normal'}
	options.DefenseModes = {'Normal'}
	options.WeaponskillModes = {'Normal'}
	options.IdleModes = {'Normal'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'PDT'}
	options.MagicalDefenseModes = {'MDT'}

	state.Defense.PhysicalMode = 'PDT'
	
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs
	
	-- Fast cast sets for spells
	
	sets.precast.FC = {
		head="Nahtirah Hat",ear2="Loquacious Earring",
		ring1="Prolix Ring",
		back="Swith Cape",waist="Witful Belt",legs="Orvail Pants",feet="Chelona Boots +1"}

	sets.precast.FC.Cure = {
		head="Nahtirah Hat",ear2="Loquacious Earring",
		ring1="Prolix Ring",
		back="Pahtli Cape",waist="Witful Belt",legs="Orvail Pants",feet="Chelona Boots +1"}

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Flash Nova'] = {
		head="Hagondes Hat",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Hagondes Coat",hands="Yaoyotl Gloves",ring2="Strendu Ring",
		back="Toro Cape",waist="Snow Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

	sets.precast.WS['Starlight'] = {ear2="Moonshade Earring"}

	sets.precast.WS['Moonlight'] = {ear2="Moonshade Earring"}
	
	
	-- Midcast Sets
	
	sets.midcast.FastRecast = {
		head="Zelus Tiara",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Bokwus Gloves",ring1="Prolix Ring",
		back="Swith Cape",waist="Goading Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}
		
	sets.midcast.Geomancy = {range="Matre Bell"}

	sets.midcast.Cure = {
		body="Heka's Kalasiris",hands="Bokwus Gloves",
		back="Swith Cape",legs="Nares Trews",feet="Hagondes Sabots"}

	sets.midcast.Protectra = {ring1="Sheltered Ring"}

	sets.midcast.Shellra = {ring1="Sheltered Ring"}

	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {head="Nefer Khat +1",neck="Wiglen Gorget",
		body="Heka's Kalasiris",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		legs="Nares Trews",feet="Chelona Boots +1"}
	

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

	sets.idle.Town = {range="Matre Bell",
		head="Nefer Khat +1",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Heka's Kalasiris",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Umbra Cape",waist="Goading Belt",legs="Nares Trews",feet="Herald's Gaiters"}
	
	sets.idle.Field = {range="Matre Bell",
		head="Nefer Khat +1",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Heka's Kalasiris",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Umbra Cape",waist="Goading Belt",legs="Nares Trews",feet="Herald's Gaiters"}

	sets.idle.Weak = {range="Matre Bell",
		head="Nefer Khat +1",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Heka's Kalasiris",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Umbra Cape",waist="Goading Belt",legs="Nares Trews",feet="Herald's Gaiters"}
	
	-- Defense sets

	sets.defense.PDT = {range="Matre Bell",
		head="Hagondes Hat",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Dark Ring",ring2="Dark Ring",
		back="Umbra Cape",waist="Goading Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

	sets.defense.MDT = {range="Matre Bell",
		head="Nahtirah Hat",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Dark Ring",ring2="Dark Ring",
		back="Umbra Cape",waist="Goading Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

	sets.Kiting = {feet="Herald's Gaiters"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {range="Matre Bell",
		head="Zelus Tiara",neck="Peacock Charm",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Hagondes Coat",hands="Bokwus Gloves",ring1="Rajas Ring",ring2="Paguroidea Ring",
		back="Umbra Cape",waist="Goading Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}


	windower.send_command('input /macro book 6;wait .1;input /macro set 1')
	gearswap_binds_on_load()

	windower.send_command('bind ^- gs c toggle target')
	windower.send_command('bind ^= gs c cycle targetmode')
end

-- Called when this job file is unloaded (eg: job change)
function file_unload()
	--spellcast_binds_on_unload()
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)

end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)

end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		-- Default base equipment layer of fast recast.
		equip(sets.midcast.FastRecast)

		-- If the spells don't get enhanced by skill or whatever, don't bother equipping gear.
		if classes.NoSkillSpells[spell.english] or classes.NoSkillSpells[spellMap] then
			if spellMap ~= 'Protectra' and spellMap ~= 'Shellra' then
				eventArgs.handled = true
			end
		end
	end
end

-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)

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

end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	--handle_equipping_gear(player.status)
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)

end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)

end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state()

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

