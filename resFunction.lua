local resFunction = {}


function spawnResBig(mas,i)
    local Wave = waves[numberWave]
    colWave = colWave-1
    expl(50*k,screenHeight/2-(colWave*300*k2/Wave[4])/2,10)
    expl(50*k,screenHeight/2-(colWave*300*k2/Wave[4])/2+colWave*300*k2/Wave[4],10)
    
    for kek =0, math.random(8,15)  do
        local kkek = math.random()
        local colorDop1 = mas[i].color1+ kkek/3
        local colorDop2 = mas[i].color2+ kkek/3
        local colorDop3 = mas[i].color3+ kkek/3
        if ( math.random(1,30)==1) then
            local eh = {
                tip = 4, --hp
                r = 0,
                flag =true,
                color1 =colorDop1,
                color2=colorDop2,
                color3 =colorDop3,
                f = false,
                x  = mas[i].x, 
                y =  mas[i].y,  
                ax  =math.random(-2*k*kek,2*k*kek), 
                ay = math.random(-2*k*kek,2*k*kek), 
            }
            table.insert(res,eh)
        else
            local RandomP =  math.random(100) 
            local RandomTip = 1
            if ( RandomP >80 and RandomP <90) then
                RandomTip = 2
            else
                  if ( RandomP > 80) then 
                      RandomTip = 3
                  end
            end
            
            local eh = {
                tip = RandomTip,
                r = math.random(1,3),
                flag =true,
                color1 =colorDop1,
                color2= colorDop2,
                color3 =colorDop3,
                f = false,
                x  = mas[i].x, 
                y =  mas[i].y,  
                ax  =math.random(-1.5*k*kek,1.5*k*kek)/RandomTip, 
                ay = math.random(-1.5*k*kek,1.5*k*kek)/RandomTip, 
            }
            table.insert(res,eh)
        end
    end
end

function spawnResNormal(mas,i)
    for kek =0, math.random(7,8) do
        local RandomP =  math.random(100) 
        local RandomTip = 1
        if ( RandomP >80 and RandomP <90) then
            RandomTip = 2
        end
        
        local eh = {
            tip = RandomTip,
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

function spawnResSmall(mas,i)
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

function resMove(i,dt)
    if (res[i].tip == 1) then
        res[i].x= res[i].x+res[i].ax*dt*10
        res[i].y= res[i].y+res[i].ay*dt*10
    end
    if (res[i].tip == 2) then
        res[i].x= res[i].x+res[i].ax*dt*7
        res[i].y= res[i].y+res[i].ay*dt*7
    end
    if (res[i].tip == 3) then
        res[i].x= res[i].x+res[i].ax*dt*5
        res[i].y= res[i].y+res[i].ay*dt*5
    end
    if (res[i].tip == 4) then
        res[i].x= res[i].x+res[i].ax*dt*10
        res[i].y= res[i].y+res[i].ay*dt*10
    end  
    if ( res[i].ax > 0 ) then
        res[i].ax  = res[i].ax - 6*dt
    else
        res[i].ax  = res[i].ax + 6*dt
    end
    if ( res[i].ay > 0 ) then
        res[i].ay  = res[i].ay - 6*dt
    else
        res[i].ay  = res[i].ay + 6*dt
    end
      
end

function resColl(i)
        if ( player.a==0  ) then 
            if ((math.sqrt(math.pow((player.x-res[i].x),2)+math.pow((player.y-res[i].y),2))) < playerAbility.radiusCollect*k) then
                local x1 = (player.x)-res[i].x+1*k
                local y1 = (player.y)-res[i].y+1*k2          
                local ugol = math.atan2(x1,y1)
             
                    player.clowRflag =3
                    if ( res[i].ax> 17*k*math.sin(ugol)) then
                        res[i].ax = res[i].ax - 2*k 
                    else
                        res[i].ax = res[i].ax + 2*k 
                    end
                    if ( res[i].ay> 17*k2*math.cos(ugol)) then
                        res[i].ay = res[i].ay - 2*k2
                    else
                        res[i].ay = res[i].ay + 2*k2 
                    end
               
            end
        end
end

function resСollect(i)
    if ( checkCollision(player.x-20*k,player.y-20*k2, 40*k, 40*k2,res[i].x,res[i].y,1*k,1*k2)) then
        if ( res[i].tip == 4) then
            hp.long3=hp.long3+50*k2
            resRemove(i,res)
        else
            score = score +1
            resRemove(i,res)
        end
    end
end

function resRemove(i,mas)
    local kek = 0
    table.insert(mas[i],kek)
    table.insert(removeEn,mas[i])
    table.remove(mas,i)
end 

function resBorder(i,mas)
    --------------------------------------------------
    if ( mas[i]) then
        if ( mas[i].x > screenWidth*2) then 
            mas[i].ax = -mas[i].ax
            mas[i].x =screenWidth*2 - 0.1*k
        end
        if ( mas[i].x <  -screenWidth) then 
            mas[i].ax = -mas[i].ax
            mas[i].x = -screenWidth + 0.1*k
        end
        if ( mas[i].y < -screenHeight) then 
            mas[i].ay = -mas[i].ay
            mas[i].y = -screenHeight+0.1*k2
        end
        if ( mas[i].y > screenHeight*2) then 
            mas[i].ay = -mas[i].ay
            mas[i].y = screenHeight*2 - 0.1*k2
        end
        if ( mas[i].x > screenWidth*2 or mas[i].x < -screenWidth or mas[i].y < -screenHeight or  mas[i].y > screenHeight*2 ) then
           table.remove(mas,i)
        end
    end
end

return resFunction