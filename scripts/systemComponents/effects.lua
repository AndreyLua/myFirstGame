local effects = {}

function light22(x1,y1,x2,y2,kkk)
    local segments = {{{x1,y1},{x2,y2}}}
    local length = math.sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1))
    if ( length < 100*k) then 
    local offset =length/5
    for i=1,kkk do
        for j =1,#segments do
            local segment = segments[j]
            local beginSegm = segment[1]
            local endSegm = segment[2]
            local ran =offset
            if ( math.random(1,2) == 1 ) then 
                ran = -ran 
            end
            local angle =math.pi-math.atan2((endSegm[1] -beginSegm[1]),(endSegm[2] -beginSegm[2]))
            local midX  =(beginSegm[1]+endSegm[1])/2+math.cos(angle)*ran
            local midY  =(beginSegm[2]+endSegm[2])/2+math.sin(angle)*ran
            if ( math.random(1,4) == 1  )then 
                local lengthDopPoint = math.sqrt((midX-beginSegm[1])*(midX-beginSegm[1])+(midY-beginSegm[2])*(midY-beginSegm[2]))
                local dopAngle = -math.atan2((endSegm[1]-beginSegm[1]),(endSegm[2]-beginSegm[2]))
                local dopPointX = midX+math.cos(dopAngle+math.pi/2-math.random()*1.2*math.random(-1,1))*lengthDopPoint*0.7
                local dopPointY = midY+math.sin(dopAngle+math.pi/2-math.random()*1.2*math.random(-1,1))*lengthDopPoint*0.7
                table.insert(segments,{{midX,midY},{dopPointX,dopPointY}})
            end
            table.remove(segments,j)
            table.insert(segments,{{beginSegm[1],beginSegm[2]},{midX,midY}})
            table.insert(segments,{{midX,midY},{endSegm[1],endSegm[2]}})
        end
        offset = offset/2
    end
    return segments
    end
end

function light22Draw(mas) 
    if ( mas~=nil) then 
        for i = 1 , #mas do
            local vert = {}
            local mouth =  mas[i]
            local versh = mouth[1]
            local versh2 = mouth[2]
            table.insert(vert,versh[1])
            table.insert(vert,versh[2])
            table.insert(vert,versh2[1])
            table.insert(vert,versh2[2])
            love.graphics.setColor(0.4,1,1,1)
            love.graphics.setLineWidth( 2*k )
            love.graphics.line(vert)
            love.graphics.setColor(0.8,1,1,1)
            love.graphics.setLineWidth( 1*k )
            love.graphics.line(vert)
        end
    end
end


function explUpdate2(dt)
    for i =1, #exp do
        if( exp[i]) then
            exp[i].x= exp[i].x+exp[i].ax*dt*k
            exp[i].y= exp[i].y+exp[i].ay*dt*k2
            if (  exp[i].flag ==false) then 
                if ( exp[i].ax > 0 ) then
                    exp[i].ax  = exp[i].ax -70*dt*k
                else
                    exp[i].ax  = exp[i].ax + 70*dt*k
                end
                if ( exp[i].ay > 0 ) then
                    exp[i].ay  = exp[i].ay -70*dt*k2
                else
                    exp[i].ay  = exp[i].ay + 70*dt*k2
                end
            end
            if ( (exp[i].ay<3*k2 and  exp[i].ay>-3*k2) or (exp[i].ax<3*k and  exp[i].ax>-3*k)) then
                table.remove(exp,i)
            end
        end
    end
end

