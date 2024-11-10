local tiny = require 'libs.tiny'

return tiny.processingSystem(class {
  filter = tiny.requireAll('input'),
  process = function(_, entity, dt)
    entity.input:update()
  end
})
