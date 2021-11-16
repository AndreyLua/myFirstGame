local game = {} 

function game:init()
-------------BODY------
----------------------------------
borderWidth =screenWidth/2
borderHeight = screenHeight/2

flaginv = true
shake = 0
fff = 0 
flagvsemflagamflag = 0 
flagtouch =false
touchx = 0
touchy = 0 
ggtouch = 30
fflag= false
score = 0
waveflag = 0
wavex = -250*k
wavey = 0
spped = 460
flagsp = false
fff3flag = false
flagCircle =false  
colWave= 20000
numberWave =1 
texti = 0 
textL = ""
textK = 0 
flagtouch1 = false
flagtouch2 = false
flagtouch3 = false
preyi= -1
klacK = 0 
removeEn = {}
colll = {}
flagclass = "slicer" 
tap =  false
np = 0 
flagfff3 = 0   

dopPa = {
  x = 0,
  y = 0 ,
  scalex = 0.8,
  scaley = 1.6
}
controler = { 
  x0 = 0, 
  y0 = 0,
  x = 0,
  y = 0,
  angle = 0,
  flag = false
}

waves = {
  {100,20,0,20000},
  {100,100,0,25},
  {100,30,0,15},
  {100,50,0,20},
  {100,70,0,25},
  {100,50,20,20},
  {100,100,100,25}
}

hp = {
    flag = false,
    long = screenHeight,
    long2 =screenHeight,
    long3 =screenHeight
}

boost = {
    flag = true,
    long = screenHeight,
    long2 =screenHeight,
    long3 =screenHeight
}
player = {
    debaffStrenght =1,
    body =HC.circle(borderWidth/2+40*k/2,borderHeight/2+40*k2/2,playerAbility.scaleBody*k),
    invis = 10,
    clowR = 0, 
    clowRflag = 0, 
    boost =  screenHeight,
    hp =  screenHeight,
    x = borderWidth/2+40*k/2, 
    y = borderHeight/2+40*k2/2,  
    ax = 0,
    a = 0 , 
    ay = 0,
    color = 0,
} 
HealthAndBoostBar = {
  x = borderWidth/2+40*k/2, 
  y = borderHeight/2+40*k2/2,  
}
camera = {
    x = borderWidth/2+40*k/2, 
    y = borderHeight/2+40*k2/2
}

en = {}
obj = {}
res = {}
objRegulS  = {}
enRegulS  = {}
enAfterDieTex = {} 
resTraces = {}
bulletRegulS  = {}
enemyBullets = {} 
playerSledi = {} 

end


function game:update(dt)
objRegulS = {}
enRegulS = {}
--boost.long = 1000
hp.long = 1000 
mouse.x,mouse.y=love.mouse.getPosition()
mouse.x = mouse.x
mouse.y = mouse.y
flagtouch2 = false -- для выхода в состояние пауза

HealthAndBoostBar.x = HealthAndBoostBar.x+(player.x-HealthAndBoostBar.x)
HealthAndBoostBar.y = HealthAndBoostBar.y+(player.y-HealthAndBoostBar.y)


if not( player.x > borderWidth*2-screenWidth/2+20*k or  player.x < -borderWidth+screenWidth/2+20*k) then
    camera.x =camera.x+(player.x-camera.x)*dt*5*k
else
    if (  player.x > borderWidth*2-screenWidth/2+20*k) then
        camera.x =camera.x+( borderWidth*2-screenWidth/2+20*k-camera.x)*dt*5*k
    else
        camera.x =camera.x+(-borderWidth+screenWidth/2+20*k-camera.x)*dt*5*k
    end
end
if not( player.y >  borderHeight*2-screenHeight/2+20*k2 or  player.y < - borderHeight+screenHeight/2+20*k2 ) then
    camera.y =camera.y+(player.y-camera.y)*dt*5*k2
else
    if (  player.y >borderHeight*2-screenHeight/2+20*k2) then
        camera.y =camera.y+(borderHeight*2-screenHeight/2+20*k2-camera.y)*dt*5*k2
    else
        camera.y =camera.y+(-borderHeight+screenHeight/2+20*k2-camera.y)*dt*5*k2
    end
