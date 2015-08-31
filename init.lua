--[[

Lost and Found [lostandfound]
==========================

A mod with a new mechanic for item loss after death

Copyright (C) 2015 Ben Deutsch <ben@bendeutsch.de>

License
-------

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
USA

]]


lostandfound = {

    -- configuration
    config = {
        tick_time = 1.0,
        found_inv_size = 2 * 8,
        lost_inv_size = 8 * 8,
    },

    -- global things
    time_next_tick = 0.0,
}
local M = lostandfound
local C = lostandfound.config


minetest.register_on_joinplayer(function(player)
    local inv = player:get_inventory()
    inv:set_size('lostandfound:found', C.found_inv_size)
    inv:set_size('lostandfound:lost',  C.lost_inv_size)
end)

minetest.register_globalstep(function(dtime)
    M.time_next_tick = M.time_next_tick - dtime
    while M.time_next_tick < 0.0 do
        M.time_next_tick = M.time_next_tick + C.tick_time
        for _,player in ipairs(minetest.get_connected_players()) do
            local inv = player:get_inventory()
            local index = math.random(inv:get_size('lostandfound:lost'))
            --print ("Trying to change index " .. index)
            local stack = inv:get_stack('lostandfound:lost', index)
            if not stack:is_empty() then
                --print("Found " .. stack:to_string())
                stack = inv:add_item('lostandfound:found', stack)
                --print("Left over: " .. stack:to_string())
                inv:set_stack('lostandfound:lost', index, stack)
            end
        end
    end
end)

minetest.register_node('lostandfound:found_chest', {
    description = 'Lost and Found',
    tiles = {
		"lostandfound_foundchest.png"
    },
    paramtype2 = 'facedir',
    groups = { choppy=2, oddly_breakable_by_hand=2 },
    on_construct = function(pos)
        -- TODO: move to on_right_click?
        minetest.get_meta(pos):set_string("formspec",[[
            size[8,7.5;]
            label[0,0;We found some of your things:]
            list[current_player;lostandfound:found;0,0.5;8,2;]
            label[0,3;Inventory]
            list[current_player;main;0,3.5;8,4;]
        ]]
        ) 
    end,
})

minetest.register_node('lostandfound:lost_chest', {
    description = 'Lost and Found debug',
    tiles = {
		"lostandfound_lostchest.png",
    },
    paramtype2 = 'facedir',
    groups = { choppy=2, oddly_breakable_by_hand=2 },
    on_construct = function(pos)
        -- TODO: move to on_right_click?
        minetest.get_meta(pos):set_string("formspec",[[
            size[8,8.5;]
            label[0,0;These are still lost:]
            list[current_player;lostandfound:lost;0,0.5;8,8;]
        ]]
        ) 
    end,
})

minetest.register_on_dieplayer(function(player)
    local inv = player:get_inventory() 
	local pos = player:getpos()

    --print("Died!")
    for _,slot in ipairs({ "main", "craft" }) do
        --print("Processing slot " .. slot)
        for i, stack in ipairs(inv:get_list(slot)) do
            --print("Adding " .. stack:to_string())
            -- add and return rest
            stack = inv:add_item("lostandfound:lost", stack)
            if not stack:is_empty() then
                -- if there is a rest (can't be added), drop here
                --print("Dropping " .. stack:to_string())
                minetest.add_item(pos, stack)
            end
        end
        inv:set_list(slot, {})
    end
end)
