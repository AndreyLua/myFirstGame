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
    text= "You can destroy meteorites without using an attack to get energy, health and resources.",
}
local BuyUpgrades = {}

StudySystem = {
    isEnabled = true,
    number = 2,
    States ={},
}
table.insert(StudySystem.States,Move)
table.insert(StudySystem.States,Atack)
table.insert(StudySystem.States,Resource)

function StudySystem:load()
    self.number = self.number+1
    print(self.number)
    Text:setText(self.States[self.number].text)
    Text:setLineSize(25)
    self.States[self.number]:load()
end

function StudySystem:update(dt)
    bodyTextPanel(130*k,screenHeight/2,1/2.3)
    Text:update(dt) 
    Player:studyBorder(160*1/2.3*k+130*k)
    self.States[self.number]:update()
end

function StudySystem:draw()
    Text:print(90*k,screenHeight/2,0.6)
    self.States[self.number]:draw()
    love.graphics.draw(studyUIBatch)
end

function Move:load()
    Move.Points:spawn(screenWidth/2,screenHeight/10)
    Move.Points:spawn(screenWidth/1.2,screenHeight/1.5)
end

function Move:update()
    studyUIBatch:clear()
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

function Atack:update()
    studyUIBatch:clear()
    if (#en<1) then
        StudySystem:load()
    end
end

function Atack:draw()
end

function Resource:load()
     allSpawn(obj,2,2)
     allSpawn(obj,1,1)
       allSpawn(obj,2,2)
     allSpawn(obj,1,1)
       allSpawn(obj,2,2)
     allSpawn(obj,1,1)
       allSpawn(obj,2,2)
     allSpawn(obj,1,1)
       allSpawn(obj,2,2)
     allSpawn(obj,1,1)
       allSpawn(obj,2,2)
     allSpawn(obj,1,1)
     
end

function Resource:update()
    studyUIBatch:clear()
   
end

function Resource:draw()
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