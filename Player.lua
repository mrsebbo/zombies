Player = Class{}

function Player:init(def)
    self.direction = 'down' 
    self.address = def.address
    self.speed = def.speed
end