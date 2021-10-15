local enFunction = {}



function enTip(i,tip,t)
if ( tip == 1 ) then
   en[i].body =  HC.rectangle(en[i].x-8*k,en[i].y-1*k2,16*k,25*k2)
end
if ( tip == 2 ) then
   en[i].body =  HC.rectangle(en[i].x-6*k,en[i].y,16*k,16*k2)
end

end

function enMove(i,dt) 
    enTip(i,en[i].tip)
    
    if (en[i].ugol) then 
        en[i].body:rotate(-en[i].ugol,en[i].x,en[i].y) 
    end
    if ( en[i].tip == 1) then
        if ( en[i].invTimer and  en[i].invTimer == en[i].timer) then
        -----------------------------------------------  
            enRotAngle(i,en[i].tip,dt)
            local ugol = math.atan2(player.x-en[i].x+20*k,player.y-en[i].y+20*k)
          if (en[i].dash and en[i].dash==en[i].dashTimer) then
                enUgol(i,ugol,dt)
           end
            if ((math.sqrt(math.pow((player.x+40*k/2-en[i].x),2)+math.pow((player.y+40*k2/2-en[i].y),2))) > 30*k) then
                if (en[i].dash and en[i].dash==en[i].dashTimer) then
                    if not((math.abs(ugol) -  math.abs(en[i].ugol)) > 2.01*dt or (math.abs(ugol) -  math.abs(en[i].ugol)) <  -2.01*dt ) then
                        en[i].ax=22*k*math.sin(ugol)
                        en[i].ay=22*k2*math.cos(ugol)
                    end
                end
            end
            
            if (en[i].dash and en[i].dash==en[i].dashTimer and en[i].atack and en[i].atack==en[i].atackTimer and en[i].invTimer ==en[i].timer and (math.sqrt(math.pow((player.x+40*k/2-en[i].x),2)+math.pow((player.y+40*k2/2-en[i].y),2))) <=100*k ) then
                en[i].atack = en[i].atackTimer-0.001
                en[i].dash = en[i].dashTimer-0.001
            end
            
            if (en[i].dash and en[i].dash==en[i].dashTimer)  then
                if ((math.abs(ugol) -  math.abs(en[i].ugol)) > 2.01*dt or (math.abs(ugol) -  math.abs(en[i].ugol)) <  -2.01*dt ) then
                   en[i].x= en[i].x+en[i].ax*dt*0
                   en[i].y= en[i].y+en[i].ay*dt*0
                   en[i].ax = 0
                   en[i].ay = 0 
                else
                    en[i].x= en[i].x+en[i].ax*dt*7
                    en[i].y= en[i].y+en[i].ay*dt*7
                end
                 if not((math.abs(ugol) -  math.abs(en[i].ugol)) > 2.01*dt or (math.abs(ugol) -  math.abs(en[i].ugol)) <  -2.01*dt ) then
                en[i].x= en[i].x+math.sin(en[i].y/10)*dt*50
                en[i].y= en[i].y+math.cos(en[i].x/10)*dt*50
                end
            else
                en[i].x= en[i].x+en[i].ax*dt*17
                en[i].y= en[i].y+en[i].ay*dt*17
           end
        -----------------------------------------------  
        else
        -----------------------------------------------  
            if (en[i].ax>0)then
                en[i].ax =en[i].ax-50*dt
            else
                en[i].ax =en[i].ax+50*dt
            end
            if (en[i].ay>0)then
                en[i].ay =en[i].ay-50*dt
            else
                en[i].ay =en[i].ay+50*dt
            end
            en[i].x= en[i].x-en[i].ax*dt*3
            en[i].y= en[i].y-en[i].ay*dt*3
        -----------------------------------------------  
        end
    end
    if ( en[i].tip == 2) then
        if ( en[i].invTimer and  en[i].invTimer ==en[i].timer) then
        -----------------------------------------------------    
            if (en[i].atack and en[i].atack==en[i].atackTimer and en[i].invTimer ==en[i].timer and (math.sqrt(math.pow((player.x+40*k/2-en[i].x),2)+math.pow((player.y+40*k2/2-en[i].y),2))) <= 300*k ) then
                en[i].atack = en[i].atackTimer-0.001
                enFire(player.x+40*k/2,player.y+40*k2/2,en[i].x,en[i].y,en[i].ugol,en[i].damage)
            end
            enRotAngle(i,en[i].tip,dt)
            local ugol = math.atan2(player.x-en[i].x+20*k,player.y-en[i].y+20*k)
            enUgol(i,ugol,dt)
            if ((math.abs(ugol) -  math.abs(en[i].ugol)) > 2.01*dt or (math.abs(ugol) -  math.abs(en[i].ugol)) <  -2.01*dt ) then
                en[i].x= en[i].x+en[i].ax*dt*3
                en[i].y= en[i].y+en[i].ay*dt*3
            else
                en[i].x= en[i].x+en[i].ax*dt*7
                en[i].y= en[i].y+en[i].ay*dt*7
            end
            en[i].x= en[i].x+math.sin(en[i].y/7)*dt*50--!!!!!!!!!!!!
            en[i].y= en[i].y+math.cos(en[i].x/7)*dt*50--!!!!!!!!!!
        -----------------------------------------------------      
        else
        -----------------------------------------------------  
            if (en[i].ax>0)then
                en[i].ax =en[i].ax-50*dt
            else
                en[i].ax =en[i].ax+50*dt
            end
            if (en[i].ay>0)then
                en[i].ay =en[i].ay-50*dt
            else
                en[i].ay =en[i].ay+50*dt
            end
            en[i].x= en[i].x-en[i].ax*dt*3
            en[i].y= en[i].y-en[i].ay*dt*3
        -----------------------------------------------------  
        end
    end
    if ( en[i].tip == 3) then
      
    end   
    
