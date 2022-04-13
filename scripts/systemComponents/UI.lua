local UI = {}

Button = Class{
    init = function(self, x, y, width, height)
        self.isTappedFlag = false
        self.x = x
        self.y = y
        self.width = width
        self.height = height
    end;

    mouseOnTheButton = function (self)
        local flagMouseOnTheButton = false
        if ( (mouse.x > self.x - self.width /2) and (mouse.x < self.x + self.width /2) and (mouse.y > self.y - self.height /2) and (mouse.y < self.y + self.height /2) ) then
            flagMouseOnTheButton = true
        end
        return flagMouseOnTheButton
    end;
    
    isTapped = function (self)
        if love.mouse.isDown(1)  then
              if self.mouseOnTheButton(self) then 
                  self.isTappedFlag = true
              else
                  self.isTappedFlag = false
              end
        else
            if (self.isTappedFlag and self.mouseOnTheButton(self)) then 
                self.isTappedFlag = false 
                return true
            end
            self.isTappedFlag = false
        end
        return false
    end;
}

Slider = Class{
    init = function(self, x, y, width, height, value, minValue, maxValue)
        self.mouseAlpha = 0
        self.value = value
        self.minValue = minValue
        self.maxValue = maxValue
        self.startValue = value
        self.isPressedFlag = false
        self.isFistClickFlag = false
        self.x = x
        self.y = y
        self.width = width
        self.height = height
    end;

    mouseOnTheButton = function (self)
        local flagMouseOnTheButton = false
        if ( (mouse.x > self.x - self.width /2) and (mouse.x < self.x + self.width /2) and (mouse.y > self.y - self.height /2) and (mouse.y < self.y + self.height /2) ) then
            flagMouseOnTheButton = true
        end
        return flagMouseOnTheButton
    end;
    
    isPressed  = function (self)
        if love.mouse.isDown(1)  then
            if (self.mouseOnTheButton(self) and self.isFistClickFlag == false) then
                if (self.isPressedFlag == false) then
                    self.mouseAlpha = mouse.y
                    self.startValue = self.value
                end
                self.isPressedFlag = true
            end
            if (self.isPressedFlag) then 
                self.value =self.startValue+(self.mouseAlpha-mouse.y) /(1340*k/10)
            end
            self.isFistClickFlag = true
            if ( self.value > self.maxValue ) then
                self.value = self.maxValue
            end
            if (self.value < self.minValue) then
                self.value = self.minValue
            end
            return true 
        else
            self.isFistClickFlag = false
            self.isPressedFlag = false
            return false
        end
    end;
    
    getValue = function(self)
        return self.value
    end;
    
    draw = function(self)
        butChange(self.x,self.y,self.value,2)
    end;
} 




function butChange(x,y,xPoint,maxPointX)
    UIBatch:setColor(1,1,1,1)    
    UIBatch:add(UIQuads.butChange,x,y,-math.pi/2,k/5,k2/5,1340/2, 146/2)
    UIBatch:add(UIQuads.butPoint,x,y+1340*k/5/2-1340*k/5*xPoint/maxPointX,-math.pi/2,k/4,k2/4,120/2, 200/2)
end


function bodyButton(x,y,flag,dopLight)
    if (dopLight) then 
        if (flag) then 
            UIBatch:setColor(1-dopLight,1-dopLight,1-dopLight,0.6-dopLight)
            UIBatch:add(UIQuads.panel,x,y,-math.pi/2,k/4,k2/4,500,120)
            UIBatch:setColor(1,1,1,1) 
        else
            UIBatch:setColor(1-dopLight,1-dopLight,1-dopLight,1-dopLight)
            UIBatch:add(UIQuads.panel,x,y,-math.pi/2,k/4,k2/4,500,120)
            UIBatch:setColor(1,1,1,1) 
        end
    else
        if (flag) then 
            UIBatch:setColor(1,1,1,0.6)
            UIBatch:add(UIQuads.panel,x,y,-math.pi/2,k/4,k2/4,500,120)
            UIBatch:setColor(1,1,1,1) 
        else
            UIBatch:add(UIQuads.panel,x,y,-math.pi/2,k/4,k2/4,500,120)
        end
    end
end

