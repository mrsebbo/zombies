--[[
in keeping with a more iterative approach, this version of Main will start out 
including much of the functionality of an anticipated future PlayState. For now, 
I'm skipping art and animation to focus on functionality.
]]

love.graphics.setDefaultFilter('nearest', 'nearest')

push = require 'lib.push'

-- physical screen dimensions
WINDOW_WIDTH, WINDOW_HEIGHT = love.window.getDesktopDimensions()
WINDOW_WIDTH, WINDOW_HEIGHT = WINDOW_WIDTH*.8, WINDOW_HEIGHT*.8 --make the window a bit smaller than the screen itself

-- virtual resolution dimensions
VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

function love.load()
    
    -- window bar title
    love.window.setTitle('Consumers')

    -- seed the RNG
    math.randomseed(os.time())

    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true,
        display = 2
    })

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {fullscreen = false })

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    
    -- add to our table of keys pressed this frame
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

function love.mouse.wasClicked()
    return love.mouse.isDown(1)
end

function love.update(dt)
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()

    push:finish()
end
