local effects = {}


function light(x1,y1,x2,y2,i)
    local length = math.sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1))
    local m = {x1,y1}
    local masKof = {}
    local x =0
    local y = 0
    local aye = 5 -- ширина разброса 
    local ran =math.random(-length/aye,length/aye)
    local angle =3.14-math.atan2((x2-x1),(y2-y1))
    x =x1+(x2-x1)/2+math.cos(angle)*ran
    y =y1+(y2-y1)/2+math.sin(angle)*ran
    local m1 = pol(x1,y1,x,y,i)
    for  i=1,#m1 do
        table.insert(m,m1[i])
    end
    table.insert(m,x)
    table.insert(m,y)
    m1 = pol(x,y,x2,y2,i)
    for  i=1,#m1 do
        table.insert(m,m1[i])
    end
    table.insert(m,x2)
    table.insert(m,y2)
    return m
end
function pol(x1,y1,x2,y2,i) 
    local aye = 5 -- ширина разброса 
    local masKofPol = {}
    local length = math.sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1))
    local ran =math.random(-length/aye,length/aye)
    local angle =3.14-math.atan2((x2-x1),(y2-y1))
    local x =x1+(x2-x1)/2+math.cos(angle)*ran
    local y =y1+(y2-y1)/2+math.sin(angle)*ran
    local m1 = {}
    if ( i>0 and i~=0 ) then
        local m2 = pol(x1,y1,x,y,i-1)
        for  i=1,#m2 do
            table.insert(m1,m2[i])
        end
    end
    table.insert(m1,x)
    table.insert(m1,y)
    if ( i>0) then
        local m2 = light(x,y,x2,y2,i-1)
        for  i=1,#m2 do
            table.insert(m1,m2[i])
        end
    end
    if ( i>0) then
        local m2 = pol(x,y,x2,y2,i-1)
        for  i=1,#m2 do
            table.insert(m1,m2[i])
        end
    end
    return m1
end

function light2(x1,y1,x2,y2,i)
    local length = math.sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1))
    local m = {x1,y1}
    local x =0
    local y = 0
    local aye = 4 -- ширина разброса 
    local ran =math.random(-length/aye,length/aye)
    local angle =3.14-math.atan2((x2-x1),(y2-y1))
    x =x1+(x2-x1)/2+math.cos(angle)*ran
    y =y1+(y2-y1)/2+math.sin(angle)*ran
    local m1 = pol2(x1,y1,x,y,i)
    for  i=1,#m1 do
        table.insert(m,m1[i])
    end
    table.insert(m,x)
    table.insert(m,y)
    m1 = pol2(x,y,x2,y2,i)
    for  i=1,#m1 do
        table.insert(m,m1[i])
    end
    table.insert(m,x2)
    table.insert(m,y2)
    return m
end

function pol2(x1,y1,x2,y2,i) 
    local aye = 5 -- ширина разброса 
    local length = math.sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1))
    local ran =math.random(-length/aye,length/aye)
    local angle =3.14-math.atan2((x2-x1),(y2-y1))
    local x =x1+(x2-x1)/2+math.cos(angle)*ran
    local y =y1+(y2-y1)/2+math.sin(angle)*ran
    local m1 = {}
    table.insert(m1,x)
    table.insert(m1,y)
    return m1
end

