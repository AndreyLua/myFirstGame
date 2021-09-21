local skills = {}
local cost = 10
  images ={
    i1 = love.graphics.newImage("assets/skills/1.png"),
    i2 = love.graphics.newImage("assets/skills/2.png"),
    i3  = love.graphics.newImage("assets/skills/3.png"),
    i4  = love.graphics.newImage("assets/skills/4.png"),
    i5  = love.graphics.newImage("assets/skills/5.png"),
    i6  = love.graphics.newImage("assets/skills/6.png"),
    i7  = love.graphics.newImage("assets/skills/7.png"),
    i8  = love.graphics.newImage("assets/skills/8.png"),
    i9  = love.graphics.newImage("assets/skills/9.png"),
    i10  = love.graphics.newImage("assets/skills/10.png"),
    i11  = love.graphics.newImage("assets/skills/11.png")
     }
local tip = 0 
rolls = 100 
flagrolls = false 
textMas = { 
  "Increases the amount of health"
  ,"Increases the amount of energy",
  "The increase in damage",
  "Increased resistance to physical attacks",
  "Studying the use of blood for attacks",
  "The increase in regeneration",
  "Radius of girth and damage from physical attacks",
  "The range of the followers and gathering resources",
  "Ability to take enemy lives when dealing damage",
  "Rebirth after death with a certain amount of HP",
  "Increase the speed of you and your followers"
}
textM = {
 {0,0},
 {20,-10},
 {10,0},
 {0,0},
 {20,0},
 {10,-10},
 {30,0},
 {0,0},
 {-10,0},
 {0,0},
 {0,-33}
}
exp =  {}
slots = { 0 , 0 , 0 , 0 }

function skills:draw()
  
love.graphics.setCanvas(kek3)
love.graphics.clear()
exit(-7*k,-7*k2)
love.graphics.circle("line",screenWidth/3,screenHeight/2,65*k)
slot(screenWidth/3,screenHeight/5,1.4,1)
slot(screenWidth/3,screenHeight/5*4,1.4,1 )
slot(screenWidth/5.5,screenHeight/2-screenHeight/7,1.4,1 )
slot(screenWidth/5.5,screenHeight/2+screenHeight/7,1.4, 1)
fbutton("Update",screenWidth/1.26,screenHeight/2,1)
love.graphics.setColor(0.0039*250,0.0039*200,0)
love.graphics.print("Cost",screenWidth/1.55,screenHeight/1.60,-1.57,0.8,0.8)
local kal = tostring(rolls)
local kakal = #kal
love.graphics.print(rolls,screenWidth/3-32.5*0.8*k,screenHeight/2-2*k2+(kakal*45*0.8/2*k2),-1.57,0.8,0.8)
 if ( tip~= 0 ) then 
fbutton(tostring(cost),screenWidth/1.4,screenHeight/2,0.4)
end
--local key = textM[1]
--imageskill("line",screenWidth/3,screenHeight/5*4,key[1]*k,key[2]*k2,1)
 --key = textM[5]
--imageskill("line",screenWidth/3,screenHeight/5*4,key[1]*k,key[2]*k2,5)


text(screenWidth/2.2,screenHeight/2+screenHeight/2.7,0.5)
love.graphics.setColor(0.0039*250,0.0039*200,0)
if ( flagrolls == true) then
  
  

    imageskill("line",screenWidth/3,screenHeight/5,key1[1]*k,key1[2]*k2,slots[1])
    imageskill("line",screenWidth/3,screenHeight/5*4,key2[1]*k,key2[2]*k2,slots[2])
    imageskill("line",screenWidth/5.5,screenHeight/2-screenHeight/7,key3[1]*k,key3[2]*k2,slots[3])
    imageskill("line",screenWidth/5.5,screenHeight/2+screenHeight/7,key4[1]*k,key4[2]*k2,slots[4])
    
    
    
end

for i=1,#exp do
  love.graphics.setColor(0.0039*exp[i].color1,0.0039*exp[i].color2,0.0039*exp[i].color3)
   love.graphics.rectangle("fill",exp[i].x,exp[i].y,exp[i].scale*40*k,exp[i].scale*40*k2,4*exp[i].scale*k)
  end
love.graphics.setColor(1,1,1)

--print(stat.drawcalls)

         
love.graphics.setCanvas()


fon:draw()
love.graphics.setColor(0,0,0, 0.0039*180)
love.graphics.rectangle('fill',0,0,d1,d2)
love.graphics.setColor(1,1,1)
love.graphics.draw(kek3,0,0,0,sx,sy) 
end

function skills:update(dt)
explUpdate()
mouse.x,mouse.y=love.mouse.getPosition()
mouse.x = mouse.x/sx
mouse.y = mouse.y/sy

