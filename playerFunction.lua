local playerFunction = {} 

function playerControl()
    mouse.x,mouse.y=love.mouse.getPosition()
    mouse.x = mouse.x/sx
    mouse.y = mouse.y/sy
    player.body:moveTo(player.x+40*k/2,player.y+40*k2/2)
    if ( love.mouse.isDown(1) ) then
        if ( controler.flag == false and mouse.x > screenWidth / 9) then 
            controler.x0 = mouse.x
            controler.y0 = mouse.y
            controler.flag = true
        end
        if ( controler.flag == true and mouse.x > screenWidth / 9) then 
            controler.x = mouse.x -   controler.x0
            controler.y = mouse.y -   controler.y0
            player.a = 0
            if ( math.abs(controler.x) >1*k or math.abs(controler.y)>1*k2) then
                controler.angle = math.atan2(controler.x,controler.y)
            end  
            if (( math.abs(controler.x) >1*k or math.abs(controler.y)>1*k2)) then
                player.ax  = math.sin(controler.angle)*k*math.abs(controler.x*screenWidth/screenHeight/3.5)
                player.ay  = math.cos(controler.angle)*k2*math.abs(controler.y*screenWidth/screenHeight/3.5)
                if ( player.ax > playerAbility.maxSpeed*k) then
                    player.ax = playerAbility.maxSpeed*k 
                end
                if ( player.ax < -playerAbility.maxSpeed*k) then
                    player.ax = -playerAbility.maxSpeed*k 
                end
                if ( player.ay > playerAbility.maxSpeed*k2) then
                    player.ay = playerAbility.maxSpeed*k2
                end
                if ( player.ay < -playerAbility.maxSpeed*k2) then
                    player.ay = -playerAbility.maxSpeed*k2
                end
            end
        else
            controler.flag = true
        end
    else
        player.a = 0
        controler.flag =false
    end
    
    if ((#love.touch.getTouches()>1 and boost.flag == true) or (love.keyboard.isDown('t')  and boost.flag == true ) ) then
        player.clowRflag =4 
        player.a = 1 
    end
    if ( boost.long >70*k2  ) then
        boost.flag = true
    end
    if ( boost.long <= 30*k2  ) then
        player.a=0
        boost.long =30*k2
        boost.flag = false
    end
end

function playerMove()
    if not(love.mouse.isDown(1)) then
        if ( player.ax> 0) then
            player.ax = player.ax-13*dt2*k
        else
            player.ax = player.ax+13*dt2*k
        end
        if ( player.ay> 0) then
            player.ay = player.ay-13*dt2*k2
        else
            player.ay = player.ay+13*dt2*k2
        end
    end
    player.x = player.x + player.ax*dt2*13*k
    player.y = player.y + player.ay*dt2*13*k2
    if ( player.a==1) then
        player.x = player.x + player.ax*dt2*6*k
        player.y = player.y + player.ay*dt2*6*k2
    end
end

function playerDraw()
    playerSledDraw()
    playerBatch:add(playerQuads.body,player.x+player.scale/2*40*k,player.y+player.scale/2*40*k2,-controler.angle+math.pi,k/7,k2/7, 464/2, 384/2)
    playerBatch:setColor( 1, 1,1,0.8 )
    playerBatch:add(playerQuads.wings,player.x+player.scale/2*40*k,player.y+player.scale/2*40*k2,-controler.angle+math.pi,k/7,k2/7,448/2, 256/2-40)
    local r ,g ,b = gradient()
    playerBatch:setColor(r,g,b)
    playerBatch:add(playerQuads.cristal,player.x+player.scale/2*40*k,player.y+player.scale/2*40*k2,-controler.angle+math.pi,k/7,k2/7,80/2, 136/2-20)
    playerBatch:setColor(1,1,1,1)
    local clow1X = player.x+player.scale/2*40*k +26*k*math.sin(controler.angle+0.17219081452294)
    local clow1Y = player.y+player.scale/2*40*k2 +26*k2*math.cos(controler.angle+0.17219081452294)
    local clow2X = player.x+player.scale/2*40*k +26*k*math.sin(controler.angle-0.17219081452294)
    local clow2Y = player.y+player.scale/2*40*k2 +26*k2*math.cos(controler.angle-0.17219081452294)
    playerBatch:add(playerQuads.clow1,clow1X,clow1Y,-controler.angle+math.pi+player.clowR,k/7,k2/7,176, 80)
    playerBatch:add(playerQuads.clow2,clow2X,clow2Y,-controler.angle+math.pi-player.clowR,k/7,k2/7,16, 80)
end

function playerSledDraw()
 --   player.body:draw('fill')
    love.graphics.circle('fill',controler.x0,controler.y0,10*k)
    love.graphics.circle('line',controler.x0,controler.y0,13*k)
    love.graphics.circle('line',mouse.x,mouse.y,5*k)
    love.graphics.circle('line',mouse.x,mouse.y,5*k)
    
    local playerSled = {
        angle = -controler.angle+math.pi,
        ax =-2*k*math.sin(controler.angle) ,
        ay =-2*k2*math.cos(controler.angle),
        x = player.x+player.scale*20*k,
        y = player.y+player.scale*20*k2, 
        r = 0.2 ,
    }
    table.insert(playerSledi,playerSled)
    for i = 1,#playerSledi do
        local sled = playerSledi[i]
        local radius =sled.r*i
        local tailW,tailH = playerQuads.tail:getTextureDimensions()
        sled.x = sled.x+150*sled.ax*dt2
        sled.y = sled.y+150*sled.ay*dt2
        playerBatch:setColor( 0.1*i, 0.1*i, 0.1*i )
        playerBatch:add(playerQuads.tail,sled.x,sled.y,sled.angle,k/7*radius,k2/7*radius,48,60)
    end
    if ( #playerSledi>10) then
        table.remove(playerSledi,1)
    end
end

function playerClowR()
    if ( player.clowRflag == 0 or player.clowRflag ==1) then
        if ( player.clowR> 0.2 ) then
            player.clowRflag = 1 
        end
        if ( player.clowR< 0 ) then
            player.clowRflag = 0 
        end
        if ( player.clowRflag==1) then
            if ( player.clowR > 0.25) then
                player.clowR = player.clowR-1*dt2
            else
                player.clowR = player.clowR-0.2*dt2
            end
        else
            if ( player.clowR<-0.1) then
                player.clowR = player.clowR+1.2*dt2
            else
                player.clowR = player.clowR+0.6*dt2
            end
        end
    end
    if ( player.clowRflag ==3) then
        if (  player.clowR>-0.35) then
          player.clowR = player.clowR-2*dt2
        end
    end
    if ( player.clowRflag ==4) then
        if (  player.clowR<0.6) then
          player.clowR = player.clowR+2*dt2
        end
    end
end

function playerDebaff()
    if (player.debaffStrenght < 1) then
        local time = 1 
        if (  player.ax >  player.debaffStrenght*playerAbility.maxSpeed*k ) then
              player.ax = player.debaffStrenght*playerAbility.maxSpeed*k
        end
        if (  player.ay > player.debaffStrenght*playerAbility.maxSpeed*k2 ) then
              player.ay = player.debaffStrenght*playerAbility.maxSpeed*k2
        end
        if (  player.ax < -player.debaffStrenght*playerAbility.maxSpeed*k ) then
              player.ax = -player.debaffStrenght*playerAbility.maxSpeed*k
        end
        if (  player.ay < -player.debaffStrenght*playerAbility.maxSpeed*k2 ) then
              player.ay = -player.debaffStrenght*playerAbility.maxSpeed*k2
        end
        player.debaffStrenght = player.debaffStrenght  + 0.8*dt2/time
    else
        player.debaffStrenght = 1 
    end
end

function playerBorder()
    if player.x < 0  then
        player.x = 0
        player.ax = math.abs(player.ax)/2
        player.ay = player.ay/2
    elseif player.x > screenWidth -  player.scale*40*k then
        player.x = screenWidth -  player.scale*40*k
        player.ax = -1*player.ax/2
        player.ay = player.ay/2
    end
    if player.y < 0 then
        player.y = 0 
        player.ay = math.abs(   player.ay)/2
        player.ax = player.ax/2
    elseif player.y > screenHeight -  player.scale*40*k2 then
        player.y = screenHeight -  player.scale*40*k2
        player.ay = -1*player.ay/2
        player.ax = player.ax/2
    end
end

return playerFunction