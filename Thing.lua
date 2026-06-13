Thing = Class{}

function Thing:init(def)
    self.x = def.address[1]
    self.y = def.address[2]
end

function Thing:update(dt)


end

function Thing:reconcile(player)
    print(player.y)
    if MAP[player.x][player.y] ~= player then
        for k, row in pairs(MAP) do
            for l, cell in pairs(MAP[k]) do
                if MAP[k][l] == player then
                    MAP[k][l] = nil
                end
            end
        end
        MAP[player.x][player.y] = player
    end
end