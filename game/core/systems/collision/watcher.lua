local tiny = require 'libs.tiny'

return tiny.processingSystem(class {
  filter = tiny.requireAll('position', 'velocity', 'shape'),
  is_draw = true,
  process = function(self, entity, dt)
    entity.position = entity.position + entity.velocity * dt
    entity.shape:moveTo(entity.position:unpack())
  end,
})
