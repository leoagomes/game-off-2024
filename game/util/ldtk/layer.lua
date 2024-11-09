local array = require 'util.array'

local Entity = require 'util.ldtk.entity'
local Tile = require 'util.ldtk.tile'

return class {
  init = function(self, world, level, raw)
    self.world = world
    self.level = level
    self.iid = raw.iid
    self.level_id = raw.levelId
    self.identifier = raw.__identifier
    self.type = raw.__type
    self.tileset_uid = raw.__tilesetDefUid
    self.tileset_relative_path = raw.__tilesetRelPath
    self.tileset = array.find(world.defs.tilesets, function(tileset)
      return tileset.uid == self.tileset_uid
    end)
    self.tiles_width = raw.__cWid
    self.tiles_height = raw.__cHei
    self.grid_size = raw.__gridSize
    self.opacity = raw.__opacity
    self.pixel_total_offset = Vector(
      raw.__pxTotalOffsetX,
      raw.__pxTotalOffsetY
    )
    self.visible = raw.visible
    self.seed = raw.seed
    self.entities = array.map(raw.entityInstances, function(raw_entity)
      return Entity(raw_entity)
    end)
    self.grid_tiles = array.map(raw.gridTiles, function(raw_tile)
      return Tile(raw_tile)
    end)
    self.auto_layer_tiles = array.map(raw.autoLayerTiles, function(raw_tile)
      return Tile(raw_tile)
    end)
    self.int_grid_csv = raw.intGridCsv
  end,
}
