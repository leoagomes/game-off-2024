local tiny = require 'libs.tiny'

return tiny.processingSystem(class {
  filter = tiny.requireAll('signal', 'input'),
  init = function(self, opt)
    self.signal = opt.signal
  end,
  process = function(self, entity, dt)
    local input, signal = entity.input, entity.signal
    if input:pressed('pause') then
      local name = 'input:pause'
      self.signal:emit(name, entity)
      signal:emit(name, entity)
    end
    if input:pressed('jump') then
      signal:emit('input:jump', entity)
    end
    if input:pressed('attack') then
      signal:emit('input:attack', entity)
    end
  end
})
