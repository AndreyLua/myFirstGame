local resourceFunction = {}

local resourceSmallClass =  require "scripts/resourcesGameObject/resourceSmallClass" 
local resourceNormalClass =  require "scripts/resourcesGameObject/resourceNormalClass" 
local resourceBigClass =  require "scripts/resourcesGameObject/resourceBigClass" 
local resourceHpClass =  require "scripts/resourcesGameObject/resourceHpClass" 
local resourceEnergyClass =  require "scripts/resourcesGameObject/resourceEnergyClass" 

function spawnResourceCrackMet(i)
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

function spawnResourceHitEn(i)
    for kV =1, math.random(2,3) do
        newPoint(en,i,kV) 
    end
end

function spawnResourceKillEn(i)
    for kV =1, math.random(4,6) do
        newPoint(en,i,kV) 
    end
end

function newHealPoint(mas,i,kV) 
    if ( math.random(1,20)==1) then
        local masHpPoint = {
            3-0.0001, --timer
            3, --invTimer
            math.random(-3,3)*math.random(), --angle
            1, -- colorR
            1, -- colorG
            1, -- colorB
            mas[i].x,  --x
            mas[i].y,   --y
            math.random(-2*k*kV,2*k2*kV),  --ax
            math.random(-2*k*kV,2*k2*kV),  --ay
        }
        local resourceClone = ResourceHp(unpack(masHpPoint))
        table.insert(resource,resourceClone)
    end
end

function newBoostPoint(mas,i,kV) 
    if ( math.random(1,30)==1) then
        local masEnergyPoint = {
            3-0.0001, --timer
            3, --invTimer
            math.random(-3,3)*math.random(), --angle
            1, -- colorR
            1, -- colorG
            1, -- colorB
            mas[i].x,  --x
            mas[i].y,   --y
            math.random(-2*k*kV,2*k2*kV),  --ax
            math.random(-2*k*kV,2*k2*kV),  --ay
        }
        local resourceClone = ResourceEnergy(unpack(masEnergyPoint))
        table.insert(resource,resourceClone)
    end
end

function newPoint(mas,i,kV) 
    local size = randomSizePoint(mas)
    newResource(mas,i,kV,size)
end

function resourceRemove(i)
    table.insert(resourcesReceiveText,resource[i])
    table.remove(resource,i)
end 

function randomSizePoint(mas)
    local RandomP =  math.random(100)
    if (mas == obj) then 
        if ( RandomP >90) then
            return'normal'
        else
            if ( RandomP > 80) then 
                return 'big'
            else
                return 'small'
            end
        end
    else
        if ( RandomP >90 ) then
            return 'normal'
        else
            return 'small'
        end
    end
end

function newResource(mas,i,kV,size)
    local randomColor = math.random()
    local colorR = mas[i].color1+ randomColor/3
    local colorG = mas[i].color2+ randomColor/3
    local colorB = mas[i].color3+ randomColor/3
    
    local resourcePar = {
        3-0.0001, --timer
        3, --invTimer
        math.random(1,3), --angle
        colorR, -- colorR
        colorG, -- colorG
        colorB, -- colorB
        mas[i].x,  --x
        mas[i].y,   --y
        mas[i].ax/12 + math.random(-1.5*k*kV,1.5*k2*kV)/1,  --ax
        mas[i].ay/12+math.random(-1.5*k*kV,1.5*k2*kV)/1,  --ay
    }
    if ( mas == en) then
        resourcePar[1] = 10 - 0.0001
        resourcePar[2] = 10
    end
    
    if (size == 'small') then
        table.insert(resource,ResourceSmall(unpack(resourcePar)))
    elseif (size == 'normal') then
        table.insert(resource,ResourceNormal(unpack(resourcePar)))
    elseif (size == 'big') then 
        table.insert(resource,ResourceBig(unpack(resourcePar)))
    end
  
end

function resourceAfterDie(dt)
    for i = #resourcesReceiveText, 1, -1 do
        local resource =  resourcesReceiveText[i]
        resource:drawReceiveText() 
        resource:updateTimerReceiveText(dt) 
        if ( resource.timerReceiveText<0) then
            table.remove(resourcesReceiveText,i)
        end 
    end
end

return resourceFunction