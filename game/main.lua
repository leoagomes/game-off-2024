-- development utilities
local lovebird
if DEVELOPMENT then
  if arg[2] == 'debug' then
    require('lldebug').start()
  end
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
  -- crashe()
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


local love_errorhandler = love.errorhandler
function love.errorhandler(msg)
  if lldebugger then
    error(msg, 2)
  else
    return love_errorhandler(msg)
  end
end
