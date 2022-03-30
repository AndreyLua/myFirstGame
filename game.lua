local game = {} 

local playerFunction = require "playerFunction"
local bulletFunction = require "bulletFunction"
local enFunction = require "enFunction"
local enClassMelee = require "enClassMelee" 
local enClassHammer = require "enClassHammer" 
local enClassShooter = require "enClassShooter" 
local enClassInvader = require "enClassInvader" 
local enClassBomb = require "enClassBomb" 
local enClassСleaner = require "enClassCleaner" 
local resSimpleClass =  require "resSimpleClass" 
local resFunction = require "resFunction" 
local objFunction = require "objFunction" 
local wavesFunction = require "wavesFunction" 
pause = require "pause" 
local loadGame = require "loadGame"

loadPlayerParametrsAndImg()
loadEnImg()
loadObjImg()

function game:init()



--#####################################################
--effects   
waveEffects = {} 
bloodEffects = {} 
tradeEffects = {} 
deffenseEffects = {} 
bloodPart = {}
greenPlayerEffect = {} 
playerGerDamageEffect = {} 

stars = {} 
--effects
--#####################################################
-------------------gameParametrs
score = 9999999
borderWidth =screenWidth/2
borderHeight = screenHeight/2
numberCleaner = 0 
shake = 0
touchx = 0
touchy = 0 
flagtouch =false
flagtouch1 = false
flagtouch2 = false
flagtouch3 = false
-------------------gameParametrs
--#####################################################
-------------------playerParametrs
flaginv = true
-------------------playerParametrs
--#####################################################
-------------------WaveParametrs
waveflag = 0
wavex = -250*k
wavey = 0
numberWave =8
colWave= 50
waves = {5,50}
-------------------WaveParametrs

controler = { 
  x0 = 0, 
  y0 = 0,
  x = 0,
  y = 0,
  angle = 0,
  flag = false
}
hp = {
    flag = false,
    long = 720,
    long2 =720,
    long3 =720
}
boost = {
    flag = true,
    long = 720,
    long2 =720,
    long3 =720
}

boostDop = {
    long = 0,
    angle = 0 ,
    recovery = 10,
    recoveryTimer = 10,
    shake = 1,
    shakeK = 1,
}
player = {
    a = 0 , 
    li = 0,
    liTimer = 20,
    debaffStrenght =1,
    body =HC.circle(borderWidth/2+40*k/2,borderHeight/2+40*k2/2,playerAbility.scaleBody*k),
    clowR = 0, 
    clowRflag = 0,
    clowLScaleK =1, 
    clowRScaleK =1,
    clowLTimer = 10,
    clowRTimer = 10,
    x = borderWidth/2+40*k/2, 
    y = borderHeight/2+40*k2/2,  
    ax = 0,
    ay = 0,
} 
camera = {
    x = borderWidth/2+40*k/2, 
    y = borderHeight/2+40*k2/2
}

playerLiRan = {} 
enBoomAnimat = {}
removeEn = {}
en = {}
obj = {}
res = {}
objRegulS  = {}
enRegulS  = {}
enAfterDieTex = {} 
resTraces = {}
bulletRegulS  = {}
waveRegulS = {}
enemyBullets = {} 
playerSledi = {} 

masli= {} 

loadSave()
lvlParametrs()
end

function gamestate.focus(v)
    if (not(v) and gamestate.current() == game) then
        gamestate.switch(pause)
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
        gamestate.switch(pause)
    elseif key == "q" then
        love.event.push('quit')
    end
end

function game:update(dt)

-- en = {}
--flaginv =true
explUpdate2(dt)
objRegulS = {}
enRegulS = {}
waveRegulS = {}
--boost.long = 1000
--hp.long = 1000 
mouse.x,mouse.y=love.mouse.getPosition()
mouse.x = mouse.x
mouse.y = mouse.y
flagtouch2 = false -- для выхода в состояние пауза
wavesUpdate(dt)

--------------------
playerCamera(dt)
playerControl()
playerClowR(dt)
playerHP(dt)
-------------------
for i = #obj, 1, -1 do
    if (obj[i]) then  
        allInvTimer(i,obj,dt)
        objMove(i,dt) 
        allBorder(i,obj)
        if (obj[i]) then 
            local IobjRegulS =math.floor((obj[i].x-60*k)/(120*k)) + math.floor((obj[i].y-60*k2)/(120*k2))*math.floor((screenWidth/(120*k))+1)
            if (obj[i].x>camera.x-screenWidth/2-obj[i].collScale*k and  obj[i].x<screenWidth+camera.x-screenWidth/2+20*k+obj[i].collScale*k and  obj[i].y>camera.y-screenHeight/2-obj[i].collScale*k2 and obj[i].y<screenHeight+camera.y-screenHeight/2+20*k2+obj[i].collScale*k2) then
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

