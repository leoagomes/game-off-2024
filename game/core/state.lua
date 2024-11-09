local tiny = require 'libs.tiny'
local Camera = require 'libs.hump.camera'
local HC = require 'libs.HC'

local draw_system_filter = tiny.requireAll('_is_draw')

return class {
  init = function(self)
    self.map = require('data.worlds.test.init')()
    self.map:load('data/worlds/test')
    local player_position = Vector(100, 100) -- TODO: load from level
    self.collider = HC.new()
    self.camera = Camera(player_position.x, player_position.y)
    self.world = tiny.world(
      require('core.systems.animation.update')(),
      require('core.systems.animation.draw')(),
      require('core.systems.physics.movement')(),
      require('core.systems.physics.forces')(),
      require('core.systems.physics.force')(),
      require('core.systems.collision.debug-draw')()
    )
    local player = require('core.entities.player')({
      position = player_position,
      collider = self.collider,
    })
    player.controls.config.joystick = love.joystick.getJoysticks()[1]
    self.world:add(player)
  end,
  update = function(self, dt)
    self.world:update(dt)
  end,
  draw = function(self)
    self.camera:attach()
    self.map:draw()
    self.camera:detach()

    self.world:update(nil, draw_system_filter)
  end,
  joystickadded = function(self, joystick)
    if self.player.controls.config.joystick == nil then
      self.player.controls.config.joystick = joystick
    end
  end,
  joystickremoved = function(self, joystick)
    if self.player.controls.config.joystick == joystick then
      self.player.controls.config.joystick = nil
    end
  end,
}
