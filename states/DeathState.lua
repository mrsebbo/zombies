DeathState = Class{__includes = BaseState}

DeathState.label = 'death'

function DeathState:update(dt)
    if love.keyboard.wasPressed('r') then
        for k = #THINGS, 1, -1 do
            table.remove(THINGS, k)
        end
        gStateMachine:change('play', {level = 1})
    end
end


function DeathState:render()
    for k, thing in pairs(THINGS) do
        thing:render()
    end
    love.graphics.setColor(0,0,0,.6)
    love.graphics.rectangle('fill',0,0,VIRTUAL_WIDTH,VIRTUAL_HEIGHT)
    love.graphics.setColor(1,1,1,1)
    love.graphics.print('YOU HAVE DIED', 100, 100)
end
