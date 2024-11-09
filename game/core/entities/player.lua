local anim8 = require 'libs.anim8'
local baton = require 'libs.baton'

local SPRITES = {
  PATH = 'data/assets/third-party/character/Sprites/PlayerSheet.png',
  FRAME_WIDTH = 96,
  FRAME_HEIGHT = 84,
}

return function(opt)
  opt = opt or {}
  -- animation setup
  local sheet = love.graphics.newImage(SPRITES.PATH)
  local grid = anim8.newGrid(
    SPRITES.FRAME_WIDTH, SPRITES.FRAME_HEIGHT,
    sheet:getWidth(), sheet:getHeight()
  )
  local animations = {
    idle = anim8.newAnimation(grid('1-7', 1), 0.2),
  }
  local initial_animation = 'idle'
  -- physics properties
  local position = opt.position or Vector(0, 0)
  local velocity = Vector(0, 0)
  local force = Vector(0, 0)
  local forces = opt.forces or {
    gravity = Vector(0, 9.81),
  }
  local mass = 1
  -- controls
  local controls = baton.new(opt.controls or require('game.data.conf.controls'))
  -- return the entity
  return {
    sprite_sheet = sheet,
    animations = animations,
    animation = initial_animation,
    position = position,
    controls = controls,
    velocity = velocity,
    force = force,
    forces = forces,
    mass = mass,
  }
end
