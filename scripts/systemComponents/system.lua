local system = {}

function checkCollision(x1,y1,w1,h1, x2,y2,w2,h2)
    return 
        x1 < x2+w2 and x2 < x1+w1 and
        y1 < y2+h2 and y2 < y1+h1
end


function round(number)
  if (number - (number % 0.1)) - (number - (number % 1)) < 0.5 then
      number = number - (number % 1)
  else
      number = (number - (number % 1)) + 1
  end
  return number
end

function angleRotateToAngle2 (dt,angle,angle2,speed) 
    if ( angle2 == 0) then
        angle2=0.00000001
    end
    if ( angle2 < -math.pi) then
        angle2=math.pi
    end
    if ( angle2 > math.pi) then
        angle2=-math.pi
    end
    if ( angle == 0) then
        angle=0.00000001
    end
    if ((angle -  angle2 > 2.1*dt) or (angle -  angle2) <  -2.1*dt ) then
        if (angle/math.abs(angle)==angle2/math.abs(angle2))then
            if ( angle>angle2) then
                angle2 = angle2+speed*dt
            else 
                angle2 = angle2-speed*dt
            end
        else
            if (math.abs(angle)+math.abs(angle2)> 2*math.pi - math.abs(angle)-math.abs(angle2)) then
                if (angle2>0) then 
                    angle2 = angle2+speed*dt
                else
                    angle2 = angle2-speed*dt
                end
            else 
                if (angle2>0) then 
                    angle2 = angle2-speed*dt
                else
                    angle2 = angle2+speed*dt
                end
            end
        end
    end
    return angle2
end

function tableСopy(t)
  local t2 = {}
  for k,v in pairs(t) do
    t2[k] = v
  end
  return t2
end

function random(min,max)
  local min,max = min or 0, max or 1
  return (min > max and (love.math.random()*(min -max)+max)) or (love.math.random()*(max-min)+min)
end

function rot(mode,x,y,w,h,rx,ry,segments,r,ox,oy)
  if not oy and rx then r,ox,oy = rx,ry, segments end
  r = r or 0 
  ox = ox or w/2
  oy = oy or h/2
  love.graphics.push()
  love.graphics.translate( x + ox,y + oy )
  love.graphics.push()
  love.graphics.rotate(-r)
  love.graphics.rectangle(mode,-ox,-oy,w,h,rx,ry,segments)
  love.graphics.pop()
  love.graphics.pop()
end

function EnFront(en) 
    local flagAt = false
    local anglePlEn =  math.atan2(Player.x-en.x, Player.y-en.y) 
    if (anglePlEn/math.abs(anglePlEn)==en.angleBody/math.abs(en.angleBody))then
        if (math.abs(math.abs(anglePlEn) - math.abs(en.angleBody)) <  math.pi/4) then 
            flagAt = true
        end
    else
        if (math.abs(anglePlEn)+math.abs(en.angleBody)> 2*math.pi - math.abs(anglePlEn)-math.abs(en.angleBody)) then
            if ((2*math.pi - math.abs(anglePlEn)-math.abs(en.angleBody)) <  math.pi/4) then 
                flagAt = true
            end
        else 
            if ((math.abs(anglePlEn)+math.abs(en.angleBody)) <  math.pi/4) then 
                flagAt = true
            end
        end
    end
    return flagAt
end


function checkCircle(x,y,scale1,scale2,x2,y2,r)
    if ( (math.sqrt((x-r-x2)*(x-r-x2)+(y-r-y2)*(y-r-y2))<r) or (math.sqrt((x-r+scale1*40*k-x2)*(x-r+scale1*40*k-x2)+(y-r-y2)*(y-r-y2))<r) or (math.sqrt((x-r-x2)*(x-r-x2)+(y-r+scale2*40*k2-y2)*(y-r+scale2*40*k2-y2))<r) or (math.sqrt((x-r+scale1*40*k-x2)*(x-r+scale1*40*k-x2)+(y-r+scale2*40*k2-y2)*(y-r+scale2*40*k2-y2))<r) ) then
        return true
    else
        return false
    end
end

function particlColor() 
    local randomNumber = math.random(1,5)
    
    if ( randomNumber ==  1 ) then 
        return 0.008,0.298,0.408
    end 
    if ( randomNumber ==  2 ) then 
        return 0.133,0.376,0.471
    end 
    if ( randomNumber ==  3 ) then 
        return 0.027,0.463,0.627
    end 
    if ( randomNumber ==  4 ) then 
        return 0.227,0.651,0.816
    end 
    if ( randomNumber == 5 ) then 
        return 0.384,0.694,0.816
    end 
end

function lvlParametrs()
    for i =1, #playerSkills do 
        local masSkill = playerSkills[i] 
        ----------------------------------------------------------------------------
        if (masSkill.numb == 1 ) then 
            playerSkillParametrs.hpK =0.02*(masSkill.lvl-1)
        end
        if (masSkill.numb == 2 ) then 
            playerSkillParametrs.enK =0.02*(masSkill.lvl-1)
        end
        if (masSkill.numb == 3 ) then 
            playerSkillParametrs.meleeDefK=0.02*(masSkill.lvl-1)
        end
        if (masSkill.numb == 4 ) then 
            playerSkillParametrs.rangeDefK=0.02*(masSkill.lvl-1)
        end
        if (masSkill.numb == 5 ) then 
            playerSkillParametrs.damageK =1+0.03*(masSkill.lvl-1)
        end
        if (masSkill.numb == 6 ) then 
            playerSkillParametrs.speedK =1+0.015*(masSkill.lvl-1)
        end
        if (masSkill.numb == 7 ) then 
            playerSkillParametrs.collectRangeK =1+0.02*(masSkill.lvl-1)
        end
        ----------------------------------------------------------------------------
        if (masSkill.numb == 8 ) then 
            playerSkillParametrs.waveAt =0.02*(masSkill.lvl-1)
        end
        if (masSkill.numb == 9 ) then 
            playerSkillParametrs.bloodAt =0.02*(masSkill.lvl-1)
        end
        if (masSkill.numb == 10 ) then 
            playerSkillParametrs.sealAt =0.04*(masSkill.lvl-1)
        end
        if (masSkill.numb == 11 ) then 
            playerSkillParametrs.spikeFlag = true
            playerSkillParametrs.spike =0.01*math.log(masSkill.lvl,2)
        end
        ----------------------------------------------------------------------------
        if (masSkill.numb == 12 ) then 
            playerSkillParametrs.dopEnFlag = true
            playerSkillParametrs.dopEn =0.01*math.log(masSkill.lvl,2)
        end
        if (masSkill.numb == 13 ) then 
            playerSkillParametrs.tradeFlag = true
            playerSkillParametrs.tradeK =0.01*math.log(masSkill.lvl,2)
        end
        if (masSkill.numb == 14 ) then 
            playerSkillParametrs.vampirK =0.01*math.log(masSkill.lvl,2)
        end
        
    end
end

return system 