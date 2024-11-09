local array = require 'util.array'

local Enum = require 'util.ldtk.enum'
local Level = require 'util.ldtk.level'
local Tileset = require 'util.ldtk.tileset'

return class {
  init = function(self, raw)
    self.raw = raw
    self.layout = raw.worldLayout
    self.grid_width = raw.worldGridWidth
    self.grid_height = raw.worldGridHeight
    -- first define tilesets since levels will reference them
    self.defs = {
      enums = array.map(raw.defs.enums, function(raw_enum)
        return Enum(raw_enum)
      end),
      tilesets = array.map(raw.defs.tilesets, function(raw_tileset)
        return Tileset(raw_tileset)
      end)
    }
    self.levels = array.map(raw.levels, function(raw_level)
      return Level(self, raw_level)
    end)
  end,
}
