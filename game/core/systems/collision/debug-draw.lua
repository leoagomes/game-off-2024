local tiny = require 'libs.tiny'

return tiny.processingSystem(class {
  _is_draw = true,
  filter = tiny.requireAll('shape', '_debug_shape'),
  init = function(self, opt)
    opt = opt or {}
    self.camera = opt.camera
  end,
  process = function(_, e)
    if e._debug_shape then
      love.graphics.setColor(e._debug_shape.color)
      e.shape:draw('line')
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
