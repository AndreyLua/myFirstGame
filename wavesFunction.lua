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
        local Geo  =math.random(1,4)
        local Tip =math.random(1,2)
        if ( Tip == 2 ) then 
            Tip = 3
        end
        for i = 1, math.random(1,2) do 
            allSpawn(en,Geo,Tip) 
        end 
        Tip = 2
        for i = 1, math.random(1,2) do 
            allSpawn(en,Geo,Tip) 
        end 
    end
    ---------------------------
    ---------Around------------
    if ( numb == 2 ) then
        local Geo  =1
        local Tip =math.random(1,3)
        for i = 1, math.random(1,2) do 
            allSpawn(en,Geo,Tip) 
        end 
        Geo  =2
        for i = 1, math.random(1,2) do 
            allSpawn(en,Geo,Tip) 
        end 
        Geo  =3
        for i = 1, math.random(1,2) do 
            allSpawn(en,Geo,Tip) 
        end 
        Geo  =4
        for i = 1, math.random(1,2) do 
            allSpawn(en,Geo,Tip) 
        end 
    end
    ---------------------------
    ---------Group-------------
    if ( numb == 3 ) then
        local Geo  =math.random(1,4)
        local Tip =math.random(1,3)
        for i = 2, math.random(3,4) do 
            allSpawn(en,Geo,Tip) 
        end 
    end
    ---------------------------
    ---------Boom--------------
    if ( numb == 4 ) then
        local Geo  =1
        local Tip =4
        allSpawn(en,Geo,Tip) 
        Geo  =2
        allSpawn(en,Geo,Tip) 
        Geo  =3
        allSpawn(en,Geo,Tip) 
        Geo  =4
        allSpawn(en,Geo,Tip) 
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
    
    love.graphics.setColor(0.431,0.545,0.573,(125*k+wavex)/125*k+0.4)
    love.graphics.print("W   v   s", 80*k+wavex*k,screenHeight/2+fontWidth/2*k2-wavey*k2,-math.pi/2,k,k2)
    
    love.graphics.setColor(0.531,0.645,0.673,(125*k+wavex)/125*k+0.4)
    love.graphics.print("    a   e   ", 80*k+wavex*k,screenHeight/2+fontWidth/2*k2-wavey*k2,-math.pi/2,k,k2)
    
    love.graphics.setColor(0.431,0.545,0.573,(125*k+wavex)/125*k+0.4)
    fontWidth = font:getWidth(">>"..tostring (n)..'<<')
    love.graphics.print(">>"..tostring (n)..'<<', 125*k+wavex*k,screenHeight/2+fontWidth/2*k2+wavey*k2,-math.pi/2,k,k2)
end

return wavesFunction