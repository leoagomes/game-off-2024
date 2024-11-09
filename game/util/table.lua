local function clone(t)
  local new = {}
  for k, v in pairs(t) do
    new[k] = v
  end
  return new
end

return {
  clone = clone,
}
