local convert = {}

local UI = require "scripts/systemComponents/UI"
--tlocal playerFunction = require "scripts/playerGameObject/playerFunction"

local buttonAdd = Button(0,0,120*k,120*k)  
function buttonAdd:draw()
    add()
end

local buttonOkX = screenWidth/2+200*k
local buttonOkY = screenHeight/2
local buttonOkWidth = 60*k
local buttonOkHeight = 250*k2
local buttonOk = Button(buttonOkX,buttonOkY,buttonOkWidth,buttonOkHeight)
function buttonOk:draw()
    bodyButton(buttonOk.x,buttonOk.y,buttonOk.isTappedFlag)
end
      
local buttonConvertX = screenWidth/1.7+220*k
local buttonConvertY = screenHeight/2
local buttonConvertWidth = 60*k
local buttonConvertHeight = 250*k2
local buttonConvert = Button(buttonConvertX,buttonConvertY,buttonConvertWidth,buttonConvertHeight)
function buttonConvert:draw(light)
    bodyButton(buttonConvert.x,buttonConvert.y,buttonConvert.isTappedFlag,light)
end

Particle = {
    flagClear = false,
    clearX = 0,
    regulS = {},
    list =  {},
    delaySound = 0,    
}

local Colba = {
    bodySprite = love.graphics.newImage("assets/constrSet.png"),
    standSprite = love.graphics.newImage("assets/constrSet2.png"),
    body = HC.circle(screenWidth/1.7,screenHeight/2,80*k),
    flagCollision =  false,
    colbaFill = false,
    redText = -0.1,
    flagRedText = true,
    flagRes = -0.1,
    flagResBool = true,
    
    Borders = {
        R = {
            body1 = HC.rectangle(0,0,25*k,30*k2),--2.1867155200084
            body2 = HC.rectangle(0,0,22*k,22*k2),--2.5879619886168
            body3 = HC.rectangle(0,0,25*k,30*k2),--2.9036124236754
            body4 = HC.circle(0,0,10*k),--2.5465780219889
        },
        L = {
            body1 = HC.rectangle(0,0,25*k,30*k2),--2.1867155200084
            body2 = HC.rectangle(0,0,22*k,22*k2),--2.5879619886168
            body3 = HC.rectangle(0,0,25*k,30*k2),--2.9036124236754
            body4 = HC.circle(0,0,10*k),--2.5465780219889
        },    
    },
}

local Reward = {
    count = 0,
    flagMenu = false ,
    money  = 0,
    skill  = 0,
    slotScale = 0,  
}
local playerSkills = {}

function convert:init()
    Colba.Borders:init()
    for skillIndex, skill in pairs(Player.Skills) do
        if (skill.isOpened~=nil) then 
            if (skill.isOpened == true) then
                table.insert(playerSkills,skill)
            end
        else
            for atackSkillIndex, atackSkill in pairs(skill) do
                if (atackSkill.isOpened == true) then
                    table.insert(playerSkills,atackSkill)
                end
            end
        end
    end
end

