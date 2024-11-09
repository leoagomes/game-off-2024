local tiny = require 'libs.tiny'

return tiny.processingSystem(class {
  _is_draw = true,
  filter = tiny.requireAll('sprite_sheet', 'animation', 'position'),
  init = function(self, opt)
    opt = opt or {}
    self.camera = opt.camera
  end,
  process = function(_, e)
    local animation = e.animation and e.animations[e.animation]
    if animation then
      animation:draw(e.sprite_sheet, e.position.x, e.position.y)
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