function bodyButtonScale(x,y,flag,scale)
    if (flag) then 
        UIBatch:setColor(1,1,1,0.6)
        UIBatch:add(UIQuads.panel,x,y,-math.pi/2,k*scale,k2*scale,500,120)
        UIBatch:setColor(1,1,1,1) 
    else
        UIBatch:setColor(1,1,1,1)
        UIBatch:add(UIQuads.panel,x,y,-math.pi/2,k*scale,k2*scale,500,120)
    end
end

function bodyTextPanel(x,y)
    UIBatch:add(UIQuads.textPanel,x,y,-math.pi/2,k/3,k2/3,500,160)
end

function bodyButtonDirect(x,y,flag,direct,angle,scale)
    if ( angle == nil) then 
        if ( direct == 'left') then
            if (flag) then 
                UIBatch:setColor(1,1,1,0.6)
                UIBatch:add(UIQuads.butDirect,x,y,-math.pi/4-math.pi/2,k/3,k2/3,90,160)
                UIBatch:setColor(1,1,1,1) 
            else
                UIBatch:add(UIQuads.butDirect,x,y,-math.pi/4-math.pi/2,k/3,k2/3,90,160)
            end
        else
            if (flag) then 
                UIBatch:setColor(1,1,1,0.6)
                UIBatch:add(UIQuads.butDirect,x,y,-math.pi/4-math.pi,k/3,k2/3,90,160)
                UIBatch:setColor(1,1,1,1) 
            else
                UIBatch:add(UIQuads.butDirect,x,y,-math.pi/4-math.pi,k/3,k2/3,90,160)
            end
        end
    else
        if ( direct == 'left') then
            if (flag) then 
                UIBatch:setColor(1,1,1,0.6)
                UIBatch:add(UIQuads.butDirectRotated,x,y,angle,k/4,k2/4,160,160)
                UIBatch:setColor(1,1,1,1) 
            else
                UIBatch:add(UIQuads.butDirectRotated,x,y,angle,k/4,k2/4,160,160)
            end
        else
            if (flag) then 
                UIBatch:setColor(1,1,1,0.6)
                UIBatch:add(UIQuads.butDirectRotated,x,y,angle,k/4,k2/4,160,160)
                UIBatch:setColor(1,1,1,1) 
            else
                UIBatch:add(UIQuads.butDirectRotated,x,y,angle,k/4,k2/4,160,160)
            end
        end
    end
end

function textButton(name,x,y,flag,scale)
    if not(scale) then
        scale = 1 
    end
    local fontWidth = font:getWidth(name)
    local fontHeight = font:getHeight()
    if (flag) then 
        love.graphics.setColor(1,1,1,0.6)
        love.graphics.print(name, x-fontHeight/2*k2*scale,y+fontWidth/2*k*scale,-math.pi/2,k*scale,k2*scale)
        love.graphics.setColor(1,1,1,1)
    else
        love.graphics.print(name, x-fontHeight/2*k2*scale,y+fontWidth/2*k*scale,-math.pi/2,k*scale,k2*scale)
    end
end

function textButtonFixed(nameMas,x,y,flag,scale,state)
    if not(scale) then
        scale = 1 
    end
    local fontWidth = font:getWidth(nameMas[state])
    local fontHeight = font:getHeight()
    if (flag) then
        love.graphics.setColor(1,1,1,0.6)
        love.graphics.print(nameMas[state], x-fontHeight/2*k2*scale,y+fontWidth/2*k*scale,-math.pi/2,k*scale,k2*scale)
        love.graphics.setColor(1,1,1,1)
    else
        love.graphics.print(nameMas[state], x-fontHeight/2*k2*scale,y+fontWidth/2*k*scale,-math.pi/2,k*scale,k2*scale)
    end
end

function acceptBut(x,y,scale,flag) 
    if (flag) then 
        UIBatch:setColor(1,1,1,0.6)
        UIBatch:add(UIQuads.yes,x,y,-math.pi/2,k*scale,k2*scale,120,120)    
        UIBatch:setColor(1,1,1,1)
    else
        UIBatch:add(UIQuads.yes,x,y,-math.pi/2,k*scale,k2*scale,120,120)    
    end
end

