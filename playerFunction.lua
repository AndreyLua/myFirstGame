local playerFunction = {} 

function playerControl()
    mouse.x,mouse.y=love.mouse.getPosition()
    mouse.x = mouse.x
    mouse.y = mouse.y
    player.body:moveTo(player.x,player.y)
    if ( love.mouse.isDown(1) ) then
        if ( controler.flag == false and mouse.x > screenWidth / 9) then 
            if ( controllerChoose == 1 ) then 
                controler.x0 = mouse.x
                controler.y0 = mouse.y
            elseif ( controllerChoose == 2 ) then 
                controler.x0 = screenWidth/1.2
                controler.y0 = screenHeight - screenHeight/3
            elseif ( controllerChoose == 3 ) then  
                controler.x0 = screenWidth/1.2
                controler.y0 = screenHeight/3
            end
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
                player.ax  =math.sin(controler.angle)*math.abs(controler.x*screenWidth/screenHeight/3.5)*Sensitivity
                player.ay  =math.cos(controler.angle)*math.abs(controler.y*screenWidth/screenHeight/3.5)*Sensitivity
                
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
        player.x = player.x + player.ax*dt*playerAbility.speedA*k*player.debaffStrenght*playerSkillParametrs.speedK
        player.y = player.y + player.ay*dt*playerAbility.speedA*k2*player.debaffStrenght*playerSkillParametrs.speedK
    else
        player.x = player.x + player.ax*dt*playerAbility.speed*k*player.debaffStrenght*playerSkillParametrs.speedK
        player.y = player.y + player.ay*dt*playerAbility.speed*k2*player.debaffStrenght*playerSkillParametrs.speedK
    end
end

function playerCamera(dt)
    if not( player.x > borderWidth*2-screenWidth/2+20*k or  player.x < -borderWidth+screenWidth/2+20*k) then
        camera.x =camera.x+(player.x-camera.x)*dt*5*k
    else
        if (  player.x > borderWidth*2-screenWidth/2+20*k) then
            camera.x =camera.x+( borderWidth*2-screenWidth/2+20*k-camera.x)*dt*5*k
        else
            camera.x =camera.x+(-borderWidth+screenWidth/2+20*k-camera.x)*dt*5*k
        end
    end
    if not( player.y >  borderHeight*2-screenHeight/2+20*k2 or  player.y < - borderHeight+screenHeight/2+20*k2 ) then
        camera.y =camera.y+(player.y-camera.y)*dt*5*k2
    else
        if (  player.y >borderHeight*2-screenHeight/2+20*k2) then
            camera.y =camera.y+(borderHeight*2-screenHeight/2+20*k2-camera.y)*dt*5*k2
        else
            camera.y =camera.y+(-borderHeight+screenHeight/2+20*k2-camera.y)*dt*5*k2
        end
    end
    if ( player.clowR> 0.2 ) then
        player.clowRflag = 1 
    end
    if ( player.clowR< 0 ) then
        player.clowRflag = 0 
    end
end 
  
function playerDraw(dt)
    local xDraw = screenWidth/2+20*k+(player.x-camera.x)
    local yDraw = screenHeight/2+20*k2+(player.y-camera.y)  
    local clow1X =xDraw +playerDrawPar[playerAbility.tip].clowX*k2*math.sin(controler.angle+playerDrawPar[playerAbility.tip].clowR)
    local clow1Y =yDraw +playerDrawPar[playerAbility.tip].clowX*k2*math.cos(controler.angle+playerDrawPar[playerAbility.tip].clowR)
    local clow2X =xDraw +playerDrawPar[playerAbility.tip].clowX*k2*math.sin(controler.angle-playerDrawPar[playerAbility.tip].clowR)
    local clow2Y =yDraw+playerDrawPar[playerAbility.tip].clowX*k2*math.cos(controler.angle-playerDrawPar[playerAbility.tip].clowR)
    playerSledDraw(screenWidth/2+20*k,screenHeight/2+20*k2,dt)
    playerBatch:add(playerQuads[playerAbility.tip].body,xDraw,yDraw,-controler.angle+math.pi,k/7,k2/7, playerDrawPar[playerAbility.tip].bodyW/2, playerDrawPar[playerAbility.tip].bodyH/2)
    playerBatch:setColor( 1, 1,1,0.8 )
    playerBatch:add(playerQuads[playerAbility.tip].wings,xDraw,yDraw,-controler.angle+math.pi,k/7,k2/7,playerDrawPar[playerAbility.tip].wingsW/2, playerDrawPar[playerAbility.tip].wingsH/2-playerDrawPar[playerAbility.tip].wingsX)
    local r ,g ,b = gradient(dt)
    playerBatch:setColor(r,g,b)
    playerBatch:add(playerQuads[playerAbility.tip].cristal,xDraw,yDraw,-controler.angle+math.pi,k/7,k2/7,playerDrawPar[playerAbility.tip].cristalW/2, playerDrawPar[playerAbility.tip].cristalH/2-playerDrawPar[playerAbility.tip].cristalX)
    playerBatch:setColor(1,1,1,1)
    if (playerSkillParametrs.bloodAtFlag == true ) then
        playerBatch:setColor(1,0.7,0.7,1)  
    end
    playerBatch:add(playerQuads[playerAbility.tip].clow1,clow1X,clow1Y,-controler.angle+math.pi+player.clowR,k/7*player.clowLScaleK,k2/7*player.clowLScaleK,playerDrawPar[playerAbility.tip].clowW1, playerDrawPar[playerAbility.tip].clowH)
    playerBatch:add(playerQuads[playerAbility.tip].clow2,clow2X,clow2Y,-controler.angle+math.pi-player.clowR,k/7*player.clowRScaleK,k2/7*player.clowRScaleK,playerDrawPar[playerAbility.tip].clowW2, playerDrawPar[playerAbility.tip].clowH)
