-------------------------------------------------------------------------------------------------------------------
-- General utility functions that can be used by any job files.  Outside the scope of what the main
-- include file deals with.
-------------------------------------------------------------------------------------------------------------------

local utility = {}

-------------------------------------------------------------------------------------------------------------------
-- Function to easily change to a given macro set or book.  Book value is optional.
-------------------------------------------------------------------------------------------------------------------

function utility.set_macro_page(set,book)
	if not tonumber(set) then
		add_to_chat(123,'Error setting macro page: Set is not a valid number ('..tostring(set)..').')
		return
	end
	if set < 1 or set > 10 then
		add_to_chat(123,'Error setting macro page: Macro set ('..tostring(set)..') must be between 1 and 10.')
		return
	end

	if book then
		if not tonumber(book) then
			add_to_chat(123,'Error setting macro page: book is not a valid number ('..tostring(book)..').')
			return
		end
		if book < 1 or book > 20 then
			add_to_chat(123,'Error setting macro page: Macro book ('..tostring(book)..') must be between 1 and 20.')
			return
		end
		windower.send_command('input /macro book '..tostring(book)..';wait .1;input /macro set '..tostring(set))
	else
		windower.send_command('input /macro set '..tostring(set))
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions for changing target types and spells in an automatic manner.
-------------------------------------------------------------------------------------------------------------------

function utility.auto_change_target(spell, action, spellMap)
	-- Do not modify target for spells where we get <lastst> or <me>.
	if spell.target.raw == ('<lastst>') or spell.target.raw == ('<me>') then
		return
	end
	
	-- init a new eventArgs with current values
	local eventArgs = {handled = false, PCTargetMode = state.PCTargetMode, SelectNPCTargets = state.SelectNPCTargets}

	-- Allow the job to do custom handling, or override the default values.
	-- They can completely handle it, or set one of the secondary eventArgs vars to selectively
	-- override the default state vars.
	if job_auto_change_target then
		job_auto_change_target(spell, action, spellMap, eventArgs)
	end
	
	-- If the job handled it, we're done.
	if eventArgs.handled then
		return
	end
	
	local pcTargetMode = eventArgs.PCTargetMode
	local selectNPCTargets = eventArgs.SelectNPCTargets
	
	local canUseOnPlayer = spell.validtarget and 
		(spell.validtarget.Self or spell.validtarget.Player or spell.validtarget.Party or spell.validtarget.Ally or spell.validtarget.NPC)

	local newTarget
	
	-- For spells that we can cast on players:
	if canUseOnPlayer and pcTargetMode ~= 'default' then
		if pcTargetMode == 'stal' then
			-- Use <stal> if possible, otherwise fall back to <stpt>.
			if spell.validtarget.Ally then
				newTarget = '<stal>'
			elseif spell.validtarget.Party then
				newTarget = '<stpt>'
			end
		elseif pcTargetMode == 'stpt' then
			-- Even ally-possible spells are limited to the current party.
			if spell.validtarget.Ally or spell.validtarget.Party then
				newTarget = '<stpt>'
			end
		elseif pcTargetMode == 'stpc' then
			-- If it's anything other than a self-only spell, can change to <stpc>.
			if spell.validtarget.Player or spell.validtarget.Party or spell.validtarget.Ally or spell.validtarget.NPC then
				newTarget = '<stpc>'
			end
		end
	-- For spells that can be used on enemies:
	elseif spell.validtarget and spell.validtarget.Enemy and selectNPCTargets then
		-- Note: this means macros should be written for <t>, and it will change to <stnpc>
		-- if the flag is set.  It won't change <stnpc> back to <t>.
		newTarget = '<stnpc>'
	end
	
	-- If a new target was selected and is different from the original, call the change function.
	if newTarget and newTarget ~= spell.target.raw then
		change_target(newTarget)
	end
end


