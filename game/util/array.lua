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

local function to_set(array)
  local set = {}
  for _, v in ipairs(array) do
    set[v] = true
  end
  return set
end

return {
  map = map,
  find = find,
  to_set = to_set,
}
