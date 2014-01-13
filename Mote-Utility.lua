-------------------------------------------------------------------------------------------------------------------
-- General utility functions that can be used by any job files.  Outside the scope of what the main
-- include file deals with.
-------------------------------------------------------------------------------------------------------------------

local utility = {}

-------------------------------------------------------------------------------------------------------------------
-- Function to easily change to a given macro set or book.  Book value is optional.
-------------------------------------------------------------------------------------------------------------------

function utility.set_macro_page(set,book)
	if not tonumber(set) then error('Macro page: Set not a valid number ('..tostring(set)..')', 2) end
	if set < 1 or set > 10 then error('Macro page: Set can only be between 1 and 10', 2) end

	if book then
		if not tonumber(book) then error('Macro page: Book not a valid number ('..tostring(book)..')', 2) end
		if book < 1 or book > 20 then error('Macro page: Book can only be between 1 and 20', 2) end
		windower.send_command('input /macro book '..tostring(book)..';wait .1;input /macro set '..tostring(set))
	else
		windower.send_command('input /macro set '..tostring(set))
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility function for changing target types in an automatic manner.
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
			

	local canUseOnPlayer = spell.validtarget.Self or spell.validtarget.Player or spell.validtarget.Party or spell.validtarget.Ally or spell.validtarget.NPC

	local newTarget = ''
	
	-- For spells that we can cast on players:
	if canUseOnPlayer then
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
	elseif spell.validtarget.Enemy then
		if selectNPCTargets then
			-- Note: this means macros should be written for <t>, and it will change to <stnpc>
			-- if the flag is set.  It won't change <stnpc> back to <t>.
			newTarget = '<stnpc>'
		end
	end
	
	-- If a new target was selected and is different from the original, call the change function.
	if newTarget ~= '' and newTarget ~= spell.target.raw then
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

	-- Can only calculate healing amounts for ourself.
	if spell.target.type ~= "SELF" then
		return
	end
	
	local missingHP = player.max_hp - player.hp
	local newWaltz
	
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
	
	local tpCost = waltzTPCost[newWaltz]
	
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
		
		add_to_chat(122, 'Insufficient TP ['..tostring(player.tp)..']. Downgrading to '..newWaltz..'.')
	end

	
	if newWaltz ~= spell.english then
		send_command('wait 0.03;input /ja "'..newWaltz..'" <me>')
		eventArgs.cancel = true
		return
	end

	add_to_chat(122,'Using '..newWaltz..' to cure '..tostring(missingHP)..' HP.')
end



-- Function to get the current weather intensity: 0 for none, 1 for single weather, 2 for double weather.
function utility.get_weather_intensity()
	if world.weather_id <= 3 then
		return 0
	else
		return (world.weather_id % 2) + 1
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions for vars or other data manipulation.
-------------------------------------------------------------------------------------------------------------------

-- Utility for splitting strings.  Obsoleted by revised library function.
function utility.split(msg, delim)
	local result = T{}

	-- If no delimiter specified, just extract alphabetic words
	if not delim or delim == '' then
		for word in msg:gmatch("%a+") do
			result[#result+1] = word
		end
	else
		-- If the delimiter isn't in the message, just return the whole message
		if string.find(msg, delim) == nil then
			result[1] = msg
		else
			-- Otherwise use a capture pattern based on the delimiter to
			-- extract text chunks.
			local pat = "(.-)" .. delim .. "()"
			local lastPos
			for part, pos in msg:gmatch(pat) do
				result[#result+1] = part
				lastPos = pos
			end
			-- Handle the last field
			if #msg > lastPos then
				result[#result+1] = msg:sub(lastPos)
			end
		end
	end
	
	return result
end


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
