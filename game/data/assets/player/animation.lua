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
  walk = anim8.newAnimation(grid('1-8', 2), 0.1),
  run_blade_up = anim8.newAnimation(grid('1-8', 3), 0.1),
  run_blade_down = anim8.newAnimation(grid('1-8', 4), 0.1),
  sprint = anim8.newAnimation(grid('1-6', 5), 0.1),
  run_attack = anim8.newAnimation(grid('1-6', 6), 0.1),
  crouch_idle = anim8.newAnimation(grid('1-6', 7), 0.2),
  jump_rise = anim8.newAnimation(grid(1, 15), 0.1),
  jump_mid = anim8.newAnimation(grid(1, 16), 0.1),
  jump_fall = anim8.newAnimation(grid(1, 17), 0.1),
  guard = anim8.newAnimation(grid('1-6', 24), 0.1),
}
local offsets = {
  idle = default_offset,
}

local function clone(thing)
  return thing:clone()
end

return function()
  local sheet = love.graphics.newImage(sheet_path)
  local data = _table.transform_values(
    animations,
    function(animation)
      return {
        offset = default_offset:clone(),
        sheet = sheet,
        animation = animation:clone(),
      }
    end
  )
  return data
end
