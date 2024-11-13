local tiny = require 'libs.tiny'

return tiny.processingSystem(class {
  filter = tiny.requireAll('position', 'velocity'),
  init = function(self, opt)
    self.collider = opt.collider
  end,
  process = function(self, entity, dt)
    local direction = entity.velocity:normalized()
    local movement_delta = entity.velocity * dt
    local next_position = entity.position + movement_delta
    if entity.shape then
      local shape = entity.shape
      if entity.shape.tags.solid then
        local len2 = entity.velocity:len2()
        local len = entity.velocity:len()
        local perp = direction:perpendicular()
        local max_x, max_y = shape:support(perp.x, perp.y)
        perp = -perp
        local min_x, min_y = shape:support(perp.x, perp.y)



      end
      entity.shape:moveTo(next_position.x, next_position.y)
    end
    entity.position = next_position
  end,
})
