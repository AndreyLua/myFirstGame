local character = {}
local butGL = false
local but1 = false
local but2 = false
local but3 = false
local mousePosY = 0

local butSelect =screenWidth / 2 + 250*k

local anglePlayerHeight = math.asin((140*k)/(screenWidth/2))
    
local xR =math.pi/2
local speedR = 0 
local xRMax = math.pi/2
function character:update(dt)
    mouse.x,mouse.y=love.mouse.getPosition()
    if love.mouse.isDown(1)  then
        if ( mouse.x > screenWidth/2-250*k and  mouse.x <screenWidth/2+200*k and mouse.y > 0 and  mouse.y <screenHeight and butGL ==false) then
            butGL = true
            mousePosY = mouse.y
        end
        
        if ( mouse.x >screenWidth-math.sin(math.pi/2+anglePlayerHeight)*screenWidth/2+50*k-50*k and  mouse.x <screenWidth-math.sin(math.pi/2+anglePlayerHeight)*screenWidth/2+50*k+50*k   and mouse.y > screenHeight/2-math.cos(math.pi/2+anglePlayerHeight)*screenWidth/2-50*k   and  mouse.y <screenHeight/2-math.cos(math.pi/2+anglePlayerHeight)*screenWidth/2+50*k  and math.abs(mouse.y - mousePosY)<=10*k and math.abs(xRMax-xR)<math.pi/8) then
            but1 = true
        end
        if ( mouse.x >screenWidth-math.sin(math.pi/2-anglePlayerHeight)*screenWidth/2+50*k-50*k and  mouse.x <screenWidth-math.sin(math.pi/2-anglePlayerHeight)*screenWidth/2+50*k+50*k   and mouse.y > screenHeight/2-math.cos(math.pi/2-anglePlayerHeight)*screenWidth/2-50*k   and  mouse.y <screenHeight/2-math.cos(math.pi/2-anglePlayerHeight)*screenWidth/2+50*k and math.abs(mouse.y - mousePosY)<=10*k and math.abs(xRMax-xR)<math.pi/8 ) then
            but2 = true
        end
        
        if ( mouse.x > butSelect-120*k/4 and  mouse.x <butSelect+120*k/4  and mouse.y > screenHeight/2-500*k/4  and  mouse.y <screenHeight/2+500*k/4) then
            but3 = true
        end
        
        flagtouch3 =true
    else
        if ( mouse.x > 0 and  mouse.x <60*k and mouse.y > 0 and  mouse.y <60*k2 and flagtouch3 == true) then
            AddSound(uiClick,0.3)
            exp = {}
            gamestate.switch(pause)
        end 
        if ( mouse.x >screenWidth-math.sin(math.pi/2+anglePlayerHeight)*screenWidth/2+50*k-50*k and  mouse.x <screenWidth-math.sin(math.pi/2+anglePlayerHeight)*screenWidth/2+50*k+50*k   and mouse.y > screenHeight/2-math.cos(math.pi/2+anglePlayerHeight)*screenWidth/2-50*k   and  mouse.y <screenHeight/2-math.cos(math.pi/2+anglePlayerHeight)*screenWidth/2+50*k and but1 == true ) then
            if ( speedR < 0 ) then 
                speedR = -6
            else
                speedR = -3
            end
            xRMax = xRMax-math.pi/2
            
            if (xRMax>= math.pi/2) then 
                AddSound(uiClick,0.3)
            end
        end
        if ( mouse.x >screenWidth-math.sin(math.pi/2-anglePlayerHeight)*screenWidth/2+50*k-50*k and  mouse.x <screenWidth-math.sin(math.pi/2-anglePlayerHeight)*screenWidth/2+50*k+50*k   and mouse.y > screenHeight/2-math.cos(math.pi/2-anglePlayerHeight)*screenWidth/2-50*k   and  mouse.y <screenHeight/2-math.cos(math.pi/2-anglePlayerHeight)*screenWidth/2+50*k and but2 == true ) then
            if ( speedR > 0 ) then 
                speedR = 6
            else
                speedR = 3
            end
            xRMax = xRMax+math.pi/2
            if (xRMax<= math.pi/2*3) then 
                AddSound(uiClick,0.3)
            end
        end
        
        if ( mouse.x > butSelect-120*k/4 and  mouse.x <butSelect+120*k/4  and mouse.y > screenHeight/2-500*k/4  and  mouse.y <screenHeight/2+500*k/4 and but3 == true) then
            AddSound(uiClick,0.3)
            ----Choose New Statistic
        end
        if ( mouse.x > screenWidth/2-250*k and  mouse.x <screenWidth/2+250*k and mouse.y > 0 and  mouse.y <screenHeight and  butGL == true) then
            if ( math.abs(mouse.y - mousePosY)>10*k) then
                if ((mouse.y - mousePosY) <0) then
                    if ( speedR < 0 ) then 
                        speedR = -6
                    else
                        speedR = -3
                    end
                    xRMax = xRMax-math.pi/2
                else
                    xRMax = xRMax+math.pi/2
                    if ( speedR > 0 ) then 
                        speedR = 6
                    else
                        speedR = 3
                    end
                end
            end
        end
        if (xRMax< math.pi/2) then 
            xRMax = math.pi/2
        end
        if (xRMax> math.pi/2*3) then 
            xRMax = math.pi/2*3
        end
        butGL = false
        but1 = false
        but2 = false
        but3 = false
        flagtouch3 =false
    end
    if (xR<xRMax and speedR>0) then
        xR = xR+(xRMax-xR)*speedR*dt
    else
        if (xR>=xRMax and speedR>0) then 
            speedR = 0
        end
    end

    if (xR>xRMax and speedR<0) then
        xR = xR+(xR-xRMax)*speedR*dt
    else
        if (xR<=xRMax and speedR<0) then 
            speedR = 0
        end
    end
