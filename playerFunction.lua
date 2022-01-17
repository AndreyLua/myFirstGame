local playerFunction = {} 

function playerControl()
    mouse.x,mouse.y=love.mouse.getPosition()
    mouse.x = mouse.x
    mouse.y = mouse.y
    player.body:moveTo(player.x,player.y)
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
                player.ax  =math.sin(controler.angle)*math.abs(controler.x*screenWidth/screenHeight/3.5)
                player.ay  =math.cos(controler.angle)*math.abs(controler.y*screenWidth/screenHeight/3.5)
                
                if ( player.ax > playerAbility.maxSpeed) then
                    player.ax = playerAbility.maxSpeed 
                end
                if ( player.ax < -playerAbility.maxSpeed) then
                    player.ax = -playerAbility.maxSpeed 
                end
                if ( player.ay > playerAbility.maxSpeed) then
                    player.ay = playerAbility.maxSpeed
                end
                if ( player.ay < -playerAbility.maxSpeed) then
                    player.ay = -playerAbility.maxSpeed
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

function playerMove(dt)
    if not(love.mouse.isDown(1)) then
        if ( player.ax> 0) then
            player.ax = player.ax-10*dt*k
        else
            player.ax = player.ax+10*dt*k
        end
        if ( player.ay> 0) then
            player.ay = player.ay-10*dt*k2
        else
            player.ay = player.ay+10*dt*k2
        end
    end
    playerLiTimerUpdate(dt)
    if ( player.a==1) then
       --- playerLiTimerUpdate(dt)
        player.x = player.x + player.ax*dt*playerAbility.speedA*k*player.debaffStrenght*playerSkillParametrs.speedK
        player.y = player.y + player.ay*dt*playerAbility.speedA*k2*player.debaffStrenght*playerSkillParametrs.speedK
    else
        player.x = player.x + player.ax*dt*playerAbility.speed*k*player.debaffStrenght*playerSkillParametrs.speedK
        player.y = player.y + player.ay*dt*playerAbility.speed*k2*player.debaffStrenght*playerSkillParametrs.speedK
    end
end

