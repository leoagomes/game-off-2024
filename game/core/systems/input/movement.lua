local tiny = require 'libs.tiny'

return tiny.processingSystem(class {
  filter = tiny.requireAll('input', 'velocity'),
  process = function(_, entity)
    -- local x, y = entity.input:get('move')
    -- entity.velocity.x = x * 4 * 22
  end,
})
