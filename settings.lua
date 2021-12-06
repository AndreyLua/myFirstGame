local settings = {}
local flagControl = false
local flagok = true

function settings:draw()
  
love.graphics.setCanvas(kek3)
love.graphics.clear()
love.graphics.setColor(1,1,1,0.7)
love.graphics.draw(kek,0,0,0,1,1) 
love.graphics.setColor(1,1,1,1)
exit(-7*k,-7*k2)
textButton("Volume",screenWidth/2.2,screenHeight/2,0.9)

textButton("Sensitivity",screenWidth/3.6,screenHeight/2,0.7)

controlButton(sens,screenWidth/3,screenHeight/2,1,1,100)

controlButton(volume,screenWidth/2,screenHeight/2,1,1,100)

textButton("Vibration",screenWidth/1.55,screenHeight/1.4,0.6)
boolenButton(flagVibr,screenWidth/1.38,screenHeight/1.4,1)

textButton("Choose",screenWidth/1.63,screenHeight/3.6,0.6)
textButton("controls",screenWidth/1.55,screenHeight/3.6,0.6)
boolenButton("Not",screenWidth/1.38,screenHeight/3.6,1)
love.graphics.setCanvas()



love.graphics.setColor(0,0,0, 0.0039*180)
love.graphics.rectangle('fill',0,0,screenWidth,screenHeight)
love.graphics.setColor(1,1,1)
love.graphics.draw(kek3,0,0,0,1,1) 

end

function settings:update(dt)
mouse.x,mouse.y=love.mouse.getPosition()
mouse.x = mouse.x
mouse.y = mouse.y

ggtouch =(sens)

 
 
 
 
if (love.mouse.isDown(1)) then
flagtouch3 =true

if ( (mouse.x >(screenWidth/1.38-100*k)) and (mouse.x <(screenWidth/1.38+100*k)) and flagtouch3 == true and mouse.y >(screenHeight/1.4-100*k2) and mouse.y <(screenHeight/1.4+100*k2) and flagok == true) then
   flagok =false
   if (flagVibr == true) then
    flagVibr = false 
 else
    flagVibr = true
  end
  
end
--screenWidth/1.38,screenHeight/1.4

  if ( (mouse.x >(screenWidth/2-50*k)) and (mouse.x <(screenWidth/2+50*k)) and flagtouch3 == true ) then
   
     if ( flagControl == true) then
       
 volume =volume+ (mouse.y -  (screenHeight/2-(350*k2)/2+(volume/100)*(350*k2)) )/20
 
 if  ( volume>100) then
    volume = 100
 end
 if  ( volume<0) then
    volume =0
 end
end
  
    flagControl = true

end


if ( (mouse.x >(screenWidth/3-50*k)) and (mouse.x <(screenWidth/3+50*k)) and flagtouch3 == true ) then
   
     if ( flagControl == true) then
       
 sens =sens+ (mouse.y -  (screenHeight/2-(350*k2)/2+(sens/100)*(350*k2)) )/20
 
 if  ( sens>100) then
    sens = 100
 end
 if  ( sens<0) then
    sens =0
 end
 
end
    flagControl = true
 end   
    
    
    
    
else
      if (  mouse.x > 0 and  mouse.x <60*k and mouse.y > 0 and  mouse.y <60*k2 and flagtouch3 == true  ) then
  gamestate.switch(game)
end
    
 flagControl =false  
flagtouch3 =false
flagok =true
end



end

function textButton(name,x,y,scale)
  
 local  kol = #name
love.graphics.setLineWidth(2)
love.graphics.setColor(0.0039*250,0.0039*200,0)
love.graphics.print(name, x-(70*k*scale*0.8)/2,y+(kol*45*scale/2*k2*0.8),-math.pi/2,0.8*scale,0.8*scale)

end

function controlButton(per,x,y,scale,min,max)
  
love.graphics.setLineWidth(2)
love.graphics.setColor(0.0039*230,0.0039*130,0)
love.graphics.rectangle('line',x-(15*k*scale)/2,y-(350*k2*scale)/2,15*k*scale,350*k2*scale)


  love.graphics.setBlendMode("replace")
love.graphics.setColor(0,0,0,0)  
love.graphics.circle('fill',x,y-(350*k2*scale)/2+(per/max)*(350*k2*scale),25*k*scale)

  love.graphics.setBlendMode("alpha")
love.graphics.setColor(0.0039*250,0.0039*200,0)
love.graphics.circle('line',x,y-(350*k2*scale)/2+(per/max)*(350*k2*scale),25*k*scale)

end

function boolenButton(per,x,y,scale)
   local  kol = 3
   local per2 = ""
if ( per==true) then
     per2 ="Yes"
    kol = 3 
else
    per2 ="No"
    kol = 2
end
 

 
love.graphics.setLineWidth(2)
love.graphics.setColor(0.0039*230,0.0039*130,0)
love.graphics.rectangle('line',x-(100*k*scale)/2,y-(100*k2*scale)/2,100*k*scale,100*k2*scale)
love.graphics.print(per2,x-(70*k*0.8*0.7)/2,y+(kol*45/2*k2*0.8*0.7),-math.pi/2,0.8*k,0.8*k2)

--love.graphics.print(name, x-(70*k*scale*0.8)/2,y+(kol*45*scale/2*k2*0.8),-math.pi/2,0.8*scale,0.8*scale)

end



function settings:keypressed(key, code)
    if key == "escape" then
        gamestate.switch(game)
    elseif key == "q" then
        love.event.push('quit')
    end
end

return settings