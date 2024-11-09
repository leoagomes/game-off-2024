-- raw baton control configuration
return {
  controls = {
    left = {'key:left', 'key:a', 'axis:leftx-', 'button:dpleft'},
    right = {'key:right', 'key:d', 'axis:leftx+', 'button:dpright'},
    up = {'key:up', 'key:w', 'axis:lefty-', 'button:dpup'},
    down = {'key:down', 'key:s', 'axis:lefty+', 'button:dpdown'},
    jump = {'key:space', 'button:a'},
    attack = {'key:x', 'button:b'},
    pause = {'key:escape', 'button:start'},
  },
  pairs = {
    move = {'left', 'right', 'up', 'down'},
  },
}
