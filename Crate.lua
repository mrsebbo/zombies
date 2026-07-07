Crate = Class{}

function Crate:init(def)
    Thing.init(self, def)
    self.address = def.address
    self.intact = true
    self.label = 'crate'
end

function Crate:update(dt)
    Thing.update(self, dt)
end

function Crate:render()
    Thing.render(self)
end