function explUpdate(dt)
    for i =1, #exp do
        if( exp[i]) then
            exp[i].x= exp[i].x+exp[i].ax*dt*2*k
            exp[i].y= exp[i].y+exp[i].ay*dt*2*k2
            if (  exp[i].flag ==false) then 
                if ( exp[i].ax > 0 ) then
                    exp[i].ax  = exp[i].ax - 50*dt*k
                else
                    exp[i].ax  = exp[i].ax + 50*dt*k
                end
                if ( exp[i].ay > 0 ) then
                    exp[i].ay  = exp[i].ay - 50*dt*k2
                else
                    exp[i].ay  = exp[i].ay + 50*dt*k2
                end
            end
            if ( (exp[i].ay<10*k2 and  exp[i].ay>-10*k2) or (exp[i].ax<10*k and  exp[i].ax>-10*k)) then
                exp[i].flag =true
            end
            if ( exp[i].flag == true) then
                local x1 = exp[i].x - exp[i].xx
                local y1 = exp[i].y - exp[i].yy
                local ugol = math.atan2(x1,y1)
                exp[i].ax=90*k*math.sin(ugol+2)
                exp[i].ay=90*k2*math.cos(ugol+2)
            end
            if ( ((exp[i].y<exp[i].yy+200*k2*dt and  exp[i].y>exp[i].yy-200*k2*dt) and (exp[i].x<exp[i].xx+200*k*dt and  exp[i].x>exp[i].xx-200*k*dt)) and exp[i].flag == true ) then
                table.remove(exp,i)
            end
        end
    end
end

function expl(x,y,kol)
    for kek =0, kol do
        local Color1,Color2,Color3  = particlColor()
        local e = {
        flag  =false,-----new but old
        tip = 1,
        r = 0 ,
        color1 = Color1,--- old 
        color2= Color2,--- old 
        color3 =Color3,--- old 
        f = false,
        x  = x, 
        y =  y,  
        xx  = x, 
        yy =  y,
        ax  =math.random(-1.72*k*30,1.73*k*30), 
        ay = math.random(-1.73*k*30,1.73*k*30), 
        scale =0.15
        }
    table.insert(exp,e)
    end
end


function newWaveEffect(x,y)
    local waveEff =
    {
      x =x ,
      y =y, 
      r = 1*k,
      timer =  10,
      count =3,
    }
    table.insert(waveEffects,waveEff)
    for i = 1, math.random(1,3) do
        waveEff =
        {
          x =x+math.random(-50,50)*k ,
          y =y+math.random(-50,50)*k , 
          r = 0.1*k,
          timer =  5,
          count =3,
        }
        table.insert(waveEffects,waveEff)
    end
end
function waveEffect(dt)
    for i = #waveEffects,1, -1 do
        if ( waveEffects[i].timer > 0 ) then 
            love.graphics.setColor(0.6,1,1,waveEffects[i].timer/8)
            love.graphics.circle('line',waveEffects[i].x,waveEffects[i].y,waveEffects[i].r/2*waveEffects[i].count)
            love.graphics.circle('line',waveEffects[i].x,waveEffects[i].y,waveEffects[i].r/1.5*waveEffects[i].count)
            love.graphics.circle('line',waveEffects[i].x,waveEffects[i].y,waveEffects[i].r/1.2*waveEffects[i].count)
            love.graphics.circle('line',waveEffects[i].x,waveEffects[i].y,waveEffects[i].r*waveEffects[i].count)
            waveEffects[i].r = waveEffects[i].r + 30*k* dt
            waveEffects[i].timer  = waveEffects[i].timer - 30*dt
        else
           if (waveEffects[i].count >1 ) then
                waveEffects[i].count = waveEffects[i].count - 1 
                waveEffects[i].r = 0 *k 
                waveEffects[i].timer = 10
            else
                table.remove(waveEffects,i)  
            end
        end
        if ( waveEffects[i]) then 
            local IwaveRegulS =math.floor((waveEffects[i].x-40*k)/(80*k)) + math.floor((waveEffects[i].y-40*k2)/(80*k2))*math.floor((screenWidth/(80*k))+1)
            if (objRegulS[IobjRegulS]) then
                table.insert(waveRegulS[IwaveRegulS],i)
            else
                waveRegulS[IwaveRegulS] = {i}
            end
        end
    end
end

function newBloodEffect(self)
    if ( self~= nil) then 
        local bloodEff  ={
            en = self,
            timer = 10,
            timerTick = 10,
        }
    table.insert(bloodEffects,bloodEff)
    end
