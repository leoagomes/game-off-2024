local tiny = require 'libs.tiny'
local Camera = require 'libs.hump.camera'
local HC = require 'libs.HC'

local path = require 'util.path'

local draw_system_filter = tiny.requireAll('_is_draw')

return class {
  init = function(self)
    -- ugly hack because Gamestate calls `init` when you change to the state,
    -- but at this point it has already been initialized
    if self._initialized then return end
    self._initialized = true

    self.timer = Timer()
    self.signal = Signal()
    self.collider = HC.new()
    self.camera = Camera()
    self.camera:zoomTo(1)
    self.world = tiny.world(
      -- update input so other systems can rely on it
      require('core.systems.input.update')(),
      -- signal input events
      require('core.systems.input.signaling')({ signal = self.signal }),
      -- collisions might interfere with movement, so run them first
      require('core.systems.collision.detection')({ collider = self.collider }),
      require('core.systems.input.movement')(),
      require('core.systems.update')(), -- TODO: maybe change order
      -- process physics
      require('core.systems.physics.forces')(),
      require('core.systems.physics.force')(),
      require('core.systems.physics.movement')({ collider = self.collider }),
      -- graphics update systems
      require('core.systems.camera.track')({ camera = self.camera }),
      require('core.systems.animation.update')(),
      -- draw systems, run separately after all updates
      -- require('core.systems.draw')({ camera = self.camera }),
      require('core.systems.animation.draw')({ camera = self.camera }),
      require('core.systems.collision.debug-draw')()
    )
    self.map = require('core.map')({
      collider = self.collider,
      data = require('data/worlds/test/init')(),
    })
    self.player = require('core.entities.player')({
      position = self.map.data.player_spawn.world:clone(),
      collider = self.collider,
    })
    self.player.input.config.joystick = love.joystick.getJoysticks()[1]
    self.world:add(self.player)
    self.camera:lookAt(self.player.position.x, self.player.position.y)
  end,
  update = function(self, dt)
    self.world:update(dt)
  end,
  draw = function(self)
    self.camera:attach()
    self.map:draw()
    -- self.map:debug_draw()
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