end

if ( player.clowR> 0.2 ) then
    player.clowRflag = 1 
end
if ( player.clowR< 0 ) then
    player.clowRflag = 0 
end
--------------------
playerControl()
playerClowR(dt)
playerHP(dt)
explUpdate2(dt)
-------------------
local Wave = waves[numberWave] 
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
        objDestroy(obj,i) 
        table.remove(obj,i)
    end
end

for i = #res, 1, -1 do
    if (res[i]) then 
        resColl(i)
        resMove(i,dt)
        res[i]:traceSpawn()
        resBorder(i,res)    
        if (res[i]) then  
            resСollect(i)
        end
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

if ( colWave<=0) then
    numberWave = numberWave +1 
    local Wave = waves[numberWave]
    colWave =Wave[4]
    waveflag = 0
    wavex = -250*k
    wavey = 0
end

playerBoost(dt)

if ( colWave>0 and #obj < 200) then
    Timer.every(5, function()
        for i=1,math.random(1,1) do
            local Wave = waves[numberWave]
            local Geo  =math.random(1,4)
            local Tip =1
            local Scale =math.random(1,2)
            if (math.random(1,100)<Wave[2]) then
                Tip =1
            else
                Tip =1
            end
            allSpawn(obj,Geo,Tip)
        end
  
        for i=1,math.random(0,1) do
            local Wave = waves[numberWave]
            local Geo  =math.random(1,4)
            local Tip =math.random(1,4)
            local Scale =math.random(2,2)
            allSpawn(en,Geo,Tip)
        end
        Timer.clear() 
    end)
  
    Timer.update(dt)
end
playerCollWithObj(dt)
playerCollWithEn(dt)
playerDebaff(dt)
playerMove(dt)
bulletsUpdate(dt)
self:movement(dt)
playerBorder()
end

function game:keypressed(key1,key, code)
    if key == "escape" then
        if gamestate.current() == self and player.isAlive then
            gamestate.switch(pause)
        end
    elseif key == "q" then
        love.event.push('quit')
    end
end

function game:movement(dt)
    if ( hp.long<=0) then 
        gamestate.switch(pause)
    end
    
    if ( love.mouse.isDown(1))then
        
        flagtouch=true
    else
        if (  flagtouch==true and mouse.x > 0 and  mouse.x <60*k and mouse.y > 0 and  mouse.y <60 *k2 and flagtouch1== true) then
            gamestate.switch(pause)
        end
        if ( flagtouch==false) then
            touchx = mouse.x
            touchy = mouse.y
        end
        flagtouch=false
        flagtouch1 = true
    end   
     if love.keyboard.isDown('w') then
       kekKK = kekKK +0.01
    end
     if love.keyboard.isDown('s') then
       kekKK = kekKK -0.01
    end
    
    if love.keyboard.isDown('e') then
        local Geo  =math.random(1,4)
        allSpawn(obj,Geo,Tip)
        obj[#obj].f = true
        obj[#obj].x = mouse.x
        obj[#obj].y = mouse.y
        allSpawn(en,Geo,math.random(4,4))
        en[#en].x = mouse.x
        en[#en].y = mouse.y
    end
      if love.keyboard.isDown('y') then
     table.remove(obj,#obj)
     end
end


function  game:draw()
    local dt = love.timer.getDelta()
    playerBatch:clear()
    resBatch:clear()
    enBatch:clear()
    enBatchDop:clear()
    love.graphics.setCanvas(kek)
    love.graphics.clear()
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(fon1,0,0,0,k,k2)
    love.graphics.draw(fon2,(-player.x+40*k/2+screenWidth/2)/20,(-player.y+40*k2/2+screenHeight/2)/40,0,k,k2)
    love.graphics.draw(fon3,(-player.x+40*k/2+screenWidth/2)/7,(-player.y+40*k2/2+screenHeight/2)/10,0,k,k2)
    love.graphics.setColor(1,1,1,1)
    --for i = 0, 20 do
    --  for j =0, 20 do 
    --    love.graphics.rectangle('line', i*120*k,j*120*k2,120*k,120*k2)  
       --  love.graphics.circle('line', i*120*k,j*120*k2,60*k)  

    --  end
    --end 
    if (flaginv == false ) then
    love.graphics.translate( 0  ,random()*random(-2,0,2)*k )   
  end
  
    love.graphics.setLineWidth(2)
    love.graphics.setColor(1,1,1,1)
  --   allDraw()
    love.graphics.push()
    love.graphics.translate(-camera.x+40*k/2+screenWidth/2,-camera.y+40*k2/2+screenHeight/2)
    love.graphics.rectangle('line',-borderWidth,-borderHeight,borderWidth*3,borderHeight*3,k,k2)
   
    allDraw(dt)
    love.graphics.setColor(1,1,1,1)
    love.graphics.setLineWidth(1)
    love.graphics.draw(resBatch)
    bulletsDraw()
    enRemoveTag(dt)
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
        --  love.graphics.setShader(myShader)
      --  love.graphics.setShader()
        love.graphics.draw(meshMeteors, 0,0)
     --   love.graphics.setShader()
    end
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(enBatch)
    love.graphics.pop()
   
 
    love.graphics.setColor(1,1,1,1)
    playerDraw(dt)
    love.graphics.draw(playerBatch)
    love.graphics.draw(enBatchDop)
    love.graphics.push()
    love.graphics.translate(-camera.x+40*k/2+screenWidth/2,-camera.y+40*k2/2+screenHeight/2)
    Health_Boost()
    love.graphics.pop()
    love.graphics.setColor(1,0,0.02)
   -- love.graphics.print("HP "..math.floor(hp.long/screenHeight*100)..'/'..100, screenWidth-55*k,screenHeight/2+200*k2,-math.pi/2,0.3,0.3)
    love.graphics.setColor(0,0.643,0.502)
 --   love.graphics.print("BOOST "..math.floor(boost.long/screenHeight*100)..'/'..100, screenWidth-55*k,220*k2,-math.pi/2,0.3,0.3)
    love.graphics.setColor(1,1,1)
    local kkol = #(tostring (score))
    love.graphics.print(score,22*k-(70*k*0.5)/2, screenHeight/2+(kkol*45/2*k2*0.5),-math.pi/2,0.5,0.5)
    Waves(numberWave,dt)
    sc(0,screenHeight/2)
    exit(-7*k,-7*k2)
    lineW()
    
   -- for i=1,#exp do
   --     love.graphics.setColor(exp[i].color1,exp[i].color2,exp[i].color3)
   --     love.graphics.rectangle("fill",exp[i].x,exp[i].y,exp[i].scale*20*k,exp[i].scale*20*k2,4*exp[i].scale*k)
  --  end
    love.graphics.setCanvas()
    love.graphics.setColor(1,1,1,1)
    if (flaginv == false ) then
        effect1(function()
            love.graphics.draw(kek,0,0,0,sx,sy)
        end)
    else
        love.graphics.draw(kek,0,0,0,sx,sy)
    end


  love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10,0,k,k2)
  love.graphics.print("EN: "..tostring(#en), 10, 40)
  local stat  =  love.graphics.getStats()
  love.graphics.print("Stat  "..tostring(stat.drawcalls), 10, 70)
  love.graphics.print("OBJ: "..tostring(#obj), 10, 110)
  love.graphics.print("RES: "..tostring(#res), 10, 150)
  
  vect = {}
end
               

function Waves(n,dt)
    if ( waveflag == 0   ) then
        wavetimer:update(dt)
        wavetimer:every(0.001, function()
            wavetimer:clear() 
            if (wavex*k<0) then
                wavex = wavex+0.2*k
            else
                wavex = 0 
                waveflag = 1
            end
        end)
    end
    if ( waveflag == 1) then
        wavetimer:update(dt)
        wavetimer:every(3, function()
            wavetimer:clear() 
            waveflag = 2
        end)
    end
    if ( waveflag == 2 and wavex == 0) then
        wavetimer:update(dt)
        wavetimer:every(0.001, function()
            wavetimer:clear() 
            if (wavey*k<screenHeight/2+200*k2) then
                wavey = wavey+0.6*k
            end
        end)
    end
    love.graphics.setColor(0.8,0.5,0,(125*k+wavex)/125*k+0.4)
    love.graphics.print("Waves", 80*k+wavex*k,screenHeight/2+110*k2-wavey*k2,-math.pi/2,1,1)
    love.graphics.setColor(0.7,0.48,0.2,(125*k+wavex)/125*k+0.4)
    local  char = tostring(n)
    if (#char==1) then
        love.graphics.print(">>"..tostring (n)..'<<', 125*k+wavex*k,screenHeight/2+65*k2+wavey*k2,-math.pi/2,1,1)
    end
    if (#char==2) then
        love.graphics.print(">>"..tostring (n)..'<<', 125*k+wavex*k,screenHeight/2+90*k2+wavey*k2,-math.pi/2,1,1)
    end
    
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
  -- player.body:draw('fill')
  --  enemiesSledDraw(dt)
    for i= 1,#res do
        if (res[i].x>camera.x-screenWidth/2-30*k and  res[i].x<camera.x+screenWidth/2+30*k and  res[i].y>camera.y-screenHeight/2-30*k2 and res[i].y<camera.y + screenHeight/2+30*k2) then
            res[i]:traceDraw(dt)
            if ( res[i].tip == 1) then
                love.graphics.setColor(res[i].color1,res[i].color2,res[i].color3)
                rot('fill',res[i].x,res[i].y,4*k,4*k2,1,2*k,2*k2)
            end
            if ( res[i].tip == 2) then
                 love.graphics.setColor(res[i].color1,res[i].color2,res[i].color3)
                 rot('fill',res[i].x,res[i].y,7*k,7*k2,1,3.5*k,3.5*k2)
            end
            if ( res[i].tip == 3) then
                love.graphics.setColor(res[i].color1,res[i].color2,res[i].color3)
                rot('fill',res[i].x,res[i].y,9*k,9*k2,1,4.5*k,4.5*k2)
            end
            ------------------------------------------------------------------
            if ( res[i].tip == 4) then
                resBatch:add(resQuads.hp,res[i].x,res[i].y,res[i].r+math.pi/2,k/19,k2/19,105,105)
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
                         --   obj[i].body:draw('line')
                        else
                            objVect(i,1,0.6,0.6)
                         --  obj[i].body:draw('line')
                        end
                    else
                        if ( obj[i] and obj[i].pok>0) then
                            objFragmVect(i,1,1,1)
                      --      obj[i].body:draw('line')
                        else
                            objVect(i,1,1,1)
                    --        obj[i].body:draw('line')
                        end
                    end
                --    love.graphics.circle('line', obj[i].x, obj[i].y, obj[i].collScale*k/2)
                end
            end
        end
    end
    enAfterDieDraw(dt)----inscreen
    for i = #en, 1, -1 do
        if (en[i] and en[i]:inScreen()) then
            local IenRegulS =en[i]:IndexInRegulS(80)
            en[i]:collWithEn(IenRegulS,i,dt)
            local IenRegulS2 =en[i]:IndexInRegulS(120)   
            en[i]:collWithObj(IenRegulS2,i,dt)
            en[i]:traceDraw(dt)
            en[i]:draw(i)
        end
    end
end
function allBorder(i,mas)
    ----------если залетел на карту поднимаем флаг-------------------------------------  
    if (mas[i].x< borderWidth*2-mas[i].collScale*k/2 and  mas[i].x> -borderWidth +mas[i].collScale*k/2 and  mas[i].y> -borderHeight+mas[i].collScale*k2/2 and  mas[i].y<borderHeight*2-mas[i].collScale*k2/2) then
        mas[i].f = true
    end
    --------------------------------------------------
    
    --------------------------------------------------
    if ( mas[i] and mas[i].f == true) then
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