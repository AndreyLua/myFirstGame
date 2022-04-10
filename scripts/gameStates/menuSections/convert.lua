local convert = {}

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

local Particl = {
    flagClear = false,
    clearX = 0,
    regulS = {},
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

function convert:init()
    Colba.Borders:init()
end

function convert:update(dt)
    explUpdate2(dt)
    Particl.regulS = {}
    if (buttonAdd:isTapped()) then 
        exp = {}
        AddSound(uiClick,0.3)
        gamestate.switch(menu)
    end
    if (Reward.flagMenu == true and buttonOk:isTapped()) then
        Reward.flagMenu = false
        AddSound(uiSelect,0.3,false)
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
    if ( Reward.flagMenu == false and buttonConvert:isTapped()) then
        if (Colba.colbaFill==true and (particl[#particl].body:collidesWith(Colba.body))) then
            Particl.flagClear = true
            AddSound(uiSelect,0.3)
            AddSound(uiParticlDestroy,0.2,false)
            Reward.count = #particl
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
  
    if ( Reward.slotScale < 0.6 and Reward.flagMenu == true ) then 
        Reward.slotScale = Reward.slotScale + 1 * dt
    end
    if ( Reward.slotScale > 0 and Reward.flagMenu == false) then 
        Reward.slotScale = Reward.slotScale - 1 * dt
    end
    
    
    if ( Particl.flagClear == true) then
        Particl.clearX = Particl.clearX + 300 * dt 
    end
    if ( Particl.clearX > 200 * k ) then 
        Particl.flagClear = false
        Particl.clearX  = 0 
        Reward.slotScale = 0 
        Reward:get(Reward.count)
        Reward.count = 0 
    end
    -----
    if ( math.ceil(#particl/1.4)>= 30 ) then 
        Colba.colbaFill= true
    else
        Colba.colbaFill= false
    end
    
    
    for i=#particl,1, -1  do
        particl[i].body:moveTo(particl[i].x+6.5*k,particl[i].y+6.5*k2)
        particlInRegulS(i)
        particlCollWithStatic(i,dt)
        particlClear(i,dt) 
    end
    particllUpdate(dt)

    if love.mouse.isDown(1)  then
        local realX = mouse.x-screenWidth/1.7
        local realY = mouse.y -screenHeight/2
        if ( (realX*realX + realY*realY < 100*k*100*k) and #particl<140 and Reward.flagMenu == false ) then
            if ( score >=scoreForParticle and Particl.flagClear == false) then
                score = score - scoreForParticle
                if ( Particl.delaySound <=0) then
                    AddSound(uiParticl,0.2)
                    Particl.delaySound = 1
                end
                Particl.delaySound = Particl.delaySound - 15*dt
                if ( math.random(1,2) == 1 ) then
                    particlSpawn(0,math.random(screenHeight/2-90*k2,screenHeight/2-40*k2),1)
                else
                    particlSpawn(0,math.random(screenHeight/2+40*k2,screenHeight/2+90*k2),1)
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
    --bodyButton(screenWidth/1.7+220*k,screenHeight/2,flagButton1,Reward.slotScale)
    love.graphics.draw(Colba.bodySprite,screenWidth/1.7,screenHeight/2,-math.pi/2,k/1.9,k2/1.9,250,193.5)
    love.graphics.draw(Colba.standSprite,screenWidth/1.7+95*k,screenHeight/2,-math.pi/2,k/1.9,k2/1.9,200,150.5)
    for i=#particl,1, -1  do
        local IparticlRegulS =math.floor((particl[i].x-10*k)/(20*k)) + math.floor((particl[i].y-10*k2)/(20*k2))*math.floor((screenWidth/(20*k))+1)
        Colba.flagCollision =  false
        if (particl[i].flag == true  ) then 
            particlCollWithparticl(IparticlRegulS,i,dt)
            particlCollWithparticl(IparticlRegulS+1,i,dt)
            particlCollWithparticl(IparticlRegulS+math.floor((screenWidth/(20*k))+1),i,dt) 
            particlCollWithparticl(IparticlRegulS+math.floor((screenWidth/(20*k))+1)+1,i,dt)
            particlCollWithparticl(IparticlRegulS-math.floor((screenWidth/(20*k))+1)+1,i,dt)
        end
        particl[i].ax =particl[i].ax+ 60*dt
        if ( particl[i].ay > 0.5*k ) then
            particl[i].ay =particl[i].ay- 1
        end
        if ( particl[i].ay < -0.5*k ) then
            particl[i].ay =particl[i].ay+ 1
        end
        love.graphics.setColor(particl[i].color1,particl[i].color2,particl[i].color3)
        love.graphics.rectangle("fill",  particl[i].x,particl[i].y,13*k,13*k2,2)
       -- particl[i].body:draw('fill')
    end
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
    if ( math.ceil(#particl/1.4)>= 30 ) then 
        love.graphics.setColor(0.308,0.661,0.445,1) 
    end
    if ( math.ceil(#particl/1.4)>= 60 ) then 
        love.graphics.setColor(0.6,0.3,0.6,1) 
    end
    if ( math.ceil(#particl/1.4)== 100 ) then 
        love.graphics.setColor(0.8,0.8,0.3,1) 
    end
    redText,flagRedText = noFill(redText,dt,flagRedText)
    fontWidth = font:getWidth(tostring(math.abs(math.ceil(#particl/1.4)))..'%')
    love.graphics.print(tostring(math.abs(math.ceil(#particl/1.4)))..'%',screenWidth/1.7-250*k/1.9, screenHeight/2+fontWidth/2*k2/1.5,-math.pi/2,k/1.5,k2/1.5)
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
    love.graphics.print("particl: "..tostring(#particl), 100, 70,0,k/2,k2/2)
    for i=1,#exp do
        love.graphics.setColor(exp[i].color1,exp[i].color2,exp[i].color3,1) 
        love.graphics.rectangle("fill",exp[i].x,exp[i].y,exp[i].scale*20*k,exp[i].scale*20*k2,4*exp[i].scale*k)
    end
    Colba.flagRes,Colba.flagResBool = noRes(100*k ,screenHeight/2,0.6,Colba.flagRes,dt,Colba.flagResBool)
end

function particlCollWithparticl(index,j,dt)
    if ( Particl.regulS[index]) then 
        local kek = Particl.regulS[index]
        if (kek) then
            for i = #kek, 1, -1 do
                if (kek[i] and particl[kek[i]] and particl[j] and kek[i]~=j and math.abs(particl[kek[i]].x - particl[j].x)<14*k and math.abs(particl[kek[i]].y - particl[j].y)<14*k2 and  (math.pow((particl[kek[i]].x - particl[j].x),2) + math.pow((particl[kek[i]].y - particl[j].y),2))<=math.pow(14*k,2)) then
                    local collisFlag, intVectorX ,intVectorY = particl[kek[i]].body:collidesWith(particl[j].body)
                    if (collisFlag) then
                        Colba.flagCollision = true 
                        local lenIntVector = math.sqrt(intVectorX*intVectorX+intVectorY*intVectorY)
                        local rvX, rvY = particl[j].ax-particl[kek[i]].ax,  particl[j].ay -particl[kek[i]].ay
                        local deepX = intVectorX
                        local deepY = intVectorY
                        intVectorX = (intVectorX/lenIntVector)
                        intVectorY = (intVectorY/lenIntVector)
                        local velAlNorm  = rvX*intVectorX + rvY*intVectorY
                        if ( velAlNorm > 0) then
                            local e =0.1
                            local scImp = -(1+e)*velAlNorm
                            local impulsX, impulsY = scImp * intVectorX, scImp* intVectorY
                            local realX = particl[j].x+6.5*k-screenWidth/1.7
                            local realY = particl[j].y+6.5*k2 -screenHeight/2
                            if ( realX*realX + realY*realY <= 80*k*80*k) then
                                particl[j].ax=particl[j].ax+dt*40*impulsX
                                particl[j].ay=particl[j].ay+dt*40*impulsY
                            end
                            realX = particl[kek[i]].x+6.5*k-screenWidth/1.7
                            realY = particl[kek[i]].y+6.5*k2 -screenHeight/2
                            if ( realX*realX + realY*realY <= 80*k*80*k) then
                                particl[kek[i]].ax=particl[kek[i]].ax - dt*40*impulsX
                                particl[kek[i]].ay=particl[kek[i]].ay - dt*40*impulsY
                            end
                        end
                        if ((deepX*deepX+deepY*deepY>=math.pow(1*k,2))) then
                            local realX = particl[kek[i]].x+6.5*k-screenWidth/1.7
                            local realY = particl[kek[i]].y+6.5*k2 -screenHeight/2
                            if ( realX*realX + realY*realY <= 80*k*80*k) then
                                particl[kek[i]].x  = particl[kek[i]].x + deepX*dt*5
                                particl[kek[i]].y = particl[kek[i]].y + deepY*dt*5
                            end
                            realX = particl[j].x+6.5*k-screenWidth/1.7
                            realY = particl[j].y+6.5*k2 -screenHeight/2
                            if ( realX*realX + realY*realY <= 80*k*80*k) then
                                particl[j].x  = particl[j].x - deepX*dt*5
                                particl[j].y = particl[j].y - deepY*dt*5
                            end
                        end
                    end
                end
            end
        end
    end
end 
 

function particlSpawn(x,y,kol)
    for kek =1, kol do
        local Color1,Color2,Color3  = particlColor() 
        local e = {
        side = math.random(1,2), --- new
        ran = math.random(100,180), -----------new
        body =  HC.circle(x,y,10*k),----new
        flag  =false,-----new but old
        color1 = Color1,--- old 
        color2= Color2,--- old 
        color3 = Color3,--- old
        x  = x, 
        y =  y,  
        xx  = x, 
        yy =  y,
        ax  =math.random(-1.72*k*40,1.73*k*40), 
        ay = math.random(-1.73*k*40,1.73*k*40), 
        }
    table.insert(particl,e)
    end
end
function particlInRegulS(i)
    if (particl[i] and particl[i].flag == true) then 
        local IparticlRegulS =math.floor((particl[i].x-10*k)/(20*k)) + math.floor((particl[i].y-10*k2)/(20*k2))*math.floor((screenWidth/(20*k))+1)
        if (Particl.regulS[IparticlRegulS]) then
            table.insert(Particl.regulS[IparticlRegulS],i)
        else
            Particl.regulS[IparticlRegulS] = {i}
        end
    end
end
function particllUpdate(dt)
    for i=#particl,1, -1  do
        if( particl[i]) then
            if ( particl[i].flag == false) then 
                if ( particl[i].side == 1 ) then 
                    local x1 = particl[i].x+6.5*k -screenWidth/2
                    local y1 = particl[i].y+6.5*k2 -screenHeight/2
                    local ugol = math.atan2(x1,y1)
                    particl[i].x= particl[i].x+particl[i].ax*dt*k*2.5
                    particl[i].y= particl[i].y+particl[i].ay*dt*k2*2.5
                    particl[i].ax= particl[i].ran*math.sin(ugol+math.pi/2+math.pi/4)
                    particl[i].ay= particl[i].ran*math.cos(ugol+math.pi/2+math.pi/4)
                else
                    local x1 = screenWidth/2- particl[i].x
                    local y1 = screenHeight/2-particl[i].y 
                    local ugol = math.atan2(x1,y1)
                    particl[i].x= particl[i].x+particl[i].ax*dt*k*2.5
                    particl[i].y= particl[i].y+particl[i].ay*dt*k2*2.5
                    particl[i].ax= particl[i].ran*math.sin(ugol+math.pi/2-math.pi/4)
                    particl[i].ay= particl[i].ran*math.cos(ugol+math.pi/2-math.pi/4)
                end
            else
                local realX = particl[i].x+6.5*k-screenWidth/1.7
                local realY = particl[i].y+6.5*k2 -screenHeight/2
                local angleF = math.atan2(realX,realY) 
                if ( realX*realX + realY*realY < 80*k*80*k) then
  
                else
                    particl[i].ax=particl[i].ax-math.sin(angleF)*50
                    particl[i].ay=particl[i].ay-math.cos(angleF)*50
                end
                if ( particl[i].ax > 100) then
                    particl[i].ax = 100
                end
                if ( particl[i].ax < -100) then
                    particl[i].ax = -100
                end
                if ( particl[i].ay > 100) then
                    particl[i].ay = 100
                end
                if ( particl[i].ay < -100) then
                    particl[i].ay = -100
                end
                particl[i].x= particl[i].x+particl[i].ax*dt*k
                particl[i].y= particl[i].y+particl[i].ay*dt*k2
            end
        end
    end
end
function particlCollWithStatic(i,dt)
    if (particl[i].flag ==  false) then
        for leftBorder, body in pairs(Colba.Borders.L) do
            local collisFlag, intVectorX ,intVectorY = particl[i].body:collidesWith(body)
            if (collisFlag) then
                particl[i].x = particl[i].x + intVectorX*dt*20*k
                particl[i].y = particl[i].y +  intVectorY*dt*20*k2
            end
        end
        for rightBorder, body in pairs(Colba.Borders.R) do 
            local collisFlag, intVectorX ,intVectorY = particl[i].body:collidesWith(body)
            if (collisFlag) then 
                particl[i].x = particl[i].x + intVectorX*dt*20*k
                particl[i].y = particl[i].y +  intVectorY*dt*20*k2
            end
        end
        if (particl[i].body:collidesWith(Colba.body)) then 
            particl[i].flag = true 
            particl[i].ax =particl[i].ax / 200
            particl[i].ay =particl[i].ay / 200 
        end
    end
end

function particlClear(i,dt)
    if (Particl.flagClear == true and particl[i].x >screenWidth/1.7+80*k-Particl.clearX ) then
        expl(particl[i].x,particl[i].y,3)
        table.remove(particl,i)
       -- colbaPar = colbaPar - 1
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