if love.mouse.isDown(1)  then
    flagtouch3 =true
else
  if ( mouse.x > 0 and  mouse.x <60*k and mouse.y > 0 and  mouse.y <60*k2 and flagtouch3 == true) then
        exp =  {}
        gamestate.switch(game)
  end
  if (  mouse.x > screenWidth/3-75*k/1.4 and  mouse.x <screenWidth/3+75*k/1.4 and mouse.y > screenHeight/5-75*k2/1.4 and  mouse.y <screenHeight/5+75*k2/1.4 and flagtouch3 == true) then
        
        texti = -1
        textL = ""
        textK = 0  
        tip = slots[1]
    end
    if (  mouse.x > screenWidth/3-75*k/1.4 and  mouse.x <screenWidth/3+75*k/1.4 and mouse.y > screenHeight/5*4-75*k2/1.4 and  mouse.y <screenHeight/5*4+75*k2/1.4 and flagtouch3 == true) then
      
        texti = -1
        textL = ""
        textK = 0     
        tip = slots[2]
    end
    if (  mouse.x > screenWidth/5.5-75*k/1.4 and  mouse.x <screenWidth/5.5+75*k/1.4 and mouse.y > screenHeight/2-screenHeight/7-75*k2/1.4 and  mouse.y <screenHeight/2-screenHeight/7+75*k2/1.4 and flagtouch3 == true) then
        texti = -1
        textL = ""
        textK = 0    
        
        tip = slots[3]
    end
    if (  mouse.x >screenWidth/5.5-75*k/1.4 and  mouse.x <screenWidth/5.5+75*k/1.4 and mouse.y > screenHeight/2+screenHeight/7-75*k2/1.4 and  mouse.y <screenHeight/2+screenHeight/7+75*k2/1.4 and flagtouch3 == true) then
        texti = -1
        textL = ""
        textK = 0  
      
        tip = slots[4]
    end
    if (  mouse.x > screenWidth/3-65*k and  mouse.x <screenWidth/3+65*k and mouse.y > screenHeight/2-65*k2 and  mouse.y <screenHeight/2+65*k2 and flagtouch3 == true) then
        if ( rolls > 0 ) then
            textL = ""
            tip = 0 
            expl(screenWidth/3,screenHeight/5,40) 
            expl(screenWidth/3,screenHeight/5*4,40) 
            expl(screenWidth/5.5,screenHeight/2-screenHeight/7,40) 
            expl(screenWidth/5.5,screenHeight/2+screenHeight/7,40) 
            rolls = rolls-1
        
            flagrolls = true
            while true do 
                slots[1] = math.random(1,11)
                slots[2] = math.random(1,11)
                slots[3] = math.random(1,11)
                slots[4] = math.random(1,11)
                if ( slots[1]~= slots[2] and slots[1]~= slots[3] and slots[1]~= slots[4] and slots[2]~= slots[1] and slots[2]~= slots[3] and slots[2]~= slots[4] and slots[3]~= slots[2] and slots[3]~= slots[1] and slots[3]~= slots[4] and slots[4]~= slots[2] and slots[4]~= slots[3] and slots[4]~= slots[1]) then
                      break
                end
            end
            key1 = textM[slots[1]]
            key2 = textM[slots[2]]
            key3 = textM[slots[3]]
            key4 = textM[slots[4]]
        end
    end
  
  flagtouch3 = false
end
  
if ( tip~= 0 ) then 
    textUpdate(textMas[tip],0.1,dt) 
end
dt2 = dt
end