end
function playerDrawCristal()
    local xDraw = screenWidth/2+20*k+(player.x-camera.x)
    local yDraw = screenHeight/2+20*k2+(player.y-camera.y)  
    playerBatch:setColor(1,1,1,1)
    playerBatch:add(playerQuads[playerAbility.tip].cristal,xDraw,yDraw,-controler.angle+math.pi,k/(7-player.li/10),k2/(7-player.li/10),playerDrawPar[playerAbility.tip].cristalW/2, playerDrawPar[playerAbility.tip].cristalH/2-playerDrawPar[playerAbility.tip].cristalX)  
end
function playerSledDraw(x,y,dt)
 --  player.body:draw('line')
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
        sled.x = sled.x+3.302*sled.ax
        sled.y = sled.y+3.302*sled.ay
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

function enAtackPlayer(dmg,tip,self)
    AddSound(playerHurtSounds,0.3)
    dmg = dmg- playerSkillParametrs.hpK*dmg
    boostDop.recovery =boostDop.recoveryTimer - 0.0000001
    if (boostDop.long>0) then 
        boostDop.long = boostDop.long - (dmg-(dmg*playerSkillParametrs.dopEn))*4
        boostDop.shakeK = 20
    else
        if ( tip=='m') then
            newPlayerGetDamageEffect(self.x,self.y,7)
            hp.long = hp.long - dmg*(1-playerSkillParametrs.meleeDefK)
            if (playerSkillParametrs.spikeFlag == true) then 
                newDeffenseEffect(self)
            end
        end
        if ( tip=='e') then
            hp.long = hp.long - dmg
        end
         if ( tip=='r') then
            newPlayerGetDamageEffect(self.x,self.y,7)
            hp.long = hp.long - dmg*(1-playerSkillParametrs.rangeDefK)
            if (playerSkillParametrs.spikeFlag == true) then 
                newDeffenseEffect(self)
            end
        end
    end
end

function playerAtackEn(self,dt)
    if (playerSkillParametrs.waveAtFlag or playerSkillParametrs.bloodAtFlag or playerSkillParametrs.sealAtFlag or playerSkillParametrs.vampirFlag) then 
        boost.long = boost.long - (playerAbility.boostWasteSp-(playerAbility.boostWasteSp*playerSkillParametrs.enK))*     playerAbility.boostWasteEnHit*dt
    end
        
    AddSound(playerHitSounds,0.3)
    local clow1X =player.x +playerDrawPar[playerAbility.tip].clowX*k2*math.sin(controler.angle+playerDrawPar[playerAbility.tip].clowR)
    local clow1Y =player.y +playerDrawPar[playerAbility.tip].clowX*k2*math.cos(controler.angle+playerDrawPar[playerAbility.tip].clowR)
    local clow2X =player.x +playerDrawPar[playerAbility.tip].clowX*k2*math.sin(controler.angle-playerDrawPar[playerAbility.tip].clowR)
    local clow2Y =player.y+playerDrawPar[playerAbility.tip].clowX*k2*math.cos(controler.angle-playerDrawPar[playerAbility.tip].clowR)
    
    if ((math.pow(clow1X-self.x,2) + math.pow(clow1Y-self.y,2))> (math.pow(clow2X-self.x,2) + math.pow(clow2Y-self.y,2))) then 
        player.clowRScaleK = 1.2
        player.clowRTimer = 10 -0.0001
    else  
        player.clowLScaleK = 1.2
        player.clowLTimer = 10 -0.0001
    end
  
    boost.long = boost.long - (playerAbility.boostWaste-(playerAbility.boostWaste*playerSkillParametrs.enK))*     playerAbility.boostWasteEnHit*dt
    self.health  =  self.health - playerAbility.damage*playerSkillParametrs.damageK
    if (playerSkillParametrs.vampirFlag == true) then 
        newVampirEffect(self)
    end
    if (playerSkillParametrs.waveAtFlag == true) then 
        newWaveEffect(self.x,self.y) -- damage
    end
    if (playerSkillParametrs.bloodAtFlag == true) then 
        newBloodEffect(self)  -- damage
    end
    if (playerSkillParametrs.sealAtFlag == true) then 
        table.insert(masli,{table = self, timer = 10,flag = nil})
        self.health  =  self.health - playerAbility.damage*playerSkillParametrs.damageK*playerSkillParametrs.sealAt 
    end
