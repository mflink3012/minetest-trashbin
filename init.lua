--[[

Trashbin for Minetest

Adds a trashbin to the current inventory-menu.

]]--

local modName = minetest.get_current_modname();

local trashInv = minetest.create_detached_inventory("trash", {
	on_put = function(inv, toList, toIndex, stack, player)
		inv:set_stack(toList, toIndex, {})
	end
})

trashInv:set_size("main", 1)

minetest.register_on_joinplayer(function(player)
	if minetest.setting_getbool("creative_mode") or minetest.check_player_privs(player:get_player_name(), {creative = true}) then
		return
	end

	minetest.after(1, function()
		local formspec = player:get_inventory_formspec()
			.. " list[detached:trash;main;0,1.5;1,1;]"
                        .. " image[0.075,1.6;0.8,0.8;creative_trash_icon.png]"
		player:set_inventory_formspec(formspec)
		minetest.log("action", "[mod/" .. modName .. "] " .. formspec)
	end)
end)

minetest.log("action", "[mod/" .. modName .. "] loaded.")