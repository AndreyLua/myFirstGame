local convert = {}

local UI = require "scripts/systemComponents/UI"
local playerSkillsFunction = require "scripts/playerGameObject/playerSkills"
local particlSystem = require "scripts/gameStates/menuSections/convert/particlSystem"
local rewardSystem = require "scripts/gameStates/menuSections/convert/rewardSystem"

local buttonAdd = Button(0,0,120*k,120*k)  
function buttonAdd:draw()
    add()
end

local buttonOkX = screenWidth/2+200*k
local buttonOkY = screenHeight/2
local buttonOkWidth = 60*k
local buttonOkHeight = 250*k2
local buttonOk = Button(buttonOkX,buttonOkY,buttonOkWidth,buttonOkHeight)
function buttonOk:draw()
    bodyButton(buttonOk.x,buttonOk.y,buttonOk.isTappedFlag)
end
      
local buttonConvertX = screenWidth/1.7+220*k
local buttonConvertY = screenHeight/2
local buttonConvertWidth = 60*k
local buttonConvertHeight = 250*k2
local buttonConvert = Button(buttonConvertX,buttonConvertY,buttonConvertWidth,buttonConvertHeight)
function buttonConvert:draw(light)
    bodyButton(buttonConvert.x,buttonConvert.y,buttonConvert.isTappedFlag,light)
end

local Flask = {
    bodySprite = love.graphics.newImage("assets/constrSet.png"),
    standSprite = love.graphics.newImage("assets/constrSet2.png"),
    body = HC.circle(screenWidth/1.7,screenHeight/2,80*k),
    flaskFill = false,
    redTextColor = -0.1,
    flagRedText = true,
    
    Borders = {
        R = {
            body1 = HC.rectangle(0,0,25*k,30*k2),--2.1867155200084
            body2 = HC.rectangle(0,0,22*k,22*k2),--2.5879619886168
            body3 = HC.rectangle(0,0,25*k,30*k2),--2.9036124236754
            body4 = HC.circle(0,0,10*k),--2.5465780219889
        },
        L = {
            body1 = HC.rectangle(0,0,25*k,30*k2),--2.1867155200084
            body2 = HC.rectangle(0,0,22*k,22*k2),--2.5879619886168
            body3 = HC.rectangle(0,0,25*k,30*k2),--2.9036124236754
            body4 = HC.circle(0,0,10*k),--2.5465780219889
        },    
    },
}

local playerSkills = {}

function convert:init()
    Flask.Borders:init()
end

function convert:enter()
    NeedResourcesText:reset()
    playerSkills = {}
    Player.Skills:skillsTable(playerSkills)
    Player.Skills:sortSkillsTable(playerSkills)
end

