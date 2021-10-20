local resFunction = {}

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