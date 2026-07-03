PlayState = Class{__includes = BaseState}

PlayState.label = 'play'

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
    for k, thing in pairs(THINGS) do
        thing:update(dt)
    end
end

function PlayState:render(dt)
    for k, thing in pairs(THINGS) do
        love.graphics.setColor(COLORS[thing.label])
        love.graphics.rectangle('fill', thing.x * 32 - 32, thing.y * 32 - 32, 32, 32)
    end
end