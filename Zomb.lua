Zomb = Class{}

function Zomb:init(def)
    Thing.init(self, def)
    self.direction = 'down' 
    self.speed = def.speed or WALKSPEED
    self.label = 'zomb'
end