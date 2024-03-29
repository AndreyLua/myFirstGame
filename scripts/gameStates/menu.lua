local menu = {}


local UI= require "scripts/systemComponents/UI"
local skills = require "scripts/gameStates/menuSections/skills" 
local convert = require "scripts/gameStates/menuSections/convert/main"
local character = require "scripts/gameStates/menuSections/character"
local settings = require "scripts/gameStates/menuSections/settings" 

local difButton = (screenWidth-60*k2*5)/16
local exitFlag = false

local buttonAdd = Button(0,0,120*k,120*k)  
function buttonAdd:draw()
    exit()
end

local buttonSkillsX = difButton*6+30*k2
local buttonSkillsY = screenHeight/2
local buttonSkillsWidth = 60*k
local buttonSkillsHeight = 250*k2
local buttonSkills = Button(buttonSkillsX,buttonSkillsY,buttonSkillsWidth,buttonSkillsHeight)
function buttonSkills:draw()
    bodyButton(buttonSkills.x,buttonSkills.y,buttonSkills.isTappedFlag)
end

local buttonConverterX = difButton*7+60*k2*1+30*k2
local buttonConverterY = screenHeight/2
local buttonConverterWidth = 60*k
local buttonConverterHeight = 250*k2
local buttonConverter = Button(buttonConverterX,buttonConverterY,buttonConverterWidth,buttonConverterHeight)
function buttonConverter:draw()
    bodyButton(buttonConverter.x,buttonConverter.y,buttonConverter.isTappedFlag)
end

local buttonCharacterX = difButton*8+60*k2*2+30*k2
local buttonCharacterY = screenHeight/2
local buttonCharacterWidth = 60*k
local buttonCharacterHeight = 250*k2
local buttonCharacter = Button(buttonCharacterX,buttonCharacterY,buttonCharacterWidth,buttonCharacterHeight)
function buttonCharacter:draw()
    bodyButton(buttonCharacter.x,buttonCharacter.y,buttonCharacter.isTappedFlag)
end

local buttonSettingsX = difButton*9+60*k2*3+30*k2
local buttonSettingsY = screenHeight/2
local buttonSettingsWidth = 60*k
local buttonSettingsHeight = 250*k2
local buttonSettings = Button(buttonSettingsX,buttonSettingsY,buttonSettingsWidth,buttonSettingsHeight)
function buttonSettings:draw()
    bodyButton(buttonSettings.x,buttonSettings.y,buttonSettings.isTappedFlag)
end

local buttonExitX = difButton*10+60*k2*4+30*k2
local buttonExitY = screenHeight/2
local buttonExitWidth = 60*k
local buttonExitHeight = 250*k2
local buttonExit = Button(buttonExitX,buttonExitY,buttonExitWidth,buttonExitHeight)
function buttonExit:draw()
    bodyButton(buttonExit.x,buttonExit.y,buttonExit.isTappedFlag)
end


local buttonYesX = difButton*9+60*k2*3+30*k2 
local buttonYesY = screenHeight/2-math.cos(-math.pi/1.4)*120*k
local buttonYesScale =0.4
local buttonYesSize = buttonYesScale*k*240
local buttonYes = Button(buttonYesX,buttonYesY,buttonYesSize,buttonYesSize)
function buttonYes:draw()
    acceptBut(buttonYes.x,buttonYes.y,buttonYesScale,buttonYes.isTappedFlag) 
end

local buttonNoX = difButton*9+60*k2*3+30*k2
local buttonNoY = screenHeight/2-math.cos(-math.pi/3.5)*120*k
local buttonNoScale =0.4
local buttonNoSize = buttonNoScale*k*240
local buttonNo = Button(buttonNoX,buttonNoY,buttonNoSize,buttonNoSize)
function buttonNo:draw()
    rejectBut(buttonNo.x,buttonNo.y,buttonNoScale,buttonNo.isTappedFlag) 
end

