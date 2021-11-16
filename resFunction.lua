local resFunction = {}

function spawnResCrackMet(i)
    for kV =1, math.random(5,obj[i].scale/10) do
        newPoint(obj,i,kV) 
    end
end

function spawnDelMet(i)
    for kV =1, math.random(3,obj[i].scale/5) do
        newPoint(obj,i,kV) 
        newHealPoint(obj,i,kV) 
    end
end

function spawnResHitEn(i)
     for kV =1, math.random(2,3) do
        newPoint(en,i,kV) 
    end
end
function spawnResKillEn(i)
    for kV =1, math.random(5,9) do
        newPoint(en,i,kV) 
    end
end

function newHealPoint(mas,i,kV) 
    if ( math.random(1,30)==1) then
        local masHPoint = {
            3-0.00001, --timer
            3, --invTimer
            4, -- tip
            math.random(-3,3)*math.random(), --r
            1, -- color1
            1, -- color2
            1, -- color3
            mas[i].x,  --x
            mas[i].y,   --y
            math.random(-2*k*kV,2*k2*kV),  --ax
            math.random(-2*k*kV,2*k2*kV),  --ay
            {},
        }
        local resClone = resClass(unpack(masHPoint))
        table.insert(res,resClone)
    end
end
function newPoint(mas,i,kV) 
    local randomColor = math.random()
    local colorDop1 = mas[i].color1+ randomColor/3
    local colorDop2 = mas[i].color2+ randomColor/3
    local colorDop3 = mas[i].color3+ randomColor/3
    local RandomP =  math.random(100) 
    local RandomTip = 1
    if (mas == obj) then 
        if ( RandomP >90 and RandomP <100) then
            RandomTip = 2
        else
            if ( RandomP > 80) then 
                RandomTip = 3
            end
        end
    else
      if ( RandomP >90 and RandomP <100) then
          RandomTip = 2
      end
    end
    if (mas == obj) then 
        local masPoint = {
        3-0.00001, --timer
        3, --invTimer
        RandomTip, -- tip
        math.random(1,3), --r
        colorDop1, -- color1
        colorDop2, -- color2
        colorDop3, -- color3
        mas[i].x,  --x
        mas[i].y,   --y
        mas[i].ax/12 + math.random(-1.5*k*kV,1.5*k2*kV)/RandomTip,  --ax
        mas[i].ay/12+math.random(-1.5*k*kV,1.5*k2*kV)/RandomTip,  --ay
        {},
      }
        local resClone = resClass(unpack(masPoint))
        table.insert(res,resClone)
    else
        local masPoint = {
            10-0.00001, --timer
            10, --invTimer
            RandomTip, -- tip
            math.random(1,3), --r
            colorDop1, -- color1
            colorDop2, -- color2
            colorDop3, -- color3
            mas[i].x,  --x
            mas[i].y,   --y
            math.random(-2*k*kV,2*k2*kV)/RandomTip,  --ax
            math.random(-2*k*kV,2*k2*kV)/RandomTip,  --ay
            {},
        }
        local resClone = resClass(unpack(masPoint))
        table.insert(res,resClone)
    end
end

function resMove(i,dt)
 -- print(#resTraces)
   -- if ( resTraces[ш]) then
   ---   local trace = {
     -- -    x = res[i].x,
      ---    y = res[i].y, 
      --    }
      --    table.insert(resTraces[i],trace)
     --     if ( #resTraces[i] >2) then
    --          table.remove(resTraces[i],1)
     --     end
   -- else
    --    local traceBeg = 
--     -   {
    --        trace
    --    }
  --      table.insert(resTraces,i,traceBeg)
 --  end
    if (res[i].tip == 1) then
        res[i].x= res[i].x+res[i].ax*dt*5*k
        res[i].y= res[i].y+res[i].ay*dt*5*k2
    end
    if (res[i].tip == 2) then
        res[i].x= res[i].x+res[i].ax*dt*4*k
        res[i].y= res[i].y+res[i].ay*dt*4*k2
    end
    if (res[i].tip == 3) then
        res[i].x= res[i].x+res[i].ax*dt*2*k
        res[i].y= res[i].y+res[i].ay*dt*2*k2
    end
    if (res[i].tip == 4) then
        res[i].x= res[i].x+res[i].ax*dt*5*k
        res[i].y= res[i].y+res[i].ay*dt*5*k2
    end
    if ( res[i].ax > 0 ) then
        res[i].ax  = res[i].ax - 4*dt*k
    else
        res[i].ax  = res[i].ax + 4*dt*k
    end
    if ( res[i].ay > 0 ) then
        res[i].ay  = res[i].ay - 4*dt*k2
    else
        res[i].ay  = res[i].ay + 4*dt*k2
    end
    
    if ( res[i].timer < res[i].invTimer) then
        res[i].timer  = res[i].timer - dt* 40
    end
    if ( res[i].timer < 0) then
        res[i].timer  = res[i].invTimer
    end
end

function resColl(i)
    if ( player.a==0  ) then 
        if (res[i].timer == res[i].invTimer and (math.sqrt(math.pow((player.x-res[i].x),2)+math.pow((player.y-res[i].y),2))) < playerAbility.radiusCollect*k) then
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
    if (res[i].timer == res[i].invTimer and  checkCollision(player.x-20*k,player.y-20*k2, 40*k, 40*k2,res[i].x,res[i].y,1*k,1*k2)) then
        if ( res[i].tip == 4) then
            hp.long=hp.long+50*k2
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