end

function enColl(i, tip, a)
    if ( a == 1) then
        if (tip == 1) then 
            if ( en[i] and en[i].health and en[i].invTimer and  en[i].invTimer ==en[i].timer) then
                en[i].timer =  en[i].invTimer-0.001
                en[i].health  =  en[i].health - playerAbility.damage
                en[i].ax =en[i].ax - player.ax
                en[i].ay =en[i].ay -  player.ay
                enHit(en,i)
                
            end
        end
        if (tip == 2) then 
            if ( en[i] and en[i].health and en[i].invTimer and  en[i].invTimer ==en[i].timer) then
                en[i].timer =  en[i].invTimer-0.001
                en[i].health  =  en[i].health - playerAbility.damage
                en[i].ax =en[i].ax - player.ax
                en[i].ay =en[i].ay -  player.ay
                enHit(en,i)
            end
        end
    else
        if ( en[i].tip == 1) then
            if ( player.invis == 10 and  en[i] and en[i].health and en[i].atack  and en[i].invTimer ==en[i].timer ) then
                flaginv = false 
                shake = 2
                hp.long = hp.long - en[i].damage
                hp.long3  = hp.long
            end 
        end 
        if ( en[i].tip == 2) then
            if ( en[i] and en[i].health and en[i].invTimer and  en[i].invTimer ==en[i].timer) then
                en[i].timer =  en[i].invTimer-0.001
                en[i].health  =  en[i].health - playerAbility.damage/1.5
                en[i].ax =en[i].ax - player.ax
                en[i].ay =en[i].ay -  player.ay
                enHit(en,i)
            end  
        end
    end
end

function enHit(mas,i)
    for kek =0, math.random(7,8) do
        local eh = {
            tip = 1,
            r = math.random(0,3),
            flag =true,
            color1 =mas[i].color1+math.random()/4,
            color2= mas[i].color2+math.random()/4,
            color3 =mas[i].color3+math.random()/4,
            f = false,
            x  = mas[i].x, 
            y =  mas[i].y,  
            ax  =math.random(-2*k*kek,2*k*kek), 
            ay = math.random(-2*k*kek,2*k*kek), 
        }
        table.insert(res,eh)
    end
end
 
function enAtack(i,dt)
    if ( en[i] and en[i].atack) then
        if ( en[i].atack <  en[i].atackTimer) then
            en[i].atack  = en[i].atack  - 30*dt
        end
        if ( en[i].atack < 0) then
            en[i].atack  = en[i].atackTimer
        end
    end
    if ( en[i] and en[i].dash) then
        if ( en[i].dash <  en[i].dashTimer) then
            en[i].dash  = en[i].dash  - 30*dt
        end
        if ( en[i].dash < 0) then
            en[i].dash  = en[i].dashTimer
        end
    end
end
  
function enUgol(i,ugol,dt)
    if ( en[i].ugol == 0) then
        en[i].ugol=0.00000001
    end
    if ( en[i].ugol < -math.pi) then
        en[i].ugol=math.pi
    end
    if ( en[i].ugol > math.pi) then
        en[i].ugol=-math.pi
    end
    if ( ugol == 0) then
        ugol=0.00000001
    end
    if ((math.abs(ugol) -  math.abs(en[i].ugol)) > 2.01*dt or (math.abs(ugol) -  math.abs(en[i].ugol)) <  -2.01*dt ) then
        if (ugol/math.abs(ugol)==en[i].ugol/math.abs(en[i].ugol))then
            if ( ugol>en[i].ugol) then
                en[i].ugol = en[i].ugol+4*dt
            else 
                en[i].ugol = en[i].ugol-4*dt
            end
        else
            if (math.abs(ugol)+math.abs(en[i].ugol)> 2*math.pi - math.abs(ugol)-math.abs(en[i].ugol)) then
                if (en[i].ugol>0) then 
                    en[i].ugol = en[i].ugol+4*dt
                else
                    en[i].ugol = en[i].ugol-4*dt
                end
            else 
                if (en[i].ugol>0) then 
                    en[i].ugol = en[i].ugol-4*dt
                else
                    en[i].ugol = en[i].ugol+4*dt
                end
            end
        end
    end
