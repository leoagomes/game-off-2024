local array = require 'util.array'

local Layer = require 'util.ldtk.layer'

return class {
  init = function(self, world, raw)
    self.world = world
    self.raw = raw
    self.identifier = raw.identifier
    self.iid = raw.iid
    self.uid = raw.uid
    self.pixel_width = raw.pxWid
    self.pixel_height = raw.pxHei
    self.background_color = raw.__bgColor
    self.world_x = raw.worldX
    self.world_y = raw.worldY
    self.layers = array.map(raw.layerInstances, function(raw_layer)
      return Layer(world, self, raw_layer)
    end)
  end,
}
