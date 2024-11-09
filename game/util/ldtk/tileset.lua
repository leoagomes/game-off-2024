-- a wrapper around LDtk's tileset definition
--
local array = require 'util.array'
local path = require 'util.path'

local to_tag_set = function(enum_tags)
  local tags_by_tile_id = {}
  for _, tag in ipairs(enum_tags) do
    local value = tag.value
    for _, tile_id in ipairs(tag.tile_ids) do
      local tile_tags = tags_by_tile_id[tile_id]
      if not tile_tags then
        tile_tags = {}
        tags_by_tile_id[tile_id] = tile_tags
      end
      tile_tags[value] = true
    end
  end
  return tags_by_tile_id
end

return class {
  init = function(self, raw)
    self.raw = raw
    self.identifier = raw.identifier
    self.uid = raw.uid
    self.relative_path = raw.relPath
    self.pixel_width = raw.pxWid
    self.pixel_height = raw.pxHei
    self.tile_grid_size = raw.tileGridSize
    self.tiles_width = raw.__cWid
    self.tiles_height = raw.__cHei
    self.spacing = raw.spacing
    self.padding = raw.padding
    self.image = nil
    self.enum_id = raw.tagsSourceEnumUid
    self.enum_tags = array.map(raw.enumTags, function(tag)
      return {
        value = tag.enumValueId,
        tile_ids = tag.tileIds,
      }
    end)
    self.tags_by_tile_id = to_tag_set(self.enum_tags)
  end,
  get_tile_tags = function(self, tile_id)
    return self.tags_by_tile_id[tile_id]
  end,
  tile_has_tag = function(self, tile_id, tag)
    local tags = self.tags_by_tile_id[tile_id]
    return tags and tags[tag]
  end,
}
