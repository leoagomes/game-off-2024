-- a wrapper around json.lua with extra Love2D helpers
local J = require('libs.json')
local encode, decode = J.encode, J.decode

local decode_file = function(path)
  local contents, err = love.filesystem.read(path)
  if contents then
    return decode(contents)
  end
  return nil, err
end

return {
  encode = encode,
  decode = decode,
  decode_file = decode_file,
}
