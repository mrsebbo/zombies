--[[
in keeping with a more iterative approach, this version of Main will start out 
including much of the functionality of an anticipated future PlayState. For now, 
I'm skipping art and animation to focus on functionality.
]]

love.graphics.setDefaultFilter('nearest', 'nearest')

push = require 'lib.push'
Class = require 'lib.class'

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

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {fullscreen = false, resizable = true })

    love.keyboard.keysPressed = {}
    MAP = {}
    for row = 0, VIRTUAL_WIDTH, 32 do
        table.insert(MAP, {})
        for tile = 0, VIRTUAL_HEIGHT, 32 do
            table.insert(MAP[#MAP],0)
        end
    end

    MAP[5][5] = 1
    MAP[5][4] = 1
    MAP[5][3] = 1
    MAP[5][2] = 1
    MAP[10][3] = 2
    MAP[1][3] = 3

    COLORS = {
        crate = {1,.7,0,.6},
        player = {0,1,0,.6},
        zomb = {1,0,1,.6}
    }


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

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
    love.graphics.setColor(.2,.2,.2, 1)
    for row = 0, VIRTUAL_WIDTH, 32 do
        for tile = 0, VIRTUAL_HEIGHT, 32 do
            love.graphics.rectangle('line', row, tile, 32, 32, 10, 5)
        end
    end
    for row = 0, VIRTUAL_WIDTH, 32 do
        for tile = 0, VIRTUAL_HEIGHT, 32 do
            local spot = MAP[row/32 + 1][tile/32 + 1] 
            if spot == 1 then
                love.graphics.setColor(COLORS['crate'])
            elseif spot == 2 then
                love.graphics.setColor(COLORS['player'])
            elseif spot == 3 then
                love.graphics.setColor(COLORS['zomb'])
            end   
            if spot ~= 0 then
                love.graphics.rectangle('fill', row, tile, 32, 32)
            end
            love.graphics.setColor(.2,.2,.2, 1)


        end
    end
    

    push:finish()
end
