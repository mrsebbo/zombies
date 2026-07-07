PlayState = Class{__includes = BaseState}

PlayState.label = 'play'
PlayState.paused = false

function PlayState:enter(params)
    PlayState.level = params.level
    THINGS = {}
    for row = 0, VIRTUAL_WIDTH, 32 do
        table.insert(MAP, {})
        for tile = 0, VIRTUAL_HEIGHT, 32 do
            table.insert(MAP[#MAP],nil)
        end
    end
    for k, thing in pairs(MAPS[self.level]) do
        table.insert(THINGS, thing)
        MAP[thing.x][thing.y] = thing
    end
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('p') then 
        self.paused = not self.paused
    end
    if not self.paused then
        for k, thing in pairs(THINGS) do
            thing:update(dt)
        end
    end
end

function PlayState:render(dt)
    for k, thing in pairs(THINGS) do
        thing:render()

    end
    if self.paused then
        love.graphics.setColor(0,0,0,.6)
        love.graphics.rectangle('fill',0,0,VIRTUAL_WIDTH,VIRTUAL_HEIGHT)
        love.graphics.setColor(1,1,1,1)
        love.graphics.print('PAUSED', 100, 100)
    end
end