for i = #res, 1, -1 do
    if (res[i]) then 
        res[i]:GravityWithPlayer()
        res[i]:move(dt)
        res[i]:border(i)
        if (res[i] and res[i].tip == 6) then  
            res[i]:traceSpawn()
        end
        if (res[i]) then  
            res[i]:collWithPlayer(i)
        end
        if (res[i]) then  
            local indexResInRegS = res[i]:IndexInRegulS(80)
            res[i]:collWithEn(indexResInRegS,i,dt)
            if (numberCleaner > 0) then 
                if (res[i]) then  
                    res[i]:collWithEn(indexResInRegS-1,i,dt)
                end
                if (res[i]) then
                    res[i]:collWithEn(indexResInRegS+1,i,dt)
                end
                if (res[i]) then
                    res[i]:collWithEn(indexResInRegS-math.floor((screenWidth/(80*k))+1),i,dt)
                end
                if (res[i]) then
                    res[i]:collWithEn(indexResInRegS+math.floor((screenWidth/(80*k))+1),i,dt)
                end
                if (res[i]) then
                    res[i]:collWithEn(indexResInRegS+math.floor((screenWidth/(80*k))+1)+1,i,dt)
                end
                if (res[i]) then
                    res[i]:collWithEn(indexResInRegS+math.floor((screenWidth/(80*k))+1)-1,i,dt)
                end
                if (res[i]) then
                    res[i]:collWithEn(indexResInRegS-math.floor((screenWidth/(80*k))+1)+1,i,dt)
                end
                if (res[i]) then
                    res[i]:collWithEn(indexResInRegS-math.floor((screenWidth/(80*k))+1)-1,i,dt)
                end
            end
        end
    end
end
playerBoost(dt)
playerBoostDop(dt) -- skill
wavesSpawn()
TimerObj:update(dt)
TimerEn:update(dt)
playerCollWithObj(dt)
playerCollWithEn(dt)
playerDebaff(dt)
playerMove(dt)
bulletsUpdate(dt)
self:movement(dt)
playerBorder()
playerDie()
end

function game:keypressed(key1,key, code)
    if key == "escape" then
      --  print(love.filesystem.load( 'Save.lua' ))
        if gamestate.current() == self and player.isAlive then
            gamestate.switch(pause)
        end
    elseif key == "q" then
        love.event.push('quit')
    end
end

