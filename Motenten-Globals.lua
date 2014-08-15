-------------------------------------------------------------------------------------------------------------------
-- An example of setting up user-specific global handling of certain events.
-- This is for personal globals, as opposed to library globals.
-------------------------------------------------------------------------------------------------------------------

sets.reive = {neck="Arciela's Grace +1"}

-- Global intercept on midcast.
function user_post_midcast(spell, action, spellMap, eventArgs)
    if buffactive['Reive Mark'] and (spell.skill == 'Elemental Magic' or spellMap == 'Cure' or spellMap == 'Curaga') then
        equip(sets.reive)
    end
end

function user_customize_idle_set(idleSet)
    if buffactive['Reive Mark'] then
        idleSet = set_combine(idleSet, sets.reive)
    end
    return idleSet
end



-------------------------------------------------------------------------------------------------------------------
-- Test function to use to avoid modifying library files.
-------------------------------------------------------------------------------------------------------------------

function user_test(params)

end

