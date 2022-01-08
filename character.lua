local character = {}
local but1 = false
local but2 = false
function character:update(dt)
    mouse.x,mouse.y=love.mouse.getPosition()
    if love.mouse.isDown(1)  then
    
        flagtouch3 =true
    else
        if ( mouse.x > 0 and  mouse.x <60*k and mouse.y > 0 and  mouse.y <60*k2 and flagtouch3 == true) then
            exp = {}
            gamestate.switch(game)
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
exit(0,0)
sc(0,screenHeight/2)
playerDrawCharacter(dt)
love.graphics.draw(playerBatch)
bodyButtonDirect(screenWidth/2,screenHeight/2+170*k2,but1,'left',-math.pi/2)
bodyButtonDirect(screenWidth/2,screenHeight/2-170*k2,but2,'right',math.pi/2)
bodyButton(screenWidth/2.2-math.sin(-math.pi/2)*310*k,screenHeight/2-math.cos(-math.pi/2)*310*k,but1)
love.graphics.draw(UIBatch)
textButton("Select",screenWidth/2.2-math.sin(-math.pi/2)*310*k,screenHeight/2-math.cos(-math.pi/2)*310*k,but1,0.9)


local fontWidth = font:getWidth(tostring(score))
love.graphics.print(score,50*k/12, screenHeight/2+fontWidth/2*k2/2,-math.pi/2,k/2,k2/2)

love.graphics.setColor(1,1,1,1) 


love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 100, 10,0,k/2,k2/2)
end
function playerDrawCharacter(dt)
    local xDraw = screenWidth/2
    local yDraw = screenHeight/2
    
    playerBatch:setColor(1,1,1,1)
    local clow1X =xDraw +playerDrawPar[playerAbility.tip].clowX*k2*math.sin(-math.pi/2+playerDrawPar[playerAbility.tip].clowR)*7/3
    local clow1Y =yDraw +playerDrawPar[playerAbility.tip].clowX*k2*math.cos(-math.pi/2+playerDrawPar[playerAbility.tip].clowR)*7/3
    local clow2X =xDraw +playerDrawPar[playerAbility.tip].clowX*k2*math.sin(-math.pi/2-playerDrawPar[playerAbility.tip].clowR)*7/3
    local clow2Y =yDraw+playerDrawPar[playerAbility.tip].clowX*k2*math.cos(-math.pi/2-playerDrawPar[playerAbility.tip].clowR)*7/3
    playerBatch:add(playerQuads[playerAbility.tip].clow1,clow1X,clow1Y,math.pi/2+math.pi+player.clowR,k/3,k2/3,playerDrawPar[playerAbility.tip].clowW1, playerDrawPar[playerAbility.tip].clowH)
    playerBatch:add(playerQuads[playerAbility.tip].clow2,clow2X,clow2Y,math.pi/2+math.pi-player.clowR,k/3,k2/3,playerDrawPar[playerAbility.tip].clowW2, playerDrawPar[playerAbility.tip].clowH)
    playerSledDrawCharacter(screenWidth/2,screenHeight/2,dt)
    playerBatch:add(playerQuads[playerAbility.tip].body,xDraw,yDraw,math.pi/2+math.pi,k/3,k2/3,playerDrawPar[playerAbility.tip].bodyW/2, playerDrawPar[playerAbility.tip].bodyH/2)
    playerBatch:setColor( 1, 1,1,0.8 )
    playerBatch:add(playerQuads[playerAbility.tip].wings,xDraw,yDraw,math.pi/2+math.pi,k/3,k2/3,playerDrawPar[playerAbility.tip].wingsW/2, playerDrawPar[playerAbility.tip].wingsH/2-playerDrawPar[playerAbility.tip].wingsX)
    local r ,g ,b = gradient(dt)
    playerBatch:setColor(r,g,b)
    playerBatch:add(playerQuads[playerAbility.tip].cristal,xDraw,yDraw,math.pi/2+math.pi,k/3,k2/3,playerDrawPar[playerAbility.tip].cristalW/2, playerDrawPar[playerAbility.tip].cristalH/2-playerDrawPar[playerAbility.tip].cristalX)
    
end
function playerSledDrawCharacter(x,y,dt)
 --  player.body:draw('line')
    local playerSled = {
        angle =math.pi/2,
        ax =2*k*1*7/3 ,
        ay =0,
        x = x,
        y = y, 
        r = 0.2,
    }
    table.insert(playerSledi,playerSled)
    for i = 1,#playerSledi do
        local sled = playerSledi[i]
        local radius =sled.r*i
        sled.x = sled.x+200*sled.ax*dt
        playerBatch:setColor( 0.1*i, 0.1*i, 0.1*i )
        playerBatch:add(playerQuads[playerAbility.tip].tail,sled.x,sled.y,math.pi/2,k/3*radius,k2/3*radius,playerDrawPar[playerAbility.tip].tailW/2,playerDrawPar[playerAbility.tip].tailH/2)
    end
    if ( #playerSledi>10) then
        table.remove(playerSledi,1)
    end
end

return character