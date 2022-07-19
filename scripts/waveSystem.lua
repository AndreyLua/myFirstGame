local waveSystem = {}

Wave = {
    notionIdleTimer =  Timer.new(),
    timerSpawnObj = Timer.new(),
    timerSpawnEn = Timer.new(),
    notionX = -250*k,
    notionY = 0,
    notionState = 0,
    number =1,
    countKilledEnemies = 50,
    goalKillEnemies = 50,
    lvl = 1,
    lvlMax =5,
}

function Wave:update(dt)
    Wave.timerSpawnObj:update(dt)
    Wave.timerSpawnEn:update(dt)
    if ( self.countKilledEnemies<=0) then
        self.number = self.number + 1 
        self.goalKillEnemies = self.goalKillEnemies *(1+self.number/10)
        self.countKilledEnemies = self.goalKillEnemies
        self.lvl =1+math.ceil(self.number/2)
        if ( self.lvl > self.lvlMax) then 
            self.lvl = self.lvlMax
        end
        self.refreshNotionParameters(self)
        makeSave()
    end
end

function Wave:spawn()
    self.spawnObj(self)
    self.spawnEnemies(self)
end

function Wave:spawnObj()
    if (#obj < 200) then
        Wave.timerSpawnObj:every(math.random(10,12)/(1+self.number/10), function()
            for i=1,math.random(1,2) do
                local Geo  =math.random(1,4)
                allSpawn(obj,Geo,math.random(1,5))
                if ( #obj >30) then
                    if ( math.random(1,100) >50) then
                        allSpawn(en,Geo,6)
                    end
                end
            end
            Wave.timerSpawnObj:clear() 
        end)
    end  
end

function Wave:spawnEnemies()
    if (#en < 50) then
        Wave.timerSpawnEn:every(math.random(15,17)/(1+self.number/10), function()
            local Geo  =math.random(1,4)
            local Tip =math.random(1,self.lvl)
            allSpawn(en,Geo,Tip)
            if (math.random(1,100) > 90 and self.number>=8 ) then   
             --   self.wavesSpawnGroup(math.random(1,4))
            end
            Wave.timerSpawnEn:clear() 
        end)
    end   
end

function Wave:refreshNotionParameters()
    self.notionState = 0
    self.notionX = -250*k
    self.notionY = 0
end

function Wave:spawnGroup(numb)
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

function Wave:notionDraw(dt)
    if ( self.notionState == 0   ) then
        if (self.notionX*k<0) then
            self.notionX = self.notionX+100*dt*k
        else
            self.notionX = 0 
            self.notionState = 1
        end
    end
    if ( self.notionState == 1) then
        self.notionIdleTimer:update(dt)
        self.notionIdleTimer:every(3, function()
            self.notionIdleTimer:clear() 
            self.notionState = 2
        end)
    end
    if ( self.notionState == 2 and self.notionX == 0) then
        if (self.notionY*k<screenHeight/2+200*k2) then
            self.notionY = self.notionY+200*k*dt
        end
    end

    local fontWidthNotion = font:getWidth("Waves")
    
    love.graphics.setColor(0.431,0.545,0.573,(125*k+self.notionX)/125*k+0.4)
        love.graphics.print("W   v   s", 80*k+self.notionX*k,screenHeight/2+fontWidthNotion/2*k2-self.notionY*k2,-math.pi/2,k,k2)
        
    love.graphics.setColor(0.531,0.645,0.673,(125*k+self.notionX)/125*k+0.4)
        love.graphics.print("    a   e   ", 80*k+self.notionX*k,screenHeight/2+fontWidthNotion/2*k2-self.notionY*k2,-math.pi/2,k,k2)
        
    fontWidthNotion = font:getWidth(">>"..tostring (self.number)..'<<')    
    love.graphics.setColor(0.431,0.545,0.573,(125*k+self.notionX)/125*k+0.4)
        love.graphics.print(">>"..tostring (self.number)..'<<', 125*k+self.notionX*k,screenHeight/2+fontWidthNotion/2*k2+self.notionY*k2,-math.pi/2,k,k2)
end

function Wave:progressBarDraw()
    love.graphics.setColor(0.431,0.545,0.573)
    love.graphics.rectangle("line",50*k,screenHeight/2-(self.countKilledEnemies*250*k2/self.goalKillEnemies)/2,8*k,self.countKilledEnemies*250*k2/self.goalKillEnemies)
    love.graphics.setColor(1,1,1,1)
end 

function Wave:progressBarEffect(enValue)
    explosionEffect:new(54*k,screenHeight/2-(self.countKilledEnemies*250*k2/self.goalKillEnemies)/2,10)
    explosionEffect:new(54*k,screenHeight/2+(self.countKilledEnemies*250*k2/self.goalKillEnemies)/2,10)
    self.countKilledEnemies =  self.countKilledEnemies - enValue
end

return waveSystem