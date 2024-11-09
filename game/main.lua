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

function love.load()
end

function love.update(dt)
  if lovebird then
    lovebird.update()
  end
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
  -- love.event.quit(0)
end


