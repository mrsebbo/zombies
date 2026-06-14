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
        local go = self:obstacles(destination)
        if go then  
            self.canwalk = false

            Timer.tween(0.25, {[self] = {x = destination[1], y = destination[2]}}):finish(function()
                self.canwalk = true
                Thing:reconcile(self)
            end)
        end
    end
    Thing.update(self,dt)
end

function Player:obstacles(place)
    if place[1] < 1 or place[1] > VIRTUAL_WIDTH/32 then 
        return false 
    elseif place[2] < 1 or place[2] > VIRTUAL_HEIGHT/32 then 
        return false
    elseif MAP[place[1]][place[2]] ~= nil  then 
        return false
    end
    return true
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
