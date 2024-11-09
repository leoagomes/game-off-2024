local tiny = require 'libs.tiny'

return tiny.processingSystem(class {
  filter = tiny.requireAll('controls'),
  process = function(_, e, dt)
  end,
})
