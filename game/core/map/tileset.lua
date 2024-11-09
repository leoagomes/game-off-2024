-- a wrapper around LDtk's tileset definition
--
local path = require 'util.path'

return class {
  init = function(self, raw)
    self.raw = raw
    self.identifier = raw.identifier
    self.uid = raw.uid
    self.rel_path = raw.relPath
    self.pixel_width = raw.pxWid
    self.pixel_height = raw.pxHei
    self.tile_grid_size = raw.tileGridSize
    self.tiles_width = raw.__cWid
    self.tiles_height = raw.__cHei
    self.spacing = raw.spacing
    self.padding = raw.padding
    self.image = nil
  end,
  load = function(self, base_path)
    local p = path.absolute(path.join(base_path, self.rel_path))
    self.image = love.graphics.newImage(p)
  end,
}