end

function bloodEffect(dt)
    for i = #bloodEffects,1, -1 do
        if ( bloodEffects[i].timer > 0 and  bloodEffects[i].en ~=nil ) then 
            if ( bloodEffects[i].timerTick == 10 and bloodEffects[i].en.health >0) then 
                bloodPartSpawn(bloodEffects[i].en,7)
                bloodEffects[i].en.health = bloodEffects[i].en.health - Player.damage*Player.Skills.Damage.damageK*dt*Player.Skills.SpecialAtack.Bloody.bloodAt/2 -- damage
                bloodEffects[i].en.ax = bloodEffects[i].en.ax*(1-Player.Skills.SpecialAtack.Bloody.bloodAt)
                bloodEffects[i].en.ay = bloodEffects[i].en.ay*(1-Player.Skills.SpecialAtack.Bloody.bloodAt)
            end
            bloodEffects[i].timerTick = bloodEffects[i].timerTick - 200*dt
            bloodEffects[i].timer =bloodEffects[i].timer - 5 * dt
            if ( bloodEffects[i].timerTick < 0 ) then 
                bloodEffects[i].timerTick = 10
            end
        else
            table.remove(bloodEffects,i)
        end
    end
    love.graphics.setColor(0.8,0,0,1) 
    for i = #bloodPart,1, -1 do
        if ( bloodPart[i] and  bloodPart[i].x~=nil) then 
            bloodPart[i].x= bloodPart[i].x+bloodPart[i].ax*dt*k
            bloodPart[i].y= bloodPart[i].y+bloodPart[i].ay*dt*k2
            if ( bloodPart[i].ax > 0 ) then
                bloodPart[i].ax  = bloodPart[i].ax -70*dt*k
            else
                bloodPart[i].ax  = bloodPart[i].ax + 70*dt*k
            end
            if ( bloodPart[i].ay > 0 ) then
                bloodPart[i].ay  = bloodPart[i].ay -70*dt*k2
            else
                bloodPart[i].ay  = bloodPart[i].ay + 70*dt*k2
            end
            love.graphics.rectangle("fill",bloodPart[i].x,bloodPart[i].y,bloodPart[i].scale*5*k,bloodPart[i].scale*5*k2,4)
            if ( (bloodPart[i].ay<3*k2 and  bloodPart[i].ay>-3*k2) or (bloodPart[i].ax<3*k and  bloodPart[i].ax>-3*k)) then
                table.remove(bloodPart,i)
            end
        else
            table.remove(bloodPart,i)
        end
    end
end


function bloodPartSpawn(self,kol)
    for kek =1, kol do
        local e = {
        x  = self.x, 
        y =  self.y,  
        ax  =math.random(-1.72*k*30,1.73*k*30), 
        ay = math.random(-1.73*k*30,1.73*k*30), 
        scale =math.random()
        }
        table.insert(bloodPart,e)
    end
end

function newDeffenseEffect(self)
    if ( self~= nil) then
        local deffenseEff  ={
            en = self,
            x = Player.x, 
            y = Player.y,
            speed =math.random(200,260)*k,
        }
        table.insert(deffenseEffects,deffenseEff)
    end 
end

