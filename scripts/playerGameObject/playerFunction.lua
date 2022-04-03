local playerFunction = {} 

local die = require "scripts/gameStates/gameLoop/die" 
local saveFunction = require "scripts/systemComponents/saveFunction" 

Player = {
    tip =1 , 
    x = borderWidth/2+40*k/2, 
    y = borderHeight/2+40*k2/2,  
    scaleBody = 35,
    body =HC.circle(borderWidth/2+40*k/2,borderHeight/2+40*k2/2,35*k),
    a = 0 , 
    ax = 0,
    ay = 0,
    mass =200,
    radiusCollect = 100,
    damage = 1,
    invTimer = 0.5,
    maxSpeed = 30,
    speedA  = 1.8,
    speed = 6,
    debaffStrenght =0.2,

    Boost = {
        flag = true,
        long = 720,
        long2 =720,
        long3 =720,
        boostRegen = 100,
        boostWaste = 150,
        boostWasteSp =500,
        boostWasteEnHit = 5,
    },
    Hp = {
        flag = false,
        long = 720,
        long2 =720,
        long3 =720
    },
    Color = {
        colorR = 0.5,
        colorG = 0.437,
        colorB = 0.59,
    },
    Clows = {
        angle =0,
        flag = 0,
        R = {
            scale =1,
            timer = 10,
        },
        L = {
            scale =1,
            timer = 10,
        },
    },

}

