local separator = '/'

local function join(...)
  local parts = {...}
  local path = parts[1] or ''
  for i = 2, #parts do
    local part = parts[i]
    local requires_separator =
      path ~= '' and
      path:sub(-1) ~= separator and
      part:sub(1,1) ~= separator
    if requires_separator then
      path = path .. separator .. part
    else
      path = path .. part
    end
  end
  return path
end

local function absolute(relative_path)
  local parts = {}
  for part in relative_path:gmatch('[^' .. separator .. ']+') do
    if part == '..' then
      table.remove(parts)
    else
      table.insert(parts, part)
    end
  end
  return join(unpack(parts))
end

return {
  join = join,
  absolute = absolute,
}
