local anim8 = require 'libs.anim8'
local baton = require 'libs.baton'
local _math = require 'util.math'

local player_data = {
  animation = require 'data.assets.player.animation',
  collision = require 'data.assets.player.collision',
}

local WALK_SPEED = 4 * 22
local RUN_SPEED = 8 * 22
local SPRINT_SPEED = 12 * 22
local JUMP_SPEED = 10 * 22
local AIR_SPEED = 4 * 22
local MAX_GROUND_SPEED = 10 * 22
local GROUND_ACCELERATION = 20 * 22
local GROUND_DECELERATION = 40 * 22
local GROUND_DECELERATION_ZERO_THRESHOLD = 10
local AIR_NUDGE = 4 * 22

return class {
  _debug_shape = { color = { 1, 0, 0, 0.5 }, },
  init = function(self, opt)
    self.signal = Signal()
    -- physics properties
    self.position = opt.position or Vector(0, 0)
    self.velocity = Vector(0, 0)
    self.force = Vector(0, 0)
    self.forces = opt.forces or {
      gravity = Vector(0, 30 * 9.81),
    }
    self.mass = 1
    -- collision
    self.shape = player_data.collision(self.position, opt.collider)
    self.shape.entity = self
    -- controls
    self.input = baton.new(opt.controls or require('data.conf.controls'))
    -- player state
    self.state = 'idle'
    self.facing = 'right'
    self.on_ground = false
    self.animation = player_data.animation()
    self.camera_tracked = true

    self.signal:register('physics:slide', function(message)
      if message.delta.y < 0 then
        self.signal:emit('physics:landed', message)
      end
      local bonk_threshold = 2 -- pixels
      local bonk_amount = (
        (message.delta.y > 0 and message.delta.y) or
        (math.abs(message.delta.x) > 0 and message.delta.x)
      )
      if bonk_amount and bonk_amount > bonk_threshold then
        self.signal:emit('physics:bonked', message)
      end
    end)
    self.signal:register('physics:landed', function(message)
      if not self.on_ground then
        self.signal:emit('event:land', message)
      end
      self.velocity.y = 0
    end)
    self.signal:register('input:jump', function()
      self.signal:emit('event:jump')
    end)
    self.signal:register('physics:bonked', function(message)
      local x, y = self.position.x, self.position.y
      local cx, cy = message.self.shape:bbox()
      local ox, oy = message.delta.x, message.delta.y
      -- print(inspect({
      --   velocity = { x = self.velocity.x, y = self.velocity.y },
      --   position = { x = x, y = y },
      --   self = { x = cx, y = cy },
      --   delta = { x = ox, y = oy },
      -- }))
      print('bonked!')
    end)

    -- transient states
    self.signal:register('event:jump', function()
      if self.on_ground then
        self.velocity.y = -JUMP_SPEED
        self.on_ground = false
        self.signal:emit('event:jump-rise')
      end
    end)
    self.signal:register('event:land', function()
      self.on_ground = true
      if self.velocity.x == 0 then
        self.signal:emit('event:idle')
      else
        self.signal:emit('event:walk')
      end
    end)
    -- final states
    self.signal:register('event:jump-rise', function()
      self:change_to('jump_rise')
    end)
    self.signal:register('event:jump-mid', function()
      self:change_to('jump_mid')
    end)
    self.signal:register('event:jump-fall', function()
      self:change_to('jump_fall')
    end)
    self.signal:register('event:idle', function()
      self:change_to('idle')
    end)
    self.signal:register('event:walk', function()
      self:change_to('walk')
    end)
    self.signal:register('event:run', function()
      self:change_to('run_blade_down')
    end)
    self.signal:register('event:sprint', function()
      self:change_to('sprint')
    end)
  end,
  update = function(self, dt)
    local state = self.state
    if state == 'jump_rise' or state == 'jump_mid' then
      local max_mid_threshold = 16
      if self.velocity.y > max_mid_threshold then
        self.signal:emit('event:jump-fall')
      elseif self.velocity.y > -max_mid_threshold then
        self.signal:emit('event:jump-mid')
      end
    end

    -- process movement
    local mx, my = self.input:get('move')
    self.facing = (mx < 0 and 'left') or (mx > 0 and 'right') or self.facing
    if self.on_ground then
      if mx == 0 then
        self.velocity.x = self.velocity.x + GROUND_DECELERATION * dt * -_math.sign(self.velocity.x)
        if math.abs(self.velocity.x) < GROUND_DECELERATION_ZERO_THRESHOLD then
          self.velocity.x = 0
        end
      else
        self.velocity.x = _math.clamp(
          self.velocity.x + mx * GROUND_ACCELERATION * dt,
          -MAX_GROUND_SPEED,
          MAX_GROUND_SPEED
        )
      end

      local x_speed = math.abs(self.velocity.x)
      if x_speed <= 0 then
        if state ~= 'idle' then
          self.signal:emit('event:idle')
        end
      elseif x_speed <= RUN_SPEED then
        if state ~= 'walk' then
          self.signal:emit('event:walk')
        end
      elseif x_speed <= SPRINT_SPEED then
        if state ~= 'run_blade_down' then
          self.signal:emit('event:run')
        end
      else
        if state ~= 'sprint' then
          self.signal:emit('event:sprint')
        end
      end
    else
      self.velocity.x = self.velocity.x + mx * AIR_NUDGE * dt
    end

    -- fix animation render direction
    local animation = self.animation[state]
    if animation then
      animation.animation.flippedH = self.facing == 'left'
    end
  end,
  change_to = function(self, state)
    self.state = state
    if self.animation[state] then
      local animation = self.animation[state].animation
      animation.flippedH = self.facing == 'left'
      animation:gotoFrame(1)
      animation:resume()
    end
  end,
}
