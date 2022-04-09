local playerFunction = {} 

local die = require "scripts/gameStates/gameLoop/die" 
local saveFunction = require "scripts/systemComponents/saveFunction" 

Player = {
    tip =1 , 
    x = borderWidth/2+40*k/2, 
    y = borderHeight/2+40*k2/2,  
    scaleBody = 35,
    angleBody = 0,
    body =HC.circle(borderWidth/2+40*k/2,borderHeight/2+40*k2/2,35*k),
    a = 0 , 
    ax = 0,
    ay = 0,
    mass =200,
    radiusCollect = 100,
    damage = 1,
    flagInv = true,
    inv = 2,
    invTimer = 2,
    maxSpeed = 30,
    speedA  = 1.8,
    speed = 6,
    debaffStrenght =0.2,

    Energy = {
        value = 1000,
        maxValue = 1000,
        lengthBar = 1000,
        flag = true,
        regen = 100,
        wasteBoost = 150,
        wasteAtack = 5,
        wasteSpecialAtack =500,
    },
    Hp = {
        value = 1000, 
        maxValue = 1000,
        lengthBar = 1000,
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
    Controller = { 
        x0 = 0, 
        y0 = 0,
        x = 0,
        y = 0,
        angle = 0,
        flag = false
    },
    Camera = {
        x = borderWidth/2+40*k/2, 
        y = borderHeight/2+40*k2/2
    },
    Skills = {
        Hp = {
            hpK = 0, -- common1
        },
        Energy = {
            enK = 0, -- common2
        },
        MeleeDefense = {
            meleeDefK = 0, -- common3
        },
        RangeDefense = {
            rangeDefK = 0, -- common4
        },
        Damage = {
            damageK = 1, -- common5
        },
        Speed = {
            speedK = 1, -- common6
        },
        Collect = {
            collectRangeK = 1, -- common7
        },
        SpecialAtack = {
            Wave = {
                waveAt = 0.2, -- rare8
                waveAtFlag = false,  
            },
            Bloody = {
                bloodAt = 0.2, -- rare9
                bloodAtFlag = false,
            },
            Electric = {
                sealAt = 0.2, -- rare10
                sealAtFlag = false,
            },
            Vampir = {
                vampirK = 0.1, -- legend14
                vampirFlag = false,
            },
        },
        SpikeArmor = {
            spike = 0, -- rare11
            spikeFlag = false,
        },
        EnergyArmor = {
            dopEn = 0.1, -- legend13
            dopEnflag = false,
        },
        Trade = {
            tradeK = 0.1, -- legend13
            tradeFlag = false,
        },
    },

}

function Player:refreshParameters()
    self.x = borderWidth/2+40*k/2 
    self.y = borderHeight/2+40*k2/2
    self.body =HC.circle(borderWidth/2+40*k/2,borderHeight/2+40*k2/2,self.scaleBody)
    self.a = 0 
    self.ax = 0
    self.ay = 0
    self.inv =self.invTimer
    self.flagInv = true
    self.debaffStrenght =0.2
    
    self.Hp.value = self.Hp.maxValue
    self.Hp.lengthBar = self.Hp.maxValue

    self.Energy.value = self.Energy.maxValue
    self.Energy.lengthBar = self.Energy.maxValue
    
    self.Clows.angle = 0
    self.Clows.flag = 0
    self.Clows.R.timer = 10
    self.Clows.L.timer = 10
    self.Clows.R.scale = 1
    self.Clows.L.scale = 1
end

function Player:control()
    if ( love.mouse.isDown(1) ) then
        if ( self.Controller.flag == false and mouse.x > screenWidth / 9) then 
            if ( controllerChoose == 1 ) then 
                self.Controller.x0 = mouse.x
                self.Controller.y0 = mouse.y
            elseif ( controllerChoose == 2 ) then 
                self.Controller.x0 = screenWidth/1.2
                self.Controller.y0 = screenHeight - screenHeight/3
            elseif ( controllerChoose == 3 ) then  
                self.Controller.x0 = screenWidth/1.2
                self.Controller.y0 = screenHeight/3
            end
            self.Controller.flag = true
        end
        
        if ( self.Controller.flag == true and mouse.x > screenWidth / 9) then 
            self.Controller.x = mouse.x -   self.Controller.x0
            self.Controller.y = mouse.y -   self.Controller.y0
            if ( math.abs(self.Controller.x) >1*k or math.abs(self.Controller.y)>1*k2) then
                self.Controller.angle = math.atan2(self.Controller.x,self.Controller.y)
                self.angleBody = self.Controller.angle
            end  
            if (( math.abs(self.Controller.x) >1*k or math.abs(self.Controller.y)>1*k2)) then
                Player.ax  =math.sin(self.Controller.angle)*math.abs(self.Controller.x*screenWidth/screenHeight/3.5)*Sensitivity
                Player.ay  =math.cos(self.Controller.angle)*math.abs(self.Controller.y*screenWidth/screenHeight/3.5)*Sensitivity
            end
        else
            self.Controller.flag = true
        end
    else
        self.Controller.flag =false
    end
    
    if ((#love.touch.getTouches()>1 and Player.Energy.flag == true) or (love.keyboard.isDown('t')  and Player.Energy.flag == true ) ) then
        Player.Clows.flag =4 
        Player.a = 1
    else
        Player.a = 0
    end
end

function Player:move(dt)
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
        Player.x = Player.x + Player.ax*dt*Player.speed*Player.speedA*k*Player.debaffStrenght*Player.Skills.Speed.speedK
        Player.y = Player.y + Player.ay*dt*Player.speed*Player.speedA*k2*Player.debaffStrenght*Player.Skills.Speed.speedK
    else
        Player.x = Player.x + Player.ax*dt*k*Player.speed*Player.debaffStrenght*Player.Skills.Speed.speedK
        Player.y = Player.y + Player.ay*dt*k2*Player.speed*Player.debaffStrenght*Player.Skills.Speed.speedK
    end
    Player.body:moveTo(Player.x,Player.y)
end

function Player.Camera:update(dt)
    if not( Player.x > borderWidth*2-screenWidth/2+20*k or  Player.x < -borderWidth+screenWidth/2+20*k) then
        self.x =self.x+(Player.x-self.x)*dt*5*k
    else
        if (  Player.x > borderWidth*2-screenWidth/2+20*k) then
            self.x =self.x+( borderWidth*2-screenWidth/2+20*k-self.x)*dt*5*k
        else
            self.x =self.x+(-borderWidth+screenWidth/2+20*k-self.x)*dt*5*k
        end
    end
    if not( Player.y >  borderHeight*2-screenHeight/2+20*k2 or  Player.y < - borderHeight+screenHeight/2+20*k2 ) then
        self.y =self.y+(Player.y-self.y)*dt*5*k2
    else
        if (  Player.y >borderHeight*2-screenHeight/2+20*k2) then
            self.y =self.y+(borderHeight*2-screenHeight/2+20*k2-self.y)*dt*5*k2
        else
            self.y =self.y+(-borderHeight+screenHeight/2+20*k2-self.y)*dt*5*k2
        end
    end
end 
  
function Player:draw(dt)
    local xDraw = screenWidth/2+20*k+(self.x-self.Camera.x)
    local yDraw = screenHeight/2+20*k2+(self.y-self.Camera.y)  
    local clow1X =xDraw +playerDrawPar[self.tip].clowX*k2*math.sin(self.angleBody+playerDrawPar[self.tip].clowR)
    local clow1Y =yDraw +playerDrawPar[self.tip].clowX*k2*math.cos(self.angleBody+playerDrawPar[self.tip].clowR)
    local clow2X =xDraw +playerDrawPar[self.tip].clowX*k2*math.sin(self.angleBody-playerDrawPar[self.tip].clowR)
    local clow2Y =yDraw+playerDrawPar[self.tip].clowX*k2*math.cos(self.angleBody-playerDrawPar[self.tip].clowR)
    
    self:sledDraw(screenWidth/2+20*k,screenHeight/2+20*k2,dt)
    
    playerBatch:add(playerQuads[self.tip].body,xDraw,yDraw,-self.angleBody+math.pi,k/7,k2/7, playerDrawPar[self.tip].bodyW/2, playerDrawPar[self.tip].bodyH/2)
    playerBatch:setColor( 1, 1,1,0.8 )
      playerBatch:add(playerQuads[self.tip].wings,xDraw,yDraw,-self.angleBody+math.pi,k/7,k2/7,playerDrawPar[self.tip].wingsW/2, playerDrawPar[self.tip].wingsH/2-playerDrawPar[self.tip].wingsX)
      local r ,g ,b = gradient(dt)
    playerBatch:setColor(r,g,b)
      playerBatch:add(playerQuads[self.tip].cristal,xDraw,yDraw,-self.angleBody+math.pi,k/7,k2/7,playerDrawPar[self.tip].cristalW/2, playerDrawPar[self.tip].cristalH/2-playerDrawPar[self.tip].cristalX)
      
    playerBatch:setColor(1,1,1,1)
    if (Player.Skills.SpecialAtack.Bloody.bloodAtFlag == true ) then
        playerBatch:setColor(1,0.7,0.7,1)  
    end
      playerBatch:add(playerQuads[self.tip].clow1,clow1X,clow1Y,-self.angleBody+math.pi+self.Clows.angle,k/7*self.Clows.L.scale,k2/7*self.Clows.L.scale,playerDrawPar[self.tip].clowW1, playerDrawPar[self.tip].clowH)
      playerBatch:add(playerQuads[self.tip].clow2,clow2X,clow2Y,-self.angleBody+math.pi-self.Clows.angle,k/7*self.Clows.R.scale,k2/7*self.Clows.R.scale,playerDrawPar[self.tip].clowW2, playerDrawPar[self.tip].clowH)
end

function Player:sledDraw(x,y,dt)
    --Player.body:draw('line')
    love.graphics.circle('line',self.Controller.x0,self.Controller.y0,13*k)
    love.graphics.circle('line',mouse.x,mouse.y,5*k)
    love.graphics.circle('line',mouse.x,mouse.y,5*k)
    local playerSled = {
        angle = -self.angleBody+math.pi,
        ax =-2*k*math.sin(self.angleBody) ,
        ay =-2*k2*math.cos(self.angleBody),
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
        playerBatch:add(playerQuads[self.tip].tail,sled.x+(self.x-self.Camera.x),sled.y+(self.y-self.Camera.y),sled.angle,k/7*radius,k2/7*radius,playerDrawPar[self.tip].tailW/2,playerDrawPar[self.tip].tailH/2)
    end
    if ( #playerSledi>10) then
        table.remove(playerSledi,1)
    end
end
function Player:collisionWithObj(dt)
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

function Player:takeDamage(dmg,tip,atacker)
    self.flagInv = false
    AddSound(playerHurtSounds,0.3)
    dmg = dmg- Player.Skills.Hp.hpK*dmg
    boostDop.recovery =boostDop.recoveryTimer - 0.0000001
    if (boostDop.long>0) then 
        boostDop.long = boostDop.long - (dmg-(dmg*Player.Skills.EnergyArmor.dopEn))*4
        boostDop.shakeK = 20
    else
        if ( tip=='m') then
            newPlayerGetDamageEffect(self.x,self.y,7)
            self.Hp.value = self.Hp.value - dmg*(1-Player.Skills.MeleeDefense.meleeDefK)
            if (Player.Skills.SpikeArmor.spikeFlag == true) then 
                newDeffenseEffect(atacker)
            end
        end
        if ( tip=='e') then
            self.Hp.value = self.Hp.value - dmg
        end
         if ( tip=='r') then
            newPlayerGetDamageEffect(self.x,self.y,7)
            self.Hp.value = self.Hp.value - dmg*(1-Player.Skills.RangeDefense.rangeDefK)
            if (Player.Skills.SpikeArmor.spikeFlag == true) then 
                newDeffenseEffect(atacker)
            end
        end
    end
    if ( self.Hp.value<=0) then 
        makeSave()
        gamestate.switch(die)
    end
end

function Player:heal(value)
    Player.Hp.value=Player.Hp.value+value
end

function Player:rechargeEnergy(value)
    self.Energy.value=self.Energy.value+value
end

function Player:atack(self,dt)
    if (Player.Skills.SpecialAtack.Wave.waveAtFlag or Player.Skills.SpecialAtack.Bloody.bloodAtFlag or Player.Skills.SpecialAtack.Electric.sealAtFlag or Player.Skills.SpecialAtack.Vampir.vampirFlag) then 
        Player.Energy.value = Player.Energy.value - (Player.Energy.wasteSpecialAtack-(Player.Energy.wasteSpecialAtack*Player.Skills.Energy.enK))*Player.Energy.wasteAtack*dt
    end
        
    AddSound(playerHitSounds,0.3)
    Player.Clows:scale()
    Player.Energy.value = Player.Energy.value - (Player.Energy.wasteBoost-(Player.Energy.wasteBoost*Player.Skills.Energy.enK))*     Player.Energy.wasteAtack*dt
    self.health  =  self.health - Player.damage*Player.Skills.Damage.damageK
    if (Player.Skills.SpecialAtack.Vampir.vampirFlag == true) then 
        newVampirEffect(self)
    end
    if (Player.Skills.SpecialAtack.Wave.waveAtFlag == true) then 
        newWaveEffect(self.x,self.y) -- damage
    end
    if (Player.Skills.SpecialAtack.Bloody.bloodAtFlag == true) then 
        newBloodEffect(self)  -- damage
    end
    if (Player.Skills.SpecialAtack.Electric.sealAtFlag == true) then 
        table.insert(masli,{table = self, timer = 10,flag = nil})
        self.health  =  self.health - Player.damage*Player.Skills.Damage.damageK*Player.Skills.SpecialAtack.Electric.sealAt 
    end
end

function Player:isFrontOf(target) 
    local flagFront = false
    local anglePlayerAndTarget =  math.atan2(target.x -Player.x, target.y - Player.y) 
    if (anglePlayerAndTarget/math.abs(anglePlayerAndTarget)==Player.angleBody/math.abs(Player.angleBody))then
        if (math.abs(math.abs(anglePlayerAndTarget) - math.abs(Player.angleBody)) <  math.pi/4) then 
            flagFront = true
        end
    else
        if (math.abs(anglePlayerAndTarget)+math.abs(Player.angleBody)> 2*math.pi - math.abs(anglePlayerAndTarget)-math.abs(Player.angleBody)) then
            if ((2*math.pi - math.abs(anglePlayerAndTarget)-math.abs(Player.angleBody)) <  math.pi/4) then 
                flagFront = true
            end
        else 
            if ((math.abs(anglePlayerAndTarget)+math.abs(Player.angleBody)) <  math.pi/4) then 
                flagFront = true
            end
        end
    end
    return flagFront
end

function playerLiDraw(dt)
    if (Player.Skills.SpecialAtack.Electric.sealAtFlag == true) then 
        for i=#masli,1,-1 do
            if (masli[i].table and masli[i].timer > 0  ) then
                masli[i].timer = masli[i].timer - 50*dt
                light22Draw(light22(Player.x+35*k2*math.sin(Player.angleBody+math.pi/8)+math.random(-4,4)*k,Player.y+35*k2*math.cos(Player.angleBody+math.pi/8)+math.random(-4,4)*k,masli[i].table.x+math.random(-10,10)*k,masli[i].table.y+math.random(-10,10)*k,5))
                light22Draw(light22(Player.x+35*k2*math.sin(Player.angleBody-math.pi/8)+math.random(-4,4)*k,Player.y+35*k2*math.cos(Player.angleBody-math.pi/8)+math.random(-4,4)*k,masli[i].table.x+math.random(-10,10)*k,masli[i].table.y+math.random(-10,10)*k,5))
            else
                table.remove(masli,i)
            end
        end
        if ( Player.a == 1 and #masli == 0 ) then 
            light22Draw(light22(Player.x+35*k2*math.sin(Player.angleBody)+math.random(-2,2)*k,Player.y+35*k2*math.cos(Player.angleBody)+math.random(-2,2)*k,Player.x+35*k2*math.sin(Player.angleBody+math.pi/4)+math.random(-2,2)*k,Player.y+35*k2*math.cos(Player.angleBody+math.pi/4)+math.random(-2,2)*k,4))
            light22Draw(light22(Player.x+35*k2*math.sin(Player.angleBody)+math.random(-2,2)*k,Player.y+35*k2*math.cos(Player.angleBody)+math.random(-2,2)*k,Player.x+35*k2*math.sin(Player.angleBody-math.pi/4)+math.random(-2,2)*k,Player.y+35*k2*math.cos(Player.angleBody-math.pi/4)+math.random(-2,2)*k,4))
        end
    end
end

function Player:collision(dt)
    self:collisionWithObj(dt)
    self:collisionWithEnemies(dt)
end

function Player:collisionWithEnemies(dt)
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

function Player.Clows:update(dt)
    local ClowR = self.R
    local ClowL = self.L
    
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
  
    if ( self.flag == 0 or self.flag ==1) then
        if (self.angle> 0.2) then
            self.flag = 1 
        end
        if (self.angle< 0) then
            self.flag = 0 
        end
        if (self.flag==1) then
            if ( self.angle > 0.25) then
                self.angle = self.angle-1*dt
            else
                self.angle = self.angle-0.2*dt
            end
        else
            if ( self.angle<-0.1) then
                self.angle = self.angle+1.2*dt
            else
                self.angle = self.angle+0.6*dt
            end
        end
    end
    
    if ( self.flag ==3) then
        if (self.angle>-0.35) then
            self.angle = self.angle-2*dt
        end
    end
    if ( self.flag  ==4) then
        if (self.angle<0.6) then
            self.angle = self.angle+2*dt
        end
    end
    
    if ( self.angle> 0.2 ) then
        self.flag = 1 
    end
    
    if ( self.angle< 0 ) then
        self.flag = 0 
    end
    
end

function Player.Clows:scale()
    local clow1X =Player.x +playerDrawPar[Player.tip].clowX*k2*math.sin(Player.angleBody+playerDrawPar[Player.tip].clowR)
    local clow1Y =Player.y +playerDrawPar[Player.tip].clowX*k2*math.cos(Player.angleBody+playerDrawPar[Player.tip].clowR)
    local clow2X =Player.x +playerDrawPar[Player.tip].clowX*k2*math.sin(Player.angleBody-playerDrawPar[Player.tip].clowR)
    local clow2Y =Player.y+playerDrawPar[Player.tip].clowX*k2*math.cos(Player.angleBody-playerDrawPar[Player.tip].clowR)
    
    if ((math.pow(clow1X-Player.x,2) + math.pow(clow1Y-Player.y,2))> (math.pow(clow2X-Player.x,2) + math.pow(clow2Y-Player.y,2))) then 
        self.L.scale = 1.2
        self.L.timer = 10 -0.0001
    else  
        self.R.scale = 1.2
        self.R.timer = 10 -0.0001
    end
end

function Player:debaff(dt)
    if (self.debaffStrenght < 1) then
        local time = 3 
        self.debaffStrenght = self.debaffStrenght  + 0.8*dt/time
    else
        self.debaffStrenght = 1 
    end
end

function Player:border()
    if ( self.x > borderWidth*2-self.scaleBody*k) then
        self.x = borderWidth*2 -self.scaleBody*k
    end 
    if ( self.x < -borderWidth+self.scaleBody*k) then
        self.x = -borderWidth +self.scaleBody*k
    end 
    if ( self.y < -borderHeight+self.scaleBody*k2) then
        self.y = -borderHeight +self.scaleBody*k2
    end 
    if ( self.y > borderHeight*2- self.scaleBody*k2) then
        self.y = borderHeight*2 -self.scaleBody*k2
    end 
end

function Player.Hp:update(dt)
    if ( self.value>self.maxValue) then
        self.value = self.maxValue
        self.lengthBar = self.maxValue 
    end
    
    if (self.lengthBar<self.value) then
        self.lengthBar= self.value
    end
    if (self.lengthBar>self.value ) then
        self.lengthBar = self.lengthBar-self.maxValue/100*10*dt
    end
end

function Player:invisible(dt)
    if ( self.flagInv == false) then
        if (self.inv > 0 ) then 
            self.inv = self.inv-10*dt
        else
            self.inv = self.invTimer
            shake  = 0    
            self.flagInv =  true
        end
    end
end

function Player.Energy:update(dt)
    if ( self.value > self.maxValue) then
        self.value = self.maxValue
        self.lengthBar = self.maxValue
    end
    
    if ( self.lengthBar>self.value) then
        self.lengthBar = self.lengthBar-self.maxValue/100*8*dt
    end
    if ( self.lengthBar<self.value) then
        self.lengthBar = self.value
    end
    
    if ( Player.Energy.value > Player.Energy.maxValue/100*15) then
        Player.Energy.flag = true
    end
    if ( Player.Energy.value <= 0  ) then
        Player.a=0
        Player.Energy.value =0
        Player.Energy.flag = false
    end
    
    if ( Player.a==1) then
        self.value = self.value - (self.wasteBoost-(self.wasteBoost*Player.Skills.Energy.enK))*dt
    else
        self.value = self.value + self.regen *dt
    end
    
    ---------------------------------
    if  (self.value>self.maxValue) then
        self.value = self.maxValue
        if (Player.Skills.Trade.tradeFlag == true and Player.Hp.value<Player.Hp.maxValue and Player.flagInv == true) then 
            newTradeEffect()
            Player.Hp.value = Player.Hp.value +10*dt
        end --skill
    end
    ----------------------------------
end

function playerBoostDop(dt)
    if ( Player.Skills.EnergyArmor.dopEnFlag == true) then 
        angleBoostDop(dt,Player.Controller.angle)
        if ( boostDop.long/720*100 > 100) then
            boostDop.long = 720
        end
        if (boostDop.recovery == boostDop.recoveryTimer) then 
            boostDop.long = boostDop.long + Player.Energy.regen/1.5 *dt*k
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
        
function Player:drawUI()
    love.graphics.setColor(0.02,0.3,0.02,1)
    love.graphics.rectangle("fill",Player.x-(Player.scaleBody+17)*k,Player.y+720/11*k/2,4*k2,-720/11*k)
    love.graphics.setColor(0.19,1,0.19,1)
    love.graphics.rectangle("fill",Player.x-(Player.scaleBody+17)*k,Player.y+720/11*k/2,4*k2,(-Player.Hp.lengthBar/Player.Hp.maxValue*720/11)*k)
    love.graphics.setColor(0.02,0.6,0.02,1)
    love.graphics.rectangle("fill",Player.x-(Player.scaleBody+17)*k,Player.y+720/11*k/2,4*k2,(-Player.Hp.value/Player.Hp.maxValue*720/11)*k)

    love.graphics.setColor(0,0.32,0.225,1)
    love.graphics.rectangle("fill",Player.x-(Player.scaleBody+11)*k,Player.y+720/11*k/2,3*k2,-720/11*k)
    love.graphics.setColor(0.15,1,0.9,1)
    love.graphics.rectangle("fill",Player.x-(Player.scaleBody+11)*k,Player.y+720/11*k/2,3*k2,(-Player.Energy.lengthBar/Player.Energy.maxValue*720/11)*k)
    love.graphics.setColor(0,0.643,0.502,1)
    love.graphics.rectangle("fill",Player.x-(Player.scaleBody+11)*k,Player.y+720/11*k/2,3*k2,(-Player.Energy.value/Player.Energy.maxValue*720/11)*k)     
   
    if ( Player.Skills.EnergyArmor.dopEnFlag == true) then 
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

return playerFunction