function game:movement(dt)
    if ( love.mouse.isDown(1))then
        flagtouch=true
    else
        if (  flagtouch==true and mouse.x > 0 and  mouse.x <60*k and mouse.y > 0 and  mouse.y <60 *k2 and flagtouch1== true) then
            AddSound(uiClick,0.3)
            gamestate.switch(pause)
        end
        if ( flagtouch==false) then
            touchx = mouse.x
            touchy = mouse.y
        end
        flagtouch=false
        flagtouch1 = true
    end   
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
 -- flaginv =true
  
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
    drawStar(dt)
       love.graphics.setColor(1,1,1,1)
    love.graphics.draw(fon2,(-player.x+40*k/2+screenWidth/2)/20,(-player.y+40*k2/2+screenHeight/2)/40,0,k,k2)
    love.graphics.draw(fon3,(-player.x+40*k/2+screenWidth/2)/7,(-player.y+40*k2/2+screenHeight/2)/10,0,k,k2)
    if (flaginv == false ) then
        love.graphics.translate( 0  ,random()*random(-2,0,2)*k )   
    end
    love.graphics.setColor(1,1,1,1)
    love.graphics.push()
        love.graphics.translate(-camera.x+40*k/2+screenWidth/2,-camera.y+40*k2/2+screenHeight/2)
        waveEffect(dt)
        bloodEffect(dt)
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
    playerDraw(dt)
    if (flaginv == false ) then
        love.graphics.setColor(1,0.7,0.7,1)
    end
    if ( player.a == 1 ) then 
        love.graphics.setColor(0.9,0.7,0.9,1)
    end 
    love.graphics.draw(playerBatch)
    playerBatch:clear()
    -- playerDrawCristal()
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(enBatchDop)
    love.graphics.push()
        love.graphics.translate(-camera.x+40*k/2+screenWidth/2,-camera.y+40*k2/2+screenHeight/2)
        Health_Boost()
        love.graphics.setColor(1,1,1,1)
        playerLiDraw(dt)
        love.graphics.draw(boomBatch)
        resAfterDie(dt)
        ----------
        deffenseEffect(dt)
        greenPlayerEffectDraw(dt)
        tradeEffectDraw(dt)
        playerGetDamageEffect(dt)
        -----------
        --waveEffect(dt)
    love.graphics.pop()
   -- love.graphics.push()
      --  love.graphics.translate(screenWidth/2+20*k+(player.x-camera.x),screenHeight/2+20*k2+(player.y-camera.y))
        --love.graphics.rotate(-controler.angle)
      --  playerLiInBodyDraw()
 --   love.graphics.pop()

    love.graphics.setColor(1,1,1,1)
    for i=1,#exp do
        love.graphics.rectangle("fill",exp[i].x,exp[i].y,exp[i].scale*15*k,exp[i].scale*15*k2,4*exp[i].scale*k)
    end
    local fontWidth = font:getWidth(tostring(score))
    love.graphics.print(score,50*k/12, screenHeight/2+fontWidth/2*k2/2,-math.pi/2,k/2,k2/2)
    
    wavesTitleDraw(numberWave,dt)
    sc(0,screenHeight/2)
    add()
    
    love.graphics.draw(UIBatch)
    lineW()
   
    love.graphics.setCanvas()
    love.graphics.setColor(1,1,1,1)
    if (flaginv == false ) then
        effect1(function()
            love.graphics.draw(canvasToEffect,0,0,0,sx,sy)
        end)
    else
        love.graphics.draw(canvasToEffect,0,0,0,sx,sy)
    end
    
    local stat  =  love.graphics.getStats()
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 100, 10,0,k/2,k2/2)
    love.graphics.print("EN: "..tostring(#en), 100, 40,0,k/2,k2/2)
    love.graphics.print("Stat  "..tostring(stat.drawcalls), 100, 70,0,k/2,k2/2)
    love.graphics.print("OBJ: "..tostring(#obj), 100, 110,0,k/2,k2/2)
    love.graphics.print("RES: "..tostring(#res), 100, 150,0,k/2,k2/2)
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
    for i= 1,#res do
        if (res[i] and res[i].x>camera.x-screenWidth/2-30*k and  res[i].x<camera.x+screenWidth/2+30*k and  res[i].y>camera.y-screenHeight/2-30*k2 and res[i].y<camera.y + screenHeight/2+30*k2) then
            res[i]:draw()
            if ( res[i].tip == 6 ) then 
                res[i]:traceDraw(dt)
            end
        end
    end 
    
    for i = #obj, 1, -1 do
        if (obj[i] and obj[i].body)  then
            if (obj[i].x>camera.x-screenWidth/2-obj[i].collScale*k and  obj[i].x<screenWidth+camera.x-screenWidth/2+20*k+obj[i].collScale*k and  obj[i].y>camera.y-screenHeight/2-obj[i].collScale*k2 and obj[i].y<screenHeight+camera.y-screenHeight/2+20*k2+obj[i].collScale*k2) then
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
            enCollWithWavesInRegularS(IenRegulS,i,dt)
            enCollWithWavesInRegularS(IenRegulS-1,i,dt)
            enCollWithWavesInRegularS(IenRegulS+1,i,dt)
            enCollWithWavesInRegularS(IenRegulS-math.floor((screenWidth/(80*k))+1),i,dt)
            enCollWithWavesInRegularS(IenRegulS+math.floor((screenWidth/(80*k))+1),i,dt)
            enCollWithWavesInRegularS(IenRegulS+math.floor((screenWidth/(80*k))+1)+1,i,dt)
            enCollWithWavesInRegularS(IenRegulS+math.floor((screenWidth/(80*k))+1)-1,i,dt)
            enCollWithWavesInRegularS(IenRegulS-math.floor((screenWidth/(80*k))+1)+1,i,dt)
            enCollWithWavesInRegularS(IenRegulS-math.floor((screenWidth/(80*k))+1)-1,i,dt)
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