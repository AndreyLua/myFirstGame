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

function checkCircle(x,y,scale1,scale2,x2,y2,r)
    if ( (math.sqrt((x-r-x2)*(x-r-x2)+(y-r-y2)*(y-r-y2))<r) or (math.sqrt((x-r+scale1*40*k-x2)*(x-r+scale1*40*k-x2)+(y-r-y2)*(y-r-y2))<r) or (math.sqrt((x-r-x2)*(x-r-x2)+(y-r+scale2*40*k2-y2)*(y-r+scale2*40*k2-y2))<r) or (math.sqrt((x-r+scale1*40*k-x2)*(x-r+scale1*40*k-x2)+(y-r+scale2*40*k2-y2)*(y-r+scale2*40*k2-y2))<r) ) then
        return true
    else
        return false
    end
end



return system 