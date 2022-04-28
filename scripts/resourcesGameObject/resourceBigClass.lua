local resourceBigClass =  {} 
local resourceClass =  require "scripts/resourcesGameObject/resourceClass"             
ResourceBig = Class {__includes =resourceClass,
    value = 5,
}

function ResourceBig:move(dt)
    self.x= self.x+self.ax*dt*4*k
    self.y= self.y+self.ay*dt*4*k2
end;

function ResourceBig:draw()
    love.graphics.setColor(self.color1,self.color2,self.color3)
    rot('fill',self.x,self.y,9*k,9*k2,1,4.5*k,4.5*k2)
end;

function ResourceBig:drawReceiveText()
    love.graphics.setColor(0.8,0.8,0.235,self.timerReceiveText)
    love.graphics.print("+5",self.x,self.y,-math.pi/2,0.4*k)   
end;

return  resourceBigClass