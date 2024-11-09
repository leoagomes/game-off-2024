local json = require('util.json')

return {
  data = json.decode_file('game/data/levels/test/level.ldtk'),
}
