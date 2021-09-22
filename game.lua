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
dt2 = 0
removeEn = {}
colll = {}
slediEn ={}
flagclass = "slicer" 
tap =  false
colorx=0.2
colory=0.2
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
  body = HC.polygon(1,3,2,2,5,5),
  invis = 10,
  length1 =15,
  length2  = 20,
  boost =  screenHeight,
  hp =  screenHeight,
  x = screenWidth/2, 
  y = screenHeight/2, 
  scale  = 1,  
  ax = 0,
  a = 0 , 
  ay = 0,
  color = 0,
} 


en = {}
obj = {}
res = {}
enemyBullets = {} 
playerSledi = {} 

end




function game:update(dt)
boost.long = 1000
hp.long = 1000 
mouse.x,mouse.y=love.mouse.getPosition()
mouse.x = mouse.x/sx
mouse.y = mouse.y/sy
dt2 = dt 
flagtouch2 = false -- для выхода в состояние пауза
--------------------
lvlplayer()
playerControl()
playerHP()
explUpdate2()
-------------------
Sccale:update(dt)
local Wave = waves[numberWave] 
 
for i = 1 , #obj do
    if (obj[i]) then  
        enHpLength(i,obj)
        objMove(i) 
        allBorder(i,obj) 
        if (obj[i] and obj[i].body and player.body:collidesWith(obj[i].body) and obj[i].invTimer==obj[i].timer)  then
            objColl(i, obj[i].tip, player.a)
        end
        if ( obj[i]) then
            if (obj[i].health<=0) then
                destroyMet(obj,i) 
                table.remove(obj,i)
            end
        end  
    end
end
 
for i = 1 , #res do
    if (res[i]) then 
        resColl(i)
        resMove(i)
        allBorder(i,res)    
        if (res[i]) then  
            resСollect(i)
        end
    end
end 
 
for i=1,#en do
    if (en[i]) then 
        enHpLength(i,en)
        enMove(i)  
        enAtack(i)
        if   (en[i] and en[i].body and player.body:collidesWith(en[i].body))  then
            enColl(i, en[i].tip, player.a)
        end
    
        if (en[i] and en[i].health and en[i].health<=0 ) then
            kill(en,i)
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

playerBoost()