end

function enRotAngle(i,tip,dt)
    if (tip == 1 ) then
        if ( en[i] and en[i].r) then
            if ( en[i].r> 0.1 ) then
                en[i].flagr = 1 
            end
            if ( en[i].r< 0 ) then
                en[i].flagr = 0 
            end
            if ( en[i].flagr ==0) then
                en[i].r = en[i].r+1.1*dt*math.random(5,10)/7
            else
                en[i].r = en[i].r-1.1*dt*math.random(5,10)/7
            end
        end
    end
    
    if (tip == 2 ) then
        if ( en[i] and en[i].r) then
            if ( en[i].r> 0.22 ) then
                en[i].flagr = 1 
            end
            if ( en[i].r< 0 ) then
                en[i].flagr = 0 
            end
            if ( en[i].flagr ==0) then
                en[i].r = en[i].r+1*dt*math.random(5,10)/7
            else
                en[i].r = en[i].r-1*dt*math.random(5,10)/7
            end
        end 
    end
end

function enFire(x,y,x2,y2,angleEn,damage)
    local ugol = math.atan2(x-x2,y-y2)
    bullet = {
        x = x2 + 25*k*math.sin(angleEn),
        y = y2 + 25*k2*math.cos(angleEn),
        ax = 22*k*math.sin(ugol),
        ay = 22*k2*math.cos(ugol),
        damage = damage
    }
    table.insert(enemyBullets,bullet)
end
function enemiesSledDraw(dt)
    for i = 1, #slediEn do
        for j = 1, #slediEn[i] do
            local kkk = slediEn[i]
            if (kkk[j].tip == 1 ) then
                local radius =kkk[j].r/4*j
                kkk[j].x = kkk[j].x+50*kkk[j].ax*dt
                kkk[j].y = kkk[j].y+50*kkk[j].ay*dt
                love.graphics.setColor(kkk[j].color1*j,kkk[j].color2*j,kkk[j].color3*j) 
                love.graphics.circle("fill",kkk[j].x+radius,kkk[j].y+radius,radius)
            else
                if (kkk[j].tip == 2 ) then
                    local radius =kkk[j].r/1.3
                    kkk[j].x = kkk[j].x+40*kkk[j].ax*dt
                    kkk[j].y = kkk[j].y+40*kkk[j].ay*dt
                    love.graphics.setColor(kkk[j].color1*j,kkk[j].color2*j,kkk[j].color3*j) 
                    love.graphics.circle("fill", kkk[j].x+math.cos(kkk[j].y)+radius+1*k*math.sin(kkk[j].angle-math.pi/2) ,kkk[j].y+math.sin(kkk[j].x)+radius +1*k2*math.cos(kkk[j].angle-math.pi/2),radius)
                    love.graphics.circle("fill", kkk[j].x+math.sin(kkk[j].y)+radius+1*k*math.sin(kkk[j].angle+math.pi/2) ,kkk[j].y+math.cos(kkk[j].x)+radius +1*k2*math.cos(kkk[j].angle+math.pi/2),radius)
                end
            end
        end
        if ( #slediEn[i] >5) then
           table.remove(slediEn[i],1)
        end
    end
end

function enemySled(x,y,r,i,color1,color2,color3,angle,tip)
    local sledEn = {
        angle = angle,
        tip = tip,
        ax =-2*k*math.sin(angle) ,
        ay =-2*k2*math.cos(angle),
        x = x ,
        y = y , 
        r = r ,
        color1 = color1,
        color2 = color2,
        color3 = color3,
    }
    if ( slediEn[i]) then
        table.insert(slediEn[i],sledEn)
    else
        local ii = {}
        slediEn[i] = ii
        table.insert(slediEn[i],sledEn)
    end
end

function enRemoveTag(dt)
    for i=1,#removeEn do
        local h =  removeEn[i]
        if ( removeEn[i]) then
            if ( h.tip == 4 ) then
                love.graphics.setColor(1,0.1,0.1)
                love.graphics.print("+HP",removeEn[i].x,removeEn[i].y,-math.pi/2,0.4)  
            else 
                if ( h.tip == 1 ) then
                    love.graphics.setColor(0.235,0.616,0.816,0.6)
                    love.graphics.print("+1",removeEn[i].x,removeEn[i].y,-math.pi/2,0.2)    
                end
                if ( h.tip == 2 ) then
                    love.graphics.setColor(0.514,0.941,0.235,0.6)
                    love.graphics.print("+3",removeEn[i].x,removeEn[i].y,-math.pi/2,0.3)    
                end
                if ( h.tip == 3 ) then
                    love.graphics.setColor(0.549,0.427,0.843,0.6)
                    love.graphics.print("+5",removeEn[i].x,removeEn[i].y,-math.pi/2,0.4)    
                end
            end
            h[#h] =  h[#h]+ 0.15*dt
            if (  h[#h]> 0.1) then
                table.remove(removeEn,i)
            end        
        end
    end
end

return enFunction