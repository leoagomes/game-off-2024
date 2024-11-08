if arg[2] == "debug" then
    require("lldebug").start()
end

function love.load()
end

function love.update(dt)
end

function love.draw()
    love.graphics.print("Hello World!", 400, 300)
end

local love_errorhandler = love.errorhandler
function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end
