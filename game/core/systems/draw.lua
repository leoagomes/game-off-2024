local tiny = require 'libs.tiny'

return tiny.processingSystem(class {
  _is_draw = true,
  filter = tiny.requireAll('draw'),
  init = function(self, opt)
    self.camera = opt.camera
  end,
  process = function(_, e)
    e:draw()
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