end

function character:draw()
    local dt = love.timer.getDelta()
    UIBatch:clear()
    playerBatch:clear()
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(fon1,0,0,0,k,k2)
    love.graphics.draw(fon2,0,0,0,k,k2)
    love.graphics.draw(fon3,0,0,0,k,k2)
    sc(0,screenHeight/2)
    
    playerDrawCharacter(screenWidth-math.sin(xR)*screenWidth/2,screenHeight/2-math.cos(xR)*screenWidth/2 ,dt,1)
    love.graphics.draw(playerBatch)
    playerBatch:clear()
    playerDrawCharacter(screenWidth-math.sin(xR-math.pi/2)*screenWidth/2,screenHeight/2-math.cos(xR-math.pi/2)*screenWidth/2 ,dt,2)
    love.graphics.draw(playerBatch)
    playerBatch:clear()
    playerDrawCharacter(screenWidth-math.sin(xR-math.pi)*screenWidth/2,screenHeight/2-math.cos(xR-math.pi)*screenWidth/2 ,dt,3)
    love.graphics.draw(playerBatch)
    
  --  bodyButtonDirect(screenWidth-math.sin(xR+anglePlayerHeight)*screenWidth/2+50*k,screenHeight/2-math.cos(xR+anglePlayerHeight)*screenWidth/2,but1,'left',-math.pi/6-math.pi/2)
    bodyButtonDirect(screenWidth-math.sin(xR-anglePlayerHeight)*screenWidth/2+50*k,screenHeight/2-math.cos(xR-anglePlayerHeight)*screenWidth/2,but2,'right',math.pi/6+math.pi/2)
    
    bodyButtonDirect(screenWidth-math.sin(xR+anglePlayerHeight-math.pi/2)*screenWidth/2+50*k,screenHeight/2-math.cos(xR+anglePlayerHeight-math.pi/2)*screenWidth/2,but1,'left',-math.pi/6-math.pi/2)
    bodyButtonDirect(screenWidth-math.sin(xR-anglePlayerHeight-math.pi/2)*screenWidth/2+50*k,screenHeight/2-math.cos(xR-anglePlayerHeight-math.pi/2)*screenWidth/2,but2,'right',math.pi/6+math.pi/2)
    
    bodyButtonDirect(screenWidth-math.sin(xR+anglePlayerHeight-math.pi)*screenWidth/2+50*k,screenHeight/2-math.cos(xR+anglePlayerHeight-math.pi)*screenWidth/2,but1,'left',-math.pi/6-math.pi/2)
   -- bodyButtonDirect(screenWidth-math.sin(xR-anglePlayerHeight-math.pi)*screenWidth/2+50*k,screenHeight/2-math.cos(xR-anglePlayerHeight-math.pi)*screenWidth/2,but2,'right',math.pi/6+math.pi/2)
    
    love.graphics.draw(UIBatch)
    love.graphics.setColor(1,1,1,1)
    UIBatch:clear()
    bodyButton(butSelect,screenHeight/2,but3)
    exit()
    love.graphics.draw(UIBatch)
    textButton("Select",butSelect,screenHeight/2,but3,0.9)
  
    
    local fontWidth = font:getWidth(tostring(score))
    love.graphics.print(score,50*k/12, screenHeight/2+fontWidth/2*k2/2,-math.pi/2,k/2,k2/2)
    love.graphics.setColor(1,1,1,1) 
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 100, 10,0,k/2,k2/2)
end
function playerDrawCharacter(x,y,dt,tip)
    local xDraw =x
    local yDraw =y
    playerBatch:setColor(1,1,1,1)
    local clow1X =xDraw +playerDrawPar[tip].clowX*k2*math.sin(-math.pi/2+playerDrawPar[tip].clowR)*7/3
    local clow1Y =yDraw +playerDrawPar[tip].clowX*k2*math.cos(-math.pi/2+playerDrawPar[tip].clowR)*7/3
    local clow2X =xDraw +playerDrawPar[tip].clowX*k2*math.sin(-math.pi/2-playerDrawPar[tip].clowR)*7/3
    local clow2Y =yDraw+playerDrawPar[tip].clowX*k2*math.cos(-math.pi/2-playerDrawPar[tip].clowR)*7/3
    playerBatch:add(playerQuads[tip].clow1,clow1X,clow1Y,math.pi/2+math.pi+player.clowR,k/3,k2/3,playerDrawPar[tip].clowW1, playerDrawPar[tip].clowH)
    playerBatch:add(playerQuads[tip].clow2,clow2X,clow2Y,math.pi/2+math.pi-player.clowR,k/3,k2/3,playerDrawPar[tip].clowW2, playerDrawPar[tip].clowH)
    playerSledDrawCharacter(xDraw,yDraw ,dt,tip,opened)
    playerBatch:add(playerQuads[tip].body,xDraw,yDraw,math.pi/2+math.pi,k/3,k2/3,playerDrawPar[tip].bodyW/2, playerDrawPar[tip].bodyH/2)
    playerBatch:setColor(1,1,1,1)
    playerBatch:add(playerQuads[tip].wings,xDraw,yDraw,math.pi/2+math.pi,k/3,k2/3,playerDrawPar[tip].wingsW/2, playerDrawPar[tip].wingsH/2-playerDrawPar[tip].wingsX)
    local r ,g ,b = gradient(dt)
    playerBatch:setColor(r,g,b)
    playerBatch:add(playerQuads[tip].cristal,xDraw,yDraw,math.pi/2+math.pi,k/3,k2/3,playerDrawPar[tip].cristalW/2, playerDrawPar[tip].cristalH/2-playerDrawPar[tip].cristalX)
    
end
function playerSledDrawCharacter(x,y,dt,tip)
    for i = 1,10 do
        local radius =0.2*i
        playerBatch:setColor( 0.1*i, 0.1*i, 0.1*i )
        playerBatch:add(playerQuads[tip].tail,x+16*(10-i)*k,y,math.pi/2,k/3*radius,k2/3*radius,playerDrawPar[tip].tailW/2,playerDrawPar[tip].tailH/2)
    end
end

return character