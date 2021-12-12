local skills = {}
local cost = 10
local colba = love.graphics.newImage("assets/constrSet.png")
local images ={
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
UIBatch:clear()
love.graphics.setColor(1,1,1,1)
love.graphics.draw(fon1,0,0,0,k,k2)
love.graphics.draw(fon2,0,0,0,k,k2)
love.graphics.draw(fon3,0,0,0,k,k2)
exit(-7*k,-7*k2)
bodyButton(screenWidth/1.3,screenHeight/2,false)
love.graphics.draw(UIBatch)
textButton("Convert",screenWidth/1.3,screenHeight/2,false)
love.graphics.rectangle("line",screenWidth/8,screenHeight/2-75*k2,30*k,150*k2,3)


love.graphics.setColor(1,1,1,1)
love.graphics.draw(colba,screenWidth/2,screenHeight/2,-1.57,k/1.7,k2/1.7,250,193.5)

for i=1,#exp do
    love.graphics.setColor(0.0039*exp[i].color1,0.0039*exp[i].color2,0.0039*exp[i].color3)
    love.graphics.rectangle("fill",exp[i].x,exp[i].y,exp[i].scale*40*k,exp[i].scale*40*k2)
end
love.graphics.setColor(1,1,1,1)
--text(screenWidth/2.2,screenHeight/2+screenHeight/2.7,0.5)
end

function skills:update(dt)
explUpdate(dt)
mouse.x,mouse.y=love.mouse.getPosition()


if love.mouse.isDown(1)  then
    flagtouch3 =true
else
    if ( mouse.x > 0 and  mouse.x <60*k and mouse.y > 0 and  mouse.y <60*k2 and flagtouch3 == true) then
        exp =  {}
        gamestate.switch(game)
    end
    flagtouch3 =false
end

    --if (  mouse.x > screenWidth/3-75*k/1.4 and  mouse.x <screenWidth/3+75*k/1.4 and mouse.y > screenHeight/5*4-75*k2/1.4 and  mouse.y <screenHeight/5*4+75*k2/1.4 and flagtouch3 == true) then
      
     --   texti = -1
     --   textL = ""
     --   textK = 0     
     --   tip = slots[2]
   -- end

  
--if ( tip~= 0 ) then 
   -- textUpdate(textMas[tip],0.1,dt) 
--end
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

function skills:keypressed(key, code)
    if key == "escape" then
        gamestate.switch(game)
    elseif key == "q" then
        love.event.push('quit')
    end
end

return skills