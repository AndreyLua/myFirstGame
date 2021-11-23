local wavesFunction = {}

function wavesUpdate(dt)
    if ( colWave<=0) then
        numberWave = numberWave +1 
        local Wave = waves[numberWave]
        colWave =Wave[4] --- update
        
        wavesNextWave()
    end
end

function wavesNextWave()
    waveflag = 0
    wavex = -250*k
    wavey = 0
end

function wavesSpawnGroup(numb)
    ---------Front-------------
    if ( numb == 1 ) then
        
    end
    ---------------------------
    ---------Around------------
    if ( numb == 2 ) then
      
    end
    ---------------------------
    ---------Group-------------
    if ( numb == 3 ) then
      
    end
    ---------------------------
    ---------Boom--------------
    if ( numb == 4 ) then
      
    end
    ---------------------------
end




function wavesTitleDraw(n,dt)
    if ( waveflag == 0   ) then
        if (wavex*k<0) then
            wavex = wavex+100*dt*k
        else
            wavex = 0 
            waveflag = 1
        end
    end
    if ( waveflag == 1) then
        wavetimer:update(dt)
        wavetimer:every(3, function()
            wavetimer:clear() 
            waveflag = 2
        end)
    end
    if ( waveflag == 2 and wavex == 0) then
        if (wavey*k<screenHeight/2+200*k2) then
            wavey = wavey+200*k*dt
        end
    end

    local fontWidth = font:getWidth("Waves")
    love.graphics.setColor(0.8,0.5,0,(125*k+wavex)/125*k+0.4)
    love.graphics.print("Waves", 80*k+wavex*k,screenHeight/2+fontWidth/2*k2-wavey*k2,-math.pi/2,k,k2)
    love.graphics.setColor(0.7,0.48,0.2,(125*k+wavex)/125*k+0.4)
    fontWidth = font:getWidth(">>"..tostring (n)..'<<')
    love.graphics.print(">>"..tostring (n)..'<<', 125*k+wavex*k,screenHeight/2+fontWidth/2*k2+wavey*k2,-math.pi/2,k,k2)
end

return wavesFunction