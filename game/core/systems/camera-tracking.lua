local tiny = require 'libs.tiny'

return tiny.processingSystem(class {
  filter = tiny.requireAll('position', 'camera_tracked'),
  init = function(self, opt)
    self.camera = opt.camera
  end,
  process = function(self, entity, dt)
    if entity.camera_tracked then
      self.camera:lockPosition(entity.position.x, entity.position.y)
    end
  end,
})
