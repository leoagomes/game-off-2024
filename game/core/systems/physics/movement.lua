local tiny = require 'libs.tiny'

local PIXELS_PER_UNIT = 22

return tiny.processingSystem(class {
  filter = tiny.requireAll('position', 'velocity'),
  process = function(_, e, dt)
    local delta = e.velocity * dt * PIXELS_PER_UNIT
    e.position = e.position + delta
    if e.shape then
      e.shape:move(delta.x, delta.y)
    end
  end,
})
