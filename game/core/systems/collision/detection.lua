local tiny = require 'libs.tiny'

return tiny.processingSystem(class {
  filter = tiny.requireAll('signal', 'shape'),
  is_draw = true,
  init = function(self, opt)
    self.collider = opt.collider
  end,
  process = function(self, entity, dt)
    local signal = entity.signal
    for shape, delta in pairs(self.collider:collisions(entity.shape)) do
      signal:emit('collision', shape.entity, delta, self.collider, dt)
    end
  end,
})
