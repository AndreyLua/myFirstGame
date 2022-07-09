local game = {} 

local buttonAdd = Button(0,0,120*k,120*k)  
function buttonAdd:draw()
    add()
end


score = 20000
borderWidth =screenWidth/2
borderHeight = screenHeight/2
numberCleaner = 0 
shake = 0



local playerFunction = require "scripts/playerGameObject/playerFunction"
local bulletFunction = require "scripts/bulletsGameObject/bulletFunction"
local enFunction = require "scripts/enemiesGameObject/enFunction"
local enClassMelee = require "scripts/enemiesGameObject/enemyClass/enClassMelee" 
local enClassHammer = require "scripts/enemiesGameObject/enemyClass/enClassHammer" 
local enClassShooter = require "scripts/enemiesGameObject/enemyClass/enClassShooter" 
local enClassInvader = require "scripts/enemiesGameObject/enemyClass/enClassInvader" 
local enClassBomb = require "scripts/enemiesGameObject/enemyClass/enClassBomb" 
local enClassСleaner = require "scripts/enemiesGameObject/enemyClass/enClassCleaner" 
local resSimpleClass =  require "scripts/resourcesGameObject/resourceClass" 
local resFunction = require "scripts/resourcesGameObject/resFunction" 
local objFunction = require "scripts/meteoritesGameObject/objFunction" 
local waveSystem = require "scripts/waveSystem" 
menu = require "scripts/gameStates/menu" 
local loadGame = require "scripts/systemComponents/loadGame"
local studySystem = require "scripts/studySystem"
LoadPlayerImg()
LoadSkillsImg()
LoadPlayerParametrs()
LoadEnImg()
LoadObjImg()

function game:init()
  
if (StudySystem.isEnabled) then 
    StudySystem:load()
end
  
Wave:refreshNotionParameters()
Player:refreshParameters()
  

enBoomAnimat = {}
resourcesReceiveText = {}

en = {}
obj = {}
resource = {}
objRegulS  = {}
enRegulS  = {}
enAfterDieTex = {} 

bulletRegulS  = {}
waveRegulS = {}
enemyBullets = {} 

playerSledi = {} 

masli= {} 


Player:refreshParameters()
end

function gamestate.focus(v)
    if (not(v) and gamestate.current() == game) then
        gamestate.switch(menu)
    end
end

function love.update(dt)
    mouse.x,mouse.y=love.mouse.getPosition()
    UpdateBgMusic(dt)
end

function love.quit()
    makeSave()
end

function love.keypressed(key, code)
    if key == "escape" then
        gamestate.switch(menu)
    elseif key == "q" then
        love.event.push('quit')
    end
end

function game:update(dt)
if (buttonAdd:isTapped()) then 
    AddSound(uiClick,0.3)
    gamestate.switch(menu)
end
 --en = {}
 --obj = {}
--Player.flagInv =true
EnergyArmorEffect:update(dt)
explosionEffect:update(dt)
DamageVisualizator:update(dt)
SpikeArmorEffect:update(dt)
VampirEffect:update(dt)
WaveEffect:update(dt)
GetDamageEffect:update(dt)
HealEffect:update(dt)
BloodyEffect:update(dt)

objRegulS = {}
enRegulS = {}

--Player.Energy.value = 1000
--Player.Hp.value = 1000 
if not(StudySystem.isEnabled) then 
    Wave:update(dt)
else
    StudySystem:update(dt)
end
--------------------
Player.Camera:update(dt)
Player:control()
Player:invisible(dt)
Player.Clows:update(dt)
Player.Hp:update(dt)
-------------------
for i = #obj, 1, -1 do
    if (obj[i]) then  
        allInvTimer(i,obj,dt)
        objMove(i,dt) 
        allBorder(i,obj)
        if (obj[i]) then 
            local IobjRegulS =math.floor((obj[i].x-60*k)/(120*k)) + math.floor((obj[i].y-60*k2)/(120*k2))*math.floor((screenWidth/(120*k))+1)
            if (obj[i].x>Player.Camera.x-screenWidth/2-obj[i].collScale*k and  obj[i].x<screenWidth+Player.Camera.x-screenWidth/2+20*k+obj[i].collScale*k and  obj[i].y>Player.Camera.y-screenHeight/2-obj[i].collScale*k2 and obj[i].y<screenHeight+Player.Camera.y-screenHeight/2+20*k2+obj[i].collScale*k2) then
                if (objRegulS[IobjRegulS]) then
                    table.insert(objRegulS[IobjRegulS],i)
                else
                    objRegulS[IobjRegulS] = {i}
                end
            end
        end
    end
    if (obj[i] and obj[i].health<0) then 
        AddSound(objCrashSounds,0.1)
        objDestroy(obj,i) 
        table.remove(obj,i)
    end
