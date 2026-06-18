Thing = Class{}

function Thing:init(def)
    self.x = def.address[1]
    self.y = def.address[2]
end

function Thing:update(dt)


end

function Thing.OOBFinder(place)
    if place[1] < 1 or place[1] > VIRTUAL_WIDTH/32 then 
        return false 
    elseif place[2] < 1 or place[2] > VIRTUAL_HEIGHT/32 then 
        return false
    else return true
    end
end


function Thing:obstacles(place)
    if not Thing.OOBFinder(place) then return false
    elseif MAP[place[1]][place[2]]  then 
        if MAP[place[1]][place[2]].label == 'crate' then
            if self.label == 'player' then
                return self:blockage(place)
            else return false
            end
        else return false
        end
    end
    return true
end

function Thing:walk(destination, speed)
    self.canwalk = false
    MAP[destination[1]][destination[2]] = "!"
    Timer.tween(speed or self.speed, {[self] = {x = destination[1], y = destination[2]}}):finish(function()
        self.canwalk = true
        Thing:reconcile(self)
    end)
end

--function to ensure that Thing's internal X and Y fields line up with the MAP coordinates.
--should be called after every move.
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