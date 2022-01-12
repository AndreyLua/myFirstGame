local convert = {}
local colba = love.graphics.newImage("assets/constrSet.png")
local podst = love.graphics.newImage("assets/constrSet2.png")
local particlRegulS = {}
local flagColl =  false
local colbaBody = HC.circle(screenWidth/1.7,screenHeight/2,80*k)
local colbaFill = false
-----------------------------------LEFT-----------------------------------
local bodyL1 = HC.rectangle(0,0,25*k,30*k2)--2.1867155200084
bodyL1:moveTo(screenWidth/1.7-math.sin(2.1867155200084)*108*k	,screenHeight/2- math.cos(2.1867155200084)*108*k)
bodyL1:setRotation(1.14)
local bodyL2 = HC.rectangle(0,0,22*k,22*k2)--2.5879619886168
bodyL2:moveTo(screenWidth/1.7-math.sin(2.5879619886168)*104*k	,screenHeight/2- math.cos(2.5879619886168)*104*k)
bodyL2:setRotation(0.96)
local bodyL3 = HC.rectangle(0,0,25*k,30*k2)--2.9036124236754
bodyL3:moveTo(screenWidth/1.7-math.sin(2.9036124236754)*129.5*k	,screenHeight/2- math.cos(2.9036124236754)*129.5*k)
bodyL3:setRotation(0.52)
local bodyL4 = HC.circle(0,0,10*k)--2.5465780219889
bodyL4:moveTo(screenWidth/1.7-math.sin(2.5465780219889)*115*k	,screenHeight/2- math.cos(2.5465780219889)*115*k)
---------------------------------------------------------------------------
-----------------------------------RIGHT-----------------------------------
local bodyR1 = HC.rectangle(0,0,25*k,30*k2)--2.1867155200084
bodyR1:moveTo(screenWidth/1.7-math.sin(2.1867155200084+math.pi*1.611)*108*k	,screenHeight/2- math.cos(2.1867155200084+math.pi*1.611)*108*k)
bodyR1:setRotation(-1.07)
local bodyR2 = HC.rectangle(0,0,22*k,22*k2)--2.5879619886168
bodyR2:moveTo(screenWidth/1.7-math.sin(2.5879619886168+math.pi*1.351)*104*k	,screenHeight/2- math.cos(2.5879619886168+math.pi*1.351)*104*k)
bodyR2:setRotation(0.96-0.14-0.14)
local bodyR3 = HC.rectangle(0,0,25*k,30*k2)--2.9036124236754
bodyR3:moveTo(screenWidth/1.7-math.sin(2.9036124236754+math.pi*1.152)*129.5*k	,screenHeight/2- math.cos(2.9036124236754+math.pi*1.152)*129.5*k)
bodyR3:setRotation(-0.58)
local bodyR4 = HC.circle(0,0,10*k)--2.5465780219889
bodyR4:moveTo(screenWidth/1.7-math.sin(2.5465780219889+math.pi*1.378)*115*k	,screenHeight/2- math.cos(2.5465780219889+math.pi*1.378)*115*k)
---------------------------------------------------------------------------
local particlClearFlag = false
local particlClearX = 0
local flagButton1 = false
local flagButton2 = false
local countReward = 0
local flagRewardMenu = false 
local rewardMoney  = 0
local rewardSkill  = 0
local rewardSlotScale = 0 

