--[[
in keeping with a more iterative approach, this version of Main will start out 
including much of the functionality of an anticipated future PlayState. For now, 
I'm skipping art and animation to focus on functionality.
]]

love.graphics.setDefaultFilter('nearest', 'nearest')

push = require 'lib.push'
Class = require 'lib.class'

require 'Thing'
require 'Player'
require 'Crate'
require 'Zomb'

-- physical screen dimensions
WINDOW_WIDTH, WINDOW_HEIGHT = love.window.getDesktopDimensions()
WINDOW_WIDTH, WINDOW_HEIGHT = WINDOW_WIDTH*.8, WINDOW_HEIGHT*.8 --make the window a bit smaller than the screen itself

-- virtual resolution dimensions
VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

WALKSPEED = 57

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
    THINGS = {}
    for row = 0, VIRTUAL_WIDTH, 32 do
        table.insert(MAP, {})
        for tile = 0, VIRTUAL_HEIGHT, 32 do
            table.insert(MAP[#MAP],0)
        end
    end
    table.insert(THINGS, Crate {address = {5,5}})
    table.insert(THINGS, Crate {address = {5,4}})
    table.insert(THINGS, Crate {address = {5,3}})
    table.insert(THINGS, Crate {address = {5,2}})
    player = Player {address = {10,3}, speed = WALKSPEED}
    table.insert(THINGS, player)
    table.insert(THINGS, Zomb{address = {1,3}})
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

    local walkcounter = player.address[1] + player.speed * dt
    if walkcounter >= player.address[1] + 1 then 
        player.address[1] = player.address[1] + 1
    end
    reconcile(player.address, 2)

    love.keyboard.keysPressed = {}
end

function reconcile(address, type)
    for row = 1, #MAP do
        for col = 1, #MAP[1] do
            if MAP[row][col] == type then
                MAP[row][col] = 0
            end
            if row == address[1] and col == address[2] then
                MAP[row][col] = type
            end
        end
    end
end

function love.draw()
    push:start()
    love.graphics.setColor(.2,.2,.2, 1)
    for row = 0, VIRTUAL_WIDTH, 32 do
        for tile = 0, VIRTUAL_HEIGHT, 32 do
            love.graphics.rectangle('line', row, tile, 32, 32, 10, 5)
        end
    end
    --[[
    for row = 0, VIRTUAL_WIDTH, 32 do
        for tile = 0, VIRTUAL_HEIGHT, 32 do
            local spot = MAP[row/32 + 1][tile/32 + 1] 
            if spot == 1 then
                love.graphics.setColor(COLORS['crate'])
            elseif type(spot) == table then
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
    ]]--
    for k, thing in pairs(THINGS) do
        love.graphics.setColor(COLORS[thing.label])
        love.graphics.rectangle('fill', thing.address[1] * 32, thing.address[2] * 32, 32, 32)
    end
    

    push:finish()
end