function lightDesh(x1,y1,x2,y2,i,mas)
    local length = math.sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1))
    local m = {x1,y1}
    local aye = 4 -- ширина разброса 
    local ran =mas[1]
    local angle =3.14-math.atan2((x2-x1),(y2-y1))
    local x =x1+(x2-x1)/2+math.cos(angle)*ran
    local y =y1+(y2-y1)/2+math.sin(angle)*ran
    local m1= polDesh(x1,y1,x,y,i,2,mas)
    for  i=1,#m1 do
        table.insert(m,m1[i])
    end
    table.insert(m,x)
    table.insert(m,y)
    m1 = polDesh(x,y,x2,y2,i,2+#m1/2,mas)
    for  i=1,#m1 do
        table.insert(m,m1[i])
    end
    table.insert(m,x2)
    table.insert(m,y2)
    return m
end

function polDesh(x1,y1,x2,y2,i,masI,mas) 
    local aye = 5 -- ширина разброса 
    local length = math.sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1))
    local ran =mas[masI]
    local angle =3.14-math.atan2((x2-x1),(y2-y1))
    local x =x1+(x2-x1)/2+math.cos(angle)*ran
    local y =y1+(y2-y1)/2+math.sin(angle)*ran
    local m1 = {}
    local m2 = {}
    local m3 = {}
    if ( i>0 and i~=0 ) then
        m2 = polDesh(x1,y1,x,y,i-1,masI+1,mas)
        for  i=1,#m2 do
            table.insert(m1,m2[i])
        end
    end
    table.insert(m1,x)
    table.insert(m1,y)
    if ( i>0) then
        m3 = polDesh(x,y,x2,y2,i-1,masI+1+#m2/2,mas)
        for  i=1,#m2 do
            table.insert(m1,m3[i])
        end
    end
    return m1
end

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
            if ( math.random(1,3) == 1  )then 
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
                bloodEffects[i].en.health = bloodEffects[i].en.health - playerAbility.damage*playerSkillParametrs.damageK*dt*playerSkillParametrs.bloodAt -- damage
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
            x = player.x, 
            y = player.y,
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
                deffenseEffects[i].en.health = deffenseEffects[i].en.health -  deffenseEffects[i].en.damage*playerSkillParametrs.spike--skill
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
             
            love.graphics.line(player.x+ greenPlayerEffect[i].x,player.y +  greenPlayerEffect[i].y-0.5*k*greenPlayerEffect[i].scale,player.x+ greenPlayerEffect[i].x,player.y +  greenPlayerEffect[i].y+0.5*k*greenPlayerEffect[i].scale)
          
            love.graphics.line(player.x+ greenPlayerEffect[i].x-0.5*k*greenPlayerEffect[i].scale,player.y +  greenPlayerEffect[i].y,player.x+ greenPlayerEffect[i].x+0.5*k*greenPlayerEffect[i].scale,player.y +  greenPlayerEffect[i].y)
        else
            greenPlayerEffect[i].scale = greenPlayerEffect[i].scale  -30*dt
            if ( greenPlayerEffect[i].scale < 0 ) then 
                table.remove(greenPlayerEffect,i)
            end
            if (  greenPlayerEffect[i]) then 
                love.graphics.line(player.x+ greenPlayerEffect[i].x,player.y +  greenPlayerEffect[i].y-0.5*k*greenPlayerEffect[i].scale,player.x+ greenPlayerEffect[i].x,player.y +  greenPlayerEffect[i].y+0.5*k*greenPlayerEffect[i].scale)
                love.graphics.line(player.x+ greenPlayerEffect[i].x-0.5*k*greenPlayerEffect[i].scale,player.y +  greenPlayerEffect[i].y,player.x+ greenPlayerEffect[i].x+0.5*k*greenPlayerEffect[i].scale,player.y +  greenPlayerEffect[i].y)
            end
        end
    end
end

function newTradeEffect()
    for i = 1 , math.random(4,7) do 
        local tradeEff =
            {
                x =math.random(-20*k,20*k2)*1.7, 
                y =math.random(-20*k,20*k2)*1.7,  
                timer = 10,
            }
        table.insert(tradeEffects,tradeEff)  
    end
end

function tradeEffectDraw(dt)
    love.graphics.setColor(1,1,0.2,1)
    for i = #tradeEffects,1,-1 do
        if ( tradeEffects[i].timer > 0 ) then
            local angle = math.atan2( -tradeEffects[i].x,-tradeEffects[i].y)+1.5
            tradeEffects[i].x = tradeEffects[i].x +300*math.sin(angle)*dt 
            tradeEffects[i].y =tradeEffects[i].y +300*math.cos(angle)*dt 
            love.graphics.circle('fill',player.x+ tradeEffects[i].x,player.y +  tradeEffects[i].y,1.8*k)
            tradeEffects[i].timer =  tradeEffects[i].timer -4*dt  
            if ( math.abs(tradeEffects[i].x) < 5*k and math.abs(tradeEffects[i].y) < 5*k) then
                table.remove(tradeEffects,i) 
            end
        else
            table.remove(tradeEffects,i)
        end
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
