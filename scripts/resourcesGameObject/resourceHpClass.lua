local resourceHpClass =  {} 
local resourceClass =  require "scripts/resourcesGameObject/resourceClass"             
ResourceHp = Class {__includes =resourceClass,
}

function ResourceHp:move(dt)
    self.x= self.x+self.ax*dt*6*k
    self.y= self.y+self.ay*dt*6*k2
end;

function ResourceHp:collWithPlayer(i)
    if (self.timer == self.invTimer and  checkCollision(Player.x-20*k,Player.y-20*k2, 40*k, 40*k2,self.x,self.y,1*k,1*k2)) then
        AddSound(pickUp,0.1)
        Player:heal(0.1)
        resourceRemove(i)
    end
end;

function ResourceHp:draw()
    resBatch:add(resQuads.hp,self.x,self.y,self.angle+math.pi/2,k/19,k2/19,105,105)
end;

function ResourceHp:drawReceiveText()
    love.graphics.setColor(1,0.1,0.1,self.timerReceiveText)
    love.graphics.print("+HP",self.x,self.y,-math.pi/2,0.4*k)
end;

return  resourceHpClass