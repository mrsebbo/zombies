Zomb = Class{}

function Zomb:init(def)
    Thing.init(self, def)
    self.direction = 'down' 
    self.speed = def.speed or WALKSPEED * 1.3
    self.label = 'zomb'
    self.player = You
    self.canwalk = true
end

function Zomb:update(dt)
    local targX, targY = self.x, self.y
    local options = 0
    if self.canwalk then
        if self.player.x > self.x then
            targX = self.x + 1
            options = options + 1
        elseif self.player.x < self.x then
            targX = self.x -1 
            options = options + 1
        end
        if self.player.y > self.y then
            targY = self.y + 1
            options = options + 1
        elseif self.player.y < self.y then
            targY = self.y - 1
            options = options + 1
        end
        if options == 1 then
            -- WALKING AROUND OBSTACLES WIP
            if not Thing.walkIfYouCan(self, {targX, targY}) then
                local dir = math.random(2)
                if targX == self.x then
                    if dir == 1 then 
                        Thing.walkIfYouCan(self,{self.x + 1, self.y})
                    else
                        Thing.walkIfYouCan(self, {self.x - 1, self.y})
                    end
                else
                    if dir == 1 then 
                        Thing.walkIfYouCan(self,{self.x, self.y -1})
                    else
                        Thing.walkIfYouCan(self, {self.x, self.y + 1})
                    end
                end
            end
        elseif options == 2 then
            local dir = math.random(2)
            if dir == 1 then 
                Thing.walkIfYouCan(self,{targX, self.y})
            else
                Thing.walkIfYouCan(self, {self.x, targY})
            end
        end
    end
end

function Zomb:render()
    Thing.render(self)
end

