local tiny = require 'libs.tiny'

return tiny.processingSystem(class {
  _is_draw = true,
  filter = tiny.requireAll('animation', 'position'),
  init = function(self, opt)
    opt = opt or {}
    self.camera = opt.camera
  end,
  process = function(_, e)
    local anim = e.animation
    local current = anim.current and anim.animations[anim.current]
    if current then
      local offset = anim.offsets[anim.current] or Vector(0, 0)
      love.graphics.setColor(1, 1, 1) -- TODO: maybe not here?
      local x, y = e.position.x + offset.x, e.position.y + offset.y
      current:draw(anim.sheet, x, y)
    end
  end,
  preWrap = function(self)
    if self.camera then
      self.camera:attach()
    end
  end,
  postWrap = function(self)
    if self.camera then
      self.camera:detach()
    end
  end,
})
