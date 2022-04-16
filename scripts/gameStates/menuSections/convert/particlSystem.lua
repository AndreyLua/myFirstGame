local particlSystem = {}

Particle = {
    flagClear = false,
    clearX = 0,
    regulS = {},
    list =  {},
    delaySound = 0,    
}

function Particle:update(Colba,dt)
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
        Particle:collisionWithColba(i,Colba,dt)
        Particle:clear(i,dt)
    end
end

function Particle:draw(dt)
    for i=#Particle.list,1, -1  do
        local IparticlRegulS =math.floor((Particle.list[i].x-10*k)/(20*k)) + math.floor((Particle.list[i].y-10*k2)/(20*k2))*math.floor((screenWidth/(20*k))+1)
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
function Particle:collisionWithColba(i,Colba,dt)
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
return particlSystem