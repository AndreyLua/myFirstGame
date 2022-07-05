local playerFunction = {} 

local die = require "scripts/gameStates/gameLoop/die" 
local saveFunction = require "scripts/systemComponents/saveFunction" 
local loadGame = require "scripts/systemComponents/loadGame" 
LoadPlayerImg()
LoadSkillsImg()
local Skill = Class{
    lvl = 1, 
    perUpgrade = 0.2,
    value = 0,
    number = 10000,
    rare ="common",
    isOpened = false,
    upgrade =  function(self)
        self.Interface.cost = self.Interface.cost + math.floor(self.Interface.cost*self.Interface.costIncrease)
        self.lvl = self.lvl+1
        self.value = self.value+self.value*self.perUpgrade
    end;
}
 
Player = {
    tip =1 , 
    tipStaticParametrs ={
        {healthRatio = 1,energyRatio = 1,critChanceRatio = 1},
        {healthRatio = 1,energyRatio = 1.5,critChanceRatio = 1.5},
        {healthRatio = 1.7,energyRatio = 1.2,critChanceRatio = 1},
    },
    x = borderWidth/2+40*k/2, 
    y = borderHeight/2+40*k2/2,  
    scaleBody = 35,
    angleBody = 0,
    body = HC.circle(borderWidth/2+40*k/2,borderHeight/2+40*k2/2,35*k),
    a = 0 , 
    ax = 0,
    ay = 0,
    mass = 200,
    radiusCollect = 100,
    damage = 70,
    criticalDamage = 2,
    criticalChance = 0.07,
    flagInv = true,
    inv = 2,
    invTimer = 2,
    maxSpeed = 30,
    speedA  = 1.8,
    speed = 6,
    debaffStrenght = 0.2,
    maxLvlSkills = 10,
    
    Energy = {
        value = 250,
        maxValue = 250,
        lengthBar = 250,
        flag = true,
        regen = 0.1,--%
        wasteBoost = 130,
        wasteAtack = 10,
        wasteSpecialAtack = 70,
    },
    Hp = {
        value = 250, 
        maxValue = 250,
        lengthBar = 250,
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
        Hp =Class{__includes =Skill, 
            Interface = {
                cost = 1500,
                costIncrease = 0.35,
                text = 'Increasing the amount of health',
                image = skillQuads.hp,
                slotRarityImage = UIQuads.tableSkillNormal,
            },
            number = 1,
            isOpened = true,
            upgrade =  function(self)
                self.Interface.cost = self.Interface.cost + math.floor(self.Interface.cost*self.Interface.costIncrease)
                self.lvl = self.lvl+1
                self.value = self.value+self.value*self.perUpgrade
                Player.Hp.maxValue = Player.Skills.Hp.value
            end;
        },
        Energy = Class{__includes =Skill,
            Interface = {
                cost = 1700,
                costIncrease = 0.35,
                text = 'Increasing the amount of energy',
                image = skillQuads.energy,
                slotRarityImage = UIQuads.tableSkillNormal,
            },
            number =2,
            isOpened = true,
            
            upgrade =  function(self)
                self.Interface.cost = self.Interface.cost + math.floor(self.Interface.cost*self.Interface.costIncrease)
                self.lvl = self.lvl+1
                self.value = self.value+self.value*self.perUpgrade
                Player.Energy.maxValue = Player.Skills.Energy.value
            end;
        },
        MeleeDefense = Class{__includes =Skill, 
            Interface = {
                cost = 2000,
                costIncrease = 0.35,
                text = 'Increased resistance to melee attacks',
                image =skillQuads.meleeDef,
                slotRarityImage = UIQuads.tableSkillNormal,
            },
            
            value = 0.05,
            perUpgrade = 0.23,
            number = 3,
        },
        RangeDefense = Class{__includes =Skill, 
            Interface = {
                cost = 2000,
                costIncrease = 0.35,
                text = 'Increased resistance to range attacks',
                image =skillQuads.rangeDef,
                slotRarityImage = UIQuads.tableSkillNormal,
            },
            value = 0.05,
            perUpgrade = 0.23,
            number = 4,
        },
        Damage = Class{__includes =Skill, 
            Interface = {
                cost = 2500,
                costIncrease = 0.35,
                image =skillQuads.atack,
                text = 'Increased attack power',
                slotRarityImage = UIQuads.tableSkillNormal,
            },
            number = 5,
            value = 1,
            perUpgradeCrit = 0.17,
            isOpened = true,
            upgrade =  function(self)
                self.Interface.cost = self.Interface.cost + math.floor(self.Interface.cost*self.Interface.costIncrease)
                self.lvl = self.lvl+1
                self.value = self.value+self.value*self.perUpgrade
                Player.criticalChance = Player.criticalChance+Player.criticalChance*self.perUpgradeCrit
            end;
        },
        Speed = Class{__includes =Skill, 
            Interface = {
                cost = 2000,
                costIncrease = 0.35,
                image =skillQuads.speed,
                text = 'Speed increase',
                slotRarityImage = UIQuads.tableSkillNormal,
            },
            perUpgrade = 0.035,
            number = 6,
            value = 1,
        },
        Collect = Class{__includes =Skill, 
            Interface = {
                cost = 1000,
                costIncrease = 0.35,
                text = 'Increasing the resource collection radius',
                image =skillQuads.collectRange,
                slotRarityImage = UIQuads.tableSkillNormal,
            },
            number = 7,
            perUpgrade = 0.08,
            value =1,
        },
        SpecialAtack = {
            Wave = Class{__includes =Skill, 
                Interface = {
                    cost = 2000,
                    costIncrease = 0.35,
                    text = 'Wave attack modifier (expends energy)',
                    image =skillQuads.waveAtack,
                    slotRarityImage = UIQuads.tableSkillRare,
                },
                number = 8,
                count = 2,
                perUpgradeCount = 0.08,
                value = 0.3,
                perUpgrade = 0.15,
                rare ="rare",
                isUsed = false,
                
                upgrade =  function(self)
                    self.Interface.cost = self.Interface.cost + math.floor(self.Interface.cost*self.Interface.costIncrease) 
                    self.lvl = self.lvl+1
                    self.value = self.value+self.value*self.perUpgrade
                    self.count = self.count+self.count*self.perUpgradeCount
                end;
            },
            Bloody = Class{__includes =Skill,
                Interface = {
                    cost = 2000,
                    costIncrease = 0.35,
                    text = 'Bloody attack modifier (expends energy)',
                    image =skillQuads.bloodAtack,
                    slotRarityImage = UIQuads.tableSkillRare,
                },
                number = 9,
                value = 0.1,
                perUpgrade = 0.1,
                slowingDown = 0.15,
                perUpgradeSlowingDown = 0.15,
                rare ="rare",
                isUsed = false,
                
                upgrade =  function(self)
                    self.Interface.cost = self.Interface.cost + math.floor(self.Interface.cost*self.Interface.costIncrease)
                    self.lvl = self.lvl+1
                    self.value = self.value+self.value*self.perUpgrade
                    self.slowingDown = self.slowingDown+self.slowingDown*self.perUpgradeSlowingDown
                end;
            },
            Electric = Class{__includes =Skill,
                Interface = {
                    cost = 2000,
                    costIncrease = 0.35,
                    text = 'Electric attack modifier (expends energy)',
                    image =skillQuads.sealAtack,
                    slotRarityImage = UIQuads.tableSkillRare,
                },
                number = 10,
                value = 1.1,
                perUpgrade = 0.12,
                rare ="rare",
                isUsed = false,  
            },
            Vampir = Class{__includes =Skill,
                Interface = {
                    cost = 3000,
                    costIncrease = 0.35,
                    text = 'Steals part of the life of enemies',
                    image =skillQuads.vampir,
                    slotRarityImage = UIQuads.tableSkillLegend,
                },
                count = 3,
                number = 11,
                value = 0.1,
                rare ="legend",
                isUsed = false, 
                perUpgrade = 0.2,
                perUpgradeCount = 0.08,
                
                upgrade =  function(self)
                    self.Interface.cost = self.Interface.cost + math.floor(self.Interface.cost*self.Interface.costIncrease)
                    self.lvl = self.lvl+1
                    self.value = self.value+self.value*self.perUpgrade
                    self.count = self.count+self.count*self.perUpgradeCount
                end;
            },
        },
        SpikeArmor = Class{__includes =Skill,
            Interface = {
                cost = 3000,
                costIncrease = 0.35,
                text = 'The armor returns the damage received',
                image =skillQuads.spikeArmor,
                slotRarityImage = UIQuads.tableSkillRare,
            },
            value = 0.1,
            perUpgrade = 0.2,
            number = 12,
            rare ="rare",
            value = 0, -- rare11
        },
        EnergyArmor = Class{__includes =Skill,
            Interface = {
                cost = 3000,
                costIncrease = 0.35,
                text = 'Increase the energy reserve for defense',
                image =skillQuads.dopEnergy,
                slotRarityImage = UIQuads.tableSkillLegend,
            },
            number = 12,
            rare ="legend",
            perUpgrade = 0.24,
            value = 0.1, -- legend12
        },
        Trade = Class{__includes =Skill,
            Interface = {
                cost = 3000,
                costIncrease = 0.35,
                text = 'Exchanges energy for health',
                image =skillQuads.swapHpAndEn,
                slotRarityImage = UIQuads.tableSkillLegend,
            },
            number = 13,
            rare ="legend",
            value = 0.01, -- legend13
            perUpgrade = 0.15,
        },
    },
}
Player.Skills.Hp.value = Player.Hp.maxValue
Player.Skills.Energy.value = Player.Energy.maxValue