function convert:update(dt)
    explUpdate2(dt)
    particlRegulS = {}
    -----
    if ( rewardSlotScale < 0.6 and flagRewardMenu == true ) then 
        rewardSlotScale = rewardSlotScale + 1 * dt
    end
    if ( rewardSlotScale > 0 and flagRewardMenu == false) then 
        rewardSlotScale = rewardSlotScale - 1 * dt
    end
    if ( particlClearFlag == true) then
        particlClearX = particlClearX + 300 * dt 
    end
    if ( particlClearX > 200 * k ) then 
        particlClearFlag = false
        particlClearX  = 0 
        rewardSlotScale = 0 
        giveReward(countReward)
        countReward = 0 
    end
    -----
    if ( math.ceil(colbaPar/1.4)>= 30 ) then 
        colbaFill= true
    else
        colbaFill= false
    end
    for i=#particl,1, -1  do
        particl[i].body:moveTo(particl[i].x+6.5*k,particl[i].y+6.5*k2)
        particlInRegulS(i)
        particlCollWithStatic(i,dt)
        particlClear(i,dt) 
    end
    particllUpdate(dt)
    mouse.x,mouse.y=love.mouse.getPosition()
    if love.mouse.isDown(1)  then
        flagtouch3 =true
        local realX = mouse.x-screenWidth/1.7
        local realY = mouse.y -screenHeight/2
        if ( (realX*realX + realY*realY < 100*k*100*k) and #particl<140 and flagRewardMenu == false ) then
            if ( score >=scoreForParticle and particlClearFlag == false) then
                score = score - scoreForParticle
                if ( math.random(1,2) == 1 ) then
                    particlSpawn(0,math.random(screenHeight/2-90*k2,screenHeight/2-40*k2),1)
                else
                    particlSpawn(0,math.random(screenHeight/2+40*k2,screenHeight/2+90*k2),1)
                end
            end
        end
        if (  mouse.x > screenWidth/1.7+220*k-k2/4*120 and  mouse.x <screenWidth/1.7+220*k+ k2/4*120 and mouse.y > screenHeight/2-500*k/4 and  mouse.y <screenHeight/2+500*k/4 and flagRewardMenu == false) then
            flagButton1 = true
        end
      
        if (  mouse.x > screenWidth/2+200*k-k2/4*120 and  mouse.x <screenWidth/2+200*k+ k2/4*120 and mouse.y > screenHeight/2-500*k/4 and  mouse.y <screenHeight/2+500*k/4 and flagRewardMenu == true ) then
            flagButton2 = true
        end
    else
        if ( mouse.x > 0 and  mouse.x <60*k and mouse.y > 0 and  mouse.y <60*k2 and flagtouch3 == true) then
            exp = {}
            gamestate.switch(game)
        end 

        if (mouse.x > screenWidth/1.7+220*k-k2/4*120 and  mouse.x <screenWidth/1.7+220*k+ k2/4*120 and mouse.y > screenHeight/2-500*k/4 and  mouse.y <screenHeight/2+500*k/4 and flagButton1 == true) then
            if (colbaFill==true and colbaPar == #particl) then
                  particlClearFlag = true
                  countReward = colbaPar
            end
        end
        if (mouse.x > screenWidth/2+200*k-k2/4*120 and  mouse.x <screenWidth/2+200*k+ k2/4*120 and mouse.y > screenHeight/2-500*k/4 and  mouse.y <screenHeight/2+500*k/4 and flagRewardMenu == true and  flagButton2 == true ) then
            flagRewardMenu = false
            score = score + rewardMoney
            if ( rewardSkill ~= 0) then 
                local flagPlHave = false
                
                for i =1, #playerSkills do 
                    local masSkill = playerSkills[i] 
                    if (flagPlHave ==false and  masSkill.img == allSkills[rewardSkill] ) then 
                        flagPlHave = true
                        rewardSkill = i 
                        break
                    end
                end
                
                if ( flagPlHave) then 
                    playerSkills[rewardSkill].lvl = playerSkills[rewardSkill].lvl + 1
                else
                    table.insert(playerSkills,{img = allSkills[rewardSkill],lvl  = 1,numb = rewardSkill  } ) 
                end
            end
            rewardMoney = 0 
            rewardSkill = 0
        end
        flagButton1 = false
        flagButton2 = false
        flagtouch3 =false
    end

        --if (  mouse.x > screenWidth/3-75*k/1.4 and  mouse.x <screenWidth/3+75*k/1.4 and mouse.y > screenHeight/5*4-75*k2/1.4 and  mouse.y <screenHeight/5*4+75*k2/1.4 and flagtouch3 == true) then
          
         --   texti = -1
         --   textL = ""
         --   textK = 0     
         --   tip = slots[2]
       -- end

      
    --if ( tip~= 0 ) then 
    
    --end
end

function convert:draw()
local dt = love.timer.getDelta()
UIBatch:clear()
skillBatch:clear()
love.graphics.setColor(1,1,1,1)
love.graphics.draw(fon1,0,0,0,k,k2)
love.graphics.draw(fon2,0,0,0,k,k2)
love.graphics.draw(fon3,0,0,0,k,k2)
exit(0,0)
love.graphics.setColor(1-rewardSlotScale,1-rewardSlotScale,1-rewardSlotScale,1-rewardSlotScale)
bodyButton(screenWidth/1.7+220*k,screenHeight/2,flagButton1,rewardSlotScale)
love.graphics.draw(colba,screenWidth/1.7,screenHeight/2,-math.pi/2,k/1.9,k2/1.9,250,193.5)
love.graphics.draw(podst,screenWidth/1.7+95*k,screenHeight/2,-math.pi/2,k/1.9,k2/1.9,200,150.5)


for i=#particl,1, -1  do
    local IparticlRegulS =math.floor((particl[i].x-10*k)/(20*k)) + math.floor((particl[i].y-10*k2)/(20*k2))*math.floor((screenWidth/(20*k))+1)
    flagColl =  false
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
love.graphics.setColor(1,1,1,0.6-rewardSlotScale)
love.graphics.draw(colba,screenWidth/1.7,screenHeight/2,-math.pi/2,k/1.9,k2/1.9,250,193.5)
love.graphics.setColor(1-rewardSlotScale,1-rewardSlotScale,1-rewardSlotScale,1-rewardSlotScale)
textButton("Tap to fill",screenWidth/1.53,screenHeight/2,false,0.5)
love.graphics.setColor(0,0,0,1)
love.graphics.rectangle('fill',0,screenHeight/2-100*k2,35*k,200*k2)
love.graphics.setColor(1,1,1,0.6-rewardSlotScale)
sc(0,screenHeight/2)
local fontWidth = font:getWidth(tostring(score))
love.graphics.print(score,50*k/12, screenHeight/2+fontWidth/2*k2/2,-math.pi/2,k/2,k2/2)
if ( math.ceil(colbaPar/1.4)>= 30 ) then 
    love.graphics.setColor(0.308,0.661,0.445,1) 
end
if ( math.ceil(colbaPar/1.4)>= 60 ) then 
    love.graphics.setColor(0.6,0.3,0.6,1) 
end
if ( math.ceil(colbaPar/1.4)== 100 ) then 
    love.graphics.setColor(0.8,0.8,0.3,1) 
end
fontWidth = font:getWidth(tostring(math.abs(math.ceil(colbaPar/1.4)))..'%')
love.graphics.print(tostring(math.abs(math.ceil(colbaPar/1.4)))..'%',screenWidth/1.7-250*k/1.9, screenHeight/2+fontWidth/2*k2/1.5,-math.pi/2,k/1.5,k2/1.5)
love.graphics.setColor(1,1,1,1) 

if (flagRewardMenu == true) then 
    if (rewardSkill == 0) then 
        rewardSlot(nil,screenWidth/2,screenHeight/2,rewardSlotScale,rewardMoney)
    else
        rewardSlot(allSkills[rewardSkill],screenWidth/2,screenHeight/2,rewardSlotScale,rewardMoney)
    end
    bodyButton(screenWidth/2+200*k,screenHeight/2,flagButton2)  
end

love.graphics.draw(UIBatch)
love.graphics.draw(skillBatch) 

love.graphics.setColor(1-rewardSlotScale,1-rewardSlotScale,1-rewardSlotScale,1-rewardSlotScale) 
textButton("Convert",screenWidth/1.7+220*k,screenHeight/2,flagButton1)
if (flagRewardMenu == true) then 
    love.graphics.setColor(1,1,1,1) 
    textButton("Ok",screenWidth/2+200*k,screenHeight/2,flagButton2)  
    love.graphics.setColor(0.125,0.251,0.302,1) 
    if ( rewardMoney > 0 and rewardSkill == 0) then 
        textButton(rewardMoney,screenWidth/2,screenHeight/2,false,1.6*rewardSlotScale)  
    end
end

love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 100, 10,0,k/2,k2/2)
love.graphics.print("particl: "..tostring(#particl), 100, 70,0,k/2,k2/2)
for i=1,#exp do
    love.graphics.setColor(exp[i].color1,exp[i].color2,exp[i].color3,1) 
    love.graphics.rectangle("fill",exp[i].x,exp[i].y,exp[i].scale*20*k,exp[i].scale*20*k2,4*exp[i].scale*k)
end
end

function particlCollWithparticl(index,j,dt)
    if ( particlRegulS[index]) then 
        local kek = particlRegulS[index]
        if (kek) then
            for i = #kek, 1, -1 do
                if (kek[i] and particl[kek[i]] and particl[j] and kek[i]~=j and math.abs(particl[kek[i]].x - particl[j].x)<14*k and math.abs(particl[kek[i]].y - particl[j].y)<14*k2 and  (math.pow((particl[kek[i]].x - particl[j].x),2) + math.pow((particl[kek[i]].y - particl[j].y),2))<=math.pow(14*k,2)) then
                    local collisFlag, intVectorX ,intVectorY = particl[kek[i]].body:collidesWith(particl[j].body)
                    if (collisFlag) then
                        flagColl = true 
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
        if (particlRegulS[IparticlRegulS]) then
            table.insert(particlRegulS[IparticlRegulS],i)
        else
            particlRegulS[IparticlRegulS] = {i}
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
        local collisFlag, intVectorX ,intVectorY = particl[i].body:collidesWith(bodyL1)
        if ( particl[i].body:collidesWith(bodyL1)) then 
            particl[i].x = particl[i].x + intVectorX*dt*20*k
            particl[i].y = particl[i].y +  intVectorY*dt*20*k2
        end
        collisFlag, intVectorX ,intVectorY = particl[i].body:collidesWith(bodyL2)
        if ( particl[i].body:collidesWith(bodyL2)) then 
            particl[i].x = particl[i].x + intVectorX*dt*20*k
            particl[i].y = particl[i].y +  intVectorY*dt*20*k2
        end
        collisFlag, intVectorX ,intVectorY = particl[i].body:collidesWith(bodyL3)
        if (particl[i].body:collidesWith(bodyL3)) then 
            particl[i].x = particl[i].x + intVectorX*dt*20*k
            particl[i].y = particl[i].y +  intVectorY*dt*20*k2
        end
        collisFlag, intVectorX ,intVectorY = particl[i].body:collidesWith(bodyL4)
        if ( particl[i].body:collidesWith(bodyL4)) then 
            particl[i].x = particl[i].x + intVectorX*dt*20*k
            particl[i].y = particl[i].y +  intVectorY*dt*20*k2
        end
        collisFlag, intVectorX ,intVectorY = particl[i].body:collidesWith(bodyR1)
        if ( particl[i].body:collidesWith(bodyR1)) then 
            particl[i].x = particl[i].x + intVectorX*dt*20*k
            particl[i].y = particl[i].y +  intVectorY*dt*20*k2
        end
        collisFlag, intVectorX ,intVectorY = particl[i].body:collidesWith(bodyR2)
        if ( particl[i].body:collidesWith(bodyR2)) then 
            particl[i].x = particl[i].x + intVectorX*dt*20*k
            particl[i].y = particl[i].y +  intVectorY*dt*20*k2
        end
        collisFlag, intVectorX ,intVectorY = particl[i].body:collidesWith(bodyR3)
        if (particl[i].body:collidesWith(bodyR3)) then 
            particl[i].x = particl[i].x + intVectorX*dt*20*k
            particl[i].y = particl[i].y +  intVectorY*dt*20*k2
        end
        collisFlag, intVectorX ,intVectorY = particl[i].body:collidesWith(bodyR4)
        if ( particl[i].body:collidesWith(bodyR4)) then 
            particl[i].x = particl[i].x + intVectorX*dt*20*k
            particl[i].y = particl[i].y +  intVectorY*dt*20*k2
        end
        if (particl[i].body:collidesWith(colbaBody)) then 
            particl[i].flag = true 
            colbaPar =   colbaPar + 1 
            particl[i].ax =particl[i].ax / 200
            particl[i].ay =particl[i].ay / 200 
        end
    end
end
function particlColor() 
    local randomNumber = math.random(1,5)
   --[[ if ( randomNumber ==  1 ) then 
        return 0,0.471,0.176
    end 
    if ( randomNumber ==  2 ) then 
        return 0.137,0.545,0.286
    end 
    if ( randomNumber ==  3 ) then 
        return 0,0.725,0.271
    end 
    if ( randomNumber ==  4 ) then 
        return 0.216,0.863,0.455
    end 
    if ( randomNumber == 5 ) then 
        return 0.388,0.863,0.565
    end
  ]]--  
    
     if ( randomNumber ==  1 ) then 
        return 0.008,0.298,0.408
    end 
    if ( randomNumber ==  2 ) then 
        return 0.133,0.376,0.471
    end 
    if ( randomNumber ==  3 ) then 
        return 0.027,0.463,0.627
    end 
    if ( randomNumber ==  4 ) then 
        return 0.227,0.651,0.816
    end 
    if ( randomNumber == 5 ) then 
        return 0.384,0.694,0.816
    end 
end
function particlClear(i,dt)
    if (particlClearFlag == true and particl[i].x >screenWidth/1.7+80*k-particlClearX ) then
        expl(particl[i].x,particl[i].y,3)
        table.remove(particl,i) ---
        colbaPar = colbaPar - 1
    end 
end
function giveReward(count)
    flagRewardMenu = true 
    if ( count == 140) then 
      ---- big reward 
    else
        if (math.ceil(count/1.4)>=60) then
         -- normal  reward 
        else
            if ( math.random(1,100) > 70) then 
                rewardSkill  = math.random(1,7) 
            else
                if ( math.random(1,100) > 80) then
                    rewardMoney  = count* scoreForParticle*0.7
                else
                    if ( math.random(1,100) > 50) then
                        rewardMoney  = count* scoreForParticle*0.5 
                    else
                        rewardMoney  = 0
                    end
                end
            end
        end
    end
end
function convert:keypressed(key, code)
    if key == "escape" then
        gamestate.switch(game)
    elseif key == "q" then
        love.event.push('quit')
    end
end

return convert