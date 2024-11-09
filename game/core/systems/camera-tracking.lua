local tiny = require 'libs.tiny'

local CAMERA_MARGIN = 32

return tiny.processingSystem(class {
  filter = tiny.requireAll('position', 'camera_tracked'),
  init = function(self, opt)
    self.camera = opt.camera
  end,
  process = function(self, entity, dt)
    if entity.camera_tracked then
      local screen_width, screen_height = love.graphics.getDimensions()

      self.camera:lockWindow(
        entity.position.x, entity.position.y,
        CAMERA_MARGIN, screen_width - CAMERA_MARGIN,
        CAMERA_MARGIN, screen_height - CAMERA_MARGIN
      )
    end
  end,
})
