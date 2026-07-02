StartState = Class{__includes = BaseState}

StartState.label = 'start'

function StartState:init()
    big = love.graphics.newFont(24) 
    med = love.graphics.newFont(18)
    --love.graphics.setFont(font)
    local indent = 16
    lines  = {
        {r = 1, g = 1, b = 1, o = 0, x = indent, y = TILE_SIZE * 2, text = "CONSUMERS"},
        {r = 1, g = 1, b = 1, o = 0, x = indent, y = TILE_SIZE * 3, text = "W-A-S-D OR ARROW KEYS TO MOVE"},
        {r = 1, g = 1, b = 1, o = 0, x = indent, y = TILE_SIZE * 4, text = "P TO PAUSE, R TO RESTART,ESC TO QUIT"},
    }

    Timer.tween(1, {[lines[1]] = {o = 1}})
    Timer.after(1, function() Timer.tween(1, {[lines[2]] = {o = 1}}) end)
        --[[render text with 0 alpha: 
        CONSUMERS
        W-A-S-D OR ARROW KEYS TO MOVE
        P TO PAUSE, R TO RESTART,ESC TO QUIT]]  
end

function StartState:update(dt)

    --[[tween each line in in sequence
    :finish(function() 
        gStateMachine:change('play', {room = 1})
    end)]]
end

function writeALine(s,r,g,b,o,x,y,text)
    love.graphics.setColor(r,g,b,o)
    love.graphics.setFont(s)
    love.graphics.print(text, x, y)

end

function StartState:render()
        love.graphics.setDefaultFilter("nearest", "nearest", 1)
       --love.graphics.setColor(1,1,1, self.text.o)

        writeALine(big, 1,1,1,lines[1].o,lines[1].x,lines[1].y, lines[1].text)
        writeALine(med, 1,1,1,lines[2].o,lines[2].x,lines[2].y, lines[2].text)


        -- love.graphics.print("CONSUMERS", 14, 96)
        -- love.graphics.print("W-A-S-D OR ARROW KEYS TO MOVE",14, 32 * 4)
        -- love.graphics.print("P TO PAUSE, R TO RESTART, ESC TO QUIT", 14, 32 * 5)
end