function convert:update(dt)
    explosionEffect:update(dt)
    Particle:update(Flask,dt)
    Reward:updateSlotScale(dt)
    Flask:isFill()
    
    if (buttonAdd:isTapped()) then 
        exp = {}
        AddSound(uiClick,0.3)
        gamestate.switch(menu)
    end
    
    if (Reward.flagMenu == true and buttonOk:isTapped()) then
        Reward.flagMenu = false
        AddSound(uiSelect,0.3,false)
        Reward:give(playerSkills)
        playerSkills = {} 
        Player.Skills:skillsTable(playerSkills)
        Player.Skills:sortSkillsTable(playerSkills)
    end
    
    if ( Reward.flagMenu == false and buttonConvert:isTapped() and Particle.flagClear == false) then
        Flask:convert()
    end

    if love.mouse.isDown(1)  then
        local distanceX = mouse.x-screenWidth/1.7
        local distanceY = mouse.y -screenHeight/2
        if ( (distanceX*distanceX + distanceY*distanceY < 100*k*100*k) and #Particle.list<140 and Reward.flagMenu == false ) then
            if ( score >=scoreForParticle and Particle.flagClear == false) then
                score = score - scoreForParticle
                if ( Particle.delaySound <=0) then
                    AddSound(uiParticle,0.2)
                    Particle.delaySound = 1
                end
                Particle.delaySound = Particle.delaySound - 15*dt
                if ( math.random(1,2) == 1 ) then
                    Particle:spawn(0,math.random(screenHeight/2-90*k2,screenHeight/2-40*k2),1)
                else
                    Particle:spawn(0,math.random(screenHeight/2+40*k2,screenHeight/2+90*k2),1)
                end
            else
                if (NeedResourcesText.timer == nil or  NeedResourcesText.timer < 0) then 
                    NeedResourcesText.timer = 0
                end
                NeedResourcesText.flag = true
            end
        end
    end
end

function convert:draw()
    local dt = love.timer.getDelta()
    UIBatch:clear()
    skillBatch:clear()
    love.graphics.setColor(1,1,1,1)
      love.graphics.draw(fon1,0,0,0,k,k2)
      love.graphics.draw(fon2,0,0,0,k,k2)
      love.graphics.draw(fon3,0,0,0,k,k2)
      buttonAdd:draw()
    love.graphics.setColor(1-Reward.slotScale,1-Reward.slotScale,1-Reward.slotScale,1-Reward.slotScale)
      buttonConvert:draw(Reward.slotScale)
      love.graphics.draw(Flask.bodySprite,screenWidth/1.7,screenHeight/2,-math.pi/2,k/1.9,k2/1.9,250,193.5)
      love.graphics.draw(Flask.standSprite,screenWidth/1.7+95*k,screenHeight/2,-math.pi/2,k/1.9,k2/1.9,200,150.5)
      Particle:draw(dt)
    love.graphics.setColor(1,1,1,0.6-Reward.slotScale)
      love.graphics.draw(Flask.bodySprite,screenWidth/1.7,screenHeight/2,-math.pi/2,k/1.9,k2/1.9,250,193.5)
      love.graphics.setColor(1-Reward.slotScale,1-Reward.slotScale,1-Reward.slotScale,1-Reward.slotScale)
      textButton("Tap to fill",screenWidth/1.53,screenHeight/2,false,0.5)
    love.graphics.setColor(0,0,0,1)
      love.graphics.rectangle('fill',0,screenHeight/2-100*k2,35*k,200*k2)
    love.graphics.setColor(1,1,1,0.6-Reward.slotScale)
      sc(0,screenHeight/2)
      local fontWidth = font:getWidth(tostring(score))
      love.graphics.print(score,50*k/12, screenHeight/2+fontWidth/2*k2/2,-math.pi/2,k/2,k2/2)
    Flask:textColor(#Particle.list)
    Flask:noFillColor(dt)
      Flask:printFillPercent()
      
    love.graphics.setColor(1,1,1,1) 
    if (Reward.flagMenu == true) then 
        Reward:draw()
        buttonOk:draw()
    end
    love.graphics.draw(UIBatch)
    love.graphics.draw(skillBatch) 
    if (Reward.flagMenu == false) then 
        love.graphics.print(tostring(#playerSkills).."/14", screenWidth/1.7-130*k,screenHeight/2-130*k,-math.pi/2,k*0.4,k2*0.4)
    end
    love.graphics.setColor(1-Reward.slotScale,1-Reward.slotScale,1-Reward.slotScale,1-Reward.slotScale) 
    
    textButton("Convert",screenWidth/1.7+220*k,screenHeight/2,flagButton1)
    if (Reward.flagMenu == true) then 
        love.graphics.setColor(1,1,1,1) 
          textButton("Ok",screenWidth/2+200*k,screenHeight/2,flagButton2)  
        love.graphics.setColor(0.125,0.251,0.302,1) 
          if ( Reward.money > 0 and Reward.skill == nil) then 
              textButton(Reward.money,screenWidth/2,screenHeight/2,false,1.6*Reward.slotScale)  
          end
    end
    -----------
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 100, 10,0,k/2,k2/2)
    love.graphics.print("particl: "..tostring(#Particle.list), 100, 70,0,k/2,k2/2)
    -----------
    explosionEffect:draw()
    
    NeedResourcesText:print(100*k,screenHeight/2,0.6,dt)
end

function Flask:noFillColor(dt)
    if (self.redTextColor~= nil and self.flagRedText~=nil and self.redTextColor >= 0) then 
        love.graphics.setColor(1,self.redTextColor,self.redTextColor,1)
        if ( self.redTextColor <=3 and self.flagRedText ==true ) then
            self.redTextColor = self.redTextColor+5*dt
        else
            if ( self.redTextColor > 2 and self.flagRedText ==true ) then 
                self.redTextColor = self.redTextColor-5*dt
                self.flagRedText = false
            else
                if (self.flagRedText ==false and self.redTextColor >=0 ) then 
                    self.redTextColor = self.redTextColor-5*dt
                    self.flagRedText = false
                end
            end
        end
    end
end

function Flask.Borders:init()
    self.R.body1:moveTo(screenWidth/1.7-math.sin(2.1867155200084+math.pi*1.611)*108*k	,screenHeight/2- math.cos(2.1867155200084+math.pi*1.611)*108*k)
    self.R.body1:setRotation(-1.07)
    self.R.body2:moveTo(screenWidth/1.7-math.sin(2.5879619886168+math.pi*1.351)*104*k	,screenHeight/2- math.cos(2.5879619886168+math.pi*1.351)*104*k)
    self.R.body2:setRotation(0.96-0.14-0.14)
    self.R.body3:moveTo(screenWidth/1.7-math.sin(2.9036124236754+math.pi*1.152)*129.5*k	,screenHeight/2- math.cos(2.9036124236754+math.pi*1.152)*129.5*k)
    self.R.body3:setRotation(-0.58)
    self.R.body4:moveTo(screenWidth/1.7-math.sin(2.5465780219889+math.pi*1.378)*115*k	,screenHeight/2- math.cos(2.5465780219889+math.pi*1.378)*115*k)
    
    self.L.body1:moveTo(screenWidth/1.7-math.sin(2.1867155200084)*108*k	,screenHeight/2- math.cos(2.1867155200084)*108*k)
    self.L.body1:setRotation(1.14)
    self.L.body2:moveTo(screenWidth/1.7-math.sin(2.5879619886168)*104*k	,screenHeight/2- math.cos(2.5879619886168)*104*k)
    self.L.body2:setRotation(0.96)
    self.L.body3:moveTo(screenWidth/1.7-math.sin(2.9036124236754)*129.5*k	,screenHeight/2- math.cos(2.9036124236754)*129.5*k)
    self.L.body3:setRotation(0.52)
    self.L.body4:moveTo(screenWidth/1.7-math.sin(2.5465780219889)*115*k	,screenHeight/2- math.cos(2.5465780219889)*115*k)
end

function Flask:convert()
    if (self.flaskFill==true and (Particle.list[#Particle.list].body:collidesWith(self.body))) then
        Particle.flagClear = true
        AddSound(uiSelect,0.3)
        AddSound(uiParticleDestroy,0.2,false)
        Reward.count = #Particle.list
    else
        if (Flask.flaskFill~=true) then 
            if (self.redTextColor == nil or  self.redTextColor < 0) then 
                self.redTextColor = 0
            end
            self.flagRedText = true
        end
        AddSound(uiError,0.2)
    end
end

function Flask:textColor(particleCount)
    if ( math.ceil(particleCount/1.4)>= 30 ) then 
        love.graphics.setColor(0.308,0.661,0.445,1) 
    end
    if ( math.ceil(particleCount/1.4)>= 60 ) then 
        love.graphics.setColor(0.6,0.3,0.6,1) 
    end
    if ( math.ceil(particleCount/1.4)== 100 ) then 
        love.graphics.setColor(0.8,0.8,0.3,1) 
    end
end

function Flask:printFillPercent()
    local fontWidth = font:getWidth(tostring(math.abs(math.ceil(#Particle.list/1.4)))..'%')
    love.graphics.print(tostring(math.abs(math.ceil(#Particle.list/1.4)))..'%',screenWidth/1.7-250*k/1.9, screenHeight/2+fontWidth/2*k2/1.5,-math.pi/2,k/1.5,k2/1.5)
end

function Flask:isFill()
    if ( math.ceil(#Particle.list/1.4)>= 30 ) then 
        Flask.flaskFill= true
    else
        Flask.flaskFill= false
    end
end

return convert