end
 
for i = #en, 1, -1 do
    if (en[i]) then 
        en[i]:invTimerUpdate(dt)
        en[i]:move(dt) 
        en[i]:atackTimerUpdate(dt)
        en[i]:atackStart()
        en[i]:insertInRegulS(i)
        en[i]:traceSpawn()
        en[i]:kill(i)
    end
end

for i = #resource, 1, -1 do
    if (resource[i]) then 
        resource[i]:GravityWithPlayer()
        resource[i]:update(dt)
        resource[i]:border(i)
        if (resource[i] and resource[i].tip == 6) then  
            resource[i]:traceSpawn()
        end
        if (resource[i]) then  
            resource[i]:collWithPlayer(i)
        end
        if (resource[i]) then  
            local indexResInRegS = resource[i]:IndexInRegulS(80)
            resource[i]:collWithEn(indexResInRegS,i,dt)
            if (numberCleaner > 0) then 
                if (resource[i]) then  
                    resource[i]:collWithEn(indexResInRegS-1,i,dt)
                end
                if (resource[i]) then
                    resource[i]:collWithEn(indexResInRegS+1,i,dt)
                end
                if (resource[i]) then
                    resource[i]:collWithEn(indexResInRegS-math.floor((screenWidth/(80*k))+1),i,dt)
                end
                if (resource[i]) then
                    resource[i]:collWithEn(indexResInRegS+math.floor((screenWidth/(80*k))+1),i,dt)
                end
                if (resource[i]) then
                    resource[i]:collWithEn(indexResInRegS+math.floor((screenWidth/(80*k))+1)+1,i,dt)
                end
                if (resource[i]) then
                    resource[i]:collWithEn(indexResInRegS+math.floor((screenWidth/(80*k))+1)-1,i,dt)
                end
                if (resource[i]) then
                    resource[i]:collWithEn(indexResInRegS-math.floor((screenWidth/(80*k))+1)+1,i,dt)
                end
                if (resource[i]) then
                    resource[i]:collWithEn(indexResInRegS-math.floor((screenWidth/(80*k))+1)-1,i,dt)
                end
            end
        end
    end
end

Wave:spawn()
Player:move(dt)
Player:collision(dt)
Player.Energy:update(dt)
Player:debaff(dt)
bulletsUpdate(dt)
self:movement(dt)
Player:border()

end

function game:keypressed(key1,key, code)
    if key == "escape" then
        if gamestate.current() == self and Player.isAlive then
            gamestate.switch(pause)
        end
    elseif key == "q" then
        love.event.push('quit')
    end
end