function playerDraw(dt)
    local xDraw = screenWidth/2+20*k+(player.x-camera.x)
    local yDraw = screenHeight/2+20*k2+(player.y-camera.y)  
    playerSledDraw(screenWidth/2+20*k,screenHeight/2+20*k2,dt)
    playerBatch:add(playerQuads[playerAbility.tip].body,xDraw,yDraw,-controler.angle+math.pi,k/7,k2/7, playerDrawPar[playerAbility.tip].bodyW/2, playerDrawPar[playerAbility.tip].bodyH/2)
    playerBatch:setColor( 1, 1,1,0.8 )
    playerBatch:add(playerQuads[playerAbility.tip].wings,xDraw,yDraw,-controler.angle+math.pi,k/7,k2/7,playerDrawPar[playerAbility.tip].wingsW/2, playerDrawPar[playerAbility.tip].wingsH/2-playerDrawPar[playerAbility.tip].wingsX)
    local r ,g ,b = gradient(dt)
    playerBatch:setColor(r,g,b)
    playerBatch:add(playerQuads[playerAbility.tip].cristal,xDraw,yDraw,-controler.angle+math.pi,k/7,k2/7,playerDrawPar[playerAbility.tip].cristalW/2, playerDrawPar[playerAbility.tip].cristalH/2-playerDrawPar[playerAbility.tip].cristalX)
   
    playerBatch:setColor(1,1,1,1)
    local clow1X =xDraw +playerDrawPar[playerAbility.tip].clowX*k2*math.sin(controler.angle+playerDrawPar[playerAbility.tip].clowR)
    local clow1Y =yDraw +playerDrawPar[playerAbility.tip].clowX*k2*math.cos(controler.angle+playerDrawPar[playerAbility.tip].clowR)
    local clow2X =xDraw +playerDrawPar[playerAbility.tip].clowX*k2*math.sin(controler.angle-playerDrawPar[playerAbility.tip].clowR)
    local clow2Y =yDraw+playerDrawPar[playerAbility.tip].clowX*k2*math.cos(controler.angle-playerDrawPar[playerAbility.tip].clowR)
   if ( player.li == player.liTimer) then 
        player.li = player.liTimer - 0.00001
        masliDr2  ={}
        lii = light2(0,0,0+20*k*math.sin(0-math.pi/3.5),0+20*k*math.cos(0-math.pi/3.5),1)
        table.insert(masliDr2,lii)
        lii = light2(0,0,0+20*k*math.sin(0-math.pi/3.5+math.pi/1.75),0+20*k*math.cos(0-math.pi/3.5+math.pi/1.75),1)
        table.insert(masliDr2,lii)
        lii = light2(0+20*k*math.sin(0-math.pi/3.5),0+20*k*math.cos(0-math.pi/3.5),0+35*k*math.sin(0-math.pi/2.9),0+35*k*math.cos(0-math.pi/2.9),1)
        table.insert(masliDr2,lii)
        lii = light2(0+20*k*math.sin(0-math.pi/3.5+math.pi/1.75),0+20*k*math.cos(0-math.pi/3.5+math.pi/1.75),0+35*k*math.sin(0-math.pi/3.5+math.pi/1.55),0+35*k*math.cos(0-math.pi/3.5+math.pi/1.55),1)
        table.insert(masliDr2,lii)
        ------------------------
        lii = light2(0,0,0+22*k*math.sin(0-math.pi/1.2),0+22*k*math.cos(0-math.pi/1.2),1)
        table.insert(masliDr2,lii)
        lii = light2(0,0,0+22*k*math.sin(0-math.pi/1.2-math.pi/3),0+22*k*math.cos(0-math.pi/1.2-math.pi/3),1)
       table.insert(masliDr2,lii)
        lii = light2(0+22*k*math.sin(0-math.pi/1.2),0+22*k*math.cos(0-math.pi/1.2),0+30*k*math.sin(0-math.pi/1.25),0+30*k*math.cos(0-math.pi/1.25),1)
        table.insert(masliDr2,lii)
        lii = light2(0+22*k*math.sin(0-math.pi/1.2-math.pi/3),0+22*k*math.cos(0-math.pi/1.2-math.pi/3),0+30*k*math.sin(0-math.pi/1.2-math.pi/2.8),0+30*k*math.cos(0-math.pi/1.2-math.pi/2.8),1)
        table.insert(masliDr2,lii)
      end
    playerBatch:add(playerQuads[playerAbility.tip].clow1,clow1X,clow1Y,-controler.angle+math.pi+player.clowR,k/7,k2/7,playerDrawPar[playerAbility.tip].clowW1, playerDrawPar[playerAbility.tip].clowH)
    playerBatch:add(playerQuads[playerAbility.tip].clow2,clow2X,clow2Y,-controler.angle+math.pi-player.clowR,k/7,k2/7,playerDrawPar[playerAbility.tip].clowW2, playerDrawPar[playerAbility.tip].clowH)
end
function playerDrawCristal()
    local xDraw = screenWidth/2+20*k+(player.x-camera.x)
    local yDraw = screenHeight/2+20*k2+(player.y-camera.y)  
    playerBatch:setColor(1,1,1,1)
    playerBatch:add(playerQuads[playerAbility.tip].cristal,xDraw,yDraw,-controler.angle+math.pi,k/(7-player.li/10),k2/(7-player.li/10),playerDrawPar[playerAbility.tip].cristalW/2, playerDrawPar[playerAbility.tip].cristalH/2-playerDrawPar[playerAbility.tip].cristalX)  
