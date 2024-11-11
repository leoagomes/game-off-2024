local tiny = require 'libs.tiny'

return tiny.processingSystem(class {
  _is_draw = true,
  filter = tiny.requireAll('animation', 'state', 'position'),
  init = function(self, opt)
    self.camera = opt.camera
  end,
  process = function(_, entity)
    local animation, state, position = entity.animation, entity.state, entity.position
    local current = animation and state and animation[state]
    if current then
      local offset = current.offset
      love.graphics.setColor(1, 1, 1) -- TODO: maybe not here?
      local x, y = entity.position.x + offset.x, entity.position.y + offset.y
      current.animation:draw(current.sheet, x, y)
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
