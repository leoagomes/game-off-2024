local tiny = require 'libs.tiny'
local Camera = require 'libs.hump.camera'

local draw_system_filter = tiny.requireAll('_is_draw')

return class {
  init = function(self)
    self.level = require('game.data.levels.test.init')
    local player_position = Vector(100, 100) -- TODO: load from level
    self.camera = Camera(player_position.x, player_position.y)
    self.world = tiny.world(
      require('game.core.systems.animation')(),
      require('game.core.systems.animation-draw')()
    )
    self.world:add(require('game.core.entities.player')({
      position = player_position,
    }))
  end,
  update = function(self, dt)
    self.world:update(dt)
  end,
  draw = function(self)
    self.world:update(nil, draw_system_filter)
  end,
}