-- Utility function for automatically adjusting the waltz spell being used to match the HP needs.
-- Handle spell changes before attempting any precast stuff.
-- Returns two values on completion:
-- 1) bool of whether the original spell was cancelled
-- 2) bool of whether the spell was changed to something new
function utility.refine_waltz(spell, action, spellMap, eventArgs)
	if spell.type ~= 'Waltz' then
		return
	end
	
	-- Don't modify anything for Healing Waltz or Divine Waltzes
	if spell.name == "Healing Waltz" or spell.name == "Divine Waltz" or spell.name == "Divine Waltz II" then
		return
	end

	local newWaltz = spell.english
	
	local missingHP = 0
	local targ
	
	-- If curing someone in our alliance, we can get their HP
	if spell.target.type == "SELF" then
		targ = alliance[1][1]
		missingHP = player.max_hp - player.hp
	elseif spell.target.isallymember then
		targ = find_player_in_alliance(spell.target.name)
		local est_max_hp = targ.hp / (targ.hpp/100)
		missingHP = math.floor(est_max_hp - targ.hp)
	end
	
	-- If we can estimate missing HP, we can adjust the preferred tier used.
	if targ then
		if player.main_job == 'DNC' then
			if missingHP < 40 then
				-- not worth curing
				add_to_chat(122,'Full HP!')
				eventArgs.cancel = true
				return
			elseif missingHP < 200 then
				newWaltz = 'Curing Waltz'
			elseif missingHP < 500 then
				newWaltz = 'Curing Waltz II'
			elseif missingHP < 1100 then
				newWaltz = 'Curing Waltz III'
			elseif missingHP < 1500 then
				newWaltz = 'Curing Waltz IV'
			else
				newWaltz = 'Curing Waltz V'
			end
		elseif player.sub_job == 'DNC' then
			if missingHP < 40 then
				-- not worth curing
				add_to_chat(122,'Full HP!')
				eventArgs.cancel = true
				return
			elseif missingHP < 150 then
				newWaltz = 'Curing Waltz'
			elseif missingHP < 300 then
				newWaltz = 'Curing Waltz II'
			else
				newWaltz = 'Curing Waltz III'
			end
		else
			return
		end
	end

	local waltzTPCost = {['Curing Waltz'] = 20,['Curing Waltz II'] = 35,['Curing Waltz III'] = 50,['Curing Waltz IV'] = 65,['Curing Waltz V'] = 80}
	local tpCost = waltzTPCost[newWaltz]
	local downgrade
	
	-- Downgrade the spell to what we can afford
	if player.tp < tpCost and not buffactive.trance then
		--[[ Costs:
			Curing Waltz:     20 TP
			Curing Waltz II:  35 TP
			Curing Waltz III: 50 TP
			Curing Waltz IV:  65 TP
			Curing Waltz V:   80 TP
			Divine Waltz:     40 TP
			Divine Waltz II:  80 TP
		--]]
		
		if player.tp < 20 then
			add_to_chat(122, 'Insufficient TP ['..tostring(player.tp)..']. Cancelling.')
			eventArgs.cancel = true
			return
		elseif player.tp < 35 then
			newWaltz = 'Curing Waltz'
		elseif player.tp < 50 then
			newWaltz = 'Curing Waltz II'
		elseif player.tp < 65 then
			newWaltz = 'Curing Waltz III'
		elseif player.tp < 80 then
			newWaltz = 'Curing Waltz IV'
		end
		
		downgrade = 'Insufficient TP ['..tostring(player.tp)..']. Downgrading to '..newWaltz..'.'
	end

	
	if newWaltz ~= spell.english then
		send_command('wait 0.03;input /ja "'..newWaltz..'" '..tostring(spell.target.raw))
		if downgrade then
			add_to_chat(122, downgrade)
		end
		eventArgs.cancel = true
		return
	end

	if missingHP > 0 then
		add_to_chat(122,'Trying to cure '..tostring(missingHP)..' HP using '..newWaltz..'.')
	end
end


function utility.find_player_in_alliance(name)
	for i,v in ipairs(alliance) do
		for k,p in ipairs(v) do
			if p.name == name then
				return p
			end
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Environment utility functions.
-------------------------------------------------------------------------------------------------------------------

-- Function to get the current weather intensity: 0 for none, 1 for single weather, 2 for double weather.
function utility.get_weather_intensity()
	if world.weather_id <= 3 then
		return 0
	else
		return (world.weather_id % 2) + 1
	end
end


function utility.is_trust_party()
	-- Check if we're solo
	if party.count == 1 then
		return false
	end
	
	-- Can call a max of 3 Trust NPCs, so parties larger than that are out.
	if party.count > 4 then
		return false
	end

	-- If we're in an alliance, can't be a Trust party.
	if alliance[2].count > 0 or alliance[3].count > 0 then
		return false
	end
	
	-- Check that, for each party position aside from our own, the party
	-- member has one of the Trust NPC names, and that those party members
	-- are flagged is_npc.
	for i = 2,4 do
		if party[i] then
			if not npcs.Trust:contains(party[i].name) then
				return false
			end
			if party[i].mob and party[i].mob.is_npc == false then
				return false
			end
		end
	end
	
	return true
end


-------------------------------------------------------------------------------------------------------------------
-- Gear utility functions.
-------------------------------------------------------------------------------------------------------------------

-- Pick an item to use based on required elemental properties.
-- Cycles through the list of all elements until it matches one of the
-- provided elements to search, and checks whether an appropriate item
-- of that type exists in inventory.  If so, uses that.
-- It may optionally provide a list of valid elements, rather than
-- searching all possible elements.
-- Returns the item var if it found a match and the item was in inventory.
function utility.select_elemental_item(itemvar, itemtype, elements_to_search, valid_elements)
	local elements_list = valid_elements or elements.list
	
	for _,element in ipairs(elements_list) do
		if elements_to_search:contains(element) and player.inventory[gear_map[itemtype][element]] then
			itemvar.name = gear_map[itemtype][element]
			return itemvar
		end
	end
