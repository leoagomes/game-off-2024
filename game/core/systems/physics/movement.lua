local tiny = require 'libs.tiny'

return tiny.processingSystem(class {
  filter = tiny.requireAll('position', 'velocity'),
  process = function(_, e, dt)
    e.position = e.position + e.velocity * dt
  end,
})
