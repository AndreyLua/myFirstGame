local game = {} 

function game:init()
-------------BODY------
up  = HC.polygon(0,0,0,-100*k,screenWidth,-100*k,screenWidth,0)
down  = HC.polygon(0,screenHeight,0,screenHeight+100*k,screenWidth,screenHeight+100*k,screenWidth,screenHeight)
left  =HC.polygon(0,0,-100*k,0,-100*k,screenHeight,0,screenHeight)
right  = HC.polygon(screenWidth,0,screenWidth+100*k,0,screenWidth+100*k,screenHeight,screenWidth,screenHeight)
----------------------------------

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
slediEn ={}
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
  body =HC.circle(screenWidth/2+40*k/2,screenHeight/2+40*k2/2,playerAbility.scaleBody*k),
  invis = 10,
  clowR = 0, 
  clowRflag = 0, 
  boost =  screenHeight,
  hp =  screenHeight,
  x = screenWidth/2+40*k/2, 
  y = screenHeight/2+40*k2/2,  
  ax = 0,
  a = 0 , 
  ay = 0,
  color = 0,
} 
camera = {
  x = screenWidth/2+40*k/2, 
  y = screenHeight/2+40*k2/2
  }
en = {}
obj = {}
objRegulS  = {}
res = {}
enemyBullets = {} 
playerSledi = {} 

end


function game:update(dt)
objRegulS = {}
boost.long = 1000
hp.long = 1000 
mouse.x,mouse.y=love.mouse.getPosition()
mouse.x = mouse.x
mouse.y = mouse.y
flagtouch2 = false -- для выхода в состояние пауза
if ( player.x > screenWidth*1.5+20*k or  player.x < -screenWidth*0.5+20*k ) then
  else
camera.x = player.x
end
if ( player.y > screenHeight*1.5+20*k2 or  player.y < -screenHeight*0.5+20*k2 ) then
  else
camera.y = player.y
end
--------------------
playerControl()
playerClowR(dt)
playerHP(dt)
explUpdate2(dt)
-------------------
local Wave = waves[numberWave] 
for i = 1 , #obj do
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

if ( player.clowR> 0.2 ) then
    player.clowRflag = 1 
end
if ( player.clowR< 0 ) then
    player.clowRflag = 0 
end
playerCollWithObj()
for i = 1 , #res do
    if (res[i]) then 
        resColl(i)
        resMove(i,dt)
        resBorder(i,res)    
        if (res[i]) then  
            resСollect(i)
        end
    end
end 
 
for i=1,#en do
    if (en[i]) then 
        allInvTimer(i,en,dt)
        enMove(i,dt)  
        enAtack(i,dt)
        if (en[i] and en[i].body and player.body:collidesWith(en[i].body))  then
            enColl(i, en[i].tip, player.a)
        end
    
        if (en[i] and en[i].health and en[i].health<=0 ) then
            allDecompose(en,i)
            if (slediEn[i]) then
                table.remove(slediEn,i)
            end
            table.remove(en,i)
        end
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

