local tiny = require 'libs.tiny'
local Camera = require 'libs.hump.camera'

local draw_system_filter = tiny.requireAll('_is_draw')

return class {
  init = function(self)
    self.level = require('game.data.levels.test.init')
    local player_position = Vector(100, 100) -- TODO: load from level
    self.camera = Camera(player_position.x, player_position.y)
    self.world = tiny.world(
      require('game.core.systems.animation.update')(),
      require('game.core.systems.animation.draw')(),
      require('game.core.systems.physics.movement')(),
      require('game.core.systems.physics.forces')(),
      require('game.core.systems.physics.force')()
    )
    local player = require('game.core.entities.player')({
      position = player_position,
    })
    player.controls.config.joystick = love.joystick.getJoysticks()[1]
    self.world:add(player)
  end,
  update = function(self, dt)
    self.world:update(dt)
  end,
  draw = function(self)
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
