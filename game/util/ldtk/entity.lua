local array = require 'util.array'

local Field = require 'util.ldtk.field'

return class {
  init = function(self, raw)
    self.raw = raw
    self.identifier = raw.__identifier
    self.grid = Vector(
      raw.__grid[1],
      raw.__grid[2]
    )
    self.pixel = Vector(
      raw.px[1],
      raw.px[2]
    )
    self.world = Vector(
      raw.__worldX,
      raw.__worldY
    )
    self.tags = raw.__tags or {}
    self.width = raw.width
    self.height = raw.height
    self.fields = array.map(raw.fieldInstances, function(raw_field)
      return Field(raw_field)
    end)
  end
}
