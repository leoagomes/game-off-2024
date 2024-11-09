local array = require 'util.array'

local Entity = require 'core.map.entity'
local Field = require 'core.map.field'
local Tile = require 'core.map.tile'

return class {
  init = function(self, world, level, raw)
    self.world = world
    self.level = level
    self.iid = raw.iid
    self.level_id = raw.levelId
    self.identifier = raw.__identifier
    self.type = raw.__type
    self.tileset_uid = raw.__tilesetDefUid
    self.tileset_rel_path = raw.__tilesetRelPath
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
  load = function(self)
    if self.batch or not self.tileset then return end
    -- create a sprite batch for the layer
    local batch = love.graphics.newSpriteBatch(self.tileset.image, self.tiles_width * self.tiles_height)
    -- render the tiles to the batch
    local grid_size, tileset = self.grid_size, self.tileset
    local tileset_width, tileset_height = tileset.pixel_width, tileset.pixel_height
    local tile_lists = { self.grid_tiles, self.auto_layer_tiles }
    for _, tiles in ipairs(tile_lists) do
      for _, tile in ipairs(tiles) do
        local pixel, source = tile.pixel, tile.source
        local quad = love.graphics.newQuad(
          source.x, source.y,
          grid_size, grid_size,
          tileset_width, tileset_height
        )
        batch:add(quad, pixel.x, pixel.y)
      end
    end
    self.batch = batch
  end,
  draw = function(self)
    -- TODO: support non-batched layers
    if not self.batch then return end
    love.graphics.setColor(1, 1, 1, self.opacity)
    love.graphics.draw(self.batch)
  end,
}
