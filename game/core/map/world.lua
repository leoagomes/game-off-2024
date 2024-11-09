local array = require 'util.array'

local Level = require 'core.map.level'
local Tileset = require 'core.map.tileset'

return class {
  init = function(self, raw)
    self.raw = raw
    self.layout = raw.worldLayout
    self.grid_width = raw.worldGridWidth
    self.grid_height = raw.worldGridHeight
    -- first define tilesets since levels will reference them
    self.defs = {
      tilesets = array.map(raw.defs.tilesets, function(raw_tileset)
        return Tileset(raw_tileset)
      end)
    }
    self.levels = array.map(raw.levels, function(raw_level)
      return Level(self, raw_level)
    end)
  end,
  load = function(self, base_path)
    -- load tilesets before pre-rendering the layers
    for _, tileset in ipairs(self.defs.tilesets) do
      tileset:load(base_path)
    end
    for _, level in ipairs(self.levels) do
      for _, layer in ipairs(level.layers) do
        layer:load()
      end
    end
  end,
  draw = function(self)
    for _, level in ipairs(self.levels) do
      for _, layer in ipairs(level.layers) do
        layer:draw()
      end
    end
  end,
}
