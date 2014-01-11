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

	if book then
		if not tonumber(book) then error('Macro page: Book not a valid number ('..tostring(book)..')', 2) end
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
	
	-- init a new eventArgs
	local eventArgs = {handled = false, pcTargetMode = 'default', selectNPCTargets = false}

	-- Allow the job to do custom handling
	-- They can completely handle it, or set one of the secondary eventArgs vars to selectively
	-- override the default state vars.
	if job_auto_change_target then
		job_auto_change_target(spell, action, spellMap, eventArgs)
	end
	
	-- If the job handled it, we're done.
	if eventArgs.handled then
		return
	end
			

	local canUseOnPlayer = spell.validtarget.Self or spell.validtarget.Player or spell.validtarget.Party or spell.validtarget.Ally or spell.validtarget.NPC

	local newTarget = ''
	
	-- For spells that we can cast on players:
	if canUseOnPlayer then
		if eventArgs.pcTargetMode == 'stal' or state.PCTargetMode == 'stal' then
			-- Use <stal> if possible, otherwise fall back to <stpt>.
			if spell.validtarget.Ally then
				newTarget = '<stal>'
			elseif spell.validtarget.Party then
				newTarget = '<stpt>'
			end
		elseif eventArgs.pcTargetMode == 'stpt' or state.PCTargetMode == 'stpt' then
			-- Even ally-possible spells are limited to the current party.
			if spell.validtarget.Ally or spell.validtarget.Party then
				newTarget = '<stpt>'
			end
		elseif eventArgs.pcTargetMode == 'stpc' or state.PCTargetMode == 'stpc' then
			-- If it's anything other than a self-only spell, can change to <stpc>.
			if spell.validtarget.Player or spell.validtarget.Party or spell.validtarget.Ally or spell.validtarget.NPC then
				newTarget = '<stpc>'
			end
		end
	-- For spells that can be used on enemies:
	elseif spell.validtarget.Enemy then
		if eventArgs.selectNPCTargets or state.SelectNPCTargets then
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


-------------------------------------------------------------------------------------------------------------------
-- Utility function for automatically adjusting the waltz spell being used to match the HP needs.
-------------------------------------------------------------------------------------------------------------------


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