function playerControl()
    Player.body:moveTo(Player.x,Player.y)
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
            Player.a = 0
            if ( math.abs(controler.x) >1*k or math.abs(controler.y)>1*k2) then
                controler.angle = math.atan2(controler.x,controler.y)
            end  
            if (( math.abs(controler.x) >1*k or math.abs(controler.y)>1*k2)) then
                Player.ax  =math.sin(controler.angle)*math.abs(controler.x*screenWidth/screenHeight/3.5)*Sensitivity
                Player.ay  =math.cos(controler.angle)*math.abs(controler.y*screenWidth/screenHeight/3.5)*Sensitivity
                
                if ( Player.ax > Player.maxSpeed) then
                    Player.ax = Player.maxSpeed 
                end
                if ( Player.ax < -Player.maxSpeed) then
                    Player.ax = -Player.maxSpeed 
                end
                if ( Player.ay > Player.maxSpeed) then
                    Player.ay = Player.maxSpeed
                end
                if ( Player.ay < -Player.maxSpeed) then
                    Player.ay = -Player.maxSpeed
                end
            end
        else
            controler.flag = true
        end
    else
        Player.a = 0
        controler.flag =false
    end
    
    if ((#love.touch.getTouches()>1 and Player.Boost.flag == true) or (love.keyboard.isDown('t')  and Player.Boost.flag == true ) ) then
        Player.Clows.flag =4 
        Player.a = 1 
    end
    if ( Player.Boost.long >70*k2  ) then
        Player.Boost.flag = true
    end
    if ( Player.Boost.long <= 30*k2  ) then
        Player.a=0
        Player.Boost.long =30*k2
        Player.Boost.flag = false
    end
end

function playerMove(dt)
    if not(love.mouse.isDown(1)) then
        if ( Player.ax> 0) then
            Player.ax = Player.ax-10*dt*k
        else
            Player.ax = Player.ax+10*dt*k
        end
        if ( Player.ay> 0) then
            Player.ay = Player.ay-10*dt*k2
        else
            Player.ay = Player.ay+10*dt*k2
        end
    end
    if ( Player.a==1) then
        Player.x = Player.x + Player.ax*dt*Player.speed*Player.speedA*k*Player.debaffStrenght*playerSkillParametrs.speedK
        Player.y = Player.y + Player.ay*dt*Player.speed*Player.speedA*k2*Player.debaffStrenght*playerSkillParametrs.speedK
    else
        Player.x = Player.x + Player.ax*dt*k*Player.speed*Player.debaffStrenght*playerSkillParametrs.speedK
        Player.y = Player.y + Player.ay*dt*k2*Player.speed*Player.debaffStrenght*playerSkillParametrs.speedK
    end
end

function playerCamera(dt)
    if not( Player.x > borderWidth*2-screenWidth/2+20*k or  Player.x < -borderWidth+screenWidth/2+20*k) then
        camera.x =camera.x+(Player.x-camera.x)*dt*5*k
    else
        if (  Player.x > borderWidth*2-screenWidth/2+20*k) then
            camera.x =camera.x+( borderWidth*2-screenWidth/2+20*k-camera.x)*dt*5*k
        else
            camera.x =camera.x+(-borderWidth+screenWidth/2+20*k-camera.x)*dt*5*k
        end
    end
    if not( Player.y >  borderHeight*2-screenHeight/2+20*k2 or  Player.y < - borderHeight+screenHeight/2+20*k2 ) then
        camera.y =camera.y+(Player.y-camera.y)*dt*5*k2
    else
        if (  Player.y >borderHeight*2-screenHeight/2+20*k2) then
            camera.y =camera.y+(borderHeight*2-screenHeight/2+20*k2-camera.y)*dt*5*k2
        else
            camera.y =camera.y+(-borderHeight+screenHeight/2+20*k2-camera.y)*dt*5*k2
        end
    end
end 
  
function playerDraw(dt)
    local xDraw = screenWidth/2+20*k+(Player.x-camera.x)
    local yDraw = screenHeight/2+20*k2+(Player.y-camera.y)  
    local clow1X =xDraw +playerDrawPar[Player.tip].clowX*k2*math.sin(controler.angle+playerDrawPar[Player.tip].clowR)
    local clow1Y =yDraw +playerDrawPar[Player.tip].clowX*k2*math.cos(controler.angle+playerDrawPar[Player.tip].clowR)
    local clow2X =xDraw +playerDrawPar[Player.tip].clowX*k2*math.sin(controler.angle-playerDrawPar[Player.tip].clowR)
    local clow2Y =yDraw+playerDrawPar[Player.tip].clowX*k2*math.cos(controler.angle-playerDrawPar[Player.tip].clowR)
    playerSledDraw(screenWidth/2+20*k,screenHeight/2+20*k2,dt)
    playerBatch:add(playerQuads[Player.tip].body,xDraw,yDraw,-controler.angle+math.pi,k/7,k2/7, playerDrawPar[Player.tip].bodyW/2, playerDrawPar[Player.tip].bodyH/2)
    playerBatch:setColor( 1, 1,1,0.8 )
    playerBatch:add(playerQuads[Player.tip].wings,xDraw,yDraw,-controler.angle+math.pi,k/7,k2/7,playerDrawPar[Player.tip].wingsW/2, playerDrawPar[Player.tip].wingsH/2-playerDrawPar[Player.tip].wingsX)
    local r ,g ,b = gradient(dt)
    playerBatch:setColor(r,g,b)
    playerBatch:add(playerQuads[Player.tip].cristal,xDraw,yDraw,-controler.angle+math.pi,k/7,k2/7,playerDrawPar[Player.tip].cristalW/2, playerDrawPar[Player.tip].cristalH/2-playerDrawPar[Player.tip].cristalX)
    playerBatch:setColor(1,1,1,1)
    if (playerSkillParametrs.bloodAtFlag == true ) then
        playerBatch:setColor(1,0.7,0.7,1)  
    end
    playerBatch:add(playerQuads[Player.tip].clow1,clow1X,clow1Y,-controler.angle+math.pi+Player.Clows.angle,k/7*Player.Clows.L.scale,k2/7*Player.Clows.L.scale,playerDrawPar[Player.tip].clowW1, playerDrawPar[Player.tip].clowH)
    playerBatch:add(playerQuads[Player.tip].clow2,clow2X,clow2Y,-controler.angle+math.pi-Player.Clows.angle,k/7*Player.Clows.R.scale,k2/7*Player.Clows.R.scale,playerDrawPar[Player.tip].clowW2, playerDrawPar[Player.tip].clowH)
end

function playerSledDraw(x,y,dt)
 --  Player.body:draw('line')
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
        playerBatch:add(playerQuads[Player.tip].tail,sled.x+(Player.x-camera.x),sled.y+(Player.y-camera.y),sled.angle,k/7*radius,k2/7*radius,playerDrawPar[Player.tip].tailW/2,playerDrawPar[Player.tip].tailH/2)
    end
    if ( #playerSledi>10) then
        table.remove(playerSledi,1)
    end
end
function playerCollWithObj(dt)
    local playerIndex =math.floor((Player.x-40*k)/(120*k)) + math.floor((Player.y-40*k2)/(120*k2))*math.floor((screenWidth/(120*k))+1) 
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
            Player.Hp.long = Player.Hp.long - dmg*(1-playerSkillParametrs.meleeDefK)
            if (playerSkillParametrs.spikeFlag == true) then 
                newDeffenseEffect(self)
            end
        end
        if ( tip=='e') then
            Player.Hp.long = Player.Hp.long - dmg
        end
         if ( tip=='r') then
            newPlayerGetDamageEffect(self.x,self.y,7)
            Player.Hp.long = Player.Hp.long - dmg*(1-playerSkillParametrs.rangeDefK)
            if (playerSkillParametrs.spikeFlag == true) then 
                newDeffenseEffect(self)
            end
        end
    end
end

function playerAtackEn(self,dt)
    if (playerSkillParametrs.waveAtFlag or playerSkillParametrs.bloodAtFlag or playerSkillParametrs.sealAtFlag or playerSkillParametrs.vampirFlag) then 
        Player.Boost.long = Player.Boost.long - (Player.Boost.boostWasteSp-(Player.Boost.boostWasteSp*playerSkillParametrs.enK))*     Player.Boost.boostWasteEnHit*dt
    end
        
    AddSound(playerHitSounds,0.3)
    local clow1X =Player.x +playerDrawPar[Player.tip].clowX*k2*math.sin(controler.angle+playerDrawPar[Player.tip].clowR)
    local clow1Y =Player.y +playerDrawPar[Player.tip].clowX*k2*math.cos(controler.angle+playerDrawPar[Player.tip].clowR)
    local clow2X =Player.x +playerDrawPar[Player.tip].clowX*k2*math.sin(controler.angle-playerDrawPar[Player.tip].clowR)
    local clow2Y =Player.y+playerDrawPar[Player.tip].clowX*k2*math.cos(controler.angle-playerDrawPar[Player.tip].clowR)
    
    if ((math.pow(clow1X-self.x,2) + math.pow(clow1Y-self.y,2))> (math.pow(clow2X-self.x,2) + math.pow(clow2Y-self.y,2))) then 
        Player.clowRScaleK = 1.2
        Player.clowRTimer = 10 -0.0001
    else  
        Player.clowLScaleK = 1.2
        Player.clowLTimer = 10 -0.0001
    end
  
    Player.Boost.long = Player.Boost.long - (Player.Boost.boostWaste-(Player.Boost.boostWaste*playerSkillParametrs.enK))*     Player.Boost.boostWasteEnHit*dt
    self.health  =  self.health - Player.damage*playerSkillParametrs.damageK
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
        self.health  =  self.health - Player.damage*playerSkillParametrs.damageK*playerSkillParametrs.sealAt 
    end
end

function playerFrontAtack(i) 
    local flagAt = false
    local anglePlEn =  math.atan2(en[i].x -Player.x, en[i].y - Player.y) 
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
                light22Draw(light22(Player.x+35*k2*math.sin(controler.angle+math.pi/8)+math.random(-4,4)*k,Player.y+35*k2*math.cos(controler.angle+math.pi/8)+math.random(-4,4)*k,masli[i].table.x+math.random(-10,10)*k,masli[i].table.y+math.random(-10,10)*k,5))
                light22Draw(light22(Player.x+35*k2*math.sin(controler.angle-math.pi/8)+math.random(-4,4)*k,Player.y+35*k2*math.cos(controler.angle-math.pi/8)+math.random(-4,4)*k,masli[i].table.x+math.random(-10,10)*k,masli[i].table.y+math.random(-10,10)*k,5))
            else
                table.remove(masli,i)
            end
        end
        if ( Player.a == 1 and #masli == 0 ) then 
            light22Draw(light22(Player.x+35*k2*math.sin(controler.angle)+math.random(-2,2)*k,Player.y+35*k2*math.cos(controler.angle)+math.random(-2,2)*k,Player.x+35*k2*math.sin(controler.angle+math.pi/4)+math.random(-2,2)*k,Player.y+35*k2*math.cos(controler.angle+math.pi/4)+math.random(-2,2)*k,4))
            light22Draw(light22(Player.x+35*k2*math.sin(controler.angle)+math.random(-2,2)*k,Player.y+35*k2*math.cos(controler.angle)+math.random(-2,2)*k,Player.x+35*k2*math.sin(controler.angle-math.pi/4)+math.random(-2,2)*k,Player.y+35*k2*math.cos(controler.angle-math.pi/4)+math.random(-2,2)*k,4))
        end
    end
end


function playerCollWithEn(dt)
    local playerIndex =math.floor((Player.x-40*k)/(80*k)) + math.floor((Player.y-40*k2)/(80*k2))*math.floor((screenWidth/(80*k))+1) 
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

function Player:Clows(dt)
    local Clows = Player.Clows
    local ClowR = Clows.R
    local ClowL = Clows.L
    
    if (ClowR.timer < 10) then 
        ClowR.timer = ClowR.timer - 40*dt
    end
    if (ClowR.timer < 0) then 
        ClowR.scale = 1
        ClowR.timer = 10
    end
    
    if (ClowL.timer < 10) then 
        ClowL.timer = ClowL.timer - 40*dt
    end
    if (ClowL.timer < 0) then 
        ClowL.scale = 1
        ClowL.timer = 10
    end
  
    if ( Clows.flag == 0 or Clows.flag ==1) then
        if (Clows.angle> 0.2) then
            Clows.flag = 1 
        end
        if (Clows.angle< 0) then
            Clows.flag = 0 
        end
        if (Clows.flag==1) then
            if ( Clows.angle > 0.25) then
                Clows.angle = Clows.angle-1*dt
            else
                Clows.angle = Clows.angle-0.2*dt
            end
        else
            if ( Clows.angle<-0.1) then
                Clows.angle = Clows.angle+1.2*dt
            else
                Clows.angle = Clows.angle+0.6*dt
            end
        end
    end
    
    if ( Clows.flag ==3) then
        if (Clows.angle>-0.35) then
            Clows.angle = Clows.angle-2*dt
        end
    end
    if ( Clows.flag  ==4) then
        if (Clows.angle<0.6) then
            Clows.angle = Clows.angle+2*dt
        end
    end
    
    if ( Player.Clows.angle> 0.2 ) then
        Player.Clows.flag = 1 
    end
    if ( Player.Clows.angle< 0 ) then
        Player.Clows.flag = 0 
    end
    
end

function playerDebaff(dt)
    if (Player.debaffStrenght < 1) then
        local time = 3 
        Player.debaffStrenght = Player.debaffStrenght  + 0.8*dt/time
    else
        Player.debaffStrenght = 1 
    end
end

function playerBorder()
    if ( Player.x > borderWidth*2-Player.scaleBody*k) then
        Player.x = borderWidth*2 -Player.scaleBody*k
    end 
    if ( Player.x < -borderWidth+Player.scaleBody*k) then
        Player.x = -borderWidth +Player.scaleBody*k
    end 
    if ( Player.y < -borderHeight+Player.scaleBody*k2) then
        Player.y = -borderHeight +Player.scaleBody*k2
    end 
    if ( Player.y > borderHeight*2- Player.scaleBody*k2) then
        Player.y = borderHeight*2 -Player.scaleBody*k2
    end 
end

function playerHP(dt)
    if ( Player.Hp.long/720*100> 100) then
        Player.Hp.long = 720
        Player.Hp.long2 = 720 
    end
    if (Player.Hp.long > Player.Hp.long2) then
        Player.Hp.long2= Player.Hp.long
    end
    if (Player.Hp.long<Player.Hp.long2 ) then
        Player.Hp.long2 = Player.Hp.long2-70*dt
    end
    if ( Player.Hp.long> Player.Hp.long3) then
        Player.Hp.long3 = Player.Hp.long3+ 100*dt
    else
        Player.Hp.long3  = Player.Hp.long
    end
    if ( flaginv == false) then
        inv:update(dt)
        inv:every(Player.invTimer, function()
            inv:clear() 
            shake  = 0    
            flaginv =  true
        end)
    end
end

function playerBoost(dt)
    if ( Player.Boost.long/720*100 > 100) then
        Player.Boost.long = 720
        Player.Boost.long2 = 720
    end
    
    if ( Player.Boost.long2>Player.Boost.long) then
        Player.Boost.long2 = Player.Boost.long2-70*dt
    end
    if ( Player.Boost.long2<Player.Boost.long) then
        Player.Boost.long2 = Player.Boost.long2+Player.Boost.boostRegen *dt*2
    end
    
    if ( Player.Boost.long <= 30*k2 ) then
        Player.a=0
        Player.Boost.long =30*k2
    end
    
    if ( Player.a==1) then
        Player.Boost.long = Player.Boost.long - (Player.Boost.boostWaste-(Player.Boost.boostWaste*playerSkillParametrs.enK))*dt
    else
        Player.Boost.long = Player.Boost.long + Player.Boost.boostRegen *dt
    end
    if  (Player.Boost.long>720) then
        Player.Boost.long = 720
        if (playerSkillParametrs.tradeFlag == true and Player.Hp.long<720 and flaginv == true) then 
            newTradeEffect()
            Player.Hp.long = Player.Hp.long +10*dt
        end
    end
end

function playerBoostDop(dt)
    if ( playerSkillParametrs.dopEnFlag == true) then 
        angleBoostDop(dt,controler.angle)
        if ( boostDop.long/720*100 > 100) then
            boostDop.long = 720
        end
        if (boostDop.recovery == boostDop.recoveryTimer) then 
            boostDop.long = boostDop.long + Player.Boost.boostRegen/1.5 *dt*k
            boostDop.shakeK = 0
        end
        if ( boostDop.long <= 0 ) then
            boostDop.long =0
        end
        if  (boostDop.long>720) then
            boostDop.long = 720
        end
        boostDop.shake = math.random()*math.random(-1,1)*boostDop.shakeK
        if ( boostDop.shakeK > 1 ) then 
            boostDop.shakeK  = boostDop.shakeK - 10 *dt
        end
        
        if ( boostDop.recovery < boostDop.recoveryTimer) then 
            boostDop.recovery =boostDop.recovery - 3*dt
            if ( boostDop.recovery < 0 )then 
                boostDop.recovery = boostDop.recoveryTimer
            end
        end
    else
        boostDop.long = 0 
    end
end


function angleBoostDop (dt,angle) 
    if ( boostDop.angle == 0) then
        boostDop.angle=0.00000001
    end
    if ( boostDop.angle < -math.pi) then
        boostDop.angle=math.pi
    end
    if ( boostDop.angle > math.pi) then
        boostDop.angle=-math.pi
    end
    if ( angle == 0) then
        angle=0.00000001
    end
    if ((angle -  boostDop.angle > 2.1*dt) or (angle -  boostDop.angle) <  -2.1*dt ) then
        if (angle/math.abs(angle)==boostDop.angle/math.abs(boostDop.angle))then
            if ( angle>boostDop.angle) then
                boostDop.angle = boostDop.angle+2*dt
            else 
                boostDop.angle = boostDop.angle-2*dt
            end
        else
            if (math.abs(angle)+math.abs(boostDop.angle)> 2*math.pi - math.abs(angle)-math.abs(boostDop.angle)) then
                if (boostDop.angle>0) then 
                    boostDop.angle = boostDop.angle+2*dt
                else
                    boostDop.angle = boostDop.angle-2*dt
                end
            else 
                if (boostDop.angle>0) then 
                    boostDop.angle = boostDop.angle-2*dt
                else
                    boostDop.angle = boostDop.angle+2*dt
                end
            end
        end
    end
end
        
function Health_Boost()
    love.graphics.setColor(0.02,0.3,0.02,1)
    love.graphics.rectangle("fill",Player.x-(Player.scaleBody+17)*k,Player.y+720/11*k/2,4*k2,-720/11*k)
    love.graphics.setColor(0.19,1,0.19,1)
    love.graphics.rectangle("fill",Player.x-(Player.scaleBody+17)*k,Player.y+720/11*k/2,4*k2,(-Player.Hp.long2/720*720/11)*k)
    love.graphics.setColor(0.02,0.6,0.02,1)
    love.graphics.rectangle("fill",Player.x-(Player.scaleBody+17)*k,Player.y+720/11*k/2,4*k2,(-Player.Hp.long3/720*720/11)*k)

    love.graphics.setColor(0,0.32,0.225,1)
    love.graphics.rectangle("fill",Player.x-(Player.scaleBody+11)*k,Player.y+720/11*k/2,3*k2,-720/11*k)
    love.graphics.setColor(0.15,1,0.9,1)
    love.graphics.rectangle("fill",Player.x-(Player.scaleBody+11)*k,Player.y+720/11*k/2,3*k2,(-Player.Boost.long2/720*720/11)*k)
    love.graphics.setColor(0,0.643,0.502,1)
    love.graphics.rectangle("fill",Player.x-(Player.scaleBody+11)*k,Player.y+720/11*k/2,3*k2,(-Player.Boost.long/720*720/11)*k)     
   
    if ( playerSkillParametrs.dopEnFlag == true) then 
        love.graphics.setLineWidth(2*k)
        love.graphics.setColor(0,1,1,boostDop.long/720)
        local kek1 =  love.math.newBezierCurve(Player.x-(Player.scaleBody/2)*k,Player.y-(Player.scaleBody+2)*k, Player.x,Player.y-(Player.scaleBody+10)*k,Player.x+(Player.scaleBody/2)*k,Player.y-(Player.scaleBody+2)*k) 
        kek1:rotate(-boostDop.angle-math.pi/2,Player.x,Player.y)
        kek1:scale(boostDop.long/720,Player.x,Player.y)
        kek1:translate((1-boostDop.long/720)*40*k*-1*math.cos(boostDop.angle),(1-boostDop.long/720)*40*k*math.sin(boostDop.angle))
        love.graphics.line(kek1:render())
        local colorRandom =1 -- math.random()/2*math.random(-1,1)
        --boostDop.shake = 0
        love.graphics.setColor(0,0.8+colorRandom,1+colorRandom,boostDop.long/720/7)
        love.graphics.circle('fill',Player.x,Player.y,(Player.scaleBody+6)*k)
        love.graphics.setColor(0,0.8+colorRandom,1+colorRandom,boostDop.long/720/2)
        
        love.graphics.circle('line',Player.x,Player.y,(Player.scaleBody+6)*k+boostDop.shake*k)
        
        love.graphics.setColor(0,0.8+colorRandom,1+colorRandom,boostDop.long/720/4)
        
        love.graphics.circle('line',Player.x,Player.y,(Player.scaleBody+6)*k-2*k+boostDop.shake*k)
        love.graphics.setColor(0,0.8+colorRandom,1+colorRandom,boostDop.long/720/6)
        
        love.graphics.circle('line',Player.x,Player.y,(Player.scaleBody+6)*k-4*k+boostDop.shake*k)
    end
  
    love.graphics.setColor(1,1,1,1)
end







function playerDie()
    if ( Player.Hp.long<=0) then 
        makeSave()
        gamestate.switch(die)
    end
end

return playerFunction