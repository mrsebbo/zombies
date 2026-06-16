Thing = Class{}

function Thing:init(def)
    self.x = def.address[1]
    self.y = def.address[2]
end

function Thing:update(dt)


end

function Thing:reconcile(thing)
    if MAP[thing.x][thing.y] ~= thing then
        for k, row in pairs(MAP) do
            for l, cell in pairs(MAP[k]) do
                if MAP[k][l] == thing then
                    MAP[k][l] = nil
                end
            end
        end
        MAP[thing.x][thing.y] = thing
    end
end