function rejectBut(x,y,scale,flag) 
   if (flag) then 
        UIBatch:setColor(1,1,1,0.6)
        UIBatch:add(UIQuads.no,x,y,-math.pi/2,k*scale,k2*scale,120,120)  
        UIBatch:setColor(1,1,1,1)
    else
        UIBatch:add(UIQuads.no,x,y,-math.pi/2,k*scale,k2*scale,120,120)    
    end
end


function rewardSlot(img,x,y,scale,money)
    if (img) then 
        if ( img > 11 ) then 
            img = allSkills[img]
            UIBatch:add(UIQuads.tableSkillLegend,x,y,-math.pi/2,k*scale*1.2,k2*scale*1.2,180,180)      
            skillBatch:add(img,x,y,-math.pi/2,k*scale,k2*scale,160,160)
        else
            if ( img > 7 ) then 
                img = allSkills[img]
                UIBatch:add(UIQuads.tableSkillRare,x,y,-math.pi/2,k*scale*1.2,k2*scale*1.2,180,180)         
                skillBatch:add(img,x,y,-math.pi/2,k*scale,k2*scale,160,160)
            else
                img = allSkills[img]
                UIBatch:add(UIQuads.tableSkillNormal,x,y,-math.pi/2,k*scale*1.2,k2*scale*1.2,160,160)       
                skillBatch:add(img,x,y,-math.pi/2,k*scale,k2*scale,160,160)
            end
        end
    else
        if ( money == 0) then 
            UIBatch:add(UIQuads.tableSkillDestr,x,y,-math.pi/2,k*scale*1.2,k2*scale*1.2,160,160)
        else
            UIBatch:add(UIQuads.tableSkillNormal,x,y,-math.pi/2,k*scale*1.2,k2*scale*1.2,160,160)   
        end
    end    
end

function noRes(x,y,scale,par,dt,flag)
    if (par~= nil and flag~=nil and par >= 0) then 
        local fontWidth = font:getWidth('Need more resources')
        love.graphics.setColor(1,1,1,par) 
        love.graphics.print('Need more resources', x,y+fontWidth*k2*scale/2,-math.pi/2,k*scale,k2*scale)
        love.graphics.setColor(1,1,1,1)
        if ( par <=3 and flag ==true ) then
            return par+1*dt, flag
        else
            if ( par > 2 and flag ==true ) then 
                return par-1*dt,false
            else
                if (flag ==false and par >=0 ) then 
                    return par-1*dt,false
                end
            end
        end
    end
end

function sc(x,y)
    love.graphics.setLineWidth(2*k)
    love.graphics.setColor(0.731,0.845,0.873)
    love.graphics.rectangle('line',x,y-100*k2,35*k,200*k2)
    love.graphics.setColor(1,1,1,1)
end


function add()
  local x = 0
  local y = 0 
  if (mouse.x > 0 and  mouse.x <60*k and mouse.y > 0 and  mouse.y <60 *k2 and love.mouse.isDown(1))  then
      UIBatch:setColor(1,1,1,0.6)
      UIBatch:add(UIQuads.add,x+120/4*k2,y+125/4*k,-math.pi/2,k/4,k2/4,120, 125)
      UIBatch:setColor(1,1,1,1)
  else
      UIBatch:setColor(1,1,1,1)
      UIBatch:add(UIQuads.add,x+120/4*k2,y+125/4*k,-math.pi/2,k/4,k2/4,120, 125)
  end
  love.graphics.setColor(1,1,1,1)
end

function exit()
  local x = 0
  local y = 0 
  if (mouse.x > 0 and  mouse.x <60*k and mouse.y > 0 and  mouse.y <60 *k2 and love.mouse.isDown(1))  then
      UIBatch:setColor(1,1,1,0.6)
      UIBatch:add(UIQuads.ex,x+120/4*k2,y+125/4*k,-math.pi/2,k/4,k2/4,120, 125)
      UIBatch:setColor(1,1,1,1)
  else
      UIBatch:setColor(1,1,1,1)
      UIBatch:add(UIQuads.ex,x+120/4*k2,y+125/4*k,-math.pi/2,k/4,k2/4,120, 125)
  end
  love.graphics.setColor(1,1,1,1)
end

return UI