end
function playerSledDraw(x,y,dt)
 --  player.body:draw('line')
    love.graphics.circle('fill',controler.x0,controler.y0,10*k)
    love.graphics.circle('line',controler.x0,controler.y0,13*k)
    love.graphics.circle('line',mouse.x,mouse.y,5*k)
    love.graphics.circle('line',mouse.x,mouse.y,5*k)
    local playerSled = {
        angle = -controler.angle+math.pi,
        ax =-2*k*math.sin(controler.angle) ,
        ay =-2*k2*math.cos(controler.angle),
        x = x,
        y = y, 
        r = 0.2,
    }
    table.insert(playerSledi,playerSled)
    for i = 1,#playerSledi do
        local sled = playerSledi[i]
        local radius =sled.r*i
        sled.x = sled.x+200*sled.ax*dt
        sled.y = sled.y+200*sled.ay*dt
        playerBatch:setColor( 0.1*i, 0.1*i, 0.1*i )
        playerBatch:add(playerQuads[playerAbility.tip].tail,sled.x+(player.x-camera.x),sled.y+(player.y-camera.y),sled.angle,k/7*radius,k2/7*radius,playerDrawPar[playerAbility.tip].tailW/2,playerDrawPar[playerAbility.tip].tailH/2)
    end
    if ( #playerSledi>10) then
        table.remove(playerSledi,1)
    end
end
function playerCollWithObj(dt)
    local playerIndex =math.floor((player.x-40*k)/(120*k)) + math.floor((player.y-40*k2)/(120*k2))*math.floor((screenWidth/(120*k))+1) 
    objCollWithPlayerInRegularS(playerIndex,dt)
    objCollWithPlayerInRegularS(playerIndex-1,dt)
    objCollWithPlayerInRegularS(playerIndex+1,dt)
  
    objCollWithPlayerInRegularS(playerIndex-math.floor((screenWidth/(120*k))+1),dt)
    objCollWithPlayerInRegularS(playerIndex+math.floor((screenWidth/(120*k))+1),dt) 
    
    objCollWithPlayerInRegularS(playerIndex+math.floor((screenWidth/(120*k))+1)+1,dt)
    objCollWithPlayerInRegularS(playerIndex+math.floor((screenWidth/(120*k))+1)-1,dt)
    
    objCollWithPlayerInRegularS(playerIndex-math.floor((screenWidth/(120*k))+1)+1,dt)
    objCollWithPlayerInRegularS(playerIndex-math.floor((screenWidth/(120*k))+1)-1,dt)
end

function enAtackPlayer(dmg,tip)
    dmg = dmg- playerSkillParametrs.hpK*dmg
    if ( tip=='m') then
        hp.long = hp.long - dmg*(1-playerSkillParametrs.meleeDefK)
    end
    if ( tip=='e') then
        hp.long = hp.long - dmg
    end
     if ( tip=='r') then
        hp.long = hp.long - dmg*(1-playerSkillParametrs.rangeDefK)
    end
end

function playerAtackEn(self,dt)
    boost.long = boost.long - (playerAbility.boostWaste-(playerAbility.boostWaste*playerSkillParametrs.enK))*playerAbility.boostWasteEnHit*dt
    self.health  =  self.health - playerAbility.damage*playerSkillParametrs.damageK
    table.insert(masli,{table = self, timer = 10,draw = nil})
end
function playerLiDraw(dt)
    for i =#masli, 1, -1 do
        if ( masli[i].timer > 0 ) then 
            if ( masli[i] and masli[i].table) then
                if ( masli[i].draw == nil) then
                    masli[i].draw,masli[i].drawKoff = light(player.x,player.y,masli[i].table.x,masli[i].table.y,2)
                    --print(unpack(masli[i].drawKoff))
                end
                local lii = false
                if ( masli[i].draw ~= nil ) then 
                    lii = lightDesh(player.x,player.y,masli[i].table.x,masli[i].table.y,2,masli[i].drawKoff)
                end
                if (lii ) then 
                    love.graphics.setColor(0.4,1,1,1)
                    love.graphics.setLineWidth( 2*k )
                    love.graphics.line(lii)
                    love.graphics.setColor(0.8,1,1,1)
                    love.graphics.setLineWidth( 1*k )
                    love.graphics.line(lii)
                    masli[i].timer =  masli[i].timer - 80*dt 
                end
            end
        else
            table.remove(masli,i)
        end
    end
end
function playerCollWithEn(dt)
    local playerIndex =math.floor((player.x-40*k)/(80*k)) + math.floor((player.y-40*k2)/(80*k2))*math.floor((screenWidth/(80*k))+1) 
    enCollWithPlayerInRegularS(playerIndex,dt)
    enCollWithPlayerInRegularS(playerIndex-1,dt)
    enCollWithPlayerInRegularS(playerIndex+1,dt)
  
    enCollWithPlayerInRegularS(playerIndex-math.floor((screenWidth/(80*k))+1),dt)
    enCollWithPlayerInRegularS(playerIndex+math.floor((screenWidth/(80*k))+1),dt) 
    
    enCollWithPlayerInRegularS(playerIndex+math.floor((screenWidth/(80*k))+1)+1,dt)
    enCollWithPlayerInRegularS(playerIndex+math.floor((screenWidth/(80*k))+1)-1,dt)
    
    enCollWithPlayerInRegularS(playerIndex-math.floor((screenWidth/(80*k))+1)+1,dt)
    enCollWithPlayerInRegularS(playerIndex-math.floor((screenWidth/(80*k))+1)-1,dt)
end

function playerClowR(dt)
    if ( player.clowRflag == 0 or player.clowRflag ==1) then
        if ( player.clowR> 0.2 ) then
            player.clowRflag = 1 
        end
        if ( player.clowR< 0 ) then
            player.clowRflag = 0 
        end
        if ( player.clowRflag==1) then
            if ( player.clowR > 0.25) then
                player.clowR = player.clowR-1*dt
            else
                player.clowR = player.clowR-0.2*dt
            end
        else
            if ( player.clowR<-0.1) then
                player.clowR = player.clowR+1.2*dt
            else
                player.clowR = player.clowR+0.6*dt
            end
        end
    end
    if ( player.clowRflag ==3) then
        if (  player.clowR>-0.35) then
          player.clowR = player.clowR-2*dt
        end
    end
    if ( player.clowRflag ==4) then
        if (  player.clowR<0.6) then
          player.clowR = player.clowR+2*dt
        end
    end
end
function playerLiTimerUpdate(dt)
    if ( player.a == 1 ) then
        if (player.li < 0) then
            player.li = player.liTimer
            playerLiRan ={math.random(1,2),math.random(1,2),math.random(1,2),math.random(1,2)}
        end
        if ( player.li < player.liTimer) then 
            player.li = player.li - 60 * dt
        end
    else
        if ( player.li < player.liTimer) then 
            player.li = player.li - 60 * dt
            if ( player.li < 0) then
                player.li = 0 
            end
        end
    end
end
function playerDebaff(dt)
    if (player.debaffStrenght < 1) then
        local time = 3 
        player.debaffStrenght = player.debaffStrenght  + 0.8*dt/time
    else
        player.debaffStrenght = 1 
    end
end

function playerBorder()
    if ( player.x > borderWidth*2-playerAbility.scaleBody*k) then
        player.x = borderWidth*2 -playerAbility.scaleBody*k
    end 
    if ( player.x < -borderWidth+playerAbility.scaleBody*k) then
        player.x = -borderWidth +playerAbility.scaleBody*k
    end 
    if ( player.y < -borderHeight+playerAbility.scaleBody*k2) then
        player.y = -borderHeight +playerAbility.scaleBody*k2
    end 
    if ( player.y > borderHeight*2- playerAbility.scaleBody*k2) then
        player.y = borderHeight*2 -playerAbility.scaleBody*k2
    end 
end

return playerFunction