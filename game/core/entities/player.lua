local anim8 = require 'libs.anim8'

local PLAYER_SHEET = 'data/assets/third-party/character/Sprites/PlayerSheet.png'
local FRAME_WIDTH = 96
local FRAME_HEIGHT = 84

return function(opt)
  opt = opt or {}
  local sheet = love.graphics.newImage(PLAYER_SHEET)
  local grid = anim8.newGrid(FRAME_WIDTH, FRAME_HEIGHT, sheet:getWidth(), sheet:getHeight())
  local animations = {
    idle = anim8.newAnimation(grid('1-7', 1), 0.2),
  }
  local position = opt.position or Vector(0, 0)
  return {
    sprite_sheet = sheet,
    animations = animations,
    animation = 'idle',
    position = position,
  }
end