function convert:update(dt)
    explUpdate2(dt)
    Particle:update(dt)
    Reward:updateSlotScale(dt)
    Colba:isFill()
    if (buttonAdd:isTapped()) then 
        exp = {}
        AddSound(uiClick,0.3)
        gamestate.switch(menu)
    end
    
    if (Reward.flagMenu == true and buttonOk:isTapped()) then
        Reward.flagMenu = false
        AddSound(uiSelect,0.3,false)
        Reward:give()
    end
    
    if ( Reward.flagMenu == false and buttonConvert:isTapped()) then
        Colba:convert()
    end

    if love.mouse.isDown(1)  then
        local realX = mouse.x-screenWidth/1.7
        local realY = mouse.y -screenHeight/2
        if ( (realX*realX + realY*realY < 100*k*100*k) and #Particle.list<140 and Reward.flagMenu == false ) then
            if ( score >=scoreForParticle and Particle.flagClear == false) then
                score = score - scoreForParticle
                if ( Particle.delaySound <=0) then
                    AddSound(uiParticle,0.2)
                    Particle.delaySound = 1
                end
                Particle.delaySound = Particle.delaySound - 15*dt
                if ( math.random(1,2) == 1 ) then
                    Particle:spawn(0,math.random(screenHeight/2-90*k2,screenHeight/2-40*k2),1)
                else
                    Particle:spawn(0,math.random(screenHeight/2+40*k2,screenHeight/2+90*k2),1)
                end
            else
                if (Colba.flagRes == nil or  Colba.flagRes < 0) then 
                    Colba.flagRes = 0
                end
                Colba.flagResBool = true
            end
        end
    end
end

function convert:draw()
    local dt = love.timer.getDelta()
    UIBatch:clear()
    skillBatch:clear()
    love.graphics.setColor(1,1,1,1)
      love.graphics.draw(fon1,0,0,0,k,k2)
      love.graphics.draw(fon2,0,0,0,k,k2)
      love.graphics.draw(fon3,0,0,0,k,k2)
      buttonAdd:draw()
    love.graphics.setColor(1-Reward.slotScale,1-Reward.slotScale,1-Reward.slotScale,1-Reward.slotScale)
      buttonConvert:draw(Reward.slotScale)
      love.graphics.draw(Colba.bodySprite,screenWidth/1.7,screenHeight/2,-math.pi/2,k/1.9,k2/1.9,250,193.5)
      love.graphics.draw(Colba.standSprite,screenWidth/1.7+95*k,screenHeight/2,-math.pi/2,k/1.9,k2/1.9,200,150.5)
      Particle:draw(dt)
    love.graphics.setColor(1,1,1,0.6-Reward.slotScale)
      love.graphics.draw(Colba.bodySprite,screenWidth/1.7,screenHeight/2,-math.pi/2,k/1.9,k2/1.9,250,193.5)
      love.graphics.setColor(1-Reward.slotScale,1-Reward.slotScale,1-Reward.slotScale,1-Reward.slotScale)
      textButton("Tap to fill",screenWidth/1.53,screenHeight/2,false,0.5)
    love.graphics.setColor(0,0,0,1)
      love.graphics.rectangle('fill',0,screenHeight/2-100*k2,35*k,200*k2)
    love.graphics.setColor(1,1,1,0.6-Reward.slotScale)
      sc(0,screenHeight/2)
      local fontWidth = font:getWidth(tostring(score))
      love.graphics.print(score,50*k/12, screenHeight/2+fontWidth/2*k2/2,-math.pi/2,k/2,k2/2)
    if ( math.ceil(#Particle.list/1.4)>= 30 ) then 
        love.graphics.setColor(0.308,0.661,0.445,1) 
    end
    if ( math.ceil(#Particle.list/1.4)>= 60 ) then 
        love.graphics.setColor(0.6,0.3,0.6,1) 
    end
    if ( math.ceil(#Particle.list/1.4)== 100 ) then 
        love.graphics.setColor(0.8,0.8,0.3,1) 
    end
    redText,flagRedText = noFill(redText,dt,flagRedText)
    fontWidth = font:getWidth(tostring(math.abs(math.ceil(#Particle.list/1.4)))..'%')
    love.graphics.print(tostring(math.abs(math.ceil(#Particle.list/1.4)))..'%',screenWidth/1.7-250*k/1.9, screenHeight/2+fontWidth/2*k2/1.5,-math.pi/2,k/1.5,k2/1.5)
    love.graphics.setColor(1,1,1,1) 

    if (Reward.flagMenu == true) then 
        if (Reward.skill == 0) then 
            rewardSlot(nil,screenWidth/2,screenHeight/2,Reward.slotScale,Reward.money)
        else
            rewardSlot(Reward.skill,screenWidth/2,screenHeight/2,Reward.slotScale,Reward.money)
        end
        buttonOk:draw()
    end
    love.graphics.draw(UIBatch)
    love.graphics.draw(skillBatch) 
    if (Reward.flagMenu == false) then 
        love.graphics.print(tostring(#playerSkills).."/14", screenWidth/1.7-130*k,screenHeight/2-130*k,-math.pi/2,k*0.4,k2*0.4)
    end
    love.graphics.setColor(1-Reward.slotScale,1-Reward.slotScale,1-Reward.slotScale,1-Reward.slotScale) 
    textButton("Convert",screenWidth/1.7+220*k,screenHeight/2,flagButton1)
    if (Reward.flagMenu == true) then 
        love.graphics.setColor(1,1,1,1) 
        textButton("Ok",screenWidth/2+200*k,screenHeight/2,flagButton2)  
        love.graphics.setColor(0.125,0.251,0.302,1) 
        if ( Reward.money > 0 and Reward.skill == 0) then 
            textButton(Reward.money,screenWidth/2,screenHeight/2,false,1.6*Reward.slotScale)  
        end
    end
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 100, 10,0,k/2,k2/2)
    love.graphics.print("particl: "..tostring(#Particle.list), 100, 70,0,k/2,k2/2)
    for i=1,#exp do
        love.graphics.setColor(exp[i].color1,exp[i].color2,exp[i].color3,1) 
        love.graphics.rectangle("fill",exp[i].x,exp[i].y,exp[i].scale*20*k,exp[i].scale*20*k2,4*exp[i].scale*k)
    end
    Colba.flagRes,Colba.flagResBool = noRes(100*k ,screenHeight/2,0.6,Colba.flagRes,dt,Colba.flagResBool)
end

function Particle:update(dt)
    Particle.regulS = {}
    if ( Particle.flagClear == true) then
        Particle.clearX = Particle.clearX + 300 * dt 
    end
    if ( Particle.clearX > 200 * k ) then 
        Particle.flagClear = false
        Particle.clearX  = 0 
        Reward.slotScale = 0 
        Reward:get(Reward.count)
        Reward.count = 0 
    end
    for i=#Particle.list,1, -1  do
        Particle:move(Particle.list[i],dt)
        Particle:addToRegulS(i)
        Particle:collisionWithColba(i,dt)
        Particle:clear(i,dt)
    end
end

function Particle:draw(dt)
    for i=#Particle.list,1, -1  do
        local IparticlRegulS =math.floor((Particle.list[i].x-10*k)/(20*k)) + math.floor((Particle.list[i].y-10*k2)/(20*k2))*math.floor((screenWidth/(20*k))+1)
        Colba.flagCollision =  false
        if (Particle.list[i].flag == true  ) then 
            Particle:CollisionWithParticle(IparticlRegulS,i,dt)
            Particle:CollisionWithParticle(IparticlRegulS+1,i,dt)
            Particle:CollisionWithParticle(IparticlRegulS+math.floor((screenWidth/(20*k))+1),i,dt) 
            Particle:CollisionWithParticle(IparticlRegulS+math.floor((screenWidth/(20*k))+1)+1,i,dt)
            Particle:CollisionWithParticle(IparticlRegulS-math.floor((screenWidth/(20*k))+1)+1,i,dt)
        end
        Particle.list[i].ax =Particle.list[i].ax+ 60*dt
        if ( Particle.list[i].ay > 0.5*k ) then
            Particle.list[i].ay =Particle.list[i].ay- 1
        end
        if ( Particle.list[i].ay < -0.5*k ) then
            Particle.list[i].ay =Particle.list[i].ay+ 1
        end
        love.graphics.setColor(Particle.list[i].color1,Particle.list[i].color2,Particle.list[i].color3)
        love.graphics.rectangle("fill",  Particle.list[i].x,Particle.list[i].y,13*k,13*k2,2)
       -- Particle.list[i].body:draw('fill')
    end
end

function Particle:CollisionWithParticle(index,j,dt)
    if ( Particle.regulS[index]) then 
        local kek = Particle.regulS[index]
        if (kek) then
            for i = #kek, 1, -1 do
                if (kek[i] and Particle.list[kek[i]] and Particle.list[j] and kek[i]~=j and math.abs(Particle.list[kek[i]].x - Particle.list[j].x)<14*k and math.abs(Particle.list[kek[i]].y - Particle.list[j].y)<14*k2 and  (math.pow((Particle.list[kek[i]].x - Particle.list[j].x),2) + math.pow((Particle.list[kek[i]].y - Particle.list[j].y),2))<=math.pow(14*k,2)) then
                    local collisFlag, intVectorX ,intVectorY = Particle.list[kek[i]].body:collidesWith(Particle.list[j].body)
                    if (collisFlag) then
                        Colba.flagCollision = true 
                        local lenIntVector = math.sqrt(intVectorX*intVectorX+intVectorY*intVectorY)
                        local rvX, rvY = Particle.list[j].ax-Particle.list[kek[i]].ax,  Particle.list[j].ay -Particle.list[kek[i]].ay
                        local deepX = intVectorX
                        local deepY = intVectorY
                        intVectorX = (intVectorX/lenIntVector)
                        intVectorY = (intVectorY/lenIntVector)
                        local velAlNorm  = rvX*intVectorX + rvY*intVectorY
                        if ( velAlNorm > 0) then
                            local e =0.1
                            local scImp = -(1+e)*velAlNorm
                            local impulsX, impulsY = scImp * intVectorX, scImp* intVectorY
                            local realX = Particle.list[j].x+6.5*k-screenWidth/1.7
                            local realY = Particle.list[j].y+6.5*k2 -screenHeight/2
                            if ( realX*realX + realY*realY <= 80*k*80*k) then
                                Particle.list[j].ax=Particle.list[j].ax+dt*40*impulsX
                                Particle.list[j].ay=Particle.list[j].ay+dt*40*impulsY
                            end
                            realX = Particle.list[kek[i]].x+6.5*k-screenWidth/1.7
                            realY = Particle.list[kek[i]].y+6.5*k2 -screenHeight/2
                            if ( realX*realX + realY*realY <= 80*k*80*k) then
                                Particle.list[kek[i]].ax=Particle.list[kek[i]].ax - dt*40*impulsX
                                Particle.list[kek[i]].ay=Particle.list[kek[i]].ay - dt*40*impulsY
                            end
                        end
                        if ((deepX*deepX+deepY*deepY>=math.pow(1*k,2))) then
                            local realX = Particle.list[kek[i]].x+6.5*k-screenWidth/1.7
                            local realY = Particle.list[kek[i]].y+6.5*k2 -screenHeight/2
                            if ( realX*realX + realY*realY <= 80*k*80*k) then
                                Particle.list[kek[i]].x  = Particle.list[kek[i]].x + deepX*dt*5
                                Particle.list[kek[i]].y = Particle.list[kek[i]].y + deepY*dt*5
                            end
                            realX = Particle.list[j].x+6.5*k-screenWidth/1.7
                            realY = Particle.list[j].y+6.5*k2 -screenHeight/2
                            if ( realX*realX + realY*realY <= 80*k*80*k) then
                                Particle.list[j].x  = Particle.list[j].x - deepX*dt*5
                                Particle.list[j].y = Particle.list[j].y - deepY*dt*5
                            end
                        end
                    end
                end
            end
        end
    end
end 
 

function Particle:spawn(x,y,kol)
    local Color1,Color2,Color3  = particlColor() 
    local part = {
        side = math.random(1,2), 
        ran = math.random(100,180), 
        body =  HC.circle(x,y,10*k),
        flag  =false,
        color1 = Color1, 
        color2= Color2,
        color3 = Color3,
        x  = x, 
        y =  y,  
        xx  = x, 
        yy =  y,
        ax  =math.random(-1.72*k*40,1.73*k*40), 
        ay = math.random(-1.73*k*40,1.73*k*40), 
    }
    table.insert(Particle.list,part)
end
function Particle:addToRegulS(i)
    if (Particle.list[i] and Particle.list[i].flag == true) then 
        local IparticlRegulS =math.floor((Particle.list[i].x-10*k)/(20*k)) + math.floor((Particle.list[i].y-10*k2)/(20*k2))*math.floor((screenWidth/(20*k))+1)
        if (Particle.regulS[IparticlRegulS]) then
            table.insert(Particle.regulS[IparticlRegulS],i)
        else
            Particle.regulS[IparticlRegulS] = {i}
        end
    end
end
function Particle:move(particl,dt)
    if (particl) then
        if ( particl.flag == false) then 
            if ( particl.side == 1 ) then 
                local x1 = particl.x+6.5*k -screenWidth/2
                local y1 = particl.y+6.5*k2 -screenHeight/2
                local ugol = math.atan2(x1,y1)
                particl.x= particl.x+particl.ax*dt*k*2.5
                particl.y= particl.y+particl.ay*dt*k2*2.5
                particl.ax= particl.ran*math.sin(ugol+math.pi/2+math.pi/4)
                particl.ay= particl.ran*math.cos(ugol+math.pi/2+math.pi/4)
            else
                local x1 = screenWidth/2- particl.x
                local y1 = screenHeight/2-particl.y 
                local ugol = math.atan2(x1,y1)
                particl.x= particl.x+particl.ax*dt*k*2.5
                particl.y= particl.y+particl.ay*dt*k2*2.5
                particl.ax= particl.ran*math.sin(ugol+math.pi/2-math.pi/4)
                particl.ay= particl.ran*math.cos(ugol+math.pi/2-math.pi/4)
            end
        else
            local realX = particl.x+6.5*k-screenWidth/1.7
            local realY = particl.y+6.5*k2 -screenHeight/2
            local angleF = math.atan2(realX,realY) 
            if not( realX*realX + realY*realY < 80*k*80*k) then
                particl.ax=particl.ax-math.sin(angleF)*50
                particl.ay=particl.ay-math.cos(angleF)*50
            end
            if ( particl.ax > 100) then
                particl.ax = 100
            end
            if ( particl.ax < -100) then
                particl.ax = -100
            end
            if ( particl.ay > 100) then
                particl.ay = 100
            end
            if ( particl.ay < -100) then
                particl.ay = -100
            end
            particl.x= particl.x+particl.ax*dt*k
            particl.y= particl.y+particl.ay*dt*k2
        end
        particl.body:moveTo(particl.x+6.5*k,particl.y+6.5*k2)
    end
end
function Particle:collisionWithColba(i,dt)
    if (Particle.list[i].flag ==  false) then
        for leftBorder, body in pairs(Colba.Borders.L) do
            local collisFlag, intVectorX ,intVectorY = Particle.list[i].body:collidesWith(body)
            if (collisFlag) then
                Particle.list[i].x = Particle.list[i].x + intVectorX*dt*20*k
                Particle.list[i].y = Particle.list[i].y +  intVectorY*dt*20*k2
            end
        end
        for rightBorder, body in pairs(Colba.Borders.R) do 
            local collisFlag, intVectorX ,intVectorY = Particle.list[i].body:collidesWith(body)
            if (collisFlag) then 
                Particle.list[i].x = Particle.list[i].x + intVectorX*dt*20*k
                Particle.list[i].y = Particle.list[i].y +  intVectorY*dt*20*k2
            end
        end
        if (Particle.list[i].body:collidesWith(Colba.body)) then 
            Particle.list[i].flag = true 
            Particle.list[i].ax =Particle.list[i].ax / 200
            Particle.list[i].ay =Particle.list[i].ay / 200 
        end
    end
end

function Particle:clear(i,dt)
    if (Particle.flagClear == true and Particle.list[i].x >screenWidth/1.7+80*k-Particle.clearX ) then
        expl(Particle.list[i].x,Particle.list[i].y,3)
        table.remove(Particle.list,i)
    end 
end

function noFill(par,dt,flag)
    if (par~= nil and flag~=nil and par >= 0) then 
        love.graphics.setColor(1,par,par,1)
        if ( par <=3 and flag ==true ) then
            return par+5*dt, true
        else
            if ( par > 2 and flag ==true ) then 
                return par-5*dt,false
            else
                if (flag ==false and par >=0 ) then 
                    return par-5*dt,false
                end
            end
        end
    end
end

function Colba.Borders:init()
    self.R.body1:moveTo(screenWidth/1.7-math.sin(2.1867155200084+math.pi*1.611)*108*k	,screenHeight/2- math.cos(2.1867155200084+math.pi*1.611)*108*k)
    self.R.body1:setRotation(-1.07)
    self.R.body2:moveTo(screenWidth/1.7-math.sin(2.5879619886168+math.pi*1.351)*104*k	,screenHeight/2- math.cos(2.5879619886168+math.pi*1.351)*104*k)
    self.R.body2:setRotation(0.96-0.14-0.14)
    self.R.body3:moveTo(screenWidth/1.7-math.sin(2.9036124236754+math.pi*1.152)*129.5*k	,screenHeight/2- math.cos(2.9036124236754+math.pi*1.152)*129.5*k)
    self.R.body3:setRotation(-0.58)
    self.R.body4:moveTo(screenWidth/1.7-math.sin(2.5465780219889+math.pi*1.378)*115*k	,screenHeight/2- math.cos(2.5465780219889+math.pi*1.378)*115*k)
    
    self.L.body1:moveTo(screenWidth/1.7-math.sin(2.1867155200084)*108*k	,screenHeight/2- math.cos(2.1867155200084)*108*k)
    self.L.body1:setRotation(1.14)
    self.L.body2:moveTo(screenWidth/1.7-math.sin(2.5879619886168)*104*k	,screenHeight/2- math.cos(2.5879619886168)*104*k)
    self.L.body2:setRotation(0.96)
    self.L.body3:moveTo(screenWidth/1.7-math.sin(2.9036124236754)*129.5*k	,screenHeight/2- math.cos(2.9036124236754)*129.5*k)
    self.L.body3:setRotation(0.52)
    self.L.body4:moveTo(screenWidth/1.7-math.sin(2.5465780219889)*115*k	,screenHeight/2- math.cos(2.5465780219889)*115*k)
end

function Colba:convert()
    if (Colba.colbaFill==true and (Particle.list[#Particle.list].body:collidesWith(Colba.body))) then
        Particle.flagClear = true
        AddSound(uiSelect,0.3)
        AddSound(uiParticleDestroy,0.2,false)
        Reward.count = #Particle.list
    else
        if (Colba.colbaFill~=true) then 
            if (redText == nil or  redText < 0) then 
                redText = 0
            end
            flagRedText = true
        end
        AddSound(uiError,0.2)
    end
end

function Colba:isFill()
    if ( math.ceil(#Particle.list/1.4)>= 30 ) then 
        Colba.colbaFill= true
    else
        Colba.colbaFill= false
    end
end

function Reward:give()
    score = score + Reward.money
    if ( Reward.skill ~= 0) then 
        local flagPlHave = false
        for i =1, #playerSkills do 
            local masSkill = playerSkills[i] 
            if (flagPlHave ==false and  masSkill.img == allSkills[Reward.skill] ) then 
                flagPlHave = true
                Reward.skill = i 
                break
            end
        end
        if ( flagPlHave) then 
            playerSkills[Reward.skill].lvl = playerSkills[Reward.skill].lvl + 1
        else
            table.insert(playerSkills,{img = allSkills[Reward.skill],lvl  = 1,numb = Reward.skill  } ) 
        end
        lvlParametrs()
    end
    Reward.money = 0 
    Reward.skill = 0
end

function Reward:updateSlotScale(dt)
    if ( Reward.slotScale < 0.6 and Reward.flagMenu == true ) then 
        Reward.slotScale = Reward.slotScale + 1 * dt
    end
    if ( Reward.slotScale > 0 and Reward.flagMenu == false) then 
        Reward.slotScale = Reward.slotScale - 1 * dt
    end
end

function Reward:get(count)
    self.flagMenu = true 
    if ( count == 140) then 
        self:getBig(count)
    else
        if (math.ceil(count/1.4)>=60) then
            self:getNormal(count)
        else
            self:getSmall(count)
        end
    end
end

function Reward:getBig(count)
    if ( math.random(1,100) > 80) then 
        self.skill  = math.random(12,14) 
    else
        self:getNormal(count)
    end
end

function Reward:getNormal(count)
    if ( math.random(1,100) > 70) then 
        self.skill  = math.random(8,11) 
    else
        self:getSmall(count)
    end
end


function Reward:getSmall(count)
    if ( math.random(1,100) > 70) then 
        self.skill  = math.random(1,7) 
    else
        if ( math.random(1,100) > 80) then
            self.money  = math.ceil(count*scoreForParticle*0.7)
        else
            if ( math.random(1,100) > 50) then
                self.money  = math.ceil(count*scoreForParticle*0.5)
            else
                self.money  = 0
            end
        end
    end 
end

return convert