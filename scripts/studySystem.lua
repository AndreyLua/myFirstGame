local studySystem = {}

local ArrowToTarget = {
  
  
}
local studyUIBatch = love.graphics.newSpriteBatch(UISet)

local Move = {
    text= "Use the joystick to move the player to the marked points",
    Point = {},
}
local Atack = {}
local Resource = {}
local BuyUpgrades = {}

StudySystem = {
    isEnabled = true,
    number = 1,
    States ={},
}



function StudySystem:load()
    Text:setText(Move.text)
    Text:setLineSize(20)
    Move.Point:spawn(500*k,200*k)
end

function StudySystem:update(dt)
    bodyTextPanel(130*k,screenHeight/2,1/2.3)
    Text:update(dt) 
    Player:studyBorder(160*1/2.3*k+130*k)
    
    Move:update()
end

function StudySystem:draw()
    UIBatch:clear()
    Text:print(90*k,screenHeight/2,0.6)
    Move:draw()
end


function StudySystem:drawUnderPlayer()
    love.graphics.draw(studyUIBatch)
end

function Move:update()
    studyUIBatch:clear()
    Move.Point:collsionWithPlayer()
    ArrowToTarget:draw(self.Point[1])
end

function Move:draw()
    love.graphics.push()
        love.graphics.translate(-Player.Camera.x+40*k/2+screenWidth/2,-Player.Camera.y+40*k2/2+screenHeight/2)
        Move.Point:draw()  
    love.graphics.pop()
end

function Move.Point:spawn(x,y)
    local newPoint = {
        x = x,
        y = y,
    }
    table.insert(self,newPoint)
end

function Move.Point:draw()
    for i=1, #self do
        love.graphics.circle('fill',Move.Point[i].x,Move.Point[i].y,10*k)
    end
end

function Move.Point:collsionWithPlayer()
    for i=#self, 1,-1 do
        if ( (math.pow((Player.x - Move.Point[i].x),2)+math.pow((Player.y - Move.Point[i].y),2))<4000*k) then
            table.remove(Move.Point,i)
        end  
    end
end

function ArrowToTarget:draw(target)
    if ( target) then 
        local angleToTarget = math.atan2(Player.x-target.x, Player.y - target.y)
        studyUIBatch:add(UIQuads.arrow,Player.x-Player.Camera.x+40*k/2+screenWidth/2,Player.y-Player.Camera.y+40*k2/2+screenHeight/2,-angleToTarget-math.pi/2,k/10,k2/10,-300,384/2)
    end
end

return studySystem