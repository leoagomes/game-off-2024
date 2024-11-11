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
      local message = {
        self = entity,
        shape = shape,
        entity = shape.entity,
        delta = delta,
        collider = self.collider,
        deltatime = dt,
      }
      signal:emit('collision', entity, message)
    end
  end,
})
