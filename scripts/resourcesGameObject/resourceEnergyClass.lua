local resourceEnergyClass =  {} 
local resourceClass =  require "scripts/resourcesGameObject/resourceClass"             
ResourceEnergy = Class {__includes =resourceClass,
}

function ResourceEnergy:move(dt)
    self.x= self.x+self.ax*dt*6*k
    self.y= self.y+self.ay*dt*6*k2
end;

function ResourceEnergy:collWithPlayer(i)
    if (self.timer == self.invTimer and  checkCollision(Player.x-20*k,Player.y-20*k2, 40*k, 40*k2,self.x,self.y,1*k,1*k2)) then
        AddSound(pickUp,0.1)
        Player:rechargeEnergy(0.1)
        resourceRemove(i)
    end
end;

function ResourceEnergy:draw()
    resBatch:add(resQuads.boost,self.x,self.y,self.angle+math.pi/2,k/13,k2/13,65,105)
end;

function ResourceEnergy:drawReceiveText()
    love.graphics.setColor(0.4,0.4,1,self.timerReceiveText)
    love.graphics.print("+ENERGY",self.x,self.y,-math.pi/2,0.3*k)
end;

return  resourceEnergyClass