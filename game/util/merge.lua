return function(a, b)
  if type(a) ~= 'table' or type(b) ~= 'table' then
    return b
  end

  local result = {}
  for k, v in pairs(a) do
    result[k] = v
  end
  return result
end
