return class {
  init = function(self, raw)
    self.raw = raw
    self.alpha = raw.a
    self.flip = raw.f
    self.pixel = Vector(
      raw.px[1],
      raw.px[2]
    )
    self.source = Vector(
      raw.src[1],
      raw.src[2]
    )
    self.tile_id = raw.t
  end,
}
