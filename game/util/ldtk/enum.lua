local array = require 'util.array'

return class {
  init = function(self, raw)
    self.raw = raw
    self.identifier = raw.identifier
    self.uid = raw.uid
    self.values = array.map(raw.values, function(val)
      return val.id
    end)
    self.values_set = array.to_set(self.values)
  end,
}
