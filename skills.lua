local skills = {}
local cost = 10
local colba = love.graphics.newImage("assets/constrSet.png")
local expRegulS = {}
local flagColl =  false

local colbaBody = HC.circle(screenWidth/1.7,screenHeight/2,80*k)

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



local tip = 0 
flagrolls = false 
exp =  {}
slots = { 0 , 0 , 0 , 0 }

function skills:draw()
local dt = love.timer.getDelta()
UIBatch:clear()
love.graphics.setColor(1,1,1,1)
love.graphics.draw(fon1,0,0,0,k,k2)
love.graphics.draw(fon2,0,0,0,k,k2)
love.graphics.draw(fon3,0,0,0,k,k2)
exit(0,0)
sc(0,screenHeight/2)
bodyButton(screenWidth/1.2,screenHeight/2,false)
love.graphics.draw(UIBatch)
textButton("Convert",screenWidth/1.2,screenHeight/2,false)
local fontWidth = font:getWidth(tostring(score))
local fontHeight = font:getHeight(tostring(score))

love.graphics.print(score,50*k/12, screenHeight/2+fontWidth/2*k2/2,-math.pi/2,k/2,k2/2)

love.graphics.draw(colba,screenWidth/1.7,screenHeight/2,-math.pi/2,k/1.9,k2/1.9,250,193.5)


for i=1,#exp do
    local IexpRegulS =math.floor((exp[i].x-10*k)/(20*k)) + math.floor((exp[i].y-10*k2)/(20*k2))*math.floor((screenWidth/(20*k))+1)
    flagColl =  false
    if (exp[i].flag == true  ) then 
        expCollWithExp(IexpRegulS,i,dt)
        expCollWithExp(IexpRegulS+1,i,dt)
        expCollWithExp(IexpRegulS+math.floor((screenWidth/(20*k))+1),i,dt) 
        expCollWithExp(IexpRegulS+math.floor((screenWidth/(20*k))+1)+1,i,dt)
        expCollWithExp(IexpRegulS-math.floor((screenWidth/(20*k))+1)+1,i,dt)
    end
    exp[i].ax =exp[i].ax+ 60*dt
    if ( exp[i].ay > 0.5*k ) then
        exp[i].ay =exp[i].ay- 1
    end
    if ( exp[i].ay < -0.5*k ) then
        exp[i].ay =exp[i].ay+ 1
    end
    love.graphics.setColor(exp[i].color1,exp[i].color2,exp[i].color3)
    love.graphics.rectangle("fill",  exp[i].x,exp[i].y,13*k,13*k2,2)
  
    
   -- exp[i].body:draw('fill')
end
love.graphics.setColor(1,1,1,0.5)
love.graphics.draw(colba,screenWidth/1.7,screenHeight/2,-math.pi/2,k/1.9,k2/1.9,250,193.5)

--love.graphics.draw(colba,screenWidth/1.7,screenHeight/2,-1.57,k,k2,250,193.5)

