local studySystem = {}

local ArrowToTarget = {
}
local studyUIBatch = love.graphics.newSpriteBatch(UISet)

local Move = {
    text= "Use the joystick to move the player to the marked points",
    Points = {},
}
local Atack = { 
    text= "Use the second finger for an extra touch to attack. Watch the energy",
}
local Resource = {
    text= "You can destroy meteorites without using an attack to get energy, health and resources",
    Target={
        value = nil
    },
}
local BuyUpgrades = {
    text = "You can spend resources to upgrade abilities or create new ones. Tap to menu button",
    LightButton ={
        flag = 0,
        value =0.1,
        width = 60*k,
        height = 60*k,
    },
}

StudySystem = {
    isEnabled = true,
    number = 3,
    States ={},
}
table.insert(StudySystem.States,Move)
table.insert(StudySystem.States,Atack)
table.insert(StudySystem.States,Resource)
table.insert(StudySystem.States,BuyUpgrades)

function StudySystem:load()
    self.number = self.number+1
    Text:setText(self.States[self.number].text)
    Text:setLineSize(25)
    self.States[self.number]:load()
end

function StudySystem:update(dt)
    studyUIBatch:clear()
    bodyTextPanel(130*k,screenHeight/2,1/2.3)
    Text:update(dt) 
    Player:studyBorder(160*1/2.3*k+130*k)
    self.States[self.number]:update(dt)
    StudySystem:movement(dt)
end

function StudySystem:draw()
    Text:print(90*k,screenHeight/2,0.55)
    self.States[self.number]:draw()
    love.graphics.draw(studyUIBatch)
end

function StudySystem:movement(dt)
    if love.keyboard.isDown('x') then
        allSpawn(obj,3,2)
    end
    if love.keyboard.isDown('z') then
        obj = {}
    end
end
      
function Move:load()
    Move.Points:spawn(screenWidth/2,screenHeight/10)
    Move.Points:spawn(screenWidth/1.2,screenHeight/1.5)
end

function Move:update(dt)
    Move.Points:collsionWithPlayer()
    ArrowToTarget:draw(self.Points[1])
    Move.Points:draw()
    if (#Move.Points<1) then 
        StudySystem:load()
    end
end

function Move:draw()
end

function Atack:load()
    allSpawn(en,2,1)
    en[#en].damage = 0 
end

function Atack:update(dt)
    if (#en<1) then
        StudySystem:load()
    end
end

function Atack:draw()
end

function Resource:load()
    allSpawn(obj,4,2)
    allSpawn(obj,4,1)
    self.Target:set(obj[#obj])
end

function Resource:update(dt)
    ArrowToTarget:draw(self.Target.value)
    self.Target:draw()
    for i =1,#obj do
        if (obj[i].f) then 
            Resource:objStudyBorder(i,160*1/2.3*k+130*k)
        end
    end
    if (self.Target.value and self.Target.value.health<0) then 
        self.Target:set(obj[#obj])
    end
    if (#obj<1) then 
        StudySystem:load()
    end
end

function Resource:draw()
end

function Resource.Target:set(target)
    self.value = target
end

function Resource.Target:draw()
    if ( self.value) then
        studyUIBatch:add(UIQuads.point,self.value.x-Player.Camera.x+40*k/2+screenWidth/2,self.value.y-Player.Camera.y+40*k2/2+screenHeight/2,0,k/14,k2/14,256/2, 256/2)
    end
end

function Resource:objStudyBorder(i,panelScale)
    if ( obj[i].x <  -borderWidth+obj[i].collScale*k/2+panelScale) then 
        obj[i].ax = -obj[i].ax
        obj[i].x = -borderWidth + 0.1*k+obj[i].collScale*k/2+panelScale
    end
end

function BuyUpgrades:load()
 
end

function BuyUpgrades:update(dt)
    BuyUpgrades.LightButton:upgrade(dt)
end

function BuyUpgrades:draw()
    love.graphics.setColor(1,1,1,self.LightButton.value)
    love.graphics.rectangle("fill",0,0,self.LightButton.width,self.LightButton.width,10)
    love.graphics.setColor(1,1,1,1)
end

function BuyUpgrades.LightButton:upgrade(dt)
    if ( self.flag == 1) then 
        self.value = self.value - 0.4*dt 
        if (self.value < 0.1) then 
            self.flag =0
        end
    else
        self.value = self.value + 0.4*dt 
        if (self.value > 0.5) then 
            self.flag =1
        end
    end
end

function Move.Points:spawn(x,y)
    local newPoint = {
        x = x,
        y = y,
    }
    table.insert(self,newPoint)
end

function Move.Points:draw()
    for i=1, #self do
         studyUIBatch:add(UIQuads.point,Move.Points[i].x-Player.Camera.x+40*k/2+screenWidth/2,Move.Points[i].y-Player.Camera.y+40*k2/2+screenHeight/2,0,k/10,k2/10,256/2, 256/2)
    end
end


function Move.Points:collsionWithPlayer()
    for i=#self, 1,-1 do
        if ( (math.pow((Player.x - Move.Points[i].x),2)+math.pow((Player.y - Move.Points[i].y),2))<3000*k) then
            explosionEffect:new(Move.Points[i].x-Player.Camera.x+40*k/2+screenWidth/2,Move.Points[i].y-Player.Camera.y+40*k2/2+screenHeight/2,12,0.9,0.8,0.21)
            table.remove(Move.Points,i)
        end  
    end
end

function ArrowToTarget:draw(target)
    if ( target) then 
        local angleToTarget = math.atan2(Player.x-target.x, Player.y - target.y)
        studyUIBatch:add(UIQuads.arrow,Player.x-Player.Camera.x+40*k/2+screenWidth/2,Player.y-Player.Camera.y+40*k2/2+screenHeight/2,-angleToTarget-math.pi/2,k/10,k2/10,-600,384/2)
    end
end

return studySystem