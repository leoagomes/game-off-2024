local anim8 = require 'libs.anim8'
local baton = require 'libs.baton'

local player_assets = require 'data.assets.player'

local function load_shape(position, collider)
  local width, height = 16, 40
  local offset = Vector(-(width/2), -height)

  local x, y = position.x + offset.x, position.y + offset.y
  local shape = collider:rectangle(x, y, width, height)
  shape.offset = offset
  shape.tags = {
    solid = true,
    player = true,
  }
  return shape
end

return function(opt)
  opt = opt or {}
  local signal = Signal()
  -- animation setup
  local animation = player_assets()
  -- physics properties
  local position = opt.position or Vector(0, 0)
  local velocity = Vector(0, 0)
  local force = Vector(0, 0)
  local forces = opt.forces or {
    gravity = Vector(0, 9.81),
  }
  local mass = 1
  -- collision
  local shape = load_shape(position, opt.collider)
  -- controls
  local input = baton.new(opt.controls or require('data.conf.controls'))
  -- entity state
  local state = {
    name = 'idle',
    grounded = false,
    facing_right = true,
  }
  -- return the entity
  local entity = {
    signal = signal,
    animation = animation,
    position = position,
    velocity = velocity,
    mass = mass,
    force = force,
    forces = forces,
    shape = shape,
    _debug_shape = {
      color = { 1, 0, 0, 0.5 },
    },
    input = input,
    camera_tracked = true,
  }
  shape.entity = entity
  return entity
end