function Player:refreshParameters()
    self.x = borderWidth/2+40*k/2 
    self.y = borderHeight/2+40*k2/2

    self.Camera.x = borderWidth/2+40*k/2 
    self.Camera.y = borderHeight/2+40*k2/2
      
    self.body =HC.circle(borderWidth/2+40*k/2,borderHeight/2+40*k2/2,self.scaleBody)
    self.a = 0 
    self.ax = 0
    self.ay = 0
    self.inv =self.invTimer
    self.flagInv = true
    self.debaffStrenght =0.2
    
    self.Hp.value = self.Hp.maxValue*Player.tipStaticParametrs[Player.tip].healthRatio
    self.Hp.lengthBar = self.Hp.maxValue*Player.tipStaticParametrs[Player.tip].healthRatio

    self.Energy.value = self.Energy.maxValue*Player.tipStaticParametrs[Player.tip].energyRatio
    self.Energy.lengthBar = self.Energy.maxValue*Player.tipStaticParametrs[Player.tip].energyRatio
  
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
                self.ax  =math.sin(self.Controller.angle)*math.abs(self.Controller.x*screenWidth/screenHeight/3.5)*Sensitivity
                self.ay  =math.cos(self.Controller.angle)*math.abs(self.Controller.y*screenWidth/screenHeight/3.5)*Sensitivity
                if ( self.ax > self.maxSpeed) then
                    self.ax = self.maxSpeed 
                end
                if ( self.ax < -self.maxSpeed) then
                    self.ax = -self.maxSpeed 
                end
                if ( self.ay > self.maxSpeed) then
                    self.ay = self.maxSpeed
                end
                if ( self.ay < -self.maxSpeed) then
                    self.ay = -self.maxSpeed
                end
            end
        else
            self.Controller.flag = true
        end
    else
        self.Controller.flag =false
    end
    
    if ((#love.touch.getTouches()>1 and self.Energy.flag == true) or (love.keyboard.isDown('t')  and self.Energy.flag == true ) ) then
        self.Clows.flag =4 
        self.a = 1
    else
        self.a = 0
    end
end

function Player:move(dt)
    if not(love.mouse.isDown(1)) then
        if ( self.ax> 0) then
            self.ax = self.ax-10*dt*k
        else
            self.ax = self.ax+10*dt*k
        end
        if ( self.ay> 0) then
            self.ay = self.ay-10*dt*k2
        else
            self.ay = self.ay+10*dt*k2
        end
    end
    
    if ( self.a==1) then
        self.x = self.x + self.ax*dt*self.speed*self.speedA*k*self.debaffStrenght*self.Skills.Speed.value
        self.y = self.y + self.ay*dt*self.speed*self.speedA*k2*self.debaffStrenght*self.Skills.Speed.value
    else
        self.x = self.x + self.ax*dt*k*self.speed*self.debaffStrenght*self.Skills.Speed.value
        self.y = self.y + self.ay*dt*k2*self.speed*self.debaffStrenght*self.Skills.Speed.value
    end
    self.body:moveTo(self.x,self.y)
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
    self.Controller:draw() 
    local xDraw = screenWidth/2+20*k+(self.x-self.Camera.x)
    local yDraw = screenHeight/2+20*k2+(self.y-self.Camera.y)  
    local clow1X =xDraw +playerTipDrawParametrs[Player.tip].clowX*k2*math.sin(self.angleBody+playerTipDrawParametrs[Player.tip].clowR)
    local clow1Y =yDraw +playerTipDrawParametrs[Player.tip].clowX*k2*math.cos(self.angleBody+playerTipDrawParametrs[Player.tip].clowR)
    local clow2X =xDraw +playerTipDrawParametrs[Player.tip].clowX*k2*math.sin(self.angleBody-playerTipDrawParametrs[Player.tip].clowR)
    local clow2Y =yDraw+playerTipDrawParametrs[Player.tip].clowX*k2*math.cos(self.angleBody-playerTipDrawParametrs[Player.tip].clowR)
    
    self:sledDraw(screenWidth/2+20*k,screenHeight/2+20*k2,dt)
    
    playerBatch:add(playerQuads[Player.tip].body,xDraw,yDraw,-self.angleBody+math.pi,k/7,k2/7, playerTipDrawParametrs[Player.tip].bodyW/2, playerTipDrawParametrs[Player.tip].bodyH/2)
    playerBatch:setColor( 1, 1,1,0.8 )
      playerBatch:add(playerQuads[Player.tip].wings,xDraw,yDraw,-self.angleBody+math.pi,k/7,k2/7,playerTipDrawParametrs[Player.tip].wingsW/2, playerTipDrawParametrs[Player.tip].wingsH/2-playerTipDrawParametrs[Player.tip].wingsX)
      local r ,g ,b = gradient(dt)
    playerBatch:setColor(r,g,b)
      playerBatch:add(playerQuads[Player.tip].cristal,xDraw,yDraw,-self.angleBody+math.pi,k/7,k2/7,playerTipDrawParametrs[Player.tip].cristalW/2, playerTipDrawParametrs[Player.tip].cristalH/2-playerTipDrawParametrs[Player.tip].cristalX)
      
    playerBatch:setColor(1,1,1,1)
    if (self.Skills.SpecialAtack.Bloody.isUsed == true ) then
        playerBatch:setColor(1,0.7,0.7,1)  
    end
      playerBatch:add(playerQuads[Player.tip].clow1,clow1X,clow1Y,-self.angleBody+math.pi+self.Clows.angle,k/7*self.Clows.L.scale,k2/7*self.Clows.L.scale,playerTipDrawParametrs[Player.tip].clowW1, playerTipDrawParametrs[Player.tip].clowH)
      playerBatch:add(playerQuads[Player.tip].clow2,clow2X,clow2Y,-self.angleBody+math.pi-self.Clows.angle,k/7*self.Clows.R.scale,k2/7*self.Clows.R.scale,playerTipDrawParametrs[Player.tip].clowW2, playerTipDrawParametrs[Player.tip].clowH)
end

function Player:sledDraw(x,y,dt)
    --self.body:draw('line')
    
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
        playerBatch:add(playerQuads[Player.tip].tail,sled.x+(self.x-self.Camera.x),sled.y+(self.y-self.Camera.y),sled.angle,k/7*radius,k2/7*radius,playerTipDrawParametrs[Player.tip].tailW/2,playerTipDrawParametrs[Player.tip].tailH/2)
    end
    if ( #playerSledi>10) then
        table.remove(playerSledi,1)
    end
end

function Player:takeDamage(dmg,tip,atacker)
    self.flagInv = false
    AddSound(playerHurtSounds,0.3)
    dmg = self.Skills.EnergyArmor:getAtack(dmg)
    if ( tip=='m') then
        GetDamageEffect:new(atacker.x,atacker.y,7)
        self.Hp.value = self.Hp.value - dmg*(1-self.Skills.MeleeDefense.value)
        if (self.Skills.SpikeArmor.isOpened == true) then 
            SpikeArmorEffect:new(atacker)
        end
    end
    if ( tip=='e') then
        self.Hp.value = self.Hp.value - dmg
    end
    if ( tip=='r') then
        GetDamageEffect:new(atacker.x,atacker.y,7)
        self.Hp.value = self.Hp.value - dmg*(1-self.Skills.RangeDefense.value)
        if (self.Skills.SpikeArmor.isOpened == true) then 
            SpikeArmorEffect:new(atacker)
        end
    end
   
    if ( self.Hp.value<=0) then 
        makeSave()
        gamestate.switch(die)
    end
end

function Player:heal(value)
    for i =1,math.random(value*10*3,value*10*5) do 
        HealEffect:new()
    end
    self.Hp.value=self.Hp.value+self.Hp.maxValue*Player.tipStaticParametrs[Player.tip].healthRatio*value
end

function Player:rechargeEnergy(value)
    self.Energy.value=self.Energy.value+self.Energy.maxValue*Player.tipStaticParametrs[Player.tip].energyRatio*value
end

function Player:atack(target,dt)
    local atackDamage = self.damage*self.Skills.Damage.value
    local isCrit = false
    if ( math.random()<self.criticalChance*Player.tipStaticParametrs[Player.tip].critChanceRatio) then
        isCrit = true
        atackDamage = atackDamage*self.criticalDamage
    end
    atackDamage = math.floor(math.random(atackDamage-atackDamage*0.1,atackDamage+atackDamage*0.1))
    
    DamageVisualizator:new(atackDamage,target.x,target.y,isCrit)
    AddSound(playerHitSounds,0.3)
    self.Clows:scale()
    self.Energy.value = self.Energy.value -self.Energy.wasteAtack
    target.health  =  target.health - self.damage*self.Skills.Damage.value
    Player:SpecialAtack(target)
end

function Player:SpecialAtack(target)
    for atackSkillIndex, atackSkill in pairs(self.Skills.SpecialAtack) do
        if ( type(atackSkill)=='table') then 
            if (atackSkill.isUsed) then 
                self.Energy.value = self.Energy.value - self.Energy.wasteSpecialAtack
                atackSkill:atack(target)
            end
        end
    end
end

function Player:isFrontOf(target) 
    local flagFront = false
    local anglePlayerAndTarget =  math.atan2(target.x -self.x, target.y - self.y) 
    if (anglePlayerAndTarget/math.abs(anglePlayerAndTarget)==self.angleBody/math.abs(self.angleBody))then
        if (math.abs(math.abs(anglePlayerAndTarget) - math.abs(self.angleBody)) <  math.pi/4) then 
            flagFront = true
        end
    else
        if (math.abs(anglePlayerAndTarget)+math.abs(self.angleBody)> 2*math.pi - math.abs(anglePlayerAndTarget)-math.abs(self.angleBody)) then
            if ((2*math.pi - math.abs(anglePlayerAndTarget)-math.abs(self.angleBody)) <  math.pi/4) then 
                flagFront = true
            end
        else 
            if ((math.abs(anglePlayerAndTarget)+math.abs(self.angleBody)) <  math.pi/4) then 
                flagFront = true
            end
        end
    end
    return flagFront
end

function Player:collision(dt)
    self:collisionWithObj(dt)
    self:collisionWithEnemies(dt)
end

function Player:collisionWithObj(dt)
    local playerIndex =math.floor((self.x-40*k)/(120*k)) + math.floor((self.y-40*k2)/(120*k2))*math.floor((screenWidth/(120*k))+1) 
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

function Player:collisionWithEnemies(dt)
    local playerIndex =math.floor((self.x-40*k)/(80*k)) + math.floor((self.y-40*k2)/(80*k2))*math.floor((screenWidth/(80*k))+1) 
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
    local clow1X =Player.x +playerTipDrawParametrs[Player.tip].clowX*k2*math.sin(Player.angleBody+playerTipDrawParametrs[Player.tip].clowR)
    local clow1Y =Player.y +playerTipDrawParametrs[Player.tip].clowX*k2*math.cos(Player.angleBody+playerTipDrawParametrs[Player.tip].clowR)
    local clow2X =Player.x +playerTipDrawParametrs[Player.tip].clowX*k2*math.sin(Player.angleBody-playerTipDrawParametrs[Player.tip].clowR)
    local clow2Y =Player.y+playerTipDrawParametrs[Player.tip].clowX*k2*math.cos(Player.angleBody-playerTipDrawParametrs[Player.tip].clowR)
    
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
    if ( self.value>self.maxValue*Player.tipStaticParametrs[Player.tip].healthRatio) then
        self.value = self.maxValue*Player.tipStaticParametrs[Player.tip].healthRatio
        self.lengthBar = self.maxValue*Player.tipStaticParametrs[Player.tip].healthRatio
    end
    
    if (self.lengthBar<self.value) then
        self.lengthBar= self.value
    end
    if (self.lengthBar>self.value ) then
        self.lengthBar = self.lengthBar-self.maxValue*Player.tipStaticParametrs[Player.tip].healthRatio/100*10*dt
    end
end

function Player.Energy:update(dt)
    if ( self.value > self.maxValue*Player.tipStaticParametrs[Player.tip].energyRatio) then
        self.value = self.maxValue*Player.tipStaticParametrs[Player.tip].energyRatio
        self.lengthBar = self.maxValue*Player.tipStaticParametrs[Player.tip].energyRatio
        if (Player.Skills.Trade.isOpened == true and Player.Hp.value<Player.Hp.maxValue*Player.tipStaticParametrs[Player.tip].healthRatio and Player.flagInv == true) then 
            TradeEffect:new()
            Player.Skills.Trade:regen(dt)
        end
    end
    
    if ( self.lengthBar>self.value) then
        self.lengthBar = self.lengthBar-self.maxValue/100*8*dt
    end
 
    if ( self.value > self.maxValue*Player.tipStaticParametrs[Player.tip].energyRatio/100*15) then
        self.flag = true
    end
    if ( self.value <= 0  ) then
        Player.a=0
        self.value =0
        self.flag = false
    end
    
    if ( Player.a==1) then
        self.value = self.value - self.wasteBoost*dt
    else
        self.value = self.value + self.maxValue*self.regen *dt
    end
    
    if ( self.lengthBar<self.value) then
        self.lengthBar = self.value
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
  
function Player.Controller:draw()
    love.graphics.setColor(1,1,1,0.4)
    love.graphics.circle('line',self.x0,self.y0,13*k)
    love.graphics.circle('line',mouse.x,mouse.y,5*k)
    love.graphics.circle('line',mouse.x,mouse.y,5*k)
    love.graphics.setColor(1,1,1,1)
end
  
function Player:drawUI()
    love.graphics.setColor(0.02,0.3,0.02,1)
    love.graphics.rectangle("fill",self.x-(self.scaleBody+17)*k,self.y+720/11*k/2,4*k2,-720/11*k)
    love.graphics.setColor(0.19,1,0.19,1)
    love.graphics.rectangle("fill",self.x-(self.scaleBody+17)*k,self.y+720/11*k/2,4*k2,(-self.Hp.lengthBar/self.Hp.maxValue/Player.tipStaticParametrs[Player.tip].healthRatio*720/11)*k)
    love.graphics.setColor(0.02,0.6,0.02,1)
    love.graphics.rectangle("fill",self.x-(self.scaleBody+17)*k,self.y+720/11*k/2,4*k2,(-self.Hp.value/self.Hp.maxValue/Player.tipStaticParametrs[Player.tip].healthRatio*720/11)*k)

    love.graphics.setColor(0,0.32,0.225,1)
    love.graphics.rectangle("fill",self.x-(self.scaleBody+11)*k,self.y+720/11*k/2,3*k2,-720/11*k)
    love.graphics.setColor(0.15,1,0.9,1)
    love.graphics.rectangle("fill",self.x-(self.scaleBody+11)*k,self.y+720/11*k/2,3*k2,(-self.Energy.lengthBar/self.Energy.maxValue/Player.tipStaticParametrs[Player.tip].energyRatio*720/11)*k)
    love.graphics.setColor(0,0.643,0.502,1)
    love.graphics.rectangle("fill",self.x-(self.scaleBody+11)*k,self.y+720/11*k/2,3*k2,(-self.Energy.value/self.Energy.maxValue/Player.tipStaticParametrs[Player.tip].energyRatio*720/11)*k)     
   
    EnergyArmorEffect:draw() 
  
    love.graphics.setColor(1,1,1,1)
end

return playerFunction