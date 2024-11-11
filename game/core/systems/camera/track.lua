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
      local x1,y1, x2,y2 = entity.shape:bbox()
      local w, h = x2 - x1, y2 - y1
      self.camera:lockWindow(
        entity.position.x, entity.position.y,
        CAMERA_MARGIN, screen_width - CAMERA_MARGIN - w,
        CAMERA_MARGIN + h, screen_height - CAMERA_MARGIN
      )
    end
  end,
})