end


-- Function to get an appropriate gorget and belt for the current weaponskill.
function utility.set_weaponskill_gorget_belt(spell)
	if spell.type ~= 'WeaponSkill' then
		return
	end

	-- Get the union of all the skillchain elements for the weaponskill
	local weaponskill_elements = S{}:
		union(skillchain_elements[spell.wsA]):
		union(skillchain_elements[spell.wsB]):
		union(skillchain_elements[spell.wsC])
	
	-- Hook to the default gear vars, if available.
	local gorget = gear.ElementalGorget or {name=""}
	gorget.name = gear.default.weaponskill_neck or ""
	local belt = gear.ElementalBelt or {name=""}
	belt.name = gear.default.weaponskill_waist or ""
	
	select_elemental_item(gorget, 'Gorget', weaponskill_elements)
	select_elemental_item(belt, 'Belt', weaponskill_elements)
	
	return gorget, belt
end


-- Function to get an appropriate obi/cape/ring for the current spell.
function utility.set_spell_obi_cape_ring(spell)
	if spell.element == 'None' then
		return
	end
	
	local world_elements = S{}
	world_elements:add(world.weather_element)
	world_elements:add(world.day_element)
	
	local obi = gear.ElementalObi or {name=""}
	obi.name = gear.default.obi_waist or ""
	local cape = gear.ElementalCape or {name=""}
	cape.name = gear.default.obi_back or ""
	local ring = gear.ElementalRing or {name=""}
	ring.name = gear.default.obi_ring or ""
	
	local got_obi = select_elemental_item(obi, 'Obi', S{spell.element}, world_elements)
	
	if got_obi then
		if player.inventory['Twilight Cape'] then
			cape.name = "Twilight Cape"
		end
		if player.inventory['Zodiac Ring'] and spell.english ~= 'Impact' and
			not S{'DivineMagic','DarkMagic','HealingMagic'}:contains(spell.skill) then
			ring.name = "Zodiac Ring"
		end
	end
	
	return obi, cape, ring
end


-- Function to get an appropriate gorget and belt for the current weaponskill.
function utility.set_fastcast_staff(spell)
	if spell.action_type ~= 'Magic' then
		return
	end

	local staff = gear.FastcastStaff or {name=""}
	
	if gear_map['FastcastStaff'][spell.element] and player.inventory[gear_map['FastcastStaff'][spell.element]] then
		staff.name = gear_map['FastcastStaff'][spell.element]
	else
		staff.name = gear.default.fastcast_staff or ""
	end

	return staff
end


-- Function to get an appropriate gorget and belt for the current weaponskill.
function utility.set_recast_staff(spell)
	if spell.action_type ~= 'Magic' then
		return
	end

	local staff = gear.RecastStaff or {name=""}
	
	if gear_map['RecastStaff'][spell.element] and player.inventory[gear_map['RecastStaff'][spell.element]] then
		staff.name = gear_map['RecastStaff'][spell.element]
	else
		staff.name = gear.default.recast_staff or ""
	end

	return staff
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions for including local user files.
-------------------------------------------------------------------------------------------------------------------

-- Attempt to load user gear files in place of default gear sets.
-- Return true if one exists and was loaded.
function utility.load_user_gear(job)
	if not job then return false end
	
	-- filename format example for user-local files: whm_gear.lua, or playername_whm_gear.lua
	local filenames = {player.name..'_'..job..'_gear.lua', job..'_gear.lua'}

	if optional_include(filenames) then
		if init_user_gear_sets then
			init_user_gear_sets()
			return true
		end
	end
end

-- Attempt to include user-globals.  Return true if it exists and was loaded.
function utility.load_user_globals()
	local filenames = {'user-globals.lua'}

	return optional_include(filenames)
end

-- Optional version of include().  If file does not exist, does not
-- attempt to load, and does not throw an error.
-- filenames takes an array of possible file names to include and checks
-- each one.
function utility.optional_include(filenames)
	for _,v in pairs(filenames) do
		local path = gearswap.pathsearch({v})
		if path then
			include(v)
			return true
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions for vars or other data manipulation.
-------------------------------------------------------------------------------------------------------------------

-- Invert a table such that the keys are values and the values are keys.
-- Use this to look up the index value of a given entry.
function utility.invert_table(t)
	if t == nil then error('Attempting to invert table, received nil.', 2) end
	
	local i={}
	for k,v in pairs(t) do 
		i[v] = k
	end
	return i
end

-- Gets sub-tables based on baseSet from the string str that may be in dot form
-- (eg: baseSet=sets, str='precast.FC', this returns sets.precast.FC).
function utility.get_expanded_set(baseSet, str)
	local cur = baseSet
	for i in str:gmatch("[^.]+") do
		cur = cur[i]
	end
	
	return cur
end



return utility
