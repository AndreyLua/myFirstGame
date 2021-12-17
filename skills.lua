local skills = {}
local cost = 10
local colba = love.graphics.newImage("assets/constrSet.png")
local expRegulS = {}
local flagColl =  false
local bodyL1 = HC.rectangle(0,0,30*k,50*k2)
bodyL1:moveTo(351.4*k,286*k2)
bodyL1:setRotation(1.15)

local bodyL2 = HC.rectangle(356.4*k,291*k2,27*k,30*k2)
bodyL2:moveTo(387*k,316.8*k2)
bodyL2:setRotation(0.96)

local bodyL3 = HC.rectangle(0,0,30*k,40*k2)
bodyL3:moveTo(417*k,354*k2)
bodyL3:setRotation(	0.34)

local bodyL4 = HC.circle(0,0,11*k)
bodyL4:moveTo(375.6*k,325*k2)


local colbaBody = HC.circle(0,0,90*k)
colbaBody:moveTo(screenWidth/1.7,screenHeight/2)


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
exit(-7*k,-7*k2)
sc(0,screenHeight/2)
bodyButton(screenWidth/1.2,screenHeight/2,false)
love.graphics.draw(UIBatch)
textButton("Convert",screenWidth/1.2,screenHeight/2,false)
local fontWidth = font:getWidth(tostring(score))
love.graphics.print(score,50*k/12, screenHeight/2+fontWidth/2*k2/2,-math.pi/2,k/2,k2/2)
love.graphics.draw(colba,screenWidth/1.7,screenHeight/2,-1.57,k/1.7,k2/1.7,250,193.5)

for i=1,#exp do
    local IexpRegulS =math.floor((exp[i].x-3*k)/(6*k)) + math.floor((exp[i].y-3*k2)/(6*k2))*math.floor((screenWidth/(6*k))+1)
    flagColl =  false
    if (exp[i].flag == true  ) then 
        expCollWithExp(IexpRegulS,i,dt)
        expCollWithExp(IexpRegulS-1,i,dt)
        expCollWithExp(IexpRegulS+1,i,dt)
        expCollWithExp(IexpRegulS-math.floor((screenWidth/(6*k))+1),i,dt)
        expCollWithExp(IexpRegulS+math.floor((screenWidth/(6*k))+1),i,dt) 
        expCollWithExp(IexpRegulS+math.floor((screenWidth/(6*k))+1)+1,i,dt)
        expCollWithExp(IexpRegulS+math.floor((screenWidth/(6*k))+1)-1,i,dt)
        expCollWithExp(IexpRegulS-math.floor((screenWidth/(6*k))+1)+1,i,dt)
        expCollWithExp(IexpRegulS-math.floor((screenWidth/(6*k))+1)-1,i,dt)
    end

    if ( flagColl == false and exp[i].flag == true  ) then 
        local realX = exp[i].x-screenWidth/1.7
        local realY = exp[i].y -screenHeight/2
        if ( realX*realX + realY*realY < 100*k*100*k) then
            exp[i].ax =exp[i].ax+  exp[i].ran/5000
        end
    end 
    love.graphics.setColor(exp[i].color1,exp[i].color2,exp[i].color3)
    love.graphics.rectangle("fill",  exp[i].x,exp[i].y,exp[i].scale*45*k,exp[i].scale*45*k2,2)
 --   exp[i].body:draw('fill')
end
love.graphics.setColor(1,1,1,0.5)
love.graphics.draw(colba,screenWidth/1.7,screenHeight/2,-1.57,k/1.7,k2/1.7,250,193.5)

love.graphics.setColor(1,1,1,1)
 love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 100, 10,0,k/2,k2/2)
  love.graphics.print("EXP: "..tostring(#exp), 100, 70,0,k/2,k2/2)
--bodyL1:draw('fill')
--bodyL2:draw('fill')
--bodyL3:draw('fill')
--bodyL4:draw('fill')
--colbaBody:draw('fill')
--text(screenWidth/2.2,screenHeight/2+screenHeight/2.7,0.5)
end
function skills:update(dt)
    expRegulS = {}
for i=1,#exp do
    exp[i].body:moveTo(exp[i].x+0.15*20*k,exp[i].y+0.15*20*k2)
    if (exp[i] and exp[i].flag == true) then 
        local IexpRegulS =math.floor((exp[i].x-3*k)/(6*k)) + math.floor((exp[i].y-3*k2)/(6*k2))*math.floor((screenWidth/(6*k))+1)
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
        if (exp[i].body:collidesWith(colbaBody)) then 
            exp[i].flag = true 
            exp[i].ax =exp[i].ax / 2
            exp[i].ay =exp[i].ay / 2 
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
--bodyL3:setRotation(kekKK)

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
                if (kek[i] and exp[kek[i]] and exp[j] and kek[i]~=j) then
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
                            local realX = exp[j].x-screenWidth/1.7
                            local realY = exp[j].y -screenHeight/2
                            if ( realX*realX + realY*realY <= 100*k*100*k) then
                                exp[j].ax=exp[j].ax+dt*20*impulsX
                                exp[j].ay=exp[j].ay+dt*20*impulsY
                            end
                            realX = exp[kek[i]].x-screenWidth/1.7
                            realY = exp[kek[i]].y -screenHeight/2
                            if ( realX*realX + realY*realY <= 100*k*100*k) then
                                exp[kek[i]].ax=exp[kek[i]].ax - dt*20*impulsX
                                exp[kek[i]].ay=exp[kek[i]].ay - dt*20*impulsY
                            end
                        end
                        if ((deepX*deepX+deepY*deepY>=math.pow(0.1*k,2))) then
                            local realX = exp[kek[i]].x-screenWidth/1.7
                            local realY = exp[kek[i]].y -screenHeight/2
                            if ( realX*realX + realY*realY <= 100*k*100*k) then
                                exp[kek[i]].x  = exp[kek[i]].x - deepX*dt*5
                               exp[kek[i]].y = exp[kek[i]].y - deepY*dt*5
                            end
                            realX = exp[j].x-screenWidth/1.7
                            realY = exp[j].y -screenHeight/2
                            if ( realX*realX + realY*realY <= 100*k*100*k) then
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