local settings = {}

local difButton = (screenWidth-3*(45*k2*0.9+200/4*k)-45*k2*0.9-k/2*120)/28


local xMusicVolume = difButton*10+45*k2*0.9/2
local xMusicVolumeBut =xMusicVolume+difButton+45*k2*0.9/2+200/4*k/2

local xSoundsVolume = xMusicVolumeBut+200/4*k/2+difButton*1+45*k2*0.9/2 
local xSoundsVolumeBut =xSoundsVolume+45*k2*0.9/2+difButton+200/4*k/2

local xController = xSoundsVolumeBut+200/4*k/2+difButton*2+45*k2*0.9/2 
local xControllerBut = xController+ 45*k2*0.9/2 + difButton + k/4*120

local xSensitivity = xControllerBut+ k/4*120 + difButton+ 45*k2*0.9/2
local xSensitivityBut = xSensitivity+ 45*k2*0.9/2+difButton+200/4*k/2



local xAlpha = 0 
local but1 = false
local but2 = false
local but3 = false

local but4 = false

local VolumeAlpha = MusicVolume



function settings:update(dt)
    mouse.x,mouse.y=love.mouse.getPosition()
    mouse.x = mouse.x
    mouse.y = mouse.y
    ggtouch =(sens)
    if (love.mouse.isDown(1)) then
        flagtouch3 =true
        if (((mouse.x > xMusicVolumeBut-  146/10*k and  mouse.x <xMusicVolumeBut+  146/10*k) or but1) and but2 ==false and but3 == false) then
            if ( but1 == false ) then 
                xAlpha = mouse.y
                VolumeAlpha = MusicVolume
            else
                MusicVolume =VolumeAlpha+(xAlpha-mouse.y) /(1340*k/10)
                if ( MusicVolume > 2) then
                    MusicVolume = 2
                end
                if ( MusicVolume < 0) then
                    MusicVolume = 0
                end
                bgMusic:setVolume(0.2*(MusicVolume))
            end
            but1 = true
        end
        if (((mouse.x > xSoundsVolumeBut-  146/10*k and  mouse.x <xSoundsVolumeBut+  146/10*k) or but2) and but1 ==false and but3 == false) then
            if ( but2 == false ) then 
                xAlpha = mouse.y
                VolumeAlpha = SoundsVolume
            else
                SoundsVolume =VolumeAlpha+(xAlpha-mouse.y) /(1340*k/10)
                if ( SoundsVolume > 2) then
                    SoundsVolume = 2
                end
                if (SoundsVolume < 0) then
                    SoundsVolume = 0
                end
            end
            but2 = true
        end
        if (((mouse.x > xSensitivityBut-  146/10*k and  mouse.x <xSensitivityBut+  146/10*k) or but3) and but1 ==false and but2 == false) then
            if ( but3 == false ) then 
                xAlpha = mouse.y
                VolumeAlpha = Sensitivity
            else
                Sensitivity =VolumeAlpha+(xAlpha-mouse.y) /(1340*k/10)
                if ( Sensitivity > 2) then
                    Sensitivity = 2
                end
                if (Sensitivity < 0.2) then
                    Sensitivity = 0.2
                end
            end
            but3 = true
        end
        if (  mouse.x >  xControllerBut - 120*k/4  and  mouse.x < xControllerBut+120*k/4 and mouse.y > screenHeight/2-500*k/4 and  mouse.y <screenHeight/2+500*k/4 and but1 ==false and  but2 ==false and but3 == false) then
            but4 = true
        end 
    else
        if (  mouse.x > 0 and  mouse.x <60*k and mouse.y > 0 and  mouse.y <60*k2 and flagtouch3 == true  ) then
            AddSound(uiClick,0.3)
            gamestate.switch(pause)
        end  
        if (  mouse.x >  xControllerBut - 120*k/4  and  mouse.x < xControllerBut+120*k/4 and mouse.y > screenHeight/2-500*k/4 and  mouse.y <screenHeight/2+500*k/4 and but4 == true) then
            AddSound(uiSelect,0.3)
            controllerChoose = controllerChoose + 1 
            if (controllerChoose > 3) then
                controllerChoose = 1
            end
        end 
        but1 = false
        but2 = false
        but3 = false
        but4 = false
        flagtouch3 =false
    end
end


function settings:draw()
    UIBatch:clear()
    love.graphics.setColor(1,1,1,0.6)
    love.graphics.draw(canvasToEffect,0,0,0,1,1) 
    love.graphics.setColor(1,1,1,1)
    add()
    
    butChange(xMusicVolumeBut,screenHeight/2,MusicVolume,2)
    butChange(xSoundsVolumeBut,screenHeight/2,SoundsVolume,2)
    butChange(xSensitivityBut,screenHeight/2,Sensitivity,2)
    bodyButton(xControllerBut,screenHeight/2,but4)
    love.graphics.draw(UIBatch)
    
    textButton("Music volume",xMusicVolume,screenHeight/2,false,0.9)
    textButton("Sounds volume",xSoundsVolume,screenHeight/2,false,0.9)
    
    textButton("Controller",xController,screenHeight/2,false,0.9)
    textButtonFixed({"Not fixed","Fixed - left","Fixed - right"},xControllerBut,screenHeight/2,but4,0.7,controllerChoose)
    textButton("Sensitivity",xSensitivity,screenHeight/2,false,0.9)
  
end

return settings