function deffenseEffect(dt) 
    for i = #deffenseEffects,1, -1 do
        if ( deffenseEffects[i] and deffenseEffects[i].en ~= nil and deffenseEffects[i].en.health>0 ) then 
            love.graphics.setColor(0.27,0.80,0.63,1)
            love.graphics.circle('fill',deffenseEffects[i].x,deffenseEffects[i].y,3*k)
            local angle = math.atan2( deffenseEffects[i].en.x -  deffenseEffects[i].x, deffenseEffects[i].en.y -  deffenseEffects[i].y)
            
            
            love.graphics.circle('fill',deffenseEffects[i].x-deffenseEffects[i].speed*math.sin(angle)*0.04*math.random() *2,deffenseEffects[i].y-deffenseEffects[i].speed*math.cos(angle)*0.04*math.random()*2,1*k)
            love.graphics.circle('fill',deffenseEffects[i].x-deffenseEffects[i].speed*math.sin(angle)*0.02*math.random()*2 ,deffenseEffects[i].y-deffenseEffects[i].speed*math.cos(angle)*0.02*math.random()*2,2*k)
             
             
            deffenseEffects[i].x = deffenseEffects[i].x +deffenseEffects[i].speed*math.sin(angle)*dt 
            deffenseEffects[i].y = deffenseEffects[i].y +deffenseEffects[i].speed*math.cos(angle)*dt 
            if ( math.abs(deffenseEffects[i].en.x -  deffenseEffects[i].x) < 5*k and  math.abs(deffenseEffects[i].en.y -  deffenseEffects[i].y) < 5*k) then
                deffenseEffects[i].en.timer = deffenseEffects[i].en.invTimer/2
                deffenseEffects[i].en.health = deffenseEffects[i].en.health -  deffenseEffects[i].en.damage*Player.Skills.SpikeArmor.spike--skill
                table.remove(deffenseEffects,i)  
            end
        else
            table.remove(deffenseEffects,i)
        end
    end
end

function newVampirEffect(self)
    for i =1, math.random(3,5) do
        local masPoint = {
            10-0.00001, --timer
            10, --invTimer
            6, -- tip
            math.random(-1,1), --r
            0, -- color1
            1, -- color2
            0.67, -- color3
            self.x,--x
            self.y,--y
            math.random(-2*k,2*k2)*1.5,  --ax
            math.random(-2*k,2*k2)*1.5,  --ay
            {},
        }
        local resClone = resClass(unpack(masPoint))
        table.insert(res,resClone)
    end
end

function newGreenPlayerEffect()
   
      local greenEff =
      {
        x =math.random(-20*k,20*k2)*1.5, 
        y =math.random(-20*k,20*k2)*1.5,  
        scale = math.random()*7, 
        timer = 10,
      }
      table.insert(greenPlayerEffect,greenEff)
    
end

function greenPlayerEffectDraw(dt)
    love.graphics.setColor(0,1,0.67,1)
    love.graphics.setLineWidth(1.1*k)
              
    for i = #greenPlayerEffect,1,-1 do
        if ( greenPlayerEffect[i].timer > 0 ) then
            greenPlayerEffect[i].timer =  greenPlayerEffect[i].timer -30*dt
           
            greenPlayerEffect[i].scale = greenPlayerEffect[i].scale  +10*dt
             
            love.graphics.line(Player.x+ greenPlayerEffect[i].x,Player.y +  greenPlayerEffect[i].y-0.5*k*greenPlayerEffect[i].scale,Player.x+ greenPlayerEffect[i].x,Player.y +  greenPlayerEffect[i].y+0.5*k*greenPlayerEffect[i].scale)
          
            love.graphics.line(Player.x+ greenPlayerEffect[i].x-0.5*k*greenPlayerEffect[i].scale,Player.y +  greenPlayerEffect[i].y,Player.x+ greenPlayerEffect[i].x+0.5*k*greenPlayerEffect[i].scale,Player.y +  greenPlayerEffect[i].y)
        else
            greenPlayerEffect[i].scale = greenPlayerEffect[i].scale  -30*dt
            if ( greenPlayerEffect[i].scale < 0 ) then 
                table.remove(greenPlayerEffect,i)
            end
            if (  greenPlayerEffect[i]) then 
                love.graphics.line(Player.x+ greenPlayerEffect[i].x,Player.y +  greenPlayerEffect[i].y-0.5*k*greenPlayerEffect[i].scale,Player.x+ greenPlayerEffect[i].x,Player.y +  greenPlayerEffect[i].y+0.5*k*greenPlayerEffect[i].scale)
                love.graphics.line(Player.x+ greenPlayerEffect[i].x-0.5*k*greenPlayerEffect[i].scale,Player.y +  greenPlayerEffect[i].y,Player.x+ greenPlayerEffect[i].x+0.5*k*greenPlayerEffect[i].scale,Player.y +  greenPlayerEffect[i].y)
            end
        end
    end
