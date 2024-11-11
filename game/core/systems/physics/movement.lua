local tiny = require 'libs.tiny'

return tiny.processingSystem(class {
  filter = tiny.requireAll('position', 'velocity'),
  init = function(self, opt)
    self.collider = opt.collider
  end,
  process = function(self, entity, dt)
    local delta = entity.velocity * dt
    local next_position = entity.position + delta
    entity.position = next_position
    -- if the entity has a shape, move it
    if entity.shape then
      local shape = entity.shape
      shape:move(delta.x, delta.y)
      -- if the entity is solid, we want to slide it
      if shape.tags.solid then
        local resolve_x, resolve_y = 0, 0
        for other_shape, collision_delta in pairs(self.collider:collisions(shape)) do
          if other_shape.tags.solid then
            resolve_x = resolve_x + collision_delta.x
            resolve_y = resolve_y + collision_delta.y
          end
        end
        entity.position.x = entity.position.x + resolve_x
        entity.position.y = entity.position.y + resolve_y
        shape:move(resolve_x, resolve_y)
        -- and notify of the collisions that occurred
        if entity.signal then
          entity.signal:emit('physics:slide', {
            self = entity,
            shape = shape,
            delta = Vector(resolve_x, resolve_y),
            collider = self.collider,
            deltatime = dt,
          })
        end
      end
    end
  end,
})
