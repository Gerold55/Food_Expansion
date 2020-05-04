
local S = farming.intllib

-- corn seeds
minetest.register_node("farming:seed_corn", {
	description = S("Corn Kernels"),
	tiles = {"farming_corn_kernels.png"},
	inventory_image = "farming_corn_kernels.png",
	wield_image = "farming_corn_kernels.png",
	drawtype = "signlike",
	groups = {seed = 1, snappy = 3, attached_node = 1},
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	sunlight_propagates = true,
	selection_box = farming.select,
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:corn_1")
	end,
})

-- harvested corn
minetest.register_craftitem("farming:corn", {
	description = S("Corn"),
	inventory_image = "farming_corn.png",
	groups = {food_corn = 1, flammable = 2},
})

-- corn on the cob (texture by TenPlus1)
minetest.register_craftitem("farming:corn_cob", {
	description = S("Corn on the Cob"),
	inventory_image = "farming_corn_cob.png",
	groups = {food_corn_cooked = 1, flammable = 2},
	on_use = minetest.item_eat(5),
})

-- corn definition
local crop_def = {
	drawtype = "plantlike",
	tiles = {"farming_corn_1.png"},
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 3,
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	drop = "",
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults()
}

-- stage 1
minetest.register_node("farming:corn_1", table.copy(crop_def))

-- stage 2
crop_def.tiles = {"farming_corn_2.png"}
minetest.register_node("farming:corn_2", table.copy(crop_def))

-- stage 6
crop_def.tiles = {"farming_corn_3.png"}
crop_def.drop = {
	items = {
		{items = {'farming:corn'}, rarity = 2},
		{items = {'farming:seed_corn'}, rarity = 1},
	}
}
minetest.register_node("farming:corn_3", table.copy(crop_def))

-- stage 7 (final)
crop_def.tiles = {"farming_corn_4.png"}
crop_def.groups.growing = 0
crop_def.drop = {
	items = {
		{items = {'farming:corn'}, rarity = 1},
		{items = {'farming:corn'}, rarity = 3},
		{items = {'farming:seed_corn'}, rarity = 1},
		{items = {'farming:seed_corn'}, rarity = 3},
	}
}
minetest.register_node("farming:corn_4", table.copy(crop_def))

-- add to registered_plants
farming.registered_plants["farming:corn"] = {
	crop = "farming:corn",
	seed = "farming:seed_corn",
	minlight = 13,
	maxlight = 15,
	steps = 7
}

-- Fuel

minetest.register_craft({
	type = "fuel",
	recipe = "farming:corn",
	burntime = 1,
})

minetest.register_craft({
	type = "cooking",
	cooktime = 10,
	output = "farming:corn_cob",
	recipe = "farming:corn"
})
