local _table = require 'util.table'
local anim8 = require 'libs.anim8'

local sheet_path = 'data/assets/third-party/character/Sprites/PlayerCombatSheet.png'
local frame_width, frame_height = 96, 84
local sheet_width, sheet_height = 960, 4368
local default_offset = Vector(-48, -84)

local grid = anim8.newGrid(
  frame_width, frame_height,
  sheet_width, sheet_height
)
local animations = {
  idle = anim8.newAnimation(grid('1-7', 1), 0.2),
}
local offsets = {
  idle = default_offset,
}

local function clone(thing)
  return thing:clone()
end

return function()
  local sheet = love.graphics.newImage(sheet_path)
  return {
    sheet = sheet,
    animations = _table.transform_values(animations, clone),
    offsets = _table.transform_values(offsets, clone),
    current = 'idle',
  }
end
