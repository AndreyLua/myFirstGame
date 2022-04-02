local resFunction = {}

function spawnResCrackMet(i)
    for kV =1, math.random(3,obj[i].scale/20) do
        newPoint(obj,i,kV) 
    end
end

function spawnDelMet(i)
    for kV =1, math.random(3,obj[i].scale/5) do
        newPoint(obj,i,kV) 
        if ( math.random(-1,1) < 0) then
            newHealPoint(obj,i,kV) 
        else
            newBoostPoint(obj,i,kV) 
        end
    end
end

function spawnResHitEn(i)
    for kV =1, math.random(2,3) do
        newPoint(en,i,kV) 
    end
end
function spawnResKillEn(i)
    for kV =1, math.random(4,6) do
        newPoint(en,i,kV) 
    end
end

function newHealPoint(mas,i,kV) 
    if ( math.random(1,20)==1) then
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
function newBoostPoint(mas,i,kV) 
    if ( math.random(1,30)==1) then
        local masHPoint = {
            3-0.00001, --timer
            3, --invTimer
            5, -- tip
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

function resRemove(i)
    local kek = 0
    table.insert(res[i],kek)
    table.insert(removeEn,res[i])
    table.remove(res,i)
end 

function resAfterDie(dt)
    for i = #removeEn, 1, -1 do
        local h =  removeEn[i]
        if ( removeEn[i]) then
            if ( h.tip == 4 or h.tip == 5) then
                if ( h.tip == 4) then
                    love.graphics.setColor(1,0.1,0.1)
                    love.graphics.print("+HP",removeEn[i].x,removeEn[i].y,-math.pi/2,0.4*k)
                end
                if ( h.tip == 5) then
                    love.graphics.setColor(0.4,0.4,1)
                    love.graphics.print("+ENERGY",removeEn[i].x,removeEn[i].y,-math.pi/2,0.3*k)
                end
            else 
                if ( h.tip == 1 ) then
                    love.graphics.setColor(0.235,0.616,0.816,0.6)
                    love.graphics.print("+1",removeEn[i].x,removeEn[i].y,-math.pi/2,0.3*k)    
                end
                if ( h.tip == 2 ) then
                    love.graphics.setColor(0.514,0.941,0.235,0.6)
                    love.graphics.print("+3",removeEn[i].x,removeEn[i].y,-math.pi/2,0.35*k)    
                end
                if ( h.tip == 3 ) then
                    love.graphics.setColor(0.8,0.8,0.235,0.6)
                    love.graphics.print("+5",removeEn[i].x,removeEn[i].y,-math.pi/2,0.4*k)    
                end
            end
            h[#h] =  h[#h]+ 0.15*dt
            if (  h[#h]> 0.1) then
                table.remove(removeEn,i)
            end        
        end
    end
end

return resFunction