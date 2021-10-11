local resFunction = {}

function resMove(i)
    if (res[i].tip == 1) then
        res[i].x= res[i].x+res[i].ax*dt2*10
        res[i].y= res[i].y+res[i].ay*dt2*10
    end
    if (res[i].tip == 2) then
        res[i].x= res[i].x+res[i].ax*dt2*7
        res[i].y= res[i].y+res[i].ay*dt2*7
    end
    if (res[i].tip == 3) then
        res[i].x= res[i].x+res[i].ax*dt2*5
        res[i].y= res[i].y+res[i].ay*dt2*5
    end
    if (res[i].tip == 4) then
        res[i].x= res[i].x+res[i].ax*dt2*10
        res[i].y= res[i].y+res[i].ay*dt2*10
    end  
    if ( res[i].ax > 0 ) then
        res[i].ax  = res[i].ax - 6*dt2
    else
        res[i].ax  = res[i].ax + 6*dt2
    end
    if ( res[i].ay > 0 ) then
        res[i].ay  = res[i].ay - 6*dt2
    else
        res[i].ay  = res[i].ay + 6*dt2
    end
      
end

function resColl(i)
        if ( player.a==0  ) then 
            if ((math.sqrt(math.pow((player.x+40*k/2-res[i].x),2)+math.pow((player.y-res[i].y),2))) < playerAbility.radiusCollect*k) then
                local x1 = (player.x+40/2*k)-res[i].x+1*k
                local y1 = (player.y)-res[i].y+1*k2          
                local ugol = math.atan2(x1,y1)
                if (  math.abs(controler.angle - ugol)>math.pi) then
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
end

function resСollect(i)
    if ( checkCollision(player.x,player.y, 40*k, 40*k2,res[i].x,res[i].y,1*k,1*k2)) then
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


return resFunction