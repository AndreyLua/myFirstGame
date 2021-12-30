local convert = {}
local but1 = false
local masSkill = {}
local mousePosX = 0 
local mousePosY = 0 
local speedR = 0 
local xR = 0 
function convert:update(dt)
    mouse.x,mouse.y=love.mouse.getPosition()
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
            if (  mouse.y >  mousePosY) then 
                speedR = speedR- 10*math.abs( mouse.y - mousePosY )/screenHeight
            else
                speedR = speedR+ 10*math.abs( mouse.y - mousePosY )/screenHeight
            end
            if ( math.abs( speedR) < 2) then
                speedR =2* speedR / math.abs( speedR)
            end
        end
        flagtouch3 =false
    end
end

function convert:draw()
local dt = love.timer.getDelta()
xR = xR+ speedR*dt
if ( speedR > 0.4) then
    speedR = speedR -5*dt
else
    if ( (xR / (math.pi/6))%1   <0.06 and math.abs(speedR)< 1.5) then
        speedR = 0
      --  print((xR-(xR%(math.pi/6))) / (math.pi/6)) 
    end
end
if ( speedR < -0.4) then
    speedR = speedR+5*dt
else
    if ( (xR / (math.pi/6))%1   <0.06 and math.abs(speedR)< 1.5) then
        speedR = 0
      --  print((xR-(xR%(math.pi/6))) / (math.pi/6)) 
    end
end
if ( xR < -math.pi/2) then
    xR = -math.pi/2
    speedR = 0 
end
if ( xR >math.pi*2.5+math.pi/6) then
    xR =math.pi*2.5+math.pi/6
    speedR = 0 
end

UIBatch:clear()
skillBatch:clear()
love.graphics.setColor(1,1,1,1)
love.graphics.draw(fon1,0,0,0,k,k2)
love.graphics.draw(fon2,0,0,0,k,k2)
love.graphics.draw(fon3,0,0,0,k,k2)
exit(0,0)
sc(0,screenHeight/2)

local indexR = xR / (math.pi/6)
if ( xR%(math.pi/6) > math.pi/12) then
    indexR = math.ceil(xR / (math.pi/6))
else
    indexR = math.floor(xR / (math.pi/6))
end
if ( playerSkills[indexR+4]) then 
    slot(playerSkills[indexR+4].img,screenWidth/2.2,screenHeight/2,160,160,0.4) 
else
    slot(nil,screenWidth/2.2,screenHeight/2,160,160,0.4)   
end

for i = 1 , 20 do 
    local angle = -i*math.pi/6+math.pi/6+ xR
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
bodyButtonDirect(screenWidth/2.2-math.sin(-math.pi/1.4)*300*k,screenHeight/2-math.cos(-math.pi/1.4)*300*k,false,'left')
bodyButtonDirect(screenWidth/2.2-math.sin(-math.pi/3.5)*300*k,screenHeight/2-math.cos(-math.pi/3.5)*300*k,false,'right')
bodyButton(screenWidth/2.2-math.sin(-math.pi/2)*310*k,screenHeight/2-math.cos(-math.pi/2)*310*k,but1)
love.graphics.draw(UIBatch)
love.graphics.draw(skillBatch)
textButton("Update",screenWidth/2.2-math.sin(-math.pi/2)*310*k,screenHeight/2-math.cos(-math.pi/2)*310*k,but1,0.9)
--love.graphics.circle('line',screenWidth/2,screenHeight/2,220)

local fontWidth = font:getWidth(tostring(score))
love.graphics.print(score,50*k/12, screenHeight/2+fontWidth/2*k2/2,-math.pi/2,k/2,k2/2)

love.graphics.setColor(1,1,1,1) 


love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 100, 10,0,k/2,k2/2)
end



return convert