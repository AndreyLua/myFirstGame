local menu = {}

local but1 = false
local but2 = false
local but3 = false
local but4 = false
local but5 = false 
local difButton = (screenWidth-60*k2*5)/16

local butYes = false
local butNo = false

local exitFlag = false

function menu:init()  
    skills = require "scripts/gameStates/menuSections/skills" 
    convert = require "scripts/gameStates/menuSections/convert"
    character = require "scripts/gameStates/menuSections/character"
    settings = require "scripts/gameStates/menuSections/settings" 
end

function menu:update(dt)
    flagtouch3 = false
    flagtouch1 = false
    if love.mouse.isDown(1)  then
        flagtouch2 = true
    else
         if (  mouse.x > 0 and  mouse.x <60*k and mouse.y > 0 and  mouse.y <60*k2 and flagtouch2 == true) then
            AddSound(uiClick,0.3)
            exp =  {}
            gamestate.switch(game)
        end
        flagtouch2 = false
    end
    if ( exitFlag == false) then 
        if love.mouse.isDown(1)  then
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
                AddSound(uiSelect,0.3)
                gamestate.switch(skills)
            end
            if (but2 == true and (mouse.x >difButton*7+60*k2*1+30*k2-(60*k)/2) and (mouse.x <difButton*7+60*k2*1+30*k2+(60*k)/2) and (mouse.y <screenHeight/2+(250*k2)/2) and (mouse.y >screenHeight/2-(250*k2)/2) ) then
                AddSound(uiSelect,0.3)
                gamestate.switch(convert)
            end
            if (but5 == true and (mouse.x >difButton*8+60*k2*2+30*k2-(60*k)/2) and (mouse.x <difButton*8+60*k2*2+30*k2+(60*k)/2) and (mouse.y <screenHeight/2+(250*k2)/2) and (mouse.y >screenHeight/2-(250*k2)/2) ) then
                AddSound(uiSelect,0.3)
                gamestate.switch(character)
            end
            if (but3 == true and  (mouse.x >difButton*9+60*k2*3+30*k2-(60*k)/2) and (mouse.x <difButton*9+60*k2*3+30*k2+(60*k)/2) and (mouse.y <screenHeight/2+(250*k2)/2) and (mouse.y >screenHeight/2-(250*k2)/2) ) then
                AddSound(uiSelect,0.3)
                gamestate.switch(settings)
            end
            if (but4 == true and (mouse.x >difButton*10+60*k2*4+30*k2-(60*k)/2) and (mouse.x <difButton*10+60*k2*4+30*k2+(60*k)/2) and (mouse.y <screenHeight/2+(250*k2)/2) and (mouse.y >screenHeight/2-(250*k2)/2) ) then
                AddSound(uiSelect,0.3)
                exitFlag = true 
            --    love.event.push('quit')
            end
            exp =  {}
            but1 = false
            but2 = false
            but3 = false
            but4 = false
            but5 = false
        end
    else
        if love.mouse.isDown(1)  then
            butYes = setButtonFlag(difButton*9+60*k2*3+30*k2-0.4*k*120,difButton*9+60*k2*3+30*k2+0.4*k*120,screenHeight/2-math.cos(-math.pi/1.4)*120*k-0.4*k*120,screenHeight/2-math.cos(-math.pi/1.4)*120*k+0.4*k*120)
            butNo = setButtonFlag(difButton*9+60*k2*3+30*k2-0.4*k*120,difButton*9+60*k2*3+30*k2+0.4*k*120,screenHeight/2-math.cos(-math.pi/3.5)*120*k-0.4*k*120,screenHeight/2-math.cos(-math.pi/3.5)*120*k+0.4*k*120)
        else
            if (setButtonFlag(difButton*9+60*k2*3+30*k2-0.4*k*120,difButton*9+60*k2*3+30*k2+0.4*k*120,screenHeight/2-math.cos(-math.pi/1.4)*120*k-0.4*k*120,screenHeight/2-math.cos(-math.pi/1.4)*120*k+0.4*k*120) and butYes) then
                AddSound(uiSelect,0.3)
                love.event.push('quit')  
            end
            if (setButtonFlag(difButton*9+60*k2*3+30*k2-0.4*k*120,difButton*9+60*k2*3+30*k2+0.4*k*120,screenHeight/2-math.cos(-math.pi/3.5)*120*k-0.4*k*120,screenHeight/2-math.cos(-math.pi/3.5)*120*k+0.4*k*120) and butNo) then
                AddSound(uiSelect,0.3)
                exitFlag = false
            end
            butYes = false
            butNo = false
        end
         
    end
    
end

function menu:draw()
    UIBatch:clear()
    love.graphics.setColor(1,1,1,0.7)
        if ( exitFlag) then 
            love.graphics.setColor(0.2,0.2,0.2,1)
        end
        love.graphics.draw(canvasToEffect,0,0,0,1,1)  
    love.graphics.setColor(1,1,1,1)
    exit(0,0)
    bodyButton(difButton*6+30*k2,screenHeight/2,but1)
    bodyButton(difButton*7+60*k2*1+30*k2,screenHeight/2,but2)
    bodyButton(difButton*8+60*k2*2+30*k2,screenHeight/2,but5)
    bodyButton(difButton*9+60*k2*3+30*k2,screenHeight/2,but3)
    bodyButton(difButton*10+60*k2*4+30*k2,screenHeight/2,but4)
    if (exitFlag) then 
        love.graphics.setColor(0.2,0.2,0.2,1)
        menu:drawMainButtons()
        UIBatch:clear()
        love.graphics.setColor(1,1,1,1)
        exit()
        acceptBut(difButton*9+60*k2*3+30*k2,screenHeight/2-math.cos(-math.pi/1.4)*120*k,0.4,butYes) 
        rejectBut(difButton*9+60*k2*3+30*k2,screenHeight/2-math.cos(-math.pi/3.5)*120*k,0.4,butNo)
        love.graphics.draw(UIBatch)
        menu:drawMessageAboutExit()
        love.graphics.setColor(0.2,0.2,0.2,1)
    else
        menu:drawMainButtons()
    end
end

function menu:drawMainButtons()
    love.graphics.draw(UIBatch)
    textButton("Skills",difButton*6+30*k2,screenHeight/2,but1,0.9)
    textButton("Converter",difButton*7+60*k2*1+30*k2,screenHeight/2, but2,0.9)
    textButton("Character",difButton*8+60*k2*2+30*k2,screenHeight/2, but5,0.9)
    textButton("Settings",difButton*9+60*k2*3+30*k2,screenHeight/2, but3,0.9)
    textButton("Exit",difButton*10+60*k2*4+30*k2,screenHeight/2, but4,0.9)
end

function menu:drawMessageAboutExit()
    textButton("Do you want to exit? ",difButton*7+60*k2*1+30*k2,screenHeight/2,false,1)
end

return menu