love.graphics.setColor(1,1,1,1)
love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 100, 10,0,k/2,k2/2)
love.graphics.print("EXP: "..tostring(#exp), 100, 70,0,k/2,k2/2)
  love.graphics.circle("fill",  screenWidth/1.7,screenHeight/2,1)
  if ( kekKK == 0) then 
--bodyL1:draw('fill')
--bodyL2:draw('fill')
--bodyL3:draw('fill')
--bodyL4:draw('fill')
--bodyR1:draw('fill')
--bodyR2:draw('fill')
--bodyR3:draw('fill')
--bodyR4:draw('fill')
end

--colbaBody:draw('fill')
--text(screenWidth/2.2,screenHeight/2+screenHeight/2.7,0.5)
end
function skills:update(dt)
    expRegulS = {}
for i=1,#exp do
    exp[i].body:moveTo(exp[i].x+6.5*k,exp[i].y+6.5*k2)
    
    if (exp[i] and exp[i].flag == true) then 
        local IexpRegulS =math.floor((exp[i].x-10*k)/(20*k)) + math.floor((exp[i].y-10*k2)/(20*k2))*math.floor((screenWidth/(20*k))+1)
        if (expRegulS[IexpRegulS]) then
            table.insert(expRegulS[IexpRegulS],i)
        else
            expRegulS[IexpRegulS] = {i}
        end
    end
    if (exp[i].flag ==  false) then 
        local collisFlag, intVectorX ,intVectorY = exp[i].body:collidesWith(bodyL1)
        if ( exp[i].body:collidesWith(bodyL1)) then 
            exp[i].x = exp[i].x + intVectorX*dt*20*k
            exp[i].y = exp[i].y +  intVectorY*dt*20*k2
        end
        collisFlag, intVectorX ,intVectorY = exp[i].body:collidesWith(bodyL2)
        if ( exp[i].body:collidesWith(bodyL2)) then 
            exp[i].x = exp[i].x + intVectorX*dt*20*k
            exp[i].y = exp[i].y +  intVectorY*dt*20*k2
        end
        collisFlag, intVectorX ,intVectorY = exp[i].body:collidesWith(bodyL3)
        if (exp[i].body:collidesWith(bodyL3)) then 
            exp[i].x = exp[i].x + intVectorX*dt*20*k
            exp[i].y = exp[i].y +  intVectorY*dt*20*k2
        end
        collisFlag, intVectorX ,intVectorY = exp[i].body:collidesWith(bodyL4)
        if ( exp[i].body:collidesWith(bodyL4)) then 
            exp[i].x = exp[i].x + intVectorX*dt*20*k
            exp[i].y = exp[i].y +  intVectorY*dt*20*k2
        end
        
        collisFlag, intVectorX ,intVectorY = exp[i].body:collidesWith(bodyR1)
        if ( exp[i].body:collidesWith(bodyR1)) then 
            exp[i].x = exp[i].x + intVectorX*dt*20*k
            exp[i].y = exp[i].y +  intVectorY*dt*20*k2
        end
        collisFlag, intVectorX ,intVectorY = exp[i].body:collidesWith(bodyR2)
        if ( exp[i].body:collidesWith(bodyR2)) then 
            exp[i].x = exp[i].x + intVectorX*dt*20*k
            exp[i].y = exp[i].y +  intVectorY*dt*20*k2
        end
        collisFlag, intVectorX ,intVectorY = exp[i].body:collidesWith(bodyR3)
        if (exp[i].body:collidesWith(bodyR3)) then 
            exp[i].x = exp[i].x + intVectorX*dt*20*k
            exp[i].y = exp[i].y +  intVectorY*dt*20*k2
        end
        collisFlag, intVectorX ,intVectorY = exp[i].body:collidesWith(bodyR4)
        if ( exp[i].body:collidesWith(bodyR4)) then 
            exp[i].x = exp[i].x + intVectorX*dt*20*k
            exp[i].y = exp[i].y +  intVectorY*dt*20*k2
        end
        if (exp[i].body:collidesWith(colbaBody)) then 
            exp[i].flag = true 
            exp[i].ax =exp[i].ax / 200
            exp[i].ay =exp[i].ay / 200 
        end
    end
end
    if love.keyboard.isDown('w') then
        kekKK = kekKK +0.01
    end
    if love.keyboard.isDown('s') then
        kekKK = kekKK -0.01
    end
explUpdate3(dt)
mouse.x,mouse.y=love.mouse.getPosition()

--bodyL3:moveTo(mouse.x,mouse.y)
--bodyR1:setRotation(kekKK)

if love.mouse.isDown(1)  then
    expl(mouse.x,mouse.y,1)
    flagtouch3 =true
else
    if ( mouse.x > 0 and  mouse.x <60*k and mouse.y > 0 and  mouse.y <60*k2 and flagtouch3 == true) then
        exp =  {}
        gamestate.switch(game)
    end
    flagtouch3 =false
end

    --if (  mouse.x > screenWidth/3-75*k/1.4 and  mouse.x <screenWidth/3+75*k/1.4 and mouse.y > screenHeight/5*4-75*k2/1.4 and  mouse.y <screenHeight/5*4+75*k2/1.4 and flagtouch3 == true) then
      
     --   texti = -1
     --   textL = ""
     --   textK = 0     
     --   tip = slots[2]
   -- end

  
--if ( tip~= 0 ) then 
   -- textUpdate(textMas[tip],0.1,dt) 
--end
end

function textUpdate(text,speed,dt) 
    if (texti<=#text) then 
        textT:update(dt)
        textT:every(speed, function()
            texti = texti+1
            textK = textK+1
            local textkek = "" 
            if (textL:sub(#textL,#textL)=="_") then
                textL = textL:sub(0,#textL-1)
            end
            textkek = text:sub(texti,texti)
            if ( textK>7 and text:sub(texti,texti) == " ") then
               textK = 0 
               textkek =textkek.."\n"
            end
            textL = textL..textkek.."_"
            textT:clear()
        end)
    end
end
function expCollWithExp(index,j,dt)
    if ( expRegulS[index]) then 
        local kek = expRegulS[index]
        if (kek) then
            for i = #kek, 1, -1 do
                if (kek[i] and exp[kek[i]] and exp[j] and kek[i]~=j and math.abs(exp[kek[i]].x - exp[j].x)<14*k and math.abs(exp[kek[i]].y - exp[j].y)<14*k2 and  (math.pow((exp[kek[i]].x - exp[j].x),2) + math.pow((exp[kek[i]].y - exp[j].y),2))<=math.pow(14*k,2)) then
                    local collisFlag, intVectorX ,intVectorY = exp[kek[i]].body:collidesWith(exp[j].body)
                    if (collisFlag) then
                        flagColl = true 
                        local lenIntVector = math.sqrt(intVectorX*intVectorX+intVectorY*intVectorY)
                        local rvX, rvY = exp[j].ax-exp[kek[i]].ax,  exp[j].ay -exp[kek[i]].ay
                        local deepX = intVectorX
                        local deepY = intVectorY
                        intVectorX = (intVectorX/lenIntVector)
                        intVectorY = (intVectorY/lenIntVector)
                        local velAlNorm  = rvX*intVectorX + rvY*intVectorY
                        if ( velAlNorm > 0) then
                            local e =0.1
                            local scImp = -(1+e)*velAlNorm
                            local impulsX, impulsY = scImp * intVectorX, scImp* intVectorY
                            local realX = exp[j].x+6.5*k-screenWidth/1.7
                            local realY = exp[j].y+6.5*k2 -screenHeight/2
                            if ( realX*realX + realY*realY <= 80*k*80*k) then
                                exp[j].ax=exp[j].ax+dt*40*impulsX
                                exp[j].ay=exp[j].ay+dt*40*impulsY
                            end
                            realX = exp[kek[i]].x+6.5*k-screenWidth/1.7
                            realY = exp[kek[i]].y+6.5*k2 -screenHeight/2
                            if ( realX*realX + realY*realY <= 80*k*80*k) then
                                exp[kek[i]].ax=exp[kek[i]].ax - dt*40*impulsX
                                exp[kek[i]].ay=exp[kek[i]].ay - dt*40*impulsY
                            end
                        end
                        if ((deepX*deepX+deepY*deepY>=math.pow(1*k,2))) then
                            local realX = exp[kek[i]].x+6.5*k-screenWidth/1.7
                            local realY = exp[kek[i]].y+6.5*k2 -screenHeight/2
                            if ( realX*realX + realY*realY <= 80*k*80*k) then
                                exp[kek[i]].x  = exp[kek[i]].x + deepX*dt*5
                                exp[kek[i]].y = exp[kek[i]].y + deepY*dt*5
                            end
                            realX = exp[j].x+6.5*k-screenWidth/1.7
                            realY = exp[j].y+6.5*k2 -screenHeight/2
                            if ( realX*realX + realY*realY <= 80*k*80*k) then
                                exp[j].x  = exp[j].x - deepX*dt*5
                                exp[j].y = exp[j].y - deepY*dt*5
                            end
                        end
                    end
                end
            end
        end
    end
end 
 
function text(x,y,scale)
    love.graphics.setColor(0.0039*200,0.0039*150,0)
    love.graphics.print(textL,x,y,-3.14/2,scale,scale)
end

function skills:keypressed(key, code)
    if key == "escape" then
        gamestate.switch(game)
    elseif key == "q" then
        love.event.push('quit')
    end
end

return skills