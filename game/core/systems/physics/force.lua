local tiny = require 'libs.tiny'

return tiny.processingSystem(class {
  filter = tiny.requireAll('mass', 'force', 'velocity'),
  process = function(_, e, dt)
    local acceleration = e.force / e.mass
    e.velocity = e.velocity + acceleration * dt
  end,
})
