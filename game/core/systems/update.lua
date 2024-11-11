local tiny = require 'libs.tiny'

return tiny.processingSystem(class {
  filter = tiny.requireAll('update'),
  process = function(_, e, dt)
    e:update(dt)
  end,
})