if ( colWave>0 and #obj < 20) then
    Timer.every(0.5, function()
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
            local Tip =math.random(1,2)
            local Scale =math.random(2,2)
       --     allSpawn(en,Geo,Tip)
        end
        Timer.clear() 
    end)
  
    Timer.update(dt)
end
playerDebaff()
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
        local Tip =math.random(1,2)
        allSpawn(obj,Geo,Tip)
        obj[#obj].f = true
        obj[#obj].x = mouse.x
        obj[#obj].y = mouse.y
  --    allSpawn(en,Geo,Tip)
   --     en[#en].x = mouse.x
   --     en[#en].y = mouse.y
    end
      if love.keyboard.isDown('y') then
     table.remove(obj,#obj)
     end
end


function  game:draw()
    local dt = love.timer.getDelta()
    playerBatch:clear()
    love.graphics.setCanvas(kek)
    love.graphics.clear()
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(fon1,0,0,0,k,k2)
    love.graphics.draw(fon2,(-player.x+40*k/2+screenWidth/2)/30,(-player.y+40*k2/2+screenHeight/2)/30,0,k,k2)
    love.graphics.draw(fon3,(-player.x+40*k/2+screenWidth/2)/10,(-player.y+40*k2/2+screenHeight/2)/10,0,k,k2)
    love.graphics.setColor(1,1,1,1)
    --for i = 0, 20 do
    --  for j =0, 20 do 
    --    love.graphics.rectangle('line', i*120*k,j*120*k2,120*k,120*k2)  
       --  love.graphics.circle('line', i*120*k,j*120*k2,60*k)  

    --  end
   --end 
    if (flaginv == false ) then
    love.graphics.translate( 0  ,random(0,shake) )   
  end
  
    love.graphics.setLineWidth(1)
    love.graphics.setColor(1,1,1,1)
  --   allDraw()
    love.graphics.push()
    love.graphics.translate(-camera.x+40*k/2+screenWidth/2,-camera.y+40*k2/2+screenHeight/2)
    love.graphics.rectangle('line',-screenWidth,-screenHeight, screenWidth*3,screenHeight*3,k,k2)
    --    love.graphics.setShader(myShader)
      --  love.graphics.draw(meteors.m1,200*k,200*k2,0,1,1,meteors.m1:getWidth()/2,meteors.m1:getHeight()/2
      --  love.graphics.setShader()
    allDraw(dt)
    love.graphics.setColor(1,1,1,1)
    love.graphics.setLineWidth(1)
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
        love.graphics.draw(meshMeteors, 0,0)
  end
  love.graphics.pop()
  Health_Boost()
  love.graphics.setColor(1,1,1,1)
    playerDraw(dt)
    love.graphics.draw(playerBatch)
    
    love.graphics.setColor(1,0,0.02)
    love.graphics.print("HP "..math.floor(hp.long/screenHeight*100)..'/'..100, screenWidth-55*k,screenHeight/2+200*k2,-math.pi/2,0.3,0.3)
    love.graphics.setColor(0,0.643,0.502)
    love.graphics.print("BOOST "..math.floor(boost.long/screenHeight*100)..'/'..100, screenWidth-55*k,220*k2,-math.pi/2,0.3,0.3)
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
   -- love.graphics.setBlendMode('alpha','premultiplied')
   
-- effect(function()
    
    love.graphics.draw(kek,0,0,0,sx,sy)
  
   -- end)

   -- love.graphics.setBlendMode('alpha')

    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10,0,k,k2)
    love.graphics.print("EN: "..tostring(#en), 10, 40)

  local stat  =  love.graphics.getStats()
   love.graphics.print("Stat  "..tostring(stat.drawcalls), 10, 70)
   love.graphics.print("OBJ: "..tostring(#obj), 10, 110)
   love.graphics.print("RES: "..tostring(#res), 10, 150)
   
   --local Imouse = math.floor(mouse.x/(120*k)) + math.floor((mouse.y)/(120*k2))*math.floor((screenWidth/(120*k))+1)
   --love.graphics.print(Imouse, mouse.x , mouse.y)
  -- local playerIndex =math.floor((player.x)/(120*k)) + math.floor((player.y)/(120*k2))*math.floor((screenWidth/(120*k))+1)
  -- love.graphics.print(playerIndex,player.x, player.y)
  --   local Imouse = math.floor(mouse.x/(120*k)) + math.floor((mouse.y)/(120*k2))*math.floor((screenWidth/(120*k))+1)
  -- love.graphics.print(Imouse, mouse.x , mouse.y)
  -- local playerIndex =math.floor((player.x)/(120*k)) + math.floor((player.y)/(120*k2))*math.floor((screenWidth/(120*k))+1)
   --love.graphics.print(playerIndex,player.x, player.y)
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
function allGeo(Geo)
      if (Geo==1) then
        return -screenWidth-200*k,math.random(-screenHeight,screenHeight*2),math.random(6*k,10*k),math.random(-10*k,10*k), math.random(0.5,1)
      end
      if (Geo==2) then
        return  math.random(-screenWidth,screenWidth*2),-screenHeight-200*k2,math.random(-10*k,10*k),math.random(6*k,10*k),math.random(-1,-0.5)
      end
      if (Geo==3) then
        return   math.random(-screenWidth,screenWidth*2),screenHeight*2+200*k2,math.random(-10*k,10*k),math.random(-10*k2,-6*k2),math.random(0.5,1) 
      end
      if (Geo==4) then
        return  screenWidth*2+200*k, math.random(-screenHeight,screenHeight*2),math.random(-10*k,-6*k),math.random(-10*k,10*k), math.random(-1,-0.6)
      end
end

function allSpawn(mas,Geo,Tip)
    if ( mas == obj) then
        local colorRGB = 0.2
        local Body =math.random(1,5)
        local colorDop1,colorDop2,colorDop3,scale,collScale= objColorAndScale(Body)
        local x,y,ax,ay,ra = allGeo(Geo)
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
        local x,y,ax,ay,ra = allGeo(Geo)
        if ( Tip ==1) then
            local health = 3
            local damage = 1
            local e = {
                tip = Tip, 
                body =HC.rectangle(-10*k,-10*k2,1*k,1*k2),
                timer = 0 , 
                invTimer = 20,
                atack = 0,
                atackTimer = 60,
                dash = 0,
                dashTimer = 20,
                color1 =0.8,
                color2=0.2,
                color3 =0.2,
                scale = 'm',
                r = 0 ,
                ugol =  0,
                flagr = 0 ,
                damage = damage , 
                f = false,
                x  = x, 
                y = y ,  
                ax  =ax, 
                ay = ay, 
                health = health,
                healthM = health
                }
            table.insert(mas,e)
        end
        if ( Tip ==2) then 
            local health = 2
            local damage = 10
            local e = {
                body =HC.rectangle(-10*k,-10*k2,1*k,1*k2),
                damage = damage, 
                invTimer = 20,
                timer = 0 , 
                atack = 0,
                atackTimer = 30,
                tip = Tip, 
                ugol =  0,
                color1 =0.8,
                color2=0.2,
                color3 =0.2,
                scale = 'm',
                r = 0 ,
                flagr = 0 ,
                f = false,
                x  = x, 
                y = y ,  
                ax  =ax, 
                ay = ay, 
                health = health,
                healthM = health
                }
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

function allDecompose(mas,i)
    local Wave = waves[numberWave]
    local numberRes = 0
    if ( mas[i].scale == 'l') then
        numberRes = math.random(8,14)  
    end
    if ( mas[i].scale == 'm') then
        numberRes = math.random(5,10) 
    end
    if ( mas[i].scale == 's') then
        numberRes = math.random(4,7) 
    end
    if ( mas[i].scale == 'xs') then
        numberRes = math.random(2,4) 
    end
    colWave = colWave-1
    expl(50*k,screenHeight/2-(colWave*300*k2/Wave[4])/2,10)
    expl(50*k,screenHeight/2-(colWave*300*k2/Wave[4])/2+colWave*300*k2/Wave[4],10)
    for kek =0, numberRes do
        local kkek = math.random()
        local colorDop1 = mas[i].color1+ kkek/3
        local colorDop2 = mas[i].color2+ kkek/3
        local colorDop3 = mas[i].color3+ kkek/3
        if ( math.random(1,30)==1) then
            local eh = {
                tip = 4, --hp
                r = 0,
                flag =true,
                color1 =colorDop1,
                color2=colorDop2,
                color3 =colorDop3,
                f = false,
                x  = mas[i].x, 
                y =  mas[i].y,  
                ax  =math.random(-2*k*kek,2*k*kek), 
                ay = math.random(-2*k*kek,2*k*kek), 
            }
            table.insert(res,eh)
        else
            local RandomP =  math.random(100) 
            local RandomTip = 1
            if ( RandomP >80 and RandomP <90) then
                RandomTip = 2
            else
                  if ( RandomP > 80) then 
                      RandomTip = 3
                  end
            end
            
            local eh = {
                tip = RandomTip,
                r = math.random(1,3),
                flag =true,
                color1 =colorDop1,
                color2= colorDop2,
                color3 =colorDop3,
                f = false,
                x  = mas[i].x, 
                y =  mas[i].y,  
                ax  =math.random(-1.5*k*kek,1.5*k*kek)/RandomTip, 
                ay = math.random(-1.5*k*kek,1.5*k*kek)/RandomTip, 
            }
            table.insert(res,eh)
        end
    end
end

function enTip1(r2,mode,x,y,w,h,r,ox,oy,flag,hp,healthM )
    local dp = 0
    if (flag == 1) then
        dp = 0.3
    end
    love.graphics.setColor(1+dp,0.18+dp,0.18+dp)
    enRot1(r2,"fill",x,y,4*k,4*k2,r,4*k/2,4*k2/2)  
    love.graphics.push()
    love.graphics.translate( x + ox,y + oy )
    love.graphics.push()
    love.graphics.rotate(-r)
    love.graphics.setColor(0.28+dp,0.04+dp,0.04+dp,1)
    love.graphics.polygon('fill',1.7053571428572*k,0.3492063492064*k2,0.68898809523814*k,1.3650793650794*k2,4.7544642857143*k,4.4126984126984*k2,6.2790178571428*k,11.015873015873*k2,6.2790178571428*k,17.111111111111*k2,4.7544642857143*k,24.730158730159*k2,-0.8355654761905*k,32.349206349206*k2,0.8355654761905*k,32.349206349206*k2,-3.2299107142857*k,28.285714285714*k2,-4.7544642857143*k,24.730158730159*k2,-6.2790178571428*k,17.111111111111*k2,-6.2790178571428*k,11.015873015873*k2,-4.7544642857143*k,4.4126984126984*k2,-0.68898809523814*k,1.3650793650794*k2,-1.7053571428572*k,0.3492063492064*k2) 
    love.graphics.setColor(0.616+dp,0.09+dp,0.09+dp,1)
    if (hp/(healthM/100)>= 70) then
        love.graphics.line(5.2626488095238*k,22.190476190476*k2,10.852678571429*k,22.190476190476*k2,12.377232142857*k,15.079365079365*k2,14.409970238095*k,23.206349206349*k2,6.7872023809524*k,27.269841269841*k2,3.2299107142857*k,24.730158730159*k2)
    end
    if (hp/(healthM/100)>= 50) then
    love.graphics.line(-3.2299107142857*k,24.730158730159*k2,-6.7872023809524*k,27.269841269841*k2,-14.409970238095*k,23.206349206349*k2,-12.377232142857*k,15.079365079365*k2,-10.852678571429*k,22.190476190476*k2,-5.2626488095238*k,22.190476190476*k2)
    end
    love.graphics.setColor(0.616+dp,0.09+dp,0.09+dp,1)
    love.graphics.line(1.7053571428572*k,0.3492063492064*k2,0.68898809523814*k,1.3650793650794*k2,4.7544642857143*k,4.4126984126984*k2,6.2790178571428*k,11.015873015873*k2,6.2790178571428*k,17.111111111111*k2,4.7544642857143*k,24.730158730159*k2,3.2299107142857*k,28.285714285714*k2,-0.8355654761905*k,32.349206349206*k2)love.graphics.line(0.8355654761905*k,32.349206349206*k2,-3.2299107142857*k,30.285714285714*k2,-4.7544642857143*k,26.730158730159*k2,-6.2790178571428*k,19.111111111111*k2,-6.2790178571428*k,13.015873015873*k2,-4.7544642857143*k,6.4126984126984*k2,-0.68898809523814*k,1.3650793650794*k2,-1.7053571428572*k,0.3492063492064*k2)
    love.graphics.pop()
    love.graphics.pop()
end
function enTip2(r2,mode,x,y,w,h,r,ox,oy,flag,hp,healthM )
    local dp = 0
    if (flag == 1) then
        dp = 0.3
    end
    love.graphics.setColor(0.565+dp,0.137+dp,0.137+dp)
    enRot2(r2,"fill",x,y,4*k,4*k2,r,4*k/2,4*k2/2)  
    love.graphics.push()
    love.graphics.translate( x + ox,y + oy )
    love.graphics.push()
    love.graphics.rotate(-r)
    love.graphics.setColor(0.282+dp,0.067+dp,0.067+dp,0.8)
    love.graphics.circle('fill',0,8*k2,8*k2)
    love.graphics.setColor(0.565+dp,0.137+dp,0.137+dp)
    if (hp/(healthM/100)>= 70) then
        love.graphics.line(6.2790178571428*k,4.8888888888889*k2,10.344494047619*k,1.3333333333333*k2,10.344494047619*k,-4.7619047619048*k2,15.426339285714*k,8.952380952381*k2,7.295386904762*k,14.031746031746*k2) 
    end
    love.graphics.line(-7.295386904762*k,14.031746031746*k2,-15.426339285714*k,8.952380952381*k2,-10.344494047619*k,-4.7619047619048*k2,-10.344494047619*k,1.3333333333333*k2,-6.2790178571428*k,4.8888888888889*k2)
    love.graphics.setColor(0.282+dp,0.067+dp,0.067+dp)
    love.graphics.circle('line',0,8*k2,8*k2)
    love.graphics.pop()
    love.graphics.pop()
end

function enTip3(r2,mode,x,y,w,h,r,ox,oy,flag,hp,healthM )
    love.graphics.setColor(color1,color2,color3)
   
    enRot3(r2,"fill",x,y,4*k,4*k2,r,4*k/2,4*k2/2,color1,color2,color3)  

    love.graphics.push()
    love.graphics.translate( x + ox,y + oy )
    love.graphics.push()
    love.graphics.rotate(-r)
    love.graphics.setColor(0.1,0.1,0.1)
    love.graphics.polygon('fill',0.18080357142862*k,3.3809523809524*k2,8.311755952381*k,7.952380952381*k2,8.311755952381*k,13.539682539683*k2,-0.3273809523809*k,9.47619047619*k2,0.3273809523809*k,9.47619047619*k2,-8.311755952381*k,13.539682539683*k2,-8.311755952381*k,7.952380952381*k2,-0.18080357142862*k,3.3809523809524*k2)
    love.graphics.setColor(color1,color2,color3,1)
    love.graphics.line(0.68898809523814*k,2.3492063492064*k2,5.2626488095238*k,4.3809523809524*k2,8.8199404761905*k,7.4285714285714*k2,9.328125*k,15.555555555556*k2,8.8199404761905*k,22.15873015873*k2,5.2626488095238*k,28.761904761905*k2,2.2135416666667*k,29.777777777778*k2,1.1971726190477*k,31.809523809524*k2,-1.1971726190477*k,31.809523809524*k2,-2.2135416666667*k,29.777777777778*k2,-5.2626488095238*k,28.761904761905*k2,-8.8199404761905*k,22.15873015873*k2,-9.328125*k,15.555555555556*k2,-8.8199404761905*k,7.4285714285714*k2,-5.2626488095238*k,4.3809523809524*k2,-0.68898809523814*k,2.3492063492064*k2) 
    love.graphics.line(0,33.333333333333*k2,0,37.952380952381*k2)
    
    love.graphics.pop()
    love.graphics.pop()
end



function enRot1(r2,mode,x,y,w,h,r,ox,oy)
    love.graphics.push()
    love.graphics.translate( x + ox,y + oy )
    love.graphics.push()
    love.graphics.rotate(-r)
    love.graphics.push()
    love.graphics.rotate(r2)

   love.graphics.line(5.7708333333333*k,22.15873015873*k2,14.918154761905*k,30.793650793651*k2,7.8035714285715*k,47.047619047619*k2,9.328125*k,33.333333333333*k2,1.7053571428572*k,22.15873015873*k2) 
      


    love.graphics.pop()
    love.graphics.push()
    love.graphics.rotate(-r2)
    
love.graphics.line(-1.7053571428572*k,22.15873015873*k2,-9.328125*k,33.333333333333*k2,-7.8035714285715*k,47.047619047619*k2,-14.918154761905*k,30.793650793651*k2,-5.7708333333333*k,22.15873015873*k2)

  

    love.graphics.pop()
    love.graphics.pop()
    love.graphics.pop()
end

function enRot2(r2,mode,x,y,w,h,r,ox,oy)
    love.graphics.push()
    love.graphics.translate( x + ox,y + oy )
    love.graphics.push()
    love.graphics.rotate(-r)
    love.graphics.push()
    love.graphics.rotate(r2-0.1)


 love.graphics.line(-2.7217261904762*k,25.714285714286*k2,-8.311755952381*k,22.666666666667*k2,-3.7380952380952*k,15.555555555556*k2)

    
    love.graphics.pop()
    love.graphics.push()
    love.graphics.rotate(-r2+0.1)
   love.graphics.line(3.7380952380952*k,15.555555555556*k2,8.311755952381*k,22.666666666667*k2,2.7217261904762*k,25.714285714286*k2)
    love.graphics.pop()
    love.graphics.pop()
    love.graphics.pop()
end

function enRot3(r2,mode,x,y,w,h,r,ox,oy,color1,color2,color3)
    love.graphics.push()
    love.graphics.translate( x + ox,y + oy )
    love.graphics.push()
    love.graphics.rotate(-r)
    love.graphics.push()
    love.graphics.rotate(r2-0.1)
 love.graphics.line(-11.360863095238*k,40.952380952381*k2,-14.918154761905*k,39.428571428571*k2,-14.409970238095*k,34.857142857143*k2,-7.8035714285715*k,27.746031746032*k2)


    love.graphics.pop()
    love.graphics.push()
    love.graphics.rotate(-r2+0.1)
love.graphics.line(7.8035714285715*k,27.746031746032*k2,14.409970238095*k,34.857142857143*k2,14.918154761905*k,39.428571428571*k2,11.360863095238*k,40.952380952381*k2)
    love.graphics.pop()
    love.graphics.pop()
    love.graphics.pop()
end

function allDraw(dt)
  --  player.body:draw('fill')
    enemiesSledDraw(dt)
    for i= 1,#res do
        if (res[i].x>camera.x-screenWidth/2-30*k and  res[i].x<camera.x+screenWidth/2+30*k and  res[i].y>camera.y-screenHeight/2-30*k2 and res[i].y<camera.y + screenHeight/2+30*k2) then
            if ( res[i].tip == 1) then
                love.graphics.setColor(res[i].color1,res[i].color2,res[i].color3)
                rot('fill',res[i].x,res[i].y,4*k,4*k2,res[i].r,2*k,2*k2)
            end
            if ( res[i].tip == 2) then
                 love.graphics.setColor(res[i].color1,res[i].color2,res[i].color3)
                 rot('fill',res[i].x,res[i].y,7*k,7*k2,res[i].r,2*k,2*k2)
            end
            if ( res[i].tip == 3) then
                love.graphics.setColor(res[i].color1,res[i].color2,res[i].color3)
                rot('fill',res[i].x,res[i].y,10*k,10*k2,res[i].r,2*k,2*k2)
            end
            ------------------------------------------------------------------
            if ( res[i].tip == 4) then
                love.graphics.setColor(0.7,0.2,0.2)
                --love.graphics.circle("line",res[i].x+8*k,res[i].y+8*k2,2*k)
                --rot('line',res[i].x,res[i].y,16*k,16*k2,2)
            end
        end
    end 
   
    for i= 1,#obj do
        if (obj[i] and obj[i].body)  then
          if (obj[i].x>camera.x-screenWidth/2-obj[i].collScale*k and  obj[i].x<screenWidth+camera.x-screenWidth/2+20*k+obj[i].collScale*k and  obj[i].y>camera.y-screenHeight/2-obj[i].collScale*k2 and obj[i].y<screenHeight+camera.y-screenHeight/2+20*k2+obj[i].collScale*k2) then
            local IobjRegulS =math.floor((obj[i].x-60*k)/(120*k)) + math.floor((obj[i].y-60*k2)/(120*k2))*math.floor((screenWidth/(120*k))+1)
            objCollWithObjInRegularS(IobjRegulS,i)
          --  objCollWithObjInRegularS(IobjRegulS-1,i)
            objCollWithObjInRegularS(IobjRegulS+1,i)
          
           -- objCollWithObjInRegularS(IobjRegulS-math.floor((screenWidth/(120*k))+1),i)
            objCollWithObjInRegularS(IobjRegulS+math.floor((screenWidth/(120*k))+1),i)
            
            objCollWithObjInRegularS(IobjRegulS+math.floor((screenWidth/(120*k))+1)+1,i)
         --   objCollWithObjInRegularS(IobjRegulS+math.floor((screenWidth/(120*k))+1)-1,i)
            
            objCollWithObjInRegularS(IobjRegulS-math.floor((screenWidth/(120*k))+1)+1,i)
          --  objCollWithObjInRegularS(IobjRegulS-math.floor((screenWidth/(120*k))+1)-1,i)
          end
        end
        if (obj[i] and obj[i].body)  then
       -- love.graphics.circle("line",obj[i].x,obj[i].y,obj[i].collScale/2*k)
        local  kekI = math.floor((obj[i].x/120) + (obj[i].y/120)*(screenWidth/(120*k)) +1)
        if (obj[i].x>camera.x-screenWidth/2-obj[i].collScale*k and  obj[i].x<screenWidth+camera.x-screenWidth/2+20*k+obj[i].collScale*k and  obj[i].y>camera.y-screenHeight/2-obj[i].collScale*k2 and obj[i].y<screenHeight+camera.y-screenHeight/2+20*k2+obj[i].collScale*k2) then
        if ( obj[i].timer) then
            if not( obj[i].invTimer == obj[i].timer) then
                if ( obj[i] and obj[i].bodyDop) then
                    objFragmVect(i,1,0.6,0.6)
             --    obj[i].body:draw('line')
                else
                  objVect(i,1,0.6,0.6)
             --     obj[i].body:draw('line')
              end
            else
                if ( obj[i] and obj[i].pok>0) then
                   objFragmVect(i,1,1,1)
             --     obj[i].body:draw('line')
                else
                 objVect(i,1,1,1)
              ---    obj[i].body:draw('line')
                end
            end
        end
        end
--          love.graphics.print(IobjRegulS,obj[i].x,obj[i].y,0,2,2)
            --    love.graphics.print(kekI, obj[i].x,obj[i].y,0,1,1)
        end
    end
    
    
    for  i=1,#en do
        if ( en[i] and en[i].body) then
       --     en[i].body:draw('fill')
        end
        
        if ( en[i].tip==1) then
            if ( en[i].invTimer and en[i].invTimer ~= en[i].timer) then
                enemySled(en[i].x,en[i].y,2*k,i,1,0.6,0.6,en[i].ugol,en[i].tip)
                
                enTip1(en[i].r,"fill",en[i].x,en[i].y,4*k,4*k2,en[i].ugol,4*k/2,4*k2/2,1,en[i].health,en[i].healthM)
            else
                enemySled(en[i].x,en[i].y,2*k,i,1,0.1,0.1,en[i].ugol,en[i].tip)
            
                enTip1(en[i].r,"fill",en[i].x,en[i].y,4*k,4*k2,en[i].ugol,4*k/2,4*k2/2,0,en[i].health,en[i].healthM)
            end
        else
            if ( en[i].tip==2) then
                if ( en[i].invTimer and en[i].invTimer ~= en[i].timer) then
                    enemySled(en[i].x,en[i].y,2*k,i,1,0.6,0.6,en[i].ugol,en[i].tip)
                    
                    enTip2(en[i].r,"fill",en[i].x,en[i].y,4*k,4*k2,en[i].ugol,4*k/2,4*k2/2,1,en[i].health,en[i].healthM)
                else
                    enemySled(en[i].x,en[i].y,2*k,i,1,0.1,0.1,en[i].ugol,en[i].tip)
                    
                    enTip2(en[i].r,"fill",en[i].x,en[i].y,4*k,4*k2,en[i].ugol,4*k/2,4*k2/2,0,en[i].health,en[i].healthM)
                end
            else
            
              
              
            end
        end
    end
end
function allBorder(i,mas)
    ----------если залетел на карту поднимаем флаг-------------------------------------  
    if (mas[i].x< screenWidth*2-mas[i].collScale*k/2 and  mas[i].x> -screenWidth +mas[i].collScale*k/2 and  mas[i].y> -screenHeight+mas[i].collScale*k2/2 and  mas[i].y<screenHeight*2-mas[i].collScale*k2/2) then
        mas[i].f = true
    end
    --------------------------------------------------
    
    --------------------------------------------------
    if ( mas[i] and mas[i].f == true) then
        if ( mas[i].x > screenWidth*2-mas[i].collScale*k/2) then 
            mas[i].ax = -mas[i].ax
            mas[i].x =screenWidth*2 - 0.1*k-mas[i].collScale*k/2
        end
        if ( mas[i].x <  -screenWidth+mas[i].collScale*k/2) then 
            mas[i].ax = -mas[i].ax
            mas[i].x = -screenWidth + 0.1*k+mas[i].collScale*k/2
        end
        if ( mas[i].y < -screenHeight+mas[i].collScale*k2/2) then 
            mas[i].ay = -mas[i].ay
            mas[i].y = -screenHeight+0.1*k2+mas[i].collScale*k2/2
        end
        if ( mas[i].y > screenHeight*2-mas[i].collScale*k2/2) then 
            mas[i].ay = -mas[i].ay
            mas[i].y = screenHeight*2 - 0.1*k2-mas[i].collScale*k2/2
        end
        if ( mas[i].x > screenWidth*2 or mas[i].x < -screenWidth or mas[i].y < -screenHeight or  mas[i].y > screenHeight*2 ) then
           table.remove(mas,i)
        end
    end
end

return game