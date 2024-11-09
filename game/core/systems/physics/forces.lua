local tiny = require 'libs.tiny'

return tiny.processingSystem(class {
  filter = tiny.requireAll('forces', 'force'),
  process = function(_, e, dt)
    local rx, ry = 0, 0
    for _, force in pairs(e.forces) do
      rx = rx + force.x
      ry = ry + force.y
    end
    e.force.x, e.force.y = rx, ry
  end,
})
