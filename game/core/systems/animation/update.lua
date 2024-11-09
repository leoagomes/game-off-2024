local tiny = require 'libs.tiny'

return tiny.processingSystem(class {
  filter = tiny.requireAll('animation'),
  process = function(_, e, dt)
    local animation = e.animation and e.animations[e.animation]
    if animation then
      animation:update(dt)
    end
  end,
})