end

function playerFrontAtack(i) 
    local flagAt = false
    local anglePlEn =  math.atan2(en[i].x -player.x, en[i].y - player.y) 
    if (anglePlEn/math.abs(anglePlEn)==controler.angle/math.abs(controler.angle))then
        if (math.abs(math.abs(anglePlEn) - math.abs(controler.angle)) <  math.pi/4) then 
            flagAt = true
        end
    else
        if (math.abs(anglePlEn)+math.abs(controler.angle)> 2*math.pi - math.abs(anglePlEn)-math.abs(controler.angle)) then
            if ((2*math.pi - math.abs(anglePlEn)-math.abs(controler.angle)) <  math.pi/4) then 
                flagAt = true
            end
        else 
            if ((math.abs(anglePlEn)+math.abs(controler.angle)) <  math.pi/4) then 
                flagAt = true
            end
        end
    end
    return flagAt
end

function playerLiDraw(dt)
    if (playerSkillParametrs.sealAtFlag == true) then 
        for i=#masli,1,-1 do
            if (masli[i].table and masli[i].timer > 0  ) then
                masli[i].timer = masli[i].timer - 50*dt
                light22Draw(light22(player.x+35*k2*math.sin(controler.angle+math.pi/8)+math.random(-4,4)*k,player.y+35*k2*math.cos(controler.angle+math.pi/8)+math.random(-4,4)*k,masli[i].table.x+math.random(-10,10)*k,masli[i].table.y+math.random(-10,10)*k,5))
                light22Draw(light22(player.x+35*k2*math.sin(controler.angle-math.pi/8)+math.random(-4,4)*k,player.y+35*k2*math.cos(controler.angle-math.pi/8)+math.random(-4,4)*k,masli[i].table.x+math.random(-10,10)*k,masli[i].table.y+math.random(-10,10)*k,5))
            else
                table.remove(masli,i)
            end
        end
        if ( player.a == 1 and #masli == 0 ) then 
            light22Draw(light22(player.x+35*k2*math.sin(controler.angle)+math.random(-2,2)*k,player.y+35*k2*math.cos(controler.angle)+math.random(-2,2)*k,player.x+35*k2*math.sin(controler.angle+math.pi/4)+math.random(-2,2)*k,player.y+35*k2*math.cos(controler.angle+math.pi/4)+math.random(-2,2)*k,4))
            light22Draw(light22(player.x+35*k2*math.sin(controler.angle)+math.random(-2,2)*k,player.y+35*k2*math.cos(controler.angle)+math.random(-2,2)*k,player.x+35*k2*math.sin(controler.angle-math.pi/4)+math.random(-2,2)*k,player.y+35*k2*math.cos(controler.angle-math.pi/4)+math.random(-2,2)*k,4))
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
    if (player.clowRTimer < 10) then 
        player.clowRTimer = player.clowRTimer - 40*dt
    end
    if (player.clowRTimer < 0) then 
        player.clowRScaleK = 1
        player.clowRTimer = 10
    end
    if (player.clowLTimer < 10) then 
        player.clowLTimer = player.clowLTimer - 40*dt
    end
    if (player.clowLTimer < 0) then 
        player.clowLScaleK = 1
        player.clowLTimer = 10
    end
  
  
  
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
            player.li = player.li - 100 * dt
        end
    else
        if ( player.li < player.liTimer) then 
            player.li = player.li - 100 * dt
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

function playerDie()
    if ( hp.long<=0) then 
        gamestate.switch(die)
    end
end

return playerFunction