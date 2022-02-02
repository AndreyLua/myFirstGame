local character = {}
local but1 = false
local but2 = false
local localY =screenHeight/2
local mousePosY = 0
local speedR = 0 
function character:update(dt)
    localY = localY - speedR*dt
    if ( localY <screenHeight/2 )then
        localY   = screenHeight/2
        speedR = 0
    end
    if ( localY >screenHeight*2-20*k )then
        localY   = screenHeight*2-20*k
        speedR = 0
    end
    if ( math.abs(speedR) < 800*k) then
        if ( localY > screenHeight+100*k and localY < screenHeight+105*k) then 
          speedR = 0
        end
    else
        if ( speedR>0) then
            speedR = speedR - 700* dt*k
        else
            speedR = speedR + 700* dt*k
        end
    end
    mouse.x,mouse.y=love.mouse.getPosition()
    if love.mouse.isDown(1)  then
       if ( flagtouch3 == false) then 
            mousePosY = mouse.y
        end 
        flagtouch3 =true
    else
        if (flagtouch3 == true and  math.abs( mouse.y - mousePosY ) > 40*k and mouse.x > screenWidth/2 and  mouse.x < screenWidth/2 + 250*k   ) then 
                textK = 0 
                if (  mouse.y >  mousePosY) then 
                    speedR = speedR- 1200*math.abs( mouse.y - mousePosY )/screenHeight
                else
                    speedR = speedR+ 1200*math.abs( mouse.y - mousePosY )/screenHeight
                end
                if ( math.abs( speedR) < 800) then
                    speedR =800* speedR / math.abs( speedR)
                end
        end
        if ( mouse.x > 0 and  mouse.x <60*k and mouse.y > 0 and  mouse.y <60*k2 and flagtouch3 == true) then
            exp = {}
            gamestate.switch(pause)
        end 
        but2 = false
        but1 = false
        flagtouch3 =false
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
    if ( speedR == 0) then
        love.graphics.setColor(1,1,1,1)
    else
        love.graphics.setColor(1,1,1,0.5)
    end
    playerDrawCharacter(localY,dt,1)
    love.graphics.draw(playerBatch)
    playerBatch:clear()
    playerDrawCharacter(localY-screenHeight/2-100*k,dt,2)
    love.graphics.draw(playerBatch)
    playerBatch:clear()
    playerDrawCharacter(localY-screenHeight-200*k,dt,3)
    love.graphics.draw(playerBatch)
    
    bodyButtonDirect(screenWidth/2,screenHeight/2+140*k2,but1,'left',-math.pi/2)
    bodyButtonDirect(screenWidth/2,screenHeight/2-140*k2,but2,'right',math.pi/2)
    love.graphics.draw(UIBatch)
    love.graphics.setColor(1,1,1,1)
    UIBatch:clear()
    bodyButton(screenWidth/2.2-math.sin(-math.pi/2)*310*k,screenHeight/2-math.cos(-math.pi/2)*310*k,but1)
    exit(0,0)
    love.graphics.draw(UIBatch)
    textButton("Select",screenWidth/2.2-math.sin(-math.pi/2)*310*k,screenHeight/2-math.cos(-math.pi/2)*310*k,but1,0.9)
    local fontWidth = font:getWidth(tostring(score))
    love.graphics.print(score,50*k/12, screenHeight/2+fontWidth/2*k2/2,-math.pi/2,k/2,k2/2)
    love.graphics.setColor(1,1,1,1) 
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 100, 10,0,k/2,k2/2)
end
function playerDrawCharacter(y,dt,tip)
    local xDraw =screenWidth/2
    local yDraw = y
    playerBatch:setColor(1,1,1,1)
    local clow1X =xDraw +playerDrawPar[tip].clowX*k2*math.sin(-math.pi/2+playerDrawPar[tip].clowR)*7/3
    local clow1Y =yDraw +playerDrawPar[tip].clowX*k2*math.cos(-math.pi/2+playerDrawPar[tip].clowR)*7/3
    local clow2X =xDraw +playerDrawPar[tip].clowX*k2*math.sin(-math.pi/2-playerDrawPar[tip].clowR)*7/3
    local clow2Y =yDraw+playerDrawPar[tip].clowX*k2*math.cos(-math.pi/2-playerDrawPar[tip].clowR)*7/3
    playerBatch:add(playerQuads[tip].clow1,clow1X,clow1Y,math.pi/2+math.pi+player.clowR,k/3,k2/3,playerDrawPar[tip].clowW1, playerDrawPar[tip].clowH)
    playerBatch:add(playerQuads[tip].clow2,clow2X,clow2Y,math.pi/2+math.pi-player.clowR,k/3,k2/3,playerDrawPar[tip].clowW2, playerDrawPar[tip].clowH)
    playerSledDrawCharacter(xDraw,yDraw ,dt,tip)
    playerBatch:add(playerQuads[tip].body,xDraw,yDraw,math.pi/2+math.pi,k/3,k2/3,playerDrawPar[tip].bodyW/2, playerDrawPar[tip].bodyH/2)
    playerBatch:setColor( 1, 1,1,0.8 )
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