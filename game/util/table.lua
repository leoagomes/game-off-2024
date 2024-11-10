local function clone(t)
  local new = {}
  for k, v in pairs(t) do
    new[k] = v
  end
  return new
end

local function transform_values(t, fn)
  local new = {}
  for k, v in pairs(t) do
    new[k] = fn(v)
  end
  return new
end

return {
  clone = clone,
  transform_values = transform_values,
}
