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
        local go = Thing.obstacles(self,destination)
        if go then  
            self.canwalk = false

            Timer.tween(self.speed, {[self] = {x = destination[1], y = destination[2]}}):finish(function()
                self.canwalk = true
                Thing:reconcile(self)
            end)
        end
    end
    Thing.update(self,dt)
end

--When a player pushes a crate, this function whether there's something on the other side
--before moving the crate. TODO: zombie squishing

function Player:blockage(place)
    local thirdX = addressMath(self.x, place[1])
    local thirdY = addressMath(self.y, place[2])
    if Thing.OOBFinder({thirdX, thirdY}) and not MAP[thirdX][thirdY] then
        local thiscrate = MAP[place[1]][place[2]]
        Timer.tween(WALKSPEED, {[MAP[place[1]][place[2]]] = {x = thirdX, y = thirdY}}):finish(function()
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
