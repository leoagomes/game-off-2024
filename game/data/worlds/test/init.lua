local json = require 'util.json'
local World = require 'core.map.world'

local path = 'data/worlds/test/world.ldtk'

return function()
  local raw = json.decode_file(path)
  return World(raw)
end
