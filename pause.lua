local pause = {}

local but1 = false
local but2 = false
local but3 = false
local but4 = false
local but5 = false 
local difButton = (screenWidth-60*k2*5)/16
function pause:draw()
    UIBatch:clear()
    love.graphics.setColor(1,1,1,0.7)
        love.graphics.draw(kek,0,0,0,1,1)  
    love.graphics.setColor(1,1,1,1)
    exit(0,0)
    bodyButton(difButton*6+30*k2,screenHeight/2,but1)
    bodyButton(difButton*7+60*k2*1+30*k2,screenHeight/2,but2)
    bodyButton(difButton*8+60*k2*2+30*k2,screenHeight/2,but5)
    bodyButton(difButton*9+60*k2*3+30*k2,screenHeight/2,but3)
    bodyButton(difButton*10+60*k2*4+30*k2,screenHeight/2,but4)
    
    love.graphics.draw(UIBatch)
    textButton("Skills",difButton*6+30*k2,screenHeight/2,but1,0.9)
    textButton("Converter",difButton*7+60*k2*1+30*k2,screenHeight/2, but2,0.9)
    textButton("Character",difButton*8+60*k2*2+30*k2,screenHeight/2, but5,0.9)
    textButton("Settings",difButton*9+60*k2*3+30*k2,screenHeight/2, but3,0.9)
    textButton("Exit",difButton*10+60*k2*4+30*k2,screenHeight/2, but4,0.9)
end

function pause:update(dt)
    mouse.x,mouse.y=love.mouse.getPosition()
  
    flagtouch3 = false
    flagtouch1 = false
    if love.mouse.isDown(1)  then
        flagtouch2 = true
    else
         if (  mouse.x > 0 and  mouse.x <60*k and mouse.y > 0 and  mouse.y <60*k2 and flagtouch2 == true) then
            gamestate.switch(game)
            exp =  {}
        end
        flagtouch2 = false
    end

    if love.mouse.isDown(1)  then
      
    textButton("Skills",difButton*6+30*k2,screenHeight/2,but1,0.9)
    textButton("Converter",difButton*7+60*k2*1+30*k2,screenHeight/2, but2,0.9)
    textButton("Character",difButton*8+60*k2*2+30*k2,screenHeight/2, but5,0.9)
    textButton("Settings",difButton*9+60*k2*3+30*k2,screenHeight/2, but3,0.9)
    textButton("Exit",difButton*10+60*k2*4+30*k2,screenHeight/2, but4,0.9)
      
      
        if ( (mouse.x >difButton*6+30*k2-(60*k)/2) and (mouse.x <difButton*6+30*k2+(60*k)/2) and (mouse.y <screenHeight/2+(250*k2)/2) and (mouse.y >screenHeight/2-(250*k2)/2) ) then
            but1 = true
        end
        if ( (mouse.x >difButton*7+60*k2*1+30*k2-(60*k)/2) and (mouse.x <difButton*7+60*k2*1+30*k2+(60*k)/2) and (mouse.y <screenHeight/2+(250*k2)/2) and (mouse.y >screenHeight/2-(250*k2)/2) ) then
            but2 = true
        end
        if ( (mouse.x >difButton*9+60*k2*3+30*k2-(60*k)/2) and (mouse.x <difButton*9+60*k2*3+30*k2+(60*k)/2) and (mouse.y <screenHeight/2+(250*k2)/2) and (mouse.y >screenHeight/2-(250*k2)/2) ) then
            but3 = true
        end
        if ( (mouse.x >difButton*10+60*k2*4+30*k2-(60*k)/2) and (mouse.x <difButton*10+60*k2*4+30*k2+(60*k)/2) and (mouse.y <screenHeight/2+(250*k2)/2) and (mouse.y >screenHeight/2-(250*k2)/2) ) then
            but4 = true
        end
        if ( (mouse.x >difButton*8+60*k2*2+30*k2-(60*k)/2) and (mouse.x <difButton*8+60*k2*2+30*k2+(60*k)/2) and (mouse.y <screenHeight/2+(250*k2)/2) and (mouse.y >screenHeight/2-(250*k2)/2) ) then
            but5 = true
        end
    else
      
        if (but1 == true and  (mouse.x >difButton*6+30*k2-(60*k)/2) and (mouse.x <difButton*6+30*k2+(60*k)/2) and (mouse.y <screenHeight/2+(250*k2)/2) and (mouse.y >screenHeight/2-(250*k2)/2) ) then
            gamestate.switch(skills)
        end
        if (but2 == true and (mouse.x >difButton*7+60*k2*1+30*k2-(60*k)/2) and (mouse.x <difButton*7+60*k2*1+30*k2+(60*k)/2) and (mouse.y <screenHeight/2+(250*k2)/2) and (mouse.y >screenHeight/2-(250*k2)/2) ) then
            gamestate.switch(convert)
        end
        if (but5 == true and (mouse.x >difButton*8+60*k2*2+30*k2-(60*k)/2) and (mouse.x <difButton*8+60*k2*2+30*k2+(60*k)/2) and (mouse.y <screenHeight/2+(250*k2)/2) and (mouse.y >screenHeight/2-(250*k2)/2) ) then
            gamestate.switch(s)
        end
        if (but3 == true and  (mouse.x >difButton*9+60*k2*3+30*k2-(60*k)/2) and (mouse.x <difButton*9+60*k2*3+30*k2+(60*k)/2) and (mouse.y <screenHeight/2+(250*k2)/2) and (mouse.y >screenHeight/2-(250*k2)/2) ) then
            gamestate.switch(settings)
        end
        if (but4 == true and (mouse.x >difButton*10+60*k2*4+30*k2-(60*k)/2) and (mouse.x <difButton*10+60*k2*4+30*k2+(60*k)/2) and (mouse.y <screenHeight/2+(250*k2)/2) and (mouse.y >screenHeight/2-(250*k2)/2) ) then
            love.event.push('quit')
        end
        exp =  {}
        but1 = false
        but2 = false
        but3 = false
        but4 = false
        but5 = false
    end
end

function pause:keypressed(key, code)
    if key == "escape" then
        gamestate.switch(game)
    elseif key == "q" then
        love.event.push('quit')
    end
end

return pause