function textUpdate(text,speed,dt) 
    if (texti<=#text) then 
        textT:update(dt)
        textT:every(speed, function()
            texti = texti+1
            textK = textK+1
            local textkek = "" 
            if (textL:sub(#textL,#textL)=="_") then
                textL = textL:sub(0,#textL-1)
            end
            textkek = text:sub(texti,texti)
            if ( textK>7 and text:sub(texti,texti) == " ") then
               textK = 0 
               textkek =textkek.."\n"
            end
            textL = textL..textkek.."_"
            textT:clear()
        end)
    end
end

function text(x,y,scale)
    love.graphics.setColor(0.0039*200,0.0039*150,0)
    love.graphics.print(textL,x,y,-3.14/2,scale,scale)
end

function imageskill(mode,x,y,w,h,tip)

   if ( tip == 1) then
  r = 0 
  ox =  w/2
  oy =  h/2
  love.graphics.push()
  love.graphics.translate( x + ox,y + oy )
  love.graphics.push()
love.graphics.draw(images.i1,0,0,-1.57,k/6.4,k2/6.4,images.i1:getWidth()/2,images.i1:getHeight()/2)
  love.graphics.pop()
  love.graphics.pop()
else
   if ( tip == 2) then
  r = 0 
  ox =  w/2
  oy =  h/2
  love.graphics.push()
  love.graphics.translate( x + ox,y + oy )
  love.graphics.push()
  love.graphics.draw(images.i2,-10*k,5*k2,-1.57,k/6.4,k2/6.4,images.i2:getWidth()/2,images.i2:getHeight()/2)
  love.graphics.pop()
  love.graphics.pop()
else
 if ( tip == 3) then

  r = 0 
  ox =  w/2
  oy =  h/2
  love.graphics.push()
  love.graphics.translate( x + ox,y + oy )
  love.graphics.push()
  
love.graphics.draw(images.i3,0,0,-1.57,k/6.4,k2/6.4,images.i3:getWidth()/2,images.i3:getHeight()/2)
  love.graphics.pop()
  
  love.graphics.pop()
else
 if ( tip == 4) then
  r = 0 
  ox =  w/2
  oy =  h/2
  love.graphics.push()
  love.graphics.translate( x + ox,y + oy )
  love.graphics.push()
love.graphics.draw(images.i4,0,0,-1.57,k/6.4,k2/6.4,images.i4:getWidth()/2,images.i4:getHeight()/2)

  love.graphics.pop()
  love.graphics.pop()
else
  if ( tip == 5) then
  r = 0 
  ox =  w/2
  oy =  h/2
  love.graphics.push()
  love.graphics.translate( x + ox,y + oy )
  love.graphics.push()
love.graphics.draw(images.i5,-5*k,0,-1.57,k/6.4,k2/6.4,images.i5:getWidth()/2,images.i5:getHeight()/2)
  love.graphics.pop()
  love.graphics.pop()
else

  if ( tip == 6) then
  r = 0 
  ox =  w/2
  oy =  h/2
  love.graphics.push()
  love.graphics.translate( x + ox,y + oy )
  love.graphics.push()
love.graphics.draw(images.i6,-5*k,5*k2,-1.57,k/6.4,k2/6.4,images.i6:getWidth()/2,images.i6:getHeight()/2)
  love.graphics.pop()
  love.graphics.pop()
else
 if ( tip == 7) then
   r = 0 
  ox =  w/2
  oy =  h/2
  love.graphics.push()
  love.graphics.translate( x + ox,y + oy )
  love.graphics.push()
  --love.graphics.rotate(-1.57)
love.graphics.draw(images.i7,-15*k,0,-1.57,k/6.4,k2/6.4,images.i7:getWidth()/2,images.i7:getHeight()/2)

  love.graphics.pop()
  love.graphics.pop()
else
if ( tip == 8) then
   r = 0 
  ox =  w/2
  oy =  h/2
  love.graphics.push()
  love.graphics.translate( x + ox,y + oy )
  love.graphics.push()

  
love.graphics.draw(images.i8,0,0,-1.57,k/6.4,k2/6.4,images.i8:getWidth()/2,images.i8:getHeight()/2)

  love.graphics.pop()
  love.graphics.pop()
else
if ( tip == 9) then
  r = 0 
  ox =  w/2
  oy =  h/2
  love.graphics.push()
  love.graphics.translate( x + ox,y + oy )
  love.graphics.push()
  
 
love.graphics.draw(images.i9,0,0,-1.57,k/6.4,k2/6.4,images.i9:getWidth()/2,images.i9:getHeight()/2)


  love.graphics.pop()
  love.graphics.pop()
else
if ( tip == 10) then
  r = 0 
  ox =  w/2
  oy =  h/2
  love.graphics.push()
  love.graphics.translate( x + ox,y + oy )
  love.graphics.push()

 
love.graphics.draw(images.i10,0,0,-1.57,k/6.4,k2/6.4,images.i10:getWidth()/2,images.i10:getHeight()/2)

  love.graphics.pop()
  love.graphics.pop()
else
if ( tip == 11) then
   r = 0 
  ox =  w/2
  oy =  h/2
  love.graphics.push()
  love.graphics.translate( x + ox,y + oy )
  love.graphics.push()



love.graphics.draw(images.i11,0,20*k2,-1.57,k/6.4,k2/6.4,images.i11:getWidth()/2,images.i11:getHeight()/2)

  love.graphics.pop()
  love.graphics.pop()
else
end
end
end
end
end
end
end
end
end
end
end
end


function skills:keypressed(key, code)
    if key == "escape" then
        gamestate.switch(game)
    elseif key == "q" then
        love.event.push('quit')
    end
end

return skills