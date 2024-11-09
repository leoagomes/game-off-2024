local array = require 'util.array'
local json = require 'util.json'
local path = require 'util.path'

local World = require 'util.ldtk.world'

local function load_world(path)
  local raw = json.decode_file(path)
  return World(raw)
end

return function(opt)
  opt = opt or {}
  local base_path = opt.base_path or 'data/worlds/test'
  local world_path = opt.world_path or 'world.ldtk'
  local collision_enum_id = opt.collision_enum_id or 'Collision'
  local player_spawn_id = opt.player_spawn_id or 'PlayerSpawn'

  local world = load_world(path.join(base_path, world_path))
  local collision_enum = array.find(world.defs.enums, function(enum)
    return enum.identifier == collision_enum_id
  end)
  local player_spawn = nil
  for _, level in ipairs(world.levels) do
    for _, layer in ipairs(level.layers) do
      for _, entity in ipairs(layer.entities) do
        if entity.identifier == player_spawn_id then
          player_spawn = entity
          break
        end
      end
    end
  end

  return {
    base_path = base_path,
    collision_enum_id = collision_enum_id,
    collision_enum = collision_enum,
    player_spawn = player_spawn,
    world = world,
  }
end
