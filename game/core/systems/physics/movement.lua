local tiny = require 'libs.tiny'

local PIXELS_PER_UNIT = 22

return tiny.processingSystem(class {
  filter = tiny.requireAll('position', 'velocity'),
  process = function(_, e, dt)
    local delta_px = dt * PIXELS_PER_UNIT
    local delta = e.velocity * delta_px
    e.position = e.position + delta
    if e.shape then
      e.shape:move(delta.x, delta.y)
    end
  end,
})
