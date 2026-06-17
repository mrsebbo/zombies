Zomb = Class{}

function Zomb:init(def)
    Thing.init(self, def)
    self.direction = 'down' 
    self.speed = def.speed or WALKSPEED
    self.label = 'zomb'
    self.player = player
    self.canwalk = true
end

function Zomb:update(dt)
    local targX, targY = self.x, self.y
    local hmove = false
    if player.x > self.x then
        targX = self.x + 1
    elseif player.x < self.x then
        targX = self.x -1 
    end
    if self.canwalk then
        if targX ~= self.x  and Thing.obstacles(self, {targX, targY}) then
            Thing.walk(self, {targX, targY})            
        else 
            targX = self.x
            if player.y > self.y then
                targY = self.y + 1
            elseif player.y < self.y then
                targY = self.y - 1
            end
        end
        if targY ~= self.y and Thing.obstacles(self, {targX, targY}) then
            Thing.walk(self, {targX, targY})
        end
    end
end