function game:movement(dt)
    if love.keyboard.isDown('e') then
        local Geo  =math.random(1,4)
        allSpawn(obj,Geo)
        obj[#obj].f = true
        obj[#obj].x = mouse.x
        obj[#obj].y = mouse.y
        allSpawn(en,Geo,math.random(6))
        en[#en].x = mouse.x
        en[#en].y = mouse.y
    end
    if love.keyboard.isDown('y') then
        table.remove(obj,#obj)
    end
end


function  game:draw()
    local dt = love.timer.getDelta()
    boomBatch:clear()
    UIBatch:clear()
    playerBatch:clear()
    resBatch:clear()
    enBatch:clear()
    enBatchDop:clear()
    enBatchAfterDie:clear()
    love.graphics.setCanvas(canvasToEffect)
    love.graphics.clear()
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(fon1,0,0,0,k,k2)
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(fon2,(-Player.x+40*k/2+screenWidth/2)/20,(-Player.y+40*k2/2+screenHeight/2)/40,0,k,k2)
    love.graphics.draw(fon3,(-Player.x+40*k/2+screenWidth/2)/7,(-Player.y+40*k2/2+screenHeight/2)/10,0,k,k2)
    if (Player.flagInv == false ) then
        love.graphics.translate( 0  ,random()*random(-2,0,2)*k )   
    end
    love.graphics.setColor(1,1,1,1)
    love.graphics.push()
        love.graphics.translate(-Player.Camera.x+40*k/2+screenWidth/2,-Player.Camera.y+40*k2/2+screenHeight/2)
        VampirEffect:draw(dt)
        WaveEffect:draw()
        BloodyEffect:draw(dt)
        allDraw(dt)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(enBatchAfterDie)
        love.graphics.draw(resBatch)
        bulletsDraw()
        if ( #obj  >0 and #vect > 0) then
            for i = 1, #vect do
                if (i>= lenVect) then
                    lenVect = lenVect +100
                    objRecoveryVect()
                else
                    meshMeteors:setVertex( i, vect[i] )
                end
            end
            meshMeteors:setDrawRange( 1,  #vect )
            love.graphics.setColor(1,1,1,1)
            love.graphics.draw(meshMeteors, 0,0)
        end
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(enBatch)
        love.graphics.setColor(1,0,0,1)
    love.graphics.pop()
    love.graphics.setColor(1,1,1,1)
    Player:draw(dt)
    if (Player.flagInv == false ) then
        love.graphics.setColor(1,0.7,0.7,1)
    end
    if ( Player.a == 1 ) then 
        love.graphics.setColor(0.9,0.7,0.9,1)
    end 
    StudySystem:drawUnderPlayer()
    love.graphics.draw(playerBatch)
    playerBatch:clear()
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(enBatchDop)
    love.graphics.push()
        love.graphics.translate(-Player.Camera.x+40*k/2+screenWidth/2,-Player.Camera.y+40*k2/2+screenHeight/2)
        Player:drawUI()
        EnergyArmorEffect:draw() 
        love.graphics.setColor(1,1,1,1)
        playerLiDraw(dt)
        love.graphics.draw(boomBatch)
        resourceAfterDie(dt)
        ----------
        SpikeArmorEffect:draw()
        HealEffect:draw()
        TradeEffect:draw(dt)
        GetDamageEffect:draw(dt)
        DamageVisualizator:draw()
        -----------
    love.graphics.pop()
    love.graphics.setColor(1,1,1,1)
    explosionEffect:draw()
    
    if (StudySystem.isEnabled) then
        StudySystem:update(dt)
    end
    
    local fontWidth = font:getWidth(tostring(score))
    love.graphics.print(score,50*k/12, screenHeight/2+fontWidth/2*k2/2,-math.pi/2,k/2,k2/2)
    
    Wave:notionDraw(dt)
    sc(0,screenHeight/2)
    buttonAdd:draw()
    
    love.graphics.draw(UIBatch)
    Wave:progressBarDraw()
    StudySystem:draw()
    love.graphics.setCanvas()
    love.graphics.setColor(1,1,1,1)
    if (Player.flagInv == false ) then
        effect1(function()
            love.graphics.draw(canvasToEffect,0,0,0,sx,sy)
        end)
    else
        love.graphics.draw(canvasToEffect,0,0,0,sx,sy)
    end
    
   -- local stat  =  love.graphics.getStats()
   -- love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 100, 10,0,k/2,k2/2)
   -- love.graphics.print("EN: "..tostring(#en), 100, 40,0,k/2,k2/2)
   -- love.graphics.print("Stat  "..tostring(stat.drawcalls), 100, 70,0,k/2,k2/2)
   -- love.graphics.print("OBJ: "..tostring(#obj), 100, 110,0,k/2,k2/2)
   -- love.graphics.print("Resource: "..tostring(#resource), 100, 150,0,k/2,k2/2)
    
    vect = {}
end
               
function enGeo(Geo)
    if (Geo==1) then
        return -borderWidth-200*k,math.random(-borderHeight,borderHeight*2)
    end
    if (Geo==2) then
        return math.random(-borderWidth,borderWidth*2),-borderHeight-200*k2
    end
    if (Geo==3) then
        return math.random(-borderWidth,borderWidth*2),borderHeight*2+200*k2
    end
    if (Geo==4) then
        return borderWidth*2+200*k, math.random(-borderHeight,borderHeight*2)
    end
end
function objGeo(Geo)
    if (Geo==1) then
        return -borderWidth-200*k,math.random(-borderHeight,borderHeight*2),math.random(18*k,30*k),math.random(-30*k,30*k), math.random()*math.random(-1,1)
    end
    if (Geo==2) then
        return  math.random(-borderWidth,borderWidth*2),-borderHeight-200*k2,math.random(-30*k,30*k),math.random(18*k,30*k),math.random()*math.random(-1,1)
    end
    if (Geo==3) then
        return   math.random(-borderWidth,borderWidth*2),borderHeight*2+200*k2,math.random(-30*k,30*k),math.random(-30*k2,-18*k2),math.random()*math.random(-1,1)
    end
    if (Geo==4) then
        return  borderWidth*2+200*k, math.random(-borderHeight,borderHeight*2),math.random(-30*k,-18*k),math.random(-30*k,30*k), math.random()*math.random(-1,1)
    end
end

function allSpawn(mas,Geo,Tip)
    if ( mas == obj) then
        local colorRGB = 0.2
        local Body =math.random(1,5)
        local colorDop1,colorDop2,colorDop3,scale,collScale= objColorAndScale(Body)
        local x,y,ax,ay,ra = objGeo(Geo)
        local health = 1
        local e = {
            body = objTip(Body),
            timer = 0 ,
            invTimer = 20,
            ot = false,
            ugol =  0,
            r =0,
            rDop =0,
            flagr = 0 ,
            collScale = collScale,
            color1 =colorDop1,
            color2=colorDop2,
            color3 =colorDop3,
            scale = scale,
            f = false,
            pok = 0,
            met =Body,
            x  = x, 
            y = y,  
            ax  =ax,
            ay = ay,
            ra =ra,
            health = health
            }
        e.body:moveTo(e.x, e.y)
        table.insert(mas,e)
    end
------------------------------------------------------------------------  
------------------------------------------------------------------------  
    if ( mas == en) then
        local x,y = enGeo(Geo)
        if ( Tip ==1) then
            local e = enemyHammer:clone()
            e.x = x 
            e.y = y 
            e:newBody(e.x, e.y)
            table.insert(mas,e)
        end
        if ( Tip ==2) then 
            local e = enemyShooter:clone()
            e.x = x 
            e.y = y 
            e:newBody(e.x, e.y)
            table.insert(mas,e)
        end
        if ( Tip ==3) then 
            local e = enemyMelee:clone()
            e.x = x 
            e.y = y 
            e:newBody(e.x, e.y)
            table.insert(mas,e)
        end
        if ( Tip ==4) then 
            local e = enemyBomb:clone()
            e.x = x 
            e.y = y 
            e:newBody(e.x, e.y)
            table.insert(mas,e)
        end
        if ( Tip ==5) then 
           local e = enemyInvader:clone()
            e.x = x 
            e.y = y 
            e:newBody(e.x, e.y)
            table.insert(mas,e)
        end
        if ( Tip ==6 and numberCleaner <1 ) then 
            numberCleaner = numberCleaner+1
            local e = enemyСleaner:clone()
            e.x = x 
            e.y = y 
            e:newBody(e.x, e.y)
            table.insert(mas,e)
        end
    end
end

function allInvTimer(i,mas,dt)
    if ( mas[i] and mas[i].timer) then
        if ( mas[i].invTimer) then
            if ( mas[i].timer < mas[i].invTimer) then
                mas[i].timer  = mas[i].timer - dt* 40
            end
            if ( mas[i].timer < 0) then
                mas[i].timer  = mas[i].invTimer
            end
        end
    end
end

function allDraw(dt)
    for i= 1,#resource do
        if (resource[i] and resource[i].x>Player.Camera.x-screenWidth/2-30*k and  resource[i].x<Player.Camera.x+screenWidth/2+30*k and  resource[i].y>Player.Camera.y-screenHeight/2-30*k2 and resource[i].y<Player.Camera.y + screenHeight/2+30*k2) then
            resource[i]:draw()
            if ( resource[i].tip == 6 ) then 
                resource[i]:traceDraw(dt)
            end
        end
    end 
    
    for i = #obj, 1, -1 do
        if (obj[i] and obj[i].body)  then
            if (obj[i].x>Player.Camera.x-screenWidth/2-obj[i].collScale*k and  obj[i].x<screenWidth+Player.Camera.x-screenWidth/2+20*k+obj[i].collScale*k and  obj[i].y>Player.Camera.y-screenHeight/2-obj[i].collScale*k2 and obj[i].y<screenHeight+Player.Camera.y-screenHeight/2+20*k2+obj[i].collScale*k2) then
                local IobjRegulS =math.floor((obj[i].x-60*k)/(120*k)) + math.floor((obj[i].y-60*k2)/(120*k2))*math.floor((screenWidth/(120*k))+1)
                objCollWithObjInRegularS(IobjRegulS,i,dt)
                objCollWithObjInRegularS(IobjRegulS+1,i,dt)
                objCollWithObjInRegularS(IobjRegulS+math.floor((screenWidth/(120*k))+1),i,dt)
                objCollWithObjInRegularS(IobjRegulS+math.floor((screenWidth/(120*k))+1)+1,i,dt)
                objCollWithObjInRegularS(IobjRegulS-math.floor((screenWidth/(120*k))+1)+1,i,dt)
                if ( obj[i].timer) then
                    if not( obj[i].invTimer == obj[i].timer) then
                        if ( obj[i] and obj[i].bodyDop) then
                            objFragmVect(i,1,0.6,0.6)
                            --obj[i].body:draw('line')
                        else
                            objVect(i,1,0.6,0.6)
                            --obj[i].body:draw('line')
                        end
                    else
                        if ( obj[i] and obj[i].pok>0) then
                            objFragmVect(i,1,1,1)
                            --obj[i].body:draw('line')
                        else
                            objVect(i,1,1,1)
                            --obj[i].body:draw('line')
                        end
                    end
                    --love.graphics.circle('line', obj[i].x, obj[i].y, obj[i].collScale*k/2)
                end
            end
        end
    end
    enAfterDieDraw(dt)
    enBoomAfterDieDraw(dt)
    for i = #en, 1, -1 do
        if (en[i] and en[i]:inScreen()) then
            local IenRegulS =en[i]:IndexInRegulS(80)
            en[i]:collWithEn(IenRegulS,i,dt)
            ---------------------------
            Player.Skills.SpecialAtack.Wave:collision(IenRegulS,i,dt)
            Player.Skills.SpecialAtack.Wave:collision(IenRegulS-1,i,dt)
            Player.Skills.SpecialAtack.Wave:collision(IenRegulS+1,i,dt)
            Player.Skills.SpecialAtack.Wave:collision(IenRegulS-math.floor((screenWidth/(80*k))+1),i,dt)
            Player.Skills.SpecialAtack.Wave:collision(IenRegulS+math.floor((screenWidth/(80*k))+1),i,dt)
            Player.Skills.SpecialAtack.Wave:collision(IenRegulS+math.floor((screenWidth/(80*k))+1)+1,i,dt)
            Player.Skills.SpecialAtack.Wave:collision(IenRegulS+math.floor((screenWidth/(80*k))+1)-1,i,dt)
            Player.Skills.SpecialAtack.Wave:collision(IenRegulS-math.floor((screenWidth/(80*k))+1)+1,i,dt)
            Player.Skills.SpecialAtack.Wave:collision(IenRegulS-math.floor((screenWidth/(80*k))+1)-1,i,dt)
            ----------------------------
            local IenRegulS2 =en[i]:IndexInRegulS(120)   
            en[i]:collWithObj(IenRegulS2,i,dt)
            --------
            en[i]:traceDraw(dt)
            en[i]:draw(i)
        end
    end
end
function allBorder(i,mas)
    if (mas[i].collScale~=nil) then 
        if (mas[i].x< borderWidth*2-mas[i].collScale*k/2 and  mas[i].x> -borderWidth +mas[i].collScale*k/2 and  mas[i].y> -borderHeight+mas[i].collScale*k2/2 and  mas[i].y<borderHeight*2-mas[i].collScale*k2/2) then
            mas[i].f = true
        end
    else
        if (mas[i].x > borderWidth*2+500*k or mas[i].x < -borderWidth-500*k or mas[i].y < -borderHeight-500*k or  mas[i].y > borderHeight*2+500*k ) then
            table.remove(mas,i)
        end
    end
    if ( mas == obj and mas[i].pok > 0 ) then 
        if ( mas[i].x > borderWidth*2 or mas[i].x < -borderWidth or mas[i].y < -borderHeight or  mas[i].y > borderHeight*2 ) then
            table.remove(mas,i)
        end 
    end 
    
    if ( mas[i] and mas[i].f == true and mas[i].collScale~=nil) then
        if ( mas[i].x > borderWidth*2-mas[i].collScale*k/2) then 
            mas[i].ax = -mas[i].ax
            mas[i].x =borderWidth*2 - 0.1*k-mas[i].collScale*k/2
        end
        if ( mas[i].x <  -borderWidth+mas[i].collScale*k/2) then 
            mas[i].ax = -mas[i].ax
            mas[i].x = -borderWidth + 0.1*k+mas[i].collScale*k/2
        end
        if ( mas[i].y < -borderHeight+mas[i].collScale*k2/2) then 
            mas[i].ay = -mas[i].ay
            mas[i].y = -borderHeight+0.1*k2+mas[i].collScale*k2/2
        end
        if ( mas[i].y > borderHeight*2-mas[i].collScale*k2/2) then 
            mas[i].ay = -mas[i].ay
            mas[i].y = borderHeight*2 - 0.1*k2-mas[i].collScale*k2/2
        end
        if ( mas[i].x > borderWidth*2 or mas[i].x < -borderWidth or mas[i].y < -borderHeight or  mas[i].y > borderHeight*2 ) then
            table.remove(mas,i)
        end
    end
end


return game