local soundFunction = {} 

function AddSound(sound,volume,noise)
    if ( noise ==nil) then
        noise = true
    end
    if (type(sound) == 'table') then
        sound =sound[math.random(1,#sound)]
    end
    if ( noise) then 
        sound:setPitch(math.random()/7*math.random(-1,1)+1)
    end
    sound:setVolume(volume*(SoundsVolume))
    sound:clone():play()
end

function UpdateBgMusic(dt)
    if (not(bgMusic:isPlaying()) and delayMusic >= 0)  then
        delayMusic = delayMusic - 40*dt
        if (delayMusic <= 0 ) then  
            bgMusicI = bgMusicI + 1
            if ( bgMusicI >#bgMusicTableMix) then
                bgMusicI = 1
            end
            if (bgMusicTableMix[bgMusicI+1]~= bgMusicTableMix[bgMusicI]) then
                delayMusic = 100 
            else
                delayMusic = 0
            end
            bgMusic = love.audio.newSource(bgMusicTableMix[bgMusicI],"stream",false)
            bgMusic:setVolume(0.2*(MusicVolume))
            bgMusic:play()
        end
    end
end

return soundFunction