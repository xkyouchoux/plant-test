local util = require('util')

local plant_emissions = { pollution = 0.001 } -- pollution while plant is out
local plant_harvest_emissions = { pollution = 15 } -- pollution when plant is harvested
local plant_flags = {"placeable-neutral", "placeable-off-grid"}

data:extend({
    {
        type = "plant",
        name = "salts",
        icon = "__base__/graphics/icons/sulfur.png",
        flags = plant_flags,
        minable =
        {
            mining_time = 0.5,
            results = {
                {type = "item", name = "sulfur", amount = 2},
                {type = "item", name = "iron-ore", amount = 1, probability = .5},
                {type = "item", name = "copper-ore", amount_min = 0, amount_max = 1},
            }
        },
        growth_ticks = 1 * minute, -- growth time in ticks, 60 ticks = 1 second
        harvest_emissions = plant_harvest_emissions,
        emissions_per_second = plant_emissions,
        max_health = 50,
        collision_box = {{-0.5, -0.5}, {0.5, 0.5}}, -- change this to fit your texture
        --collision_mask = {layers={player=true, ground_tile=true, train=true}},
        selection_box = {{-0.5, -0.5}, {0.5, 0.5}}, -- change this to fit your texture
        --drawing_box_vertical_extension = 0.8,
        subgroup = "trees", -- can be what ever
        order = "salts", -- can be what ever
        impact_category = "tree", -- can be what ever
        pictures = { -- can add more for more variation
            {size = 64, filename = "__base__/graphics/icons/sulfur.png", scale = 1.0, mipmap_count = 4} 
        },
        agricultural_tower_tint =
        {
            primary = {r = 1, g = 1, b = 0, a = 1.000},
            secondary = {r = 1, g = 1, b = 0, a = 1.000}, 
        },
        autoplace =
        {
            probability_expression = 0,
            tile_restriction = {"landfill"} -- change this to set what tiles it can be placed on
        },
        map_color = {255, 255, 0}, -- can be what ever
    }
})