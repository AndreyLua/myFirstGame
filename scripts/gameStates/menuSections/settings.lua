local settings = {}

local buttonAdd = Button(0,0,120*k,120*k)  
function buttonAdd:draw()
    add()
end

local difButton = (screenWidth-3*(45*k2*0.9+200/4*k)-45*k2*0.9-k/2*120)/28

local textButtonMusicVolumeX = difButton*10+45*k2*0.9/2
local sliderMusicVolumeX =textButtonMusicVolumeX+difButton+45*k2*0.9/2+200/4*k/2

local textButtonSoundsVolumeX = sliderMusicVolumeX+200/4*k/2+difButton*1+45*k2*0.9/2 
local sliderSoundsVolumeX =textButtonSoundsVolumeX+45*k2*0.9/2+difButton+200/4*k/2
local buttonTextControllerX = sliderSoundsVolumeX+200/4*k/2+difButton*2+45*k2*0.9/2 
local buttonControllerX = buttonTextControllerX+ 45*k2*0.9/2 + difButton + k/4*120
local sliderTextSensitivityX = buttonControllerX+ k/4*120 + difButton+ 45*k2*0.9/2
local sliderSensitivityX = sliderTextSensitivityX+ 45*k2*0.9/2+difButton+200/4*k/2

local buttonController = Button(buttonControllerX,screenHeight/2,60*k,250*k2)
function buttonController:draw()
    bodyButton(buttonController.x,buttonController.y,buttonController.isTappedFlag)
end

function settings:init()
    sliderMusicVolume = Slider(sliderMusicVolumeX, screenHeight/2,146/5*k,screenHeight,MusicVolume,0,2)
    sliderSoundsVolume = Slider(sliderSoundsVolumeX, screenHeight/2,146/5*k,screenHeight,SoundsVolume,0,2)
    sliderSensitivity = Slider(sliderSensitivityX,screenHeight/2,146/5*k,screenHeight,Sensitivity,0.2,2)
end

function settings:update(dt)
    if (buttonAdd:isTapped()) then 
        AddSound(uiClick,0.3)
        gamestate.switch(menu)
    end
    if (buttonController:isTapped()) then
        AddSound(uiSelect,0.3)
        controllerChoose = controllerChoose + 1 
        if (controllerChoose > 3) then
            controllerChoose = 1
        end
    end
    if (sliderMusicVolume:isPressed()) then 
        MusicVolume =sliderMusicVolume:getValue()
        bgMusic:setVolume(0.2*(sliderMusicVolume.value))
    end
    if (sliderSoundsVolume:isPressed()) then 
        SoundsVolume =sliderSoundsVolume:getValue()
    end
    if (sliderSensitivity:isPressed()) then 
        Sensitivity =sliderSensitivity:getValue()
    end    
end


function settings:draw()
    UIBatch:clear()
    love.graphics.setColor(1,1,1,0.6)
      love.graphics.draw(canvasToEffect,0,0,0,1,1) 
    love.graphics.setColor(1,1,1,1)
    
    buttonAdd:draw()
    sliderMusicVolume:draw()
    sliderSensitivity:draw()
    sliderSoundsVolume:draw()
    buttonController:draw()
    
    love.graphics.draw(UIBatch)
    
    settings:drawTextButtons()
end

function settings:drawTextButtons()
    textButton("Music volume",textButtonMusicVolumeX,screenHeight/2,false,0.9)
    textButton("Sounds volume",textButtonSoundsVolumeX,screenHeight/2,false,0.9)
    textButton("Controller",buttonTextControllerX,screenHeight/2,false,0.9)
    textButtonFixed({"Not fixed","Fixed - left","Fixed - right"},buttonControllerX,screenHeight/2,buttonController.isTappedFlag,0.7,controllerChoose)
    textButton("Sensitivity",sliderTextSensitivityX,screenHeight/2,false,0.9)
end

return settings