if ( colWave>0 and #obj < 20) then
    Timer.every(math.random(2,4), function()
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
            spawnAll(obj,Geo,Tip)
        end
  
        for i=1,math.random(0,1) do
            local Wave = waves[numberWave]
            local Geo  =math.random(1,4)
            local Tip =math.random(1,2)
            local Scale =math.random(2,2)
            spawnAll(en,Geo,Tip)
        end
        Timer.clear() 
    end)
  
    Timer.update(dt)
end

if not(love.mouse.isDown(1)) then
    player.a = 0 
    if ( player.ax> 0) then
        player.ax = player.ax-13*dt*k
    else
        player.ax = player.ax+13*dt*k
    end
    if ( player.ay> 0) then
        player.ay = player.ay-13*dt*k2
    else
        player.ay = player.ay+13*dt*k2
    end
end

player.x = player.x + player.ax*dt*13*k
player.y = player.y + player.ay*dt*13*k2
if ( player.a==1 and flagclass=='slicer') then
    player.x = player.x + player.ax*dt*6*k
    player.y = player.y + player.ay*dt*6*k2
end

bulletsUpdate()
self:movement(dt)

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
    
    if love.keyboard.isDown('e') then
        local Geo  =math.random(1,4)
        local Tip =1
        local Scale =math.random(2,2)
        spawnAll(obj,Geo,Tip)
        obj[#obj].x = mouse.x
        obj[#obj].y = mouse.y
    end
end


function  game:draw()
    playerBatch:clear()
    if ( flagclass =='slicer') then
        if ( boost.long >70*k2  ) then
            boost.flag = true
        end
        if ( boost.long <= 30*k2  ) then
            player.a=0
            boost.long =30*k2
            boost.flag = false
        end
    end
    love.graphics.setCanvas(kek)
    love.graphics.clear()
    love.graphics.draw(fon1,0,0,0,k,k2)
    love.graphics.draw(fon2,0,0,0,k,k2)
   -- love.graphics.draw(fon3,-player.x/25,-player.y/25,0,k,k2)
    if (flaginv == false ) then
      love.graphics.translate( 0  ,random(0,shake) )   end
    playerSledDraw()
    love.graphics.setLineWidth(1.5)
    love.graphics.setColor(1,1,1,1)
    --    love.graphics.setShader(myShader)
      --  love.graphics.draw(meteors.m1,200*k,200*k2,0,1,1,meteors.m1:getWidth()/2,meteors.m1:getHeight()/2
      --  love.graphics.setShader()
    meteorDraw()
    love.graphics.setColor(1,1,1)
    love.graphics.draw(playerBatch)
    love.graphics.setLineWidth(1)
    bulletsDraw()
    Health_Boost()
    endr()
    
       
    if ( #obj  >0 and #vect > 0) then
        for i = 1, #vect do
            if (i>= lenVect) then
                lenVect = lenVect +100
                recoveryVect()
            else
                meshMeteors:setVertex( i, vect[i] )
            end
        end
        meshMeteors:setDrawRange( 1,  #vect )
        love.graphics.setColor(1,1,1,1)
       
        love.graphics.draw(meshMeteors, 0,0)
   
    end
 --  meteorDraw()
  
    if ( player.a==0  ) then 
        love.graphics.setColor( 0 , 0 ,1) 
    else
        if ( flagclass == 'slicer') then 
            love.graphics.setColor( 1 , 0 , 0 ) 
        end
    end
    if ( player.a == 0 ) then
       
    else
      
    end
    love.graphics.setColor( 1 , 1 , 1 ) 
 
    love.graphics.draw(playerIm,player.x+player.scale/2*40*k,player.y+player.scale/2*40*k2,-controler.angle+math.pi,k/7,k2/7,playerIm:getWidth()/2,playerIm:getHeight()/2)

    self:worldBorders(dt)
    love.graphics.setColor(1,0,0.02)
    love.graphics.print("HP "..math.floor(hp.long/screenHeight*100)..'/'..100, screenWidth-55*k,screenHeight/2+200*k2,-math.pi/2,0.3,0.3)
    love.graphics.setColor(0,0.643,0.502)
    love.graphics.print("BOOST "..math.floor(boost.long/screenHeight*100)..'/'..100, screenWidth-55*k,220*k2,-math.pi/2,0.3,0.3)
    love.graphics.setColor(1,1,1)
    local kkol = #(tostring (score))
    love.graphics.print(score,22*k-(70*k*0.5)/2, screenHeight/2+(kkol*45/2*k2*0.5),-math.pi/2,0.5,0.5)
    Waves(numberWave)
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
   vect = {}
end
               

function Waves(n)
    if ( waveflag == 0   ) then
        wavetimer:update(dt2)
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
        wavetimer:update(dt2)
        wavetimer:every(3, function()
            wavetimer:clear() 
            waveflag = 2
        end)
    end
    if ( waveflag == 2 and wavex == 0) then
        wavetimer:update(dt2)
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

function endr()
    for i=1,#removeEn do
        local h =  removeEn[i]
        if ( removeEn[i]) then
            if ( h.tip == 4 ) then
                love.graphics.setColor(1,0.1,0.1)
                love.graphics.print("+HP",removeEn[i].x,removeEn[i].y,-math.pi/2,0.4)  
            else 
                if ( h.tip == 1 ) then
                    love.graphics.setColor(0.235,0.616,0.816,0.6)
                    love.graphics.print("+1",removeEn[i].x,removeEn[i].y,-math.pi/2,0.2)    
                end
                if ( h.tip == 2 ) then
                    love.graphics.setColor(0.514,0.941,0.235,0.6)
                    love.graphics.print("+3",removeEn[i].x,removeEn[i].y,-math.pi/2,0.3)    
                end
                if ( h.tip == 3 ) then
                    love.graphics.setColor(0.549,0.427,0.843,0.6)
                    love.graphics.print("+5",removeEn[i].x,removeEn[i].y,-math.pi/2,0.4)    
                end
            end
            h[#h] =  h[#h]+ 0.15*dt2
            if (  h[#h]> 0.1) then
                table.remove(removeEn,i)
            end        
        end
    end
end


function enHpLength(i,mas)
    if ( mas[i] and mas[i].timer) then
        if ( mas[i].invTimer) then
            if ( mas[i].timer < mas[i].invTimer) then
                mas[i].timer  = mas[i].timer - dt2* 40
            end
            if ( mas[i].timer < 0) then
                mas[i].timer  = mas[i].invTimer
            end
        end
    end
end



function enAtack(i)
    if ( en[i] and en[i].atack) then
        if ( en[i].atack <  en[i].atackTimer) then
            en[i].atack  = en[i].atack  - 30*dt2
        end
        if ( en[i].atack < 0) then
            en[i].atack  = en[i].atackTimer
        end
    end
    if ( en[i] and en[i].dash) then
        if ( en[i].dash <  en[i].dashTimer) then
            en[i].dash  = en[i].dash  - 30*dt2
        end
        if ( en[i].dash < 0) then
            en[i].dash  = en[i].dashTimer
        end
    end
end
  
  
function objMove(i) 
    if (obj[i]) then
        objBody(i,obj[i].tip,obj[i].met)
        if ( obj[i].f == true ) then 
        -----------------------------------------------      
            if ( obj[i].tip == 1) then
                obj[i].ot =false
                obj[i].x= obj[i].x+obj[i].ax*dt2*5
                obj[i].y= obj[i].y+obj[i].ay*dt2*5
                if ( obj[i].ax >5) then
                    obj[i].ax = obj[i].ax-20*dt2
                end
                if ( obj[i].ay >5) then
                    obj[i].ay = obj[i].ay-20*dt2
                end
            end
        -----------------------------------------------  
        else
        -----------------------------------------------   
            if ( obj[i].tip == 1) then
                obj[i].ot =false
                obj[i].x= obj[i].x+obj[i].ax*dt2*10
                obj[i].y= obj[i].y+obj[i].ay*dt2*10
            end  
        -----------------------------------------------  
        end
    end
    
end


function enMove(i) 
    enTip(i,en[i].tip)
    
    if (en[i].ugol) then 
        en[i].body:rotate(-en[i].ugol,en[i].x,en[i].y) 
    end
    if ( en[i].tip == 1) then
        if ( en[i].invTimer and  en[i].invTimer == en[i].timer) then
        -----------------------------------------------  
            rotAngle(i,en[i].tip)
            local ugol = math.atan2(player.x-en[i].x+20*k,player.y-en[i].y+20*k)
          if (en[i].dash and en[i].dash==en[i].dashTimer) then
                enUgol(i,ugol)
           end
            if ((math.sqrt(math.pow((player.x+40*k/2-en[i].x),2)+math.pow((player.y+40*k2/2-en[i].y),2))) > 30*k) then
                if (en[i].dash and en[i].dash==en[i].dashTimer) then
                    if not((math.abs(ugol) -  math.abs(en[i].ugol)) > 2.01*dt2 or (math.abs(ugol) -  math.abs(en[i].ugol)) <  -2.01*dt2 ) then
                        en[i].ax=22*k*math.sin(ugol)
                        en[i].ay=22*k2*math.cos(ugol)
                    end
                end
            end
            
            if (en[i].dash and en[i].dash==en[i].dashTimer and en[i].atack and en[i].atack==en[i].atackTimer and en[i].invTimer ==en[i].timer and (math.sqrt(math.pow((player.x+40*k/2-en[i].x),2)+math.pow((player.y+40*k2/2-en[i].y),2))) <=100*k ) then
                en[i].atack = en[i].atackTimer-0.001
                en[i].dash = en[i].dashTimer-0.001
            end
            
            if (en[i].dash and en[i].dash==en[i].dashTimer)  then
                if ((math.abs(ugol) -  math.abs(en[i].ugol)) > 2.01*dt2 or (math.abs(ugol) -  math.abs(en[i].ugol)) <  -2.01*dt2 ) then
                   en[i].x= en[i].x+en[i].ax*dt2*0
                   en[i].y= en[i].y+en[i].ay*dt2*0
                   en[i].ax = 0
                   en[i].ay = 0 
                else
                    en[i].x= en[i].x+en[i].ax*dt2*7
                    en[i].y= en[i].y+en[i].ay*dt2*7
                end
                 if not((math.abs(ugol) -  math.abs(en[i].ugol)) > 2.01*dt2 or (math.abs(ugol) -  math.abs(en[i].ugol)) <  -2.01*dt2 ) then
                en[i].x= en[i].x+math.sin(en[i].y/10)*dt2*50
                en[i].y= en[i].y+math.cos(en[i].x/10)*dt2*50
                end
            else
                en[i].x= en[i].x+en[i].ax*dt2*17
                en[i].y= en[i].y+en[i].ay*dt2*17
           end
        -----------------------------------------------  
        else
        -----------------------------------------------  
            if (en[i].ax>0)then
                en[i].ax =en[i].ax-50*dt2
            else
                en[i].ax =en[i].ax+50*dt2
            end
            if (en[i].ay>0)then
                en[i].ay =en[i].ay-50*dt2
            else
                en[i].ay =en[i].ay+50*dt2
            end
            en[i].x= en[i].x-en[i].ax*dt2*3
            en[i].y= en[i].y-en[i].ay*dt2*3
        -----------------------------------------------  
        end
    end
    if ( en[i].tip == 2) then
        if ( en[i].invTimer and  en[i].invTimer ==en[i].timer) then
        -----------------------------------------------------    
            if (en[i].atack and en[i].atack==en[i].atackTimer and en[i].invTimer ==en[i].timer and (math.sqrt(math.pow((player.x+40*k/2-en[i].x),2)+math.pow((player.y+40*k2/2-en[i].y),2))) <= 300*k ) then
                en[i].atack = en[i].atackTimer-0.001
                Fire(player.x+40*k/2,player.y+40*k2/2,en[i].x,en[i].y,en[i].ugol,en[i].damage)
            end
            rotAngle(i,en[i].tip)
            local ugol = math.atan2(player.x-en[i].x+20*k,player.y-en[i].y+20*k)
            enUgol(i,ugol)
            if ((math.abs(ugol) -  math.abs(en[i].ugol)) > 2.01*dt2 or (math.abs(ugol) -  math.abs(en[i].ugol)) <  -2.01*dt2 ) then
                en[i].x= en[i].x+en[i].ax*dt2*3
                en[i].y= en[i].y+en[i].ay*dt2*3
            else
                en[i].x= en[i].x+en[i].ax*dt2*7
                en[i].y= en[i].y+en[i].ay*dt2*7
            end
            en[i].x= en[i].x+math.sin(en[i].y/7)*dt2*50--!!!!!!!!!!!!
            en[i].y= en[i].y+math.cos(en[i].x/7)*dt2*50--!!!!!!!!!!
        -----------------------------------------------------      
        else
        -----------------------------------------------------  
            if (en[i].ax>0)then
                en[i].ax =en[i].ax-50*dt2
            else
                en[i].ax =en[i].ax+50*dt2
            end
            if (en[i].ay>0)then
                en[i].ay =en[i].ay-50*dt2
            else
                en[i].ay =en[i].ay+50*dt2
            end
            en[i].x= en[i].x-en[i].ax*dt2*3
            en[i].y= en[i].y-en[i].ay*dt2*3
        -----------------------------------------------------  
        end
    end
    if ( en[i].tip == 3) then
      
    end   
    
end
function resMove(i)
    if (res[i].tip == 1) then
        res[i].x= res[i].x+res[i].ax*dt2*10
        res[i].y= res[i].y+res[i].ay*dt2*10
    end
    if (res[i].tip == 2) then
        res[i].x= res[i].x+res[i].ax*dt2*7
        res[i].y= res[i].y+res[i].ay*dt2*7
    end
    if (res[i].tip == 3) then
        res[i].x= res[i].x+res[i].ax*dt2*5
        res[i].y= res[i].y+res[i].ay*dt2*5
    end
    if (res[i].tip == 4) then
        res[i].x= res[i].x+res[i].ax*dt2*10
        res[i].y= res[i].y+res[i].ay*dt2*10
    end  
    if ( res[i].ax > 0 ) then
        res[i].ax  = res[i].ax - 6*dt2
    else
        res[i].ax  = res[i].ax + 6*dt2
    end
    if ( res[i].ay > 0 ) then
        res[i].ay  = res[i].ay - 6*dt2
    else
        res[i].ay  = res[i].ay + 6*dt2
    end
      
end
function enUgol(i,ugol)
    if ( en[i].ugol == 0) then
        en[i].ugol=0.00000001
    end
    if ( en[i].ugol < -math.pi) then
        en[i].ugol=math.pi
    end
    if ( en[i].ugol > math.pi) then
        en[i].ugol=-math.pi
    end
    if ( ugol == 0) then
        ugol=0.00000001
    end
    if ((math.abs(ugol) -  math.abs(en[i].ugol)) > 2.01*dt2 or (math.abs(ugol) -  math.abs(en[i].ugol)) <  -2.01*dt2 ) then
        if (ugol/math.abs(ugol)==en[i].ugol/math.abs(en[i].ugol))then
            if ( ugol>en[i].ugol) then
                en[i].ugol = en[i].ugol+4*dt2
            else 
                en[i].ugol = en[i].ugol-4*dt2
            end
        else
            if (math.abs(ugol)+math.abs(en[i].ugol)> 2*math.pi - math.abs(ugol)-math.abs(en[i].ugol)) then
                if (en[i].ugol>0) then 
                    en[i].ugol = en[i].ugol+4*dt2
                else
                    en[i].ugol = en[i].ugol-4*dt2
                end
            else 
                if (en[i].ugol>0) then 
                    en[i].ugol = en[i].ugol-4*dt2
                else
                    en[i].ugol = en[i].ugol+4*dt2
                end
            end
        end
    end
  
end




function allBorder(i,mas)
    ----------если залетел на карту поднимаем флаг-------------------------------------  
    if (mas[i].x>0 and  mas[i].x<screenWidth and  mas[i].y>0 and  mas[i].y<screenHeight and mas[i].body) then
        if not(mas[i].body:collidesWith(left) or mas[i].body:collidesWith(right)or mas[i].body:collidesWith(up)or mas[i].body:collidesWith(down)) then
            mas[i].f = true
        end
    end
    --------------------------------------------------
    if (mas[i].body and mas[i].body:collidesWith(left) and mas[i].f == true) then
        mas[i].ax = math.random(1*k,6*k)
    end
    if (mas[i].body and mas[i].body:collidesWith(right) and mas[i].f == true)then
       mas[i].ax = -1*math.random(1*k,6*k)
    end
    if (mas[i].body and mas[i].body:collidesWith(up) and mas[i].f == true)then
       mas[i].ay = math.random(1*k,6*k)
    end
    if (mas[i].body and mas[i].body:collidesWith(down) and mas[i].f == true) then
      mas[i].ay = -1*math.random(1*k,6*k)
    end
    --------------------------------------------------
    if ( mas[i]) then
        if (  mas[i].x>screenWidth+150*k or  mas[i].x<-150*k or  mas[i].y>screenHeight+150*k2 or  mas[i].y<-150*k2 ) then
            table.remove(mas,i)
        end
    end
    if ( mas[i]) then
        if (  (mas[i].x>screenWidth or  mas[i].x<0 or  mas[i].y>screenHeight or  mas[i].y<0) and (mas[i].ay<1*k2 and mas[i].ay>-1*k2 and mas[i].ax<1*k and mas[i].ax>-1*k)) then
            table.remove(mas,i)
        end
    end
end


function resColl(i)
        if ( player.a==0  ) then 
            if ( checkCollision(player.x+player.scale*40/2*k-playerAbility.radiusCollect*k,player.y+player.scale*40/2*k2-playerAbility.radiusCollect*k2, playerAbility.radiusCollect*k*2, playerAbility.radiusCollect*k2*2,res[i].x,res[i].y,1*k,1*k2)) then
                local x1 = (player.x+player.scale*40/2*k)-res[i].x+1*k
                local y1 = (player.y+player.scale*40/2*k2)-res[i].y+1*k2          
                local ugol = math.atan2(x1,y1)
                if ( res[i].ax> 17*k*math.sin(ugol)) then
                    res[i].ax = res[i].ax - 1*k 
                else
                    res[i].ax = res[i].ax + 1*k 
                end
                if ( res[i].ay> 17*k2*math.cos(ugol)) then
                    res[i].ay = res[i].ay - 1*k2
                else
                    res[i].ay = res[i].ay + 1*k2 
                end
            end
        end
  
end

function resСollect(i)
    if ( checkCollision(player.x,player.y, player.scale*40*k, player.scale*40*k2,res[i].x,res[i].y,1*k,1*k2)) then
        if ( res[i].tip == 4) then
            hp.long3=hp.long3+50*k2
            remove(i,res)
        else
            score = score +1
            remove(i,res)
        end
    end
end

function enColl(i, tip, a)
    if ( a == 1) then
        if (tip == 1) then 
            if ( en[i] and en[i].health and en[i].invTimer and  en[i].invTimer ==en[i].timer) then
                en[i].timer =  en[i].invTimer-0.001
                en[i].health  =  en[i].health - playerAbility.damage
                en[i].ax =en[i].ax - player.ax
                en[i].ay =en[i].ay -  player.ay
                hit(en,i)
                
            end
        end
        if (tip == 2) then 
            if ( en[i] and en[i].health and en[i].invTimer and  en[i].invTimer ==en[i].timer) then
                en[i].timer =  en[i].invTimer-0.001
                en[i].health  =  en[i].health - playerAbility.damage
                en[i].ax =en[i].ax - player.ax
                en[i].ay =en[i].ay -  player.ay
                hit(en,i)
            end
        end
    else
        if ( en[i].tip == 1) then
            if ( player.invis == 10 and  en[i] and en[i].health and en[i].atack  and en[i].invTimer ==en[i].timer ) then
                flaginv = false 
                shake = 2
                hp.long = hp.long - en[i].damage
                hp.long3  = hp.long
            end 
        end 
        if ( en[i].tip == 2) then
            if ( en[i] and en[i].health and en[i].invTimer and  en[i].invTimer ==en[i].timer) then
                en[i].timer =  en[i].invTimer-0.001
                en[i].health  =  en[i].health - playerAbility.damage/1.5
                en[i].ax =en[i].ax - player.ax
                en[i].ay =en[i].ay -  player.ay
                hit(en,i)
            end  
        end
    end
end

function objColl(i, tip, a)
    local angleD = math.atan2(player.x-obj[i].x+20*k*player.scale,player.y-obj[i].y+20*k*player.scale)
    if ( a == 1) then
        if ( obj[i].tip == 1) then
            if ( obj[i] and obj[i].health ) then
                obj[i].health = obj[i].health -2*playerAbility.damage
                player.ax = 0.2 * player.ax 
                player.ay = 0.2 * player.ay
                obj[i].ax =-40*k*math.sin(angleD)
                obj[i].ay =-40*k2*math.cos(angleD)
            end
            obj[i].timer= obj[i].invTimer- 0.001
            if (obj[i].health<0) then 
                destroyMet(obj,i) 
                table.remove(obj,i)
            end
           
        else
            if (obj[i].tip == 2) then
              
            end
        end   
    else
        if ( obj[i].tip == 1) then
            local angl = math.atan2(-player.ax,-player.ay)
            if ( obj[i] and obj[i].health ) then
                obj[i].health = obj[i].health -1*playerAbility.damage
                player.ax = 0.2 * player.ax 
                player.ay = 0.2 * player.ay
                obj[i].ax =-40*k*math.sin(angleD)
                obj[i].ay =-40*k2*math.cos(angleD)
                
            end
            obj[i].timer= obj[i].invTimer- 0.001
            if (obj[i].health<0) then 
                destroyMet(obj,i) 
                table.remove(obj,i)
            end
           
        else
            if ( obj[i].tip == 2) then 
       
            end
        end 
    end
end


function remove(i,mas)
    local kek = 0
    table.insert(mas[i],kek)
    table.insert(removeEn,mas[i])
    table.remove(mas,i)
end 

function hit(mas,i)
    for kek =0, math.random(7,8) do
        local colorRGB =0.1
        local colorDop1 = math.random()/3
        local colorDop2 = math.random()/3
        local colorDop3 = math.random()/3
        local eh = {
            tip = 1,
            r = math.random(0,3),
            flag =true,
            color1 =colorRGB + colorDop1,
            color2= colorRGB + colorDop2,
            color3 =colorRGB + colorDop3,
            f = false,
            x  = mas[i].x, 
            y =  mas[i].y,  
            ax  =math.random(-2*k*kek,3*k*kek), 
            ay = math.random(-3*k*kek,3*k*kek), 
        }
        table.insert(res,eh)
    end
end
 

function kill(mas,i)
    local Wave = waves[numberWave]
    colWave = colWave-1
    expl(50*k,screenHeight/2-(colWave*300*k2/Wave[4])/2,10)
    expl(50*k,screenHeight/2-(colWave*300*k2/Wave[4])/2+colWave*300*k2/Wave[4],10)
    for kek =0, math.random(7,20) do
        local colorRGB =0
        local kkek = math.random()
        local colorDop1 = 0.4 + kkek *0.4
        local colorDop2 =  0.30 +kkek *0.3
        local colorDop3 =  0.27 + kkek *0.20
        if ( math.random(1,30)==1) then
            local eh = {
                tip = 4, --hp
                r = 0,
                flag =true,
                color1 =colorRGB + colorDop1,
                color2= colorRGB + colorDop2,
                color3 =colorRGB + colorDop3,
                f = false,
                x  = mas[i].x, 
                y =  mas[i].y,  
                ax  =math.random(-2*k*kek,3*k*kek), 
                ay = math.random(-3*k*kek,3*k*kek), 
               
            }
            table.insert(res,eh)
        else
            local RandomP =  math.random(100) 
            local RandomTip = 1
            if ( RandomP > 60 and RandomP <90) then
                RandomTip = 2
            else
                  if ( RandomP > 60) then 
                      RandomTip = 3
                  end
            end
            
            local eh = {
                tip = RandomTip,
                r = math.random(1,3),
                flag =true,
                color1 =colorRGB + colorDop1,
                color2= colorRGB + colorDop2,
                color3 =colorRGB + colorDop3,
                f = false,
                x  = mas[i].x, 
                y =  mas[i].y,  
                ax  =math.random(-2*k*kek,3*k*kek)/RandomTip, 
                ay = math.random(-3*k*kek,3*k*kek)/RandomTip, 
            }
            table.insert(res,eh)
        end
    end
end

function rot1(mode,x,y,w,h,rx,ry,segments,r,ox,oy)
    if not oy and rx then r,ox,oy = rx,ry, segments end
    r = r or 0 
    ox = ox or w/2
    oy = oy or h/2
    love.graphics.push()
    love.graphics.translate( x + ox,y + oy )
    love.graphics.push()
    love.graphics.rotate(-r)
    xx = ((-ox +player.scale/2*40*k)+20*k*math.cos(-0.3)) 
    yy = ((-oy+player.scale/2*40*k2) +20*k*math.sin(-0.3))
    xx2 = ((-ox +player.scale/2*40*k)+20*k*math.cos(-0.7*4.1)) 
    yy2 = ((-oy+player.scale/2*40*k2) +20*k*math.sin(-0.7*4.1))
---
    love.graphics.pop()
    love.graphics.pop()
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

function rotAtack(i,tip)
 if (tip == 1 ) then
        if ( en[i] and en[i].r) then
            if ( en[i].r> 0.22 ) then
                en[i].flagr = 1 
            end
            if ( en[i].r< 0 ) then
                en[i].flagr = 0 
            end
            if ( en[i].flagr ==0) then
                en[i].r = en[i].r+1.4*dt2*math.random(5,10)/7
            else
                en[i].r = en[i].r-1.4*dt2*math.random(5,10)/7
            end
        end
    end  
  
end

function rotAngle(i,tip)
    if (tip == 1 ) then
        if ( en[i] and en[i].r) then
            if ( en[i].r> 0.1 ) then
                en[i].flagr = 1 
            end
            if ( en[i].r< 0 ) then
                en[i].flagr = 0 
            end
            if ( en[i].flagr ==0) then
                en[i].r = en[i].r+1.1*dt2*math.random(5,10)/7
            else
                en[i].r = en[i].r-1.1*dt2*math.random(5,10)/7
            end
        end
    end
    if (tip == 2 ) then
        if ( en[i] and en[i].r) then
            if ( en[i].r> 0.22 ) then
                en[i].flagr = 1 
            end
            if ( en[i].r< 0 ) then
                en[i].flagr = 0 
            end
            if ( en[i].flagr ==0) then
                en[i].r = en[i].r+1*dt2*math.random(5,10)/7
            else
                en[i].r = en[i].r-1*dt2*math.random(5,10)/7
            end
        end 
    end
end

function rot2(mode,x,y,w,h,rx,ry,segments,r,ox,oy)
    if not oy and rx then r,ox,oy = rx,ry, segments end
    r = r or 0 
    ox = ox or w/2
    oy = oy or h/2
    love.graphics.push()
    love.graphics.translate( x + ox,y + oy )
    love.graphics.push()
    love.graphics.rotate(-r)
    xx = ((-ox +player.scale/2*40*k)+20*k*math.cos(-0.3)) 
    yy = ((-oy+player.scale/2*40*k2) +20*k2*math.sin(-0.3))
    xx2 = ((-ox +player.scale/2*40*k)+20*k*math.cos(-0.7*4.1)) 
    yy2 = ((-oy+player.scale/2*40*k2) +20*k2*math.sin(-0.7*4.1))
   ---
    love.graphics.pop()
    love.graphics.pop()
end

function meteorDraw()
 --   player.body:draw('fill')
    sledEnemiesDraw()
    for i= 1,#res do
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
            love.graphics.circle("line",res[i].x+8*k,res[i].y+8*k2,2*k)
            rot('line',res[i].x,res[i].y,16*k,16*k2,2)
        end
    end 
   
    for i= 1,#obj do
        if ( obj[i].tip==1) then
            if ( obj[i].timer) then
                if not( obj[i].invTimer == obj[i].timer) then
                   love.graphics.setColor(0.7,0.2,0.2)
                    if ( obj[i] and obj[i].bodyDop) then
                        fragmVect(i)
                 --       obj[i].body:draw('line')
                    else
                       meteorVect(i)  
               --         obj[i].body:draw('line')
                  end
                   love.graphics.setColor(1,1,1)
                else
                   love.graphics.setColor(1,1,1)
                    if ( obj[i] and obj[i].pok>0) then
                      fragmVect(i)
               --      obj[i].body:draw('line')
                    else
                      meteorVect(i)
                --      obj[i].body:draw('line')
                    end
                end
            end
            if ( obj[i].tip==2) then
              
            end
        end
    end
    
    
    for  i=1,#en do
        if ( en[i] and en[i].body) then
       --     en[i].body:draw('fill')
        end
        
        if ( en[i].tip==1) then
            if ( en[i].invTimer and en[i].invTimer ~= en[i].timer) then
                sledEnemies(en[i].x,en[i].y,2*k,i,1,0.6,0.6,en[i].ugol,en[i].tip)
                
                enTip1(en[i].r,"fill",en[i].x,en[i].y,4*k,4*k2,en[i].ugol,4*k/2,4*k2/2,1,en[i].health,en[i].healthM)
            else
                sledEnemies(en[i].x,en[i].y,2*k,i,1,0.1,0.1,en[i].ugol,en[i].tip)
            
                enTip1(en[i].r,"fill",en[i].x,en[i].y,4*k,4*k2,en[i].ugol,4*k/2,4*k2/2,0,en[i].health,en[i].healthM)
            end
        else
            if ( en[i].tip==2) then
                if ( en[i].invTimer and en[i].invTimer ~= en[i].timer) then
                    sledEnemies(en[i].x,en[i].y,2*k,i,1,0.6,0.6,en[i].ugol,en[i].tip)
                    
                    enTip2(en[i].r,"fill",en[i].x,en[i].y,4*k,4*k2,en[i].ugol,4*k/2,4*k2/2,1,en[i].health,en[i].healthM)
                else
                    sledEnemies(en[i].x,en[i].y,2*k,i,1,0.1,0.1,en[i].ugol,en[i].tip)
                    
                    enTip2(en[i].r,"fill",en[i].x,en[i].y,4*k,4*k2,en[i].ugol,4*k/2,4*k2/2,0,en[i].health,en[i].healthM)
                end
            else
            
              
              
            end
        end
    end
end

function sledEnemiesDraw()
    for i = 1, #slediEn do
        for j = 1, #slediEn[i] do
            local kkk = slediEn[i]
            if (kkk[j].tip == 1 ) then
                local radius =kkk[j].r/4*j
                kkk[j].x = kkk[j].x+50*kkk[j].ax*dt2
                kkk[j].y = kkk[j].y+50*kkk[j].ay*dt2
                love.graphics.setColor(kkk[j].color1*j,kkk[j].color2*j,kkk[j].color3*j) 
                love.graphics.circle("fill",kkk[j].x+radius,kkk[j].y+radius,radius)
            else
                if (kkk[j].tip == 2 ) then
                    local radius =kkk[j].r/1.3
                    kkk[j].x = kkk[j].x+40*kkk[j].ax*dt2
                    kkk[j].y = kkk[j].y+40*kkk[j].ay*dt2
                    love.graphics.setColor(kkk[j].color1*j,kkk[j].color2*j,kkk[j].color3*j) 
                    love.graphics.circle("fill", kkk[j].x+math.cos(kkk[j].y)+radius+1*k*math.sin(kkk[j].angle-math.pi/2) ,kkk[j].y+math.sin(kkk[j].x)+radius +1*k2*math.cos(kkk[j].angle-math.pi/2),radius)
                    love.graphics.circle("fill", kkk[j].x+math.sin(kkk[j].y)+radius+1*k*math.sin(kkk[j].angle+math.pi/2) ,kkk[j].y+math.cos(kkk[j].x)+radius +1*k2*math.cos(kkk[j].angle+math.pi/2),radius)
                end
            end
        end
        if ( #slediEn[i] >5) then
           table.remove(slediEn[i],1)
        end
    end
end




function sledEnemies(x,y,r,i,color1,color2,color3,angle,tip)
    local sledEn = {
        angle = angle,
        tip = tip,
        ax =-2*k*math.sin(angle) ,
        ay =-2*k2*math.cos(angle),
        x = x ,
        y = y , 
        r = r ,
        color1 = color1,
        color2 = color2,
        color3 = color3,
    }
    if ( slediEn[i]) then
        table.insert(slediEn[i],sledEn)
    else
        local ii = {}
        slediEn[i] = ii
        table.insert(slediEn[i],sledEn)
    end
end


function playerSledDraw()
   -- player.body:draw('fill')
    love.graphics.circle('fill',controler.x0,controler.y0,10*k)
    love.graphics.circle('line',controler.x0,controler.y0,13*k)
    love.graphics.circle('line',mouse.x,mouse.y,5*k)
    love.graphics.circle('line',mouse.x,mouse.y,5*k)
    
    local playerSled = {
        angle = -controler.angle+math.pi,
        ax =-2*k*math.sin(controler.angle) ,
        ay =-2*k2*math.cos(controler.angle),
        x = player.x+player.scale*20*k,
        y = player.y+player.scale*20*k2, 
        r = 0.2 ,
    }
    table.insert(playerSledi,playerSled)
    for i = 1,#playerSledi do
        local sled = playerSledi[i]
        local radius =sled.r*i
        local tailW,tailH = playerQuads.tail:getTextureDimensions()
        sled.x = sled.x+150*sled.ax*dt2
        sled.y = sled.y+150*sled.ay*dt2
        playerBatch:add(playerQuads.tail,sled.x,sled.y,sled.angle,k/7*radius,k2/7*radius,48,60)
    end
    if ( #playerSledi>10) then
        table.remove(playerSledi,1)
    end
end

function game:worldBorders()
    if ( flagclass =='slicer') then
        if ( boost.long <= 30*k2 ) then
            player.a=0
            boost.long =30*k2
        end
    end
    if player.x < 0  then
        player.x = 0
        player.ax = math.abs(player.ax)/2
        player.ay = player.ay/2
    elseif player.x > screenWidth -  player.scale*40*k then
        player.x = screenWidth -  player.scale*40*k
        player.ax = -1*player.ax/2
        player.ay = player.ay/2
    end
    if player.y < 0 then
        player.y = 0 
        player.ay = math.abs(   player.ay)/2
        player.ax = player.ax/2
    elseif player.y > screenHeight -  player.scale*40*k2 then
        player.y = screenHeight -  player.scale*40*k2
        player.ay = -1*player.ay/2
        player.ax = player.ax/2
    end
end

return game