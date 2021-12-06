local pause = {}

local but1 = false
local but2 = false
local but3 = false
function pause:draw()
    UIBatch:clear()
    love.graphics.setColor(1,1,1,0.7)
        love.graphics.draw(kek,0,0,0,1,1)  
    love.graphics.setColor(1,1,1,1)
    exit(-7*k,-7*k2)
    bodyButton(screenWidth/3,screenHeight/2,but1)
    bodyButton(screenWidth/2,screenHeight/2,but2)
    bodyButton(screenWidth/1.5,screenHeight/2,but3)
    love.graphics.draw(UIBatch)
    textButton("Skills",screenWidth/3,screenHeight/2,but1)
    textButton("Settings",screenWidth/2,screenHeight/2, but2)
    textButton("Exit",screenWidth/1.5,screenHeight/2, but3)
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
        if ( (mouse.x >screenWidth/3-(70*k)/2) and (mouse.x <screenWidth/3+(70*k)/2) and (mouse.y <screenHeight/2+(350*k2)/2) and (mouse.y >screenHeight/2-(350*k2)/2) ) then
            but1 = true
        end
        
        if ( (mouse.x >screenWidth/2-(70*k)/2) and (mouse.x <screenWidth/2+(70*k)/2) and (mouse.y <screenHeight/2+(350*k2)/2) and (mouse.y >screenHeight/2-(350*k2)/2) ) then
            but2 = true
        end
        if ( (mouse.x >screenWidth/1.5-(70*k)/2) and (mouse.x <screenWidth/1.5+(70*k)/2) and (mouse.y <screenHeight/2+(350*k2)/2) and (mouse.y >screenHeight/2-(350*k2)/2) ) then
            but3 = true
        end
    else
        if (but1 == true and(mouse.x >screenWidth/3-(70*k)/2) and (mouse.x <screenWidth/3+(70*k)/2) and (mouse.y <screenHeight/2+(350*k2)/2) and (mouse.y >screenHeight/2-(350*k2)/2) ) then
            gamestate.switch(skills)
        end
        if (but2 == true and (mouse.x >screenWidth/2-(70*k)/2) and (mouse.x <screenWidth/2+(70*k)/2) and (mouse.y <screenHeight/2+(350*k2)/2) and (mouse.y >screenHeight/2-(350*k2)/2) ) then
            gamestate.switch(settings)
        end
         if (but3 == true and (mouse.x >screenWidth/1.5-(70*k)/2) and (mouse.x <screenWidth/1.5+(70*k)/2) and (mouse.y <screenHeight/2+(350*k2)/2) and (mouse.y >screenHeight/2-(350*k2)/2) ) then
            love.event.push('quit')
        end
        exp =  {}
        but1 = false
        but2 = false
        but3 = false
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