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

NeedResourcesText = {
    timer = -0.1,
    flag = true,
}
function NeedResourcesText:reset()
    self.timer = -0.1
    self.flag = true
end

function NeedResourcesText:print(x,y,scale,dt)
    if (self.timer~= nil and self.flag~=nil and self.timer >= 0) then 
        local fontWidth = font:getWidth('Need more resources')
        love.graphics.setColor(1,1,1,self.timer) 
        love.graphics.print('Need more resources',x,y+fontWidth*k2*scale/2,-math.pi/2,k*scale,k2*scale)
        love.graphics.setColor(1,1,1,1)
        if ( self.timer <=3 and self.flag ==true ) then
            self.timer = self.timer+1*dt
        else
            if ( self.timer > 2 and self.flag ==true ) then 
                self.timer = self.timer-1*dt
                self.flag = false
            else
                if (self.flag ==false and self.timer >=0 ) then 
                    self.timer = self.timer-1*dt
                    self.flag = false
                end
            end
        end
    end
end

Text = {
    string ="",
    outputText ="",
    maxLineLength = 13,
    lineLength =0,
    lengthIndex = 0,
}

function Text:setText(text)
    self.string =text
    self.outputText =""
    self.maxLineLength = 13
    self.lineLength =0
    self.lengthIndex = 0
end

function Text:setLineSize(size)
    self.maxLineLength = size
end
function Text:update(dt) 
    if (self.lengthIndex<=#self.string) then 
        self.lengthIndex = self.lengthIndex+1
        self.lineLength = self.lineLength+1
        local textLine ="" 
        if (self.outputText:sub(#self.outputText,#self.outputText)=="_") then
            self.outputText = self.outputText:sub(0,#self.outputText-1)
        end
        textLine = self.string:sub(self.lengthIndex,self.lengthIndex)
        if ( self.lineLength>self.maxLineLength and self.string:sub(self.lengthIndex,self.lengthIndex) == " ") then
            self.lineLength = 0 
            textLine =textLine.."\n"
        end
        self.outputText = self.outputText..textLine.."_"
    end
end

function Text:print(x,y,scale)
    love.graphics.setColor(1,1,1,1)
    love.graphics.print(self.outputText,x,y+font:getWidth(tostring(self.outputText))/2,-3.14/2,scale*k,scale*k)
end


function playerDrawCharacter(x,y,tip,light)
    if (light == nil) then 
        light = 1
    else
        light = light+0.4
    end
    local xDraw =x
    local yDraw =y
    if ( tablePlayerTipOpened[tip] ) then 
        playerBatch:setColor(1,1,1,light)
    else
        playerBatch:setColor(0.2,0.2,0.2,light)
    end
    local clow1X =xDraw +playerTipDrawParametrs[tip].clowX*k2*math.sin(-math.pi/2+playerTipDrawParametrs[tip].clowR)*7/3
    local clow1Y =yDraw +playerTipDrawParametrs[tip].clowX*k2*math.cos(-math.pi/2+playerTipDrawParametrs[tip].clowR)*7/3
    local clow2X =xDraw +playerTipDrawParametrs[tip].clowX*k2*math.sin(-math.pi/2-playerTipDrawParametrs[tip].clowR)*7/3
    local clow2Y =yDraw+playerTipDrawParametrs[tip].clowX*k2*math.cos(-math.pi/2-playerTipDrawParametrs[tip].clowR)*7/3
    playerBatch:add(playerQuads[tip].clow1,clow1X,clow1Y,math.pi/2+math.pi+Player.Clows.angle,k/3*light,k2/3*light,playerTipDrawParametrs[tip].clowW1, playerTipDrawParametrs[tip].clowH)
    playerBatch:add(playerQuads[tip].clow2,clow2X,clow2Y,math.pi/2+math.pi-Player.Clows.angle,k/3*light,k2/3*light,playerTipDrawParametrs[tip].clowW2, playerTipDrawParametrs[tip].clowH)
    playerSledDrawCharacter(xDraw,yDraw,tip,light)
    playerBatch:add(playerQuads[tip].body,xDraw,yDraw,math.pi/2+math.pi,k/3*light,k2/3*light,playerTipDrawParametrs[tip].bodyW/2, playerTipDrawParametrs[tip].bodyH/2)
    
    if ( tablePlayerTipOpened[tip] ) then 
        playerBatch:setColor(1,1,1,light)
    else
        playerBatch:setColor(0.2,0.2,0.2,light)
    end
    playerBatch:add(playerQuads[tip].wings,xDraw,yDraw,math.pi/2+math.pi,k/3*light,k2/3*light,playerTipDrawParametrs[tip].wingsW/2, playerTipDrawParametrs[tip].wingsH/2-playerTipDrawParametrs[tip].wingsX)
     
    if ( tablePlayerTipOpened[tip] ) then 
        playerBatch:setColor(1,1,1,light)
    else
        playerBatch:setColor(0.2,0.2,0.2,light)
    end
    playerBatch:add(playerQuads[tip].cristal,xDraw,yDraw,math.pi/2+math.pi,k/3*light,k2/3*light,playerTipDrawParametrs[tip].cristalW/2,  playerTipDrawParametrs[tip].cristalH/2-playerTipDrawParametrs[tip].cristalX)
    
end

function playerSledDrawCharacter(x,y,tip,light)
    if (light == nil) then 
        light = 1
    end
    for i = 1,10 do
        local radius =0.2*i*light
        if ( tablePlayerTipOpened[tip] ) then 
             playerBatch:setColor( 0.1*i, 0.1*i, 0.1*i,light)
        else
            playerBatch:setColor(0.2,0.2,0.2,light)
        end
        playerBatch:add(playerQuads[tip].tail,x+16*(10-i)*k,y,math.pi/2,k/3*radius*light,k2/3*radius*light,playerTipDrawParametrs[tip].tailW/2,playerTipDrawParametrs[tip].tailH/2)
    end
end



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

function bodyTextPanel(x,y,scale)
    if (scale == nil) then
        scale = 1/3
    end
    UIBatch:add(UIQuads.textPanel,x,y,-math.pi/2,k*scale,k2*scale,500,160)
end

function bodyButtonDirect(x,y,flag,direct,angle,scale)
    if ( angle == nil) then 
        if ( direct == 'left') then
            if (flag) then 
                UIBatch:setColor(1,1,1,0.6)
                UIBatch:add(UIQuads.butDirectRotated,x,y,-math.pi/4-math.pi/2,k/3,k2/3,160,160)
                UIBatch:setColor(1,1,1,1) 
            else
                UIBatch:add(UIQuads.butDirectRotated,x,y,-math.pi/4-math.pi/2,k/3,k2/3,160,160)
            end
        else
            if (flag) then 
                UIBatch:setColor(1,1,1,0.6)
                UIBatch:add(UIQuads.butDirectRotated,x,y,-math.pi/4-math.pi,k/3,k2/3,160,160)
                UIBatch:setColor(1,1,1,1) 
            else
                UIBatch:add(UIQuads.butDirectRotated,x,y,-math.pi/4-math.pi,k/3,k2/3,160,160)
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
    if (img~=nil) then 
        local x2, y2, w, h = img.Interface.slotRarityImage:getViewport()
        UIBatch:add(img.Interface.slotRarityImage,x,y,-math.pi/2,k*scale*1.2,k2*scale*1.2,w/2,h/2)      
        skillBatch:add(img.Interface.image,x,y,-math.pi/2,k*scale,k2*scale,160,160)
    else
        if ( money == 0) then 
            UIBatch:add(UIQuads.tableSkillDestr,x,y,-math.pi/2,k*scale*1.2,k2*scale*1.2,160,160)
        else
            UIBatch:add(UIQuads.tableSkillNormal,x,y,-math.pi/2,k*scale*1.2,k2*scale*1.2,160,160)   
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