
local item_sounds = require("__base__.prototypes.item_sounds")
local hit_effects = require ("__base__.prototypes.entity.hit-effects")
local sounds = require ("__base__.prototypes.entity.sounds")

local graphics = "__snouz-big-solar-panel__/graphics"
local ENTITYPATH = graphics .. "/entity/"


data:extend(
{
  {
    type = "item",
    name = "big-solar-panel",
    icon = graphics .. "/icons/big-solar-panel.png",
    subgroup = "energy",
    order = "d[solar-panel]-ba[big-solar-panel]",
    inventory_move_sound = item_sounds.electric_large_inventory_move,
    pick_sound = item_sounds.electric_large_inventory_pickup,
    drop_sound = item_sounds.electric_large_inventory_move,
    place_result = "big-solar-panel",
    stack_size = 20,
    weight = 1000 * kg
  },

  {
    type = "recipe",
    name = "big-solar-panel",
    energy_required = 200,
    enabled = false,
    ingredients =
    {
      {type = "item", name = "solar-panel", amount = 60},
      {type = "item", name = "medium-electric-pole", amount = 25},
      {type = "item", name = "concrete", amount = 400}
    },
    results = {{type="item", name="big-solar-panel", amount=1}}
  },

  {
    type = "technology",
    name = "big-solar-energy",
    icon = graphics .. "/technology/big-solar-energy.png",
    icon_size = 256,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "big-solar-panel"
      }
    },
    prerequisites = {"utility-science-pack", "electric-energy-distribution-2", "logistic-science-pack", "solar-energy", "concrete"},
    unit =
    {
      count = 600,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1}
      },
      time = 60
    },
  },


  {
    type = "solar-panel",
    name = "big-solar-panel",
    icon = graphics .. "/icons/big-solar-panel.png",
    flags = {"placeable-neutral", "player-creation"},
    minable = {hardness = 0.25, mining_time = 0.5, result = "big-solar-panel"},
    fast_replaceable_group = "big-solar-panel",
    max_health = 600,
    corpse = "big-solar-panel-remnants",
    dying_explosion = "solar-panel-explosion",
    collision_box = {{-4.2, -4.2}, {4.2, 4.2}},
    selection_box = {{-4.5, -4.5}, {4.5, 4.5}},
    damaged_trigger_effect = hit_effects.entity(),
    energy_source =
    {
      type = "electric",
      usage_priority = "solar"
    },
    picture =
    {
      layers =
      {
        {
          filename = ENTITYPATH .. "big-solar-panel.png",
          width = 624,
          height = 578,
          scale = 0.5,
          frame_count = 1,
          direction_count = 1,
          shift = util.by_pixel(10, 0),
        },
        {
          filename = ENTITYPATH .. "big-solar-panel_shadow.png",
          width = 624,
          height = 578,
          scale = 0.5,
          frame_count = 1,
          direction_count = 1,
          shift = util.by_pixel(10, 0),
          draw_as_shadow = true,
        }
      }
    },
    impact_category = "glass",
    --production = "60kW"
    production = "3600kW"
  },


  {
    type = "corpse",
    name = "big-solar-panel-remnants",
    icon = graphics .. "/icons/big-solar-panel.png",
    flags = {"placeable-neutral", "not-on-map"},
    hidden_in_factoriopedia = true,
    subgroup = "energy-remnants",
    order = "a-c-a",
    selection_box = {{-4.5, -4.5}, {4.5, 4.5}},
    tile_width = 9,
    tile_height = 9,
    selectable_in_game = false,
    time_before_removed = 60 * 60 * 15, -- 15 minutes
    expires = false,
    final_render_layer = "remnants",
    remove_on_tile_placement = false,
    animation = 
    {
      filename = ENTITYPATH .. "big-solar-panel_remnant.png",
      line_length = 1,
      width = 624,
      height = 578,
      frame_count = 1,
      direction_count = 1,
      shift = util.by_pixel(10, 0),
      scale = 0.5
    }
  },
})

if mods["space-age"] then
  table.insert(data.raw["technology"]["big-solar-energy"].prerequisites, "electromagnetic-science-pack")
  table.insert(data.raw["technology"]["big-solar-energy"].unit.ingredients, {"electromagnetic-science-pack", 1})
  table.insert(data.raw["recipe"]["big-solar-panel"].ingredients, {type = "item", name = "supercapacitor", amount = 10})
end
  