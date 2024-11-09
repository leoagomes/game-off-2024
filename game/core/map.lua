local path = require 'util.path'

local function load_image(base, relative)
  return love.graphics.newImage(path.absolute(path.join(base, relative)))
end

local function load_tilesets(base, tilesets)
  local images = {}
  for _, tileset in ipairs(tilesets) do
    images[tileset.uid] = load_image(base, tileset.relative_path)
  end
  return images
end

local function generate_batch(layer, tileset_image)
  local batch = love.graphics.newSpriteBatch(tileset_image, layer.tiles_width * layer.tiles_height)
  local tileset = layer.tileset
  local grid_size = tileset.tile_grid_size
  local tileset_width, tileset_height = tileset.pixel_width, tileset.pixel_height
  local tile_lists = { layer.grid_tiles, layer.auto_layer_tiles }
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
  return batch
end

local function generate_batches(worlds, tileset_images)
  local batches = {}
  for _, level in ipairs(worlds.levels) do
    for _, layer in ipairs(level.layers) do
      local tileset_image = tileset_images[layer.tileset_uid]
      if tileset_image then
        batches[layer.iid] = generate_batch(layer, tileset_image)
      end
    end
  end
  return batches
end

local function generate_solids(collider, data)
  local world, collision_enum = data.world, data.collision_enum

  -- this piece of code is particularly hideous, TODO: refactor
  local solids = {}
  for _, level in ipairs(world.levels) do
    for _, layer in ipairs(level.layers) do
      local tileset = layer.tileset
      if tileset then
        local w, h = tileset.tile_grid_size, tileset.tile_grid_size
        if tileset.enum_id == collision_enum.uid then
          local tiles = {layer.grid_tiles, layer.auto_layer_tiles}
          for _, tile_list in ipairs(tiles) do
            for _, tile in ipairs(tile_list) do
              local tags = tileset:get_tile_tags(tile.tile_id)
              if tags.Solid then
                local solid = nil
                local x, y = tile.pixel.x + layer.pixel_total_offset.x, tile.pixel.y + layer.pixel_total_offset.y

                if tags.Square then
                  solid = collider:rectangle(x, y, w, h)
                elseif tags.Slope then
                  local start_x, start_y, end_x, end_y, close_x, close_y
                  if tags.SlopeUp then
                    start_x, start_y = x, y + h
                    end_x, end_y = x + w, y
                    if tags.SlopeTop then
                      close_x, close_y = x, y
                    elseif tags.SlopeBottom then
                      close_x, close_y = x + w, y + h
                    end
                  elseif tags.SlopeDown then
                    start_x, start_y = x, y
                    end_x, end_y = x + w, y + h
                    if tags.SlopeTop then
                      close_x, close_y = x, y + h
                    elseif tags.SlopeBottom then
                      close_x, close_y = x + w, y
                    end
                  end
                  if not (start_x and start_y and end_x and end_y and close_x and close_y) then
                    error('Invalid slope tile')
                  end
                  solid = collider:polygon(start_x, start_y, end_x, end_y, close_x, close_y)
                end

                if solid then
                  solid.tags = {
                    solid = true,
                    ground = true,
                  }
                  table.insert(solids, solid)
                end
              end
            end
          end
        end
      end
    end
  end
  return solids
end

return class {
  init = function(self, opt)
    local data = opt.data
    self.data = data
    self.tileset_images = load_tilesets(data.base_path, data.world.defs.tilesets)
    self.layer_batches = generate_batches(data.world, self.tileset_images)
    self.solids = generate_solids(opt.collider, data)
  end,
  draw = function(self)
    for _, level in ipairs(self.data.world.levels) do
      for _, layer in ipairs(level.layers) do
        local batch = self.layer_batches[layer.iid]
        if batch then
          love.graphics.setColor(1, 1, 1, layer.opacity)
          love.graphics.draw(batch, layer.pixel_total_offset.x, layer.pixel_total_offset.y)
        end
      end
    end
  end,
  debug_draw = function(self)
    love.graphics.setColor(1, 0, 0, 0.7)
    for _, solid in ipairs(self.solids) do
      solid:draw('line')
    end
  end,
}
