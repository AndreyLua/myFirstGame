local resourceNormalClass =  {} 
local resourceClass =  require "scripts/resourcesGameObject/resourceClass"             
ResourceNormal = Class {__includes =resourceClass,
    value = 3,
}

function ResourceNormal:move(dt)
    self.x= self.x+self.ax*dt*4*k
    self.y= self.y+self.ay*dt*4*k2
end;

function ResourceNormal:draw()
    love.graphics.setColor(self.color1,self.color2,self.color3)
    rot('fill',self.x,self.y,7*k,7*k2,1,3.5*k,3.5*k2)
end;

function ResourceNormal:drawReceiveText()
    love.graphics.setColor(0.514,0.941,0.235,self.timerReceiveText)
    love.graphics.print("+3",self.x,self.y,-math.pi/2,0.35*k)    
end;

return  resourceNormalClass