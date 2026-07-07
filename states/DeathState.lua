DeathState = Class{__includes = BaseState}

DeathState.label = 'death'

function DeathState:render()
    for k, thing in pairs(THINGS) do
        thing:render()
    end
    love.graphics.setColor(0,0,0,.6)
    love.graphics.rectangle('fill',0,0,VIRTUAL_WIDTH,VIRTUAL_HEIGHT)
    love.graphics.setColor(1,1,1,1)
    love.graphics.print('YOU HAVE DIED', 100, 100)
end
