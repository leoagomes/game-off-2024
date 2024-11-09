DEVELOPMENT = true
CONF = require('data/conf/default')

local conf_audio, conf_window, conf_modules

function love.conf(t)
  t.console = DEVELOPMENT

  t.identity = nil
  t.appendidentity = false -- search files in source directory before save directory (boolean)
  t.version = '11.5'
  t.accelerometerjoystick = false
  t.externalstorage = false
  t.gammacorrect = false

  CONF = require('data/conf')

  conf_audio(t.audio)
  conf_window(t.window)
  conf_modules(t.modules)
end

function conf_audio(audio)
  audio.mic = false
  audio.mixwithsystem = true
end

function conf_window(window)
  window.title = 'Untitled'
  window.icon = nil
  window.width = CONF.window.width
  window.height = CONF.window.height
  window.borderless = CONF.window.borderless
  window.resizable = CONF.window.resizable
  window.minwidth = CONF.window.min_width
  window.minheight = CONF.window.min_height
  window.fullscreen = CONF.window.fullscreen
  window.fullscreentype = CONF.window.fullscreentype
  window.vsync = CONF.window.vsync
  window.msaa = CONF.window.msaa
  window.display = CONF.window.display
  window.highdpi = CONF.window.highdpi
  window.usedpiscale = CONF.window.usedpiscale
  window.x = CONF.window.x
  window.y = CONF.window.y
  window.depth = nil
  window.stencil = nil
end

function conf_modules(modules)
  modules.audio = true
  modules.data = true
  modules.event = true
  modules.font = true
  modules.graphics = true
  modules.image = true
  modules.joystick = true
  modules.keyboard = true
  modules.math = true
  modules.mouse = true
  modules.physics = true
  modules.sound = true
  modules.system = true
  modules.thread = true
  modules.timer = true
  modules.touch = true
  modules.video = true
  modules.window = true
end
