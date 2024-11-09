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
  lovebird = require('libs.lovebird')
end

-- globals
class = require 'libs.hump.class'
Vector = require 'libs.hump.vector'
Timer = require 'libs.hump.timer'
Gamestate = require 'libs.hump.gamestate'
Signal = require 'libs.hump.signal'

function love.load()
  Gamestate.registerEvents()

  local state = require('core.state')()
  Gamestate.switch(state)
end

function love.update(dt)
  if lovebird then
    lovebird.update()
  end
  Timer.update(dt)
end
