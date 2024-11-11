local tiny = require 'libs.tiny'

return tiny.processingSystem(class {
  filter = tiny.requireAll('animation', 'state'),
  process = function(_, entity, dt)
    local animation, state = entity.animation, entity.state
    if animation and state and animation[state] then
      local current = animation[state]
      if current then
        current.animation:update(dt)
      end
    end
  end,
})
