PlayState = Class{__includes = BaseState}

PlayState.label = 'play'
PlayState.paused = false
PlayState.startingx = 10
PlayState.startingy = 3

function PlayState:enter(params)
    PlayState.level = params.level or 1
    THINGS = {}
    MAP = {}
    for row = 1, ROOM_WIDTH do
        table.insert(MAP, {})
        for tile = 1, ROOM_HEIGHT do
            table.insert(MAP[#MAP],nil)
        end
    end
    for k, description in pairs(MAPS[self.level]) do
        local thing = {}
        if description.label == 'player' then 
            thing = description
            thing.dead = false 
            thing.x = 10
            thing.y = 3
        elseif description.label == 'Crate' then
            thing = Crate({address = description.address})
        elseif description.label == 'Zomb' then
            thing = Zomb({address = description.address})
        end
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