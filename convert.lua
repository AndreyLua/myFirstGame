local convert = {}
local test1 = love.graphics.newImage("assets/test1.png")
local but1 = false
local masSkill = {}
local mousePosX = 0 
local mousePosY = 0 
local speedR = 0 
function convert:update(dt)
    mouse.x,mouse.y=love.mouse.getPosition()
     if love.keyboard.isDown('w') then
       kekKK = kekKK +0.01
    end
     if love.keyboard.isDown('s') then
       kekKK = kekKK -0.01
    end
    if love.mouse.isDown(1)  then
        if ( flagtouch3 == false) then 
            mousePosX = mouse.x
            mousePosY = mouse.y
        end
        flagtouch3 =true
    else
        if ( mouse.x > 0 and  mouse.x <60*k and mouse.y > 0 and  mouse.y <60*k2 and flagtouch3 == true) then
            exp = {}
            gamestate.switch(game)
        end 
        if (flagtouch3 == true and  math.abs( mouse.y - mousePosY ) > 40*k ) then 
            speedR = speedR+ (mousePosY-mouse.y)*dt
        end
        flagtouch3 =false
    end
end

function convert:draw()
local dt = love.timer.getDelta()
kekKK = kekKK+ speedR*k/200
if ( speedR > 0.1) then
    speedR = speedR -4*dt
end
if ( speedR < -0.1) then
    speedR = speedR +4*dt
end
UIBatch:clear()
skillBatch:clear()
love.graphics.setColor(1,1,1,1)
love.graphics.draw(fon1,0,0,0,k,k2)
love.graphics.draw(fon2,0,0,0,k,k2)
love.graphics.draw(fon3,0,0,0,k,k2)
love.graphics.draw(test1,0,0,0,k/1.666,k2/1.666)
exit(0,0)
sc(0,screenHeight/2)
--slot(screenWidth/2.2,screenHeight/2,0.4)
--slot(img,x,y,ox,oy,scale)
for i = 1 , #playerSkills do 
    slot(playerSkills[i].img,playerSkills[i].x,playerSkills[i].y,playerSkills[i].ox,playerSkills[i].oy,0.4) 
end
for i = 1 , 20 do 
    local angle = -i*math.pi/6+math.pi/6+kekKK
    local light = 0.7
    if ( angle < -math.pi- math.pi /6 ) then
        angle = -math.pi - math.pi /6
    end 
    if ( angle > math.pi/6 ) then
        angle = math.pi/6
    end 
    local scale = 0.05
    if ( angle>= -math.pi /2 and  angle < 0 ) then
          scale = scale+math.abs(angle)/10
          light = light+math.abs(angle)/2
    else
          scale = (scale+math.abs(math.pi/2)/10) - math.abs(angle+math.pi/2)/10
          light = (light+math.abs(math.pi/2)/2) - math.abs(angle+math.pi/2)/2
    end 
    if ( scale <0) then
        scale = 0 
    end
    if (playerSkills[i]) then 
        slot(playerSkills[i].img,screenWidth/2.2-math.sin(angle)*160*k	,screenHeight/2- math.cos(angle)*160*k,160,160,scale,light) 
    else
        slot(nil,screenWidth/2.2-math.sin(angle)*160*k	,screenHeight/2- math.cos(angle)*160*k,160,160,scale,light) 
    end
end
bodyButton(screenWidth/1.17,screenHeight/2,but1)
love.graphics.draw(UIBatch)
love.graphics.draw(skillBatch)
textButton("Update",screenWidth/1.17,screenHeight/2,but1,0.9)
--love.graphics.circle('line',screenWidth/2,screenHeight/2,220)

local fontWidth = font:getWidth(tostring(score))
love.graphics.print(score,50*k/12, screenHeight/2+fontWidth/2*k2/2,-math.pi/2,k/2,k2/2)

love.graphics.setColor(1,1,1,1) 


love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 100, 10,0,k/2,k2/2)
end



return convert