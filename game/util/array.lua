local function map(array, fn)
  local result = {}
  for i, v in ipairs(array) do
    result[i] = fn(v, i)
  end
  return result
end

local function find(array, fn)
  for i, v in ipairs(array) do
    if fn(v, i) then
      return v
    end
  end
end

return {
  map = map,
  find = find,
}
