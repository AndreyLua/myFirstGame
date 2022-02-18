local soundFunction = {} 

function AddSound(sound,volume,noise)
    if ( noise ==nil) then
        noise = true
    end
    if (type(sound) == 'table') then
        sound =sound[math.random(1,#sound)]
    end
    local soundSource = love.audio.newSource(sound, "static",false)
    soundSource:setVolume(volume)
    if ( noise) then 
        soundSource:setPitch(math.random()/7*math.random(-1,1)+1)
    end
    table.insert(soundEffects,soundSource)
end

function UpdateBgMusic()
    if not(bgMusic:isPlaying()) then
        bgMusicI = bgMusicI + 1
        if ( bgMusicI >#bgMusicTableMix) then
            bgMusicI = 1
        end
        bgMusic = love.audio.newSource(bgMusicTableMix[bgMusicI],"stream",false)
        bgMusic:setVolume(0.2)
        bgMusic:play()
    end
end



function UpdateSound()
    for i=#soundEffects,1,-1 do
          love.audio.play(soundEffects[i])
          if (soundEffects[i]:isPlaying()) then 
              table.remove(soundEffects,i)
          end
    end
end


return soundFunction