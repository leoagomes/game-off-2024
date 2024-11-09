local anim8 = require 'libs.anim8'
local baton = require 'libs.baton'

local function load_animation()
  local path = 'data/assets/third-party/character/Sprites/PlayerSheet.png'
  local frame_width, frame_height = 96, 84
  local default_offset = Vector(-48, -84)

  local sheet = love.graphics.newImage(path)
  local grid = anim8.newGrid(frame_width, frame_height, sheet:getWidth(), sheet:getHeight())
  local animations = {
    idle = anim8.newAnimation(grid('1-7', 1), 0.2),
  }
  local offsets = {
    idle = default_offset,
  }
  return {
    offsets = offsets,
    sheet = sheet,
    animations = animations,
    current = 'idle',
  }
end

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
  -- animation setup
  local animation = load_animation()
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
  local controls = baton.new(opt.controls or require('data.conf.controls'))
  -- return the entity
  local entity = {
    animation = animation,
    position = position,
    controls = controls,
    velocity = velocity,
    force = force,
    forces = forces,
    mass = mass,
    shape = shape,
    _debug_shape = {
      color = { 1, 0, 0, 0.5 },
    },
    -- camera_tracked = true,
  }
  shape.entity = entity
  return entity
end
