Player = Class{__includes = Thing}

function Player:init(def)
    Thing.init(self, def)
    self.direction = 'down' 
    self.speed = def.speed or WALKSPEED
    self.label = 'player'
    self.canwalk = true
end

function Player:update(dt)
    local destination = {}

    if love.keyboard.isDown('left') then
        self.direction = 'left'
        destination = self:setMove(self.direction)
    elseif love.keyboard.isDown('right') then
        self.direction = 'right'
        destination = self:setMove(self.direction)
    elseif love.keyboard.isDown('up') then
        self.direction = 'up'
        destination = self:setMove(self.direction)
    elseif love.keyboard.isDown('down') then
        self.direction = 'down'
        destination = self:setMove(self.direction)
    end
    if destination[2] and self.canwalk then
        local go, speed = Thing.obstacles(self,destination)
        if go then
            Thing.walk(self,destination, speed)
        end
    end
    Thing.update(self,dt)
end

--When a player pushes a crate, this function checks whether there's something on the other side
--before moving the crate. TODO: zombie squishing

function Player:blockage(place)
    local thirdX = addressMath(self.x, place[1])
    local thirdY = addressMath(self.y, place[2])
    local clear = false
    if not MAP[thirdX][thirdY] then 
        clear = true
    else
        if MAP[thirdX][thirdY].label == 'zomb' then
            local zombie = MAP[thirdX][thirdY]
            local fourthX = addressMath(place[1],thirdX)
            local fourthY = addressMath(place[2], thirdY)
            if Thing.OOBFinder({fourthX, fourthY}) and zombie.canwalk and not MAP[fourthX][fourthY] then
                zombie.canwalk = false
                Timer.tween(WALKSPEED* 2, {[zombie] = {x = fourthX, y = fourthY}}):finish(function()
                    Thing:reconcile(zombie)
                    zombie.canwalk = true
                end)
                clear = true
            else
                for k, thing in pairs(THINGS) do
                    if thing == zombie then 
                        table.remove(THINGS, k)
                    end
                end
                clear = true
            end
        end
    end

    if Thing.OOBFinder({thirdX, thirdY}) and clear then
        local thiscrate = MAP[place[1]][place[2]]
        Timer.tween(WALKSPEED* 2, {[MAP[place[1]][place[2]]] = {x = thirdX, y = thirdY}}):finish(function()
            Thing:reconcile(thiscrate)
        end)
        return true
    else return false
    end
end


function addressMath(player,obstacle)
    local factor = player - obstacle
    return obstacle - factor
end

function Player:setMove(dir)
    local toX, toY = self.x, self.y

    if dir == 'left' then
        toX = toX - 1
    elseif dir == 'right' then
        toX = toX + 1
    elseif dir == 'up' then
        toY = toY - 1
    else
        toY = toY + 1
    end
    return{toX,toY}
end
