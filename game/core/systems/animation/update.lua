local tiny = require 'libs.tiny'

return tiny.processingSystem(class {
  filter = tiny.requireAll('animation'),
  process = function(_, e, dt)
    local anim = e.animation
    local current = anim.current and anim.animations[anim.current]
    if current then
      current:update(dt)
    end
  end,
})
