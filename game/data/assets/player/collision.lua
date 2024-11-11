return function(position, collider)
  local width, height = 16, 40
  local offset = Vector(-(width/2), -height)

  local x, y = position.x + offset.x, position.y + offset.y
  local shape = collider:rectangle(x, y, width, height)
  shape.offset = offset
  shape.tags = {
    solid = true,
    player = true,
  }
  return shape
end
