local effects = {}






function light(x1,y1,x2,y2,i)
    --[[
  if ( love.mouse.isDown(1) )then
    lightTimer:update(dt)
    lightTimer:every(0.01, function()  
    lii = light(screenWidth/1.3,screenHeight/1.6,mouse.x,mouse.y,3)
    table.insert(masli,lii)
    lightTimer:clear()
  end)
if ( #masli >3) then
  table.remove(masli,1)
  end
end
]]--
local length = math.sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1))
if ( length < screenHeight/1.7 and length > 30*k ) then 
local m = {x1,y1}
local x =0
local y = 0
local aye = 0
if ( length < screenHeight/4) then 
  aye = 4
else
  aye = 8
end
local ran =math.random(-length/aye,length/aye)
local angle =3.14-math.atan2((x2-x1),(y2-y1))
x =x1+(x2-x1)/2+math.cos(angle)*ran
y =y1+(y2-y1)/2+math.sin(angle)*ran
-----------------------------------

local m1 = pol(x1,y1,x,y,i)
for  i=1,#m1 do
  table.insert(m,m1[i])
  end

-----------------
table.insert(m,x)
table.insert(m,y)
-----------------
m1 = pol(x,y,x2,y2,i)
for  i=1,#m1 do
  table.insert(m,m1[i])
  end

table.insert(m,x2)
table.insert(m,y2)

return m
else
table.remove(masli,#masli)
table.remove(masli,#masli)
table.remove(masli,#masli)
end
end
function pol(x1,y1,x2,y2,i) 
  local aye = 0
if (math.sqrt((mouse.x-screenWidth/1.3)*(mouse.x-screenWidth/1.3)+(mouse.y-screenHeight/1.6)*(mouse.y-screenHeight/1.6)) > screenHeight/4) then  
    aye = 8
  else
    aye = 5
end
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
  
local m3 = pol(x,y,x2,y2,i-1)
for  i=1,#m3 do
  table.insert(m1,m3[i])
end
 
end


return m1

end

 function explUpdate2()
  for i =1, #exp do
    if( exp[i]) then
  exp[i].x= exp[i].x+exp[i].ax*dt2*k
  exp[i].y= exp[i].y+exp[i].ay*dt2*k2
  
  if (  exp[i].flag ==false) then 
     if ( exp[i].ax > 0 ) then
      exp[i].ax  = exp[i].ax - 50*dt2*k
     else
       exp[i].ax  = exp[i].ax + 50*dt2*k
      end
      if ( exp[i].ay > 0 ) then
       exp[i].ay  = exp[i].ay - 50*dt2*k2
     else
       exp[i].ay  = exp[i].ay + 50*dt2*k2
    end
  end
      if ( (exp[i].ay<3*k2 and  exp[i].ay>-3*k2) or (exp[i].ax<3*k and  exp[i].ax>-3*k)) then
       table.remove(exp,i)
  end

end
end
end

function explUpdate()

  for i =1, #exp do
    if( exp[i]) then
  exp[i].x= exp[i].x+exp[i].ax*dt2*2*k
  exp[i].y= exp[i].y+exp[i].ay*dt2*2*k2
  if (  exp[i].flag ==false) then 
     if ( exp[i].ax > 0 ) then
      exp[i].ax  = exp[i].ax - 50*dt2*k
     else
       exp[i].ax  = exp[i].ax + 50*dt2*k
      end
      if ( exp[i].ay > 0 ) then
       exp[i].ay  = exp[i].ay - 50*dt2*k2
     else
       exp[i].ay  = exp[i].ay + 50*dt2*k2
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
 if ( ((exp[i].y<exp[i].yy+200*k2*dt2 and  exp[i].y>exp[i].yy-200*k2*dt2) and (exp[i].x<exp[i].xx+200*k*dt2 and  exp[i].x>exp[i].xx-200*k*dt2)) and exp[i].flag == true ) then
    table.remove(exp,i)
  end
  end
end

end

function expl(x,y,kol)
  
  for kek =0, kol do
   
local e = {
  
  flag  =false,
  tip = 1,
  r = 0 ,
  color1 = math.random(200,255),
  color2= math.random(90,255),
  color3 = math.random(0,50),
  f = false,
  x  = x, 
  y =  y,  
  xx  = x, 
  yy =  y,
  ax  =math.random(-1.72*k*40,1.73*k*40), 
  ay = math.random(-1.73*k*40,1.73*k*40), 
  scale =0.15
  
}

table.insert(exp,e)

end
end

function effectGr()
  love.graphics.setColor(0,colorx,colory)
end












return effects
