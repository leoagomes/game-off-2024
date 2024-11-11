local function clamp(value, min, max)
  return math.min(math.max(value, min), max)
end

local function sign(value)
  return value > 0 and 1 or value < 0 and -1 or 0
end

return {
  clamp = clamp,
  sign = sign,
}