end

function newTradeEffect()
    for i = 1 , 1 do 
        local tradeEff =
            {
                x =math.random()*k*math.random(-1,1)/1.3, 
                y =math.random()*k*math.random(-1,1)/1.3,  
                speed = math.random(),
                color1 =0.82,
                color2 =1,
                color3 = 0.59,
                timer = 10,
                trace = {},
            }
        table.insert(tradeEffects,tradeEff)  
    end
end

function tradeEffectDraw(dt)
    for i = #tradeEffects,1,-1 do
        if ( tradeEffects[i].timer > 0 ) then
            local trace = {
                x = tradeEffects[i].x,
                y= tradeEffects[i].y,
            }
            table.insert(tradeEffects[i].trace,trace)
            for j =#tradeEffects[i].trace,1,-1 do
                local sled = tradeEffects[i].trace
                love.graphics.setColor(tradeEffects[i].color1*tradeEffects[i].speed,tradeEffects[i].color2*tradeEffects[i].speed,tradeEffects[i].color3*tradeEffects[i].speed,0.25*j*tradeEffects[i].timer/10)
                love.graphics.circle('fill',Player.x+62*math.sin(-math.pi/2-math.pi/4.3)*k+ sled[j].x,Player.y+62*math.cos(-math.pi/2-math.pi/4.3)*k +  sled[j].y,1.2*k)    
            end
            if ( #tradeEffects[i].trace > 4) then 
                table.remove(tradeEffects[i].trace,1) 
            end
            love.graphics.setColor(tradeEffects[i].color1*tradeEffects[i].speed,tradeEffects[i].color2*tradeEffects[i].speed,tradeEffects[i].color3*tradeEffects[i].speed,tradeEffects[i].timer/10)
            
            local angle = math.atan2( -tradeEffects[i].x,-tradeEffects[i].y)+1.5
            tradeEffects[i].x = tradeEffects[i].x +80*math.sin(angle)*dt*k * (1+tradeEffects[i].speed)/3
            tradeEffects[i].y =tradeEffects[i].y +80*math.cos(angle)*dt*k * (1+tradeEffects[i].speed)/3
            
            love.graphics.circle('fill',Player.x+62*math.sin(-math.pi/2-math.pi/4.3)*k+tradeEffects[i].x,Player.y +62*math.cos(-math.pi/2-math.pi/4.3)*k+  tradeEffects[i].y,1.2*k)
            
            tradeEffects[i].timer =  tradeEffects[i].timer -4*dt  
        else
            table.remove(tradeEffects,i)
        end
    end
end

function newPlayerGetDamageEffect(x,y,kol)
    local angleEnPl = math.atan2(Player.x-x,Player.y-y)+math.pi 
    for kek =0, kol do
        local e = {
        color1 =Player.Color.colorR,
        color2= Player.Color.colorG,
        color3 =Player.Color.colorB,
        x = Player.x+(Player.scaleBody-5)*k*math.sin(angleEnPl), 
        y = Player.y+(Player.scaleBody-5)*k*math.cos(angleEnPl), 
        ax  =60*k*math.sin(angleEnPl+math.random()*1.6), 
        ay = 60*k*math.cos(angleEnPl+math.random()*1.6), 
        scale =math.random()*1.5,
        timer = 10,
        }
        table.insert(playerGerDamageEffect,e)
    end
end

function playerGetDamageEffect(dt)
    for i =#playerGerDamageEffect, 1,-1 do
        if( playerGerDamageEffect[i]) then
            if ( playerGerDamageEffect[i].timer>0) then 
                playerGerDamageEffect[i].timer = playerGerDamageEffect[i].timer - 20*dt
                playerGerDamageEffect[i].x= playerGerDamageEffect[i].x+playerGerDamageEffect[i].ax*dt*k
                playerGerDamageEffect[i].y= playerGerDamageEffect[i].y+playerGerDamageEffect[i].ay*dt*k2
                if ( playerGerDamageEffect[i].ax > 0 ) then
                    playerGerDamageEffect[i].ax  = playerGerDamageEffect[i].ax -70*dt*k
                else
                    playerGerDamageEffect[i].ax  = playerGerDamageEffect[i].ax + 70*dt*k
                end
                if ( playerGerDamageEffect[i].ay > 0 ) then
                    playerGerDamageEffect[i].ay  = playerGerDamageEffect[i].ay -70*dt*k2
                else
                    playerGerDamageEffect[i].ay  = playerGerDamageEffect[i].ay + 70*dt*k2
                end
                love.graphics.setColor(playerGerDamageEffect[i].color1,playerGerDamageEffect[i].color2,playerGerDamageEffect[i].color3,playerGerDamageEffect[i].timer/6)
                love.graphics.rectangle("fill",playerGerDamageEffect[i].x,playerGerDamageEffect[i].y,playerGerDamageEffect[i].scale*3*k,playerGerDamageEffect[i].scale*3*k2,4*k)
            else
                table.remove(playerGerDamageEffect,i)
            end
        end
    end  
end

function newStar()
    local star = {
        x = -borderWidth-200*k,
        y = math.random(-borderHeight,borderHeight*2),
        speed = math.random(1,3)/2+0.2,
        speedA = math.random(1,3),
        color = math.random()+0.4,
        angleFall =0.4+math.random(-1,1)*0.8,
        
    }
    star.x,star.y,speed = objGeo(math.random(1,4))
    table.insert(stars,star)
end

function drawStar(dt)
    love.graphics.setColor(0.8,0.9,0.9,0.5)
    for i =#stars, 1,-1 do
        stars[i].x = stars[i].x+stars[i].speed*dt*200*k*math.cos(stars[i].angleFall)*stars[i].speedA
        stars[i].y = stars[i].y+stars[i].speed*dt*200*k*math.sin(stars[i].angleFall)*stars[i].speedA
        stars[i].speedA = stars[i].speedA -0.5*dt
        if ( stars[i].speedA < 1 ) then 
            stars[i].speedA = 1
        end
        love.graphics.circle('fill',stars[i].x,stars[i].y,1.5*k)
        for j =1, 10 do 
            love.graphics.setColor(0.8/(1+j/6)*stars[i].color,0.9,0.9,(1*stars[i].speedA)/(1+j/6)*1)
            love.graphics.circle('fill',stars[i].x-j*1*k*math.cos(stars[i].angleFall),stars[i].y-j*1*k*math.sin(stars[i].angleFall),1.8*k/(1+j/4))
        end
        allBorder(i,stars)
    end
end



function gradient(dt)
    if (gradientI == 1 ) then
        gradientOp1(dt)
    end
    if (gradientI  == 2 ) then 
        gradientOp2(dt)
    end
    if (gradientI  == 3 ) then 
        gradientOp3(dt)
    end
    return gradientR+0.8,gradientG+0.8,gradientB+0.8
end
function gradientOp1(dt)
    if ( gradientR>0) then
        gradientR = gradientR - 0.4*dt
        gradientG = gradientG + 0.4*dt
    else
        gradientR = 0
        gradientG = 1
        gradientI = 2
    end
end
function gradientOp2(dt)
    if ( gradientG>0) then
        gradientG = gradientG - 0.4*dt
        gradientB = gradientB + 0.4*dt
    else
        gradientG = 0
        gradientB = 1
        gradientI = 3
    end
end
function gradientOp3(dt)
    if ( gradientB>0) then
        gradientB = gradientB - 0.4*dt
        gradientR = gradientR + 0.4*dt
    else
        gradientB = 0
        gradientR = 1
        gradientI = 1
    end
end

return effects