function menu:enter()
    if (StudySystem.isEnabled ) then
        if (StudySystem.States[#StudySystem.States].state ==0) then
            StudySystem.States[#StudySystem.States]:nextState(buttonSkillsX-buttonSkillsWidth/2,buttonSkillsY-buttonSkillsHeight/2,buttonSkillsWidth,buttonSkillsHeight)
        end
        if (StudySystem.States[#StudySystem.States].state ==5) then
            StudySystem.States[#StudySystem.States]:nextState(buttonConverterX-buttonConverterWidth/2,buttonConverterY-buttonConverterHeight/2,buttonConverterWidth,buttonConverterHeight)
        end
    end
end

function menu:update(dt)
    if (StudySystem.isEnabled ) then
        StudySystem:update(dt)
    end
    if (not(StudySystem.isEnabled) or (StudySystem.isEnabled and StudySystem.States[#StudySystem.States].state ==10)) then
        if (buttonAdd:isTapped()) then 
            AddSound(uiClick,0.3)
            exp =  {}
            gamestate.switch(game)
            if ( StudySystem.isEnabled) then
                StudySystem.States[#StudySystem.States]:nextState(0,0,0,0)
            end
        end
    end
    if ( exitFlag == false) then 
        if (buttonSkills:isTapped()) then 
            if (not(StudySystem.isEnabled) or (StudySystem.isEnabled and StudySystem.States[#StudySystem.States].state ==1)) then
                AddSound(uiSelect,0.3)
                gamestate.switch(skills)
            end
        end
        if (buttonConverter:isTapped()) then 
            if (not(StudySystem.isEnabled) or (StudySystem.isEnabled and StudySystem.States[#StudySystem.States].state ==6)) then
            if ( StudySystem.isEnabled) then
                StudySystem.States[#StudySystem.States]:setConverterText()
            end
                AddSound(uiSelect,0.3)
                gamestate.switch(convert)
            end
        end
        if not(StudySystem.isEnabled) then
            if (buttonCharacter:isTapped()) then 
                AddSound(uiSelect,0.3)
                gamestate.switch(character)
            end
            if (buttonSettings:isTapped()) then 
                AddSound(uiSelect,0.3)
                gamestate.switch(settings)
            end
            if (buttonExit:isTapped()) then 
                AddSound(uiSelect,0.3)
                exitFlag = true 
            end
        end
    else
        if (buttonYes:isTapped()) then 
            AddSound(uiSelect,0.3)
            love.event.push('quit')  
        end
        if (buttonNo:isTapped()) then 
            AddSound(uiSelect,0.3)
            exitFlag = false
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
      buttonAdd:draw()
      buttonSkills:draw()
      buttonConverter:draw()
      buttonSettings:draw()
      buttonCharacter:draw()
      buttonExit:draw()
    if (exitFlag) then 
        love.graphics.setColor(0.2,0.2,0.2,1)
          menu:drawTextButtons()
          UIBatch:clear()
        love.graphics.setColor(1,1,1,1)
          exit()
          buttonYes:draw()
          buttonNo:draw()
          love.graphics.draw(UIBatch)
          menu:drawMessageAboutExit()
        love.graphics.setColor(0.2,0.2,0.2,1)
    else
        menu:drawTextButtons()
    end
    if (StudySystem.isEnabled ) then
        StudySystem:draw()
    end
end

function menu:drawTextButtons()
    love.graphics.draw(UIBatch)
    textButton("Skills",buttonSkills.x,buttonSkills.y,buttonSkills.isTappedFlag,0.9)
    textButton("Converter",buttonConverter.x,buttonConverter.y,buttonConverter.isTappedFlag,0.9)
    textButton("Character",buttonCharacter.x,buttonCharacter.y,buttonCharacter.isTappedFlag,0.9)
    textButton("Settings",buttonSettings.x,buttonSettings.y,buttonSettings.isTappedFlag,0.9)
    textButton("Exit",buttonExit.x,buttonExit.y,buttonExit.isTappedFlag,0.9)
end

function menu:drawMessageAboutExit()
    textButton("Do you want to exit? ",buttonConverterX,screenHeight/2,false,1)
end

return menu