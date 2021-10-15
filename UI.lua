local UI = {}


function fbutton(name,x,y,scale,flag)
  local  kol = #name
  if (flag) then 
      love.graphics.setLineWidth(2)
      love.graphics.setColor(0.697,	0.307,0)
      love.graphics.rectangle('line',x-(70*k*scale)/2,y-(350*k2*scale)/2,70*k*scale,350*k2*scale)
      love.graphics.setColor(0.775,	0.78,0)
      love.graphics.print(name, x-(70*k*scale*0.8)/2,y+(kol*45*scale/2*k2*0.8),-math.pi/2,0.8*scale,0.8*scale)
  else
      love.graphics.setLineWidth(2)
      love.graphics.setColor(0.897,	0.507,0)
      love.graphics.rectangle('line',x-(70*k*scale)/2,y-(350*k2*scale)/2,70*k*scale,350*k2*scale)
      love.graphics.setColor(0.975,	0.78,0)
      love.graphics.print(name, x-(70*k*scale*0.8)/2,y+(kol*45*scale/2*k2*0.8),-math.pi/2,0.8*scale,0.8*scale)
  end
end

function slot(x,y,scale,number)
  local  kol = #(tostring(number))
  love.graphics.setLineWidth(2)
  love.graphics.setColor(0.0039*230,0.0039*130,0)
  love.graphics.rectangle('line',x-(75*k*scale)/2,y-(75*k2*scale)/2,75*k*scale,75*k2*scale)
  love.graphics.print(number,x-(75*k*scale)/2+3*k,y-(75*k*scale)/2+(kol*45*scale/2*k2*0.4)+3*k2,-3.14/2,0.4*k,0.4*k2)
end

function sc(x,y)
  love.graphics.setLineWidth(2)
  love.graphics.setColor(0.0039*200,0.0039*150,0)
  love.graphics.rectangle('line',x,y-100*k2,35*k,200*k2)
end

function playerHP(dt)
  
  if ( hp.long/screenHeight*100> 100) then
    hp.long = screenHeight
    hp.long2 = screenHeight 
    hp.long3 = screenHeight
  end
  
  if ( hp.long3> hp.long2 and hp.long >= hp.long2) then
    hp3:update(dt)
   hp3:every(0.1, function()
      hp.long2= hp.long2+0.5
     hp.long= hp.long+0.5
      if ( hp.long>d2/2) then
        hp.long = screenHeight
        hp.long2 =screenHeight
        hp.long3 =screenHeight
      end
   end)
  end

  if (hp.long< hp.long2 ) then
    hp1:update(dt)
    hp1:every(0.01, function()
      hp.long2 = hp.long2-1
      hp1:clear()
    end)
  end
  
  if ( flaginv == false) then
   hp2:update(dt)
    hp2:every(0.01, function()
      hp.long = hp.long- 1
    hp.long3  = hp.long
     hp2:clear()
  end)

  inv:update(dt)
   inv:every(playerAbility.invTimer, function()
     inv:clear() 
     shake  = 0    
    flaginv =  true
   end)
  end
  
end

function playerBoost(dt)
 
  if ( boost.long/screenHeight*100> 100) then
    boost.long = screenHeight
    boost.long2 = screenHeight
  end
  
  if ( boost.long2>boost.long) then
    boost2:update(dt)
    boost2:every(0.01, function()
      boost.long2 = boost.long2-2
      boost2:clear()
    end)
  end
  
  if ( boost.long2<boost.long) then
     boost2:update(dt)
     boost2:every(0.01, function()
       boost.long2 = boost.long2+1
       boost2:clear()
     end)
  end

  if ( boost.long <= 30*k2 ) then
    player.a=0
    boost.long =30*k2
  end
  
  if ( player.a==1) then
    boost1:update(dt)
    boost1:every(0.01, function()
      boost.long = boost.long -5
      boost1:clear()
    end)
  else
    boost1:update(dt)
    boost1:every(0.01, function()
      boost.long = boost.long +0.6
      boost1:clear()
    end)
  end
  
  if  (boost.long>screenHeight) then
    boost.long = screenHeight
  end
end

function Health_Boost()
    love.graphics.setColor(0.64,0,0.02)
    love.graphics.rectangle("line",screenWidth-40*k+10*k,screenHeight-(hp.long2-20*k2)/2-10*k2,25*k,(hp.long2-20*k2)/2,5)
    love.graphics.setColor(1,0,0.02)
    love.graphics.rectangle("line",screenWidth-40*k+10*k,screenHeight-(hp.long2-20*k2)/2-10*k2,25*k,(hp.long-20*k2)/2,5)
    love.graphics.setColor(0,0.32,0.225)
    love.graphics.rectangle("line",screenWidth-40*k+10*k,-(boost.long2-20*k2)/2+screenHeight/2-10*k2,25*k,(boost.long2-20*k2)/2,5)
    love.graphics.setColor(0,0.643,0.502)
    love.graphics.rectangle("line",screenWidth-40*k+10*k,-(boost.long-20*k2)/2+screenHeight/2-10*k2,25*k,(boost.long-20*k2)/2,5)
end

function exit(x,y)
  if (mouse.x > 0 and  mouse.x <60*k and mouse.y > 0 and  mouse.y <60 *k2 and ((flagtouch==true and flagtouch1== true) or flagtouch2 == true or flagtouch3 == true) )  then
      love.graphics.setLineWidth(2)
      love.graphics.setColor(0.697,0.307,0)
      love.graphics.rectangle('line',x+10*k,y+10*k2,60*k,60*k2)
      love.graphics.rectangle('line',x+20*k,y+20*k2,8*k,40*k2,2)
      love.graphics.rectangle('line',x+35*k,y+20*k2,8*k,40*k2,2)
      love.graphics.rectangle('line',x+50*k,y+20*k2,8*k,40*k2,2)
  else
      love.graphics.setLineWidth(2)
      love.graphics.setColor(0.897,0.507,0)
      love.graphics.rectangle('line',x+10*k,y+10*k2,60*k,60*k2)
      love.graphics.rectangle('line',x+20*k,y+20*k2,8*k,40*k2,2)
      love.graphics.rectangle('line',x+35*k,y+20*k2,8*k,40*k2,2)
      love.graphics.rectangle('line',x+50*k,y+20*k2,8*k,40*k2,2)
  end
  
  
end

function lineW()
    love.graphics.setColor(0.897,0.507,0)
    local Wave = waves[numberWave]
    love.graphics.rectangle("line",50*k,screenHeight/2-(colWave*300*k2/Wave[4])/2,10*k,colWave*300*k2/Wave[4])
end 




return UI