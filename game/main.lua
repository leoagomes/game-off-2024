-- development utilities
local lovebird
DEBUG = arg[2] == 'debug'
if DEBUG then
  require('lldebug').start()
  local error_handler = love.errorhandler
  love.errorhandler = function(msg)
    error(msg, 2)
  end
end
if DEVELOPMENT then
  lovebird = require('libs/lovebird')
end

-- globals
class = require('libs/hump/class')
Vector = require('libs/hump/vector')
Timer = require('libs/hump/timer')
Gamestate = require('libs/hump/gamestate')
Signal = require('libs/hump/signal')

function love.load()
end

function love.update(dt)
  if lovebird then
    lovebird.update()
  end
  Timer.update(dt)
end

function love.draw()
  -- love.graphics.print("Hello World!", 400, 300)
  love.graphics.print("This: " .. love.joystick.getJoystickCount(), 100, 100)
end

function love.joystickpressed(joystick, button)
  print("Gamepad pressed: " .. button)
  love.event.quit(0)
end

function love.keypressed(key)
  print("Key pressed: " .. key)
end


