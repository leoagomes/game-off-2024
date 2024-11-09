return class {
  init = function(self, raw)
    self.raw = raw
    self.identifier = raw.__identifier
    self.value = raw.__value
    self.type = raw.__type
  end,
}
