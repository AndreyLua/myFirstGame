local settings = {}

local xMusicVolume = screenWidth/6
local xMusicVolumeBut = screenWidth/6+50*k

local xSoundsVolume = screenWidth/3
local xSoundsVolumeBut = screenWidth/3+50*k

local xSensitivity = screenWidth / 1.2
local xSensitivityBut = screenWidth / 1.2+50*k

local xVibration = screenWidth / 2
local xVibrationBut = screenWidth / 2+90*k

local xController = screenWidth / 2
local xControllerBut = screenWidth / 2+50*k


local xAlpha = 0 
local but1 = false
local but2 = false
local but3 = false
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
                MusicVolume =VolumeAlpha+(xAlpha-mouse.y) /(1340*k/5)
                if ( MusicVolume > 1) then
                    MusicVolume = 1
                end
                if ( MusicVolume < 0) then
                    MusicVolume = 0
                end
            end
            but1 = true
        end
        if (((mouse.x > xSoundsVolumeBut-  146/10*k and  mouse.x <xSoundsVolumeBut+  146/10*k) or but2) and but1 ==false and but3 == false) then
            if ( but2 == false ) then 
                xAlpha = mouse.y
                VolumeAlpha = SoundsVolume
            else
                SoundsVolume =VolumeAlpha+(xAlpha-mouse.y) /(1340*k/5)
                if ( SoundsVolume > 1) then
                    SoundsVolume = 1
                end
                if (SoundsVolume < 0) then
                    SoundsVolume = 0
                end
            end
            but2 = true
        end
       
    else
        if (  mouse.x > 0 and  mouse.x <60*k and mouse.y > 0 and  mouse.y <60*k2 and flagtouch3 == true  ) then
            AddSound(uiClick,0.3)
            gamestate.switch(pause)
        end  
        but1 = false
        but2 = false
        but3 = false
        flagtouch3 =false
    end
end


function settings:draw()
    UIBatch:clear()
    love.graphics.setColor(1,1,1,0.6)
    love.graphics.draw(kek,0,0,0,1,1) 
    love.graphics.setColor(1,1,1,1)
    exit()
    
    butChange(xMusicVolumeBut,screenHeight/2,MusicVolume,1)
    butChange(xSoundsVolumeBut,screenHeight/2,SoundsVolume,1)
    butChange(xSensitivityBut,screenHeight/2,Sensitivity,2)
    acceptBut(xVibrationBut,screenHeight/2+screenHeight/4,0.45,false) 
    
    love.graphics.draw(UIBatch)
    
    textButton("Music volume",xMusicVolume,screenHeight/2,false,0.9)
    textButton("Sounds volume",xSoundsVolume,screenHeight/2,false,0.9)
    
    textButton("Vibration",xVibration,screenHeight/2+screenHeight/4,false,0.7)
    textButton("Controller",xController,screenHeight/2-screenHeight/4,false,0.7)
    
    textButton("Sensitivity",xSensitivity,screenHeight/2,false,0.9)
    

end

return settings