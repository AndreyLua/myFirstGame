local enClassMelee =  {} 

enemyMeleeTable = {
    25, --w
    30,  --h
    1,  -- tip
    HC.rectangle(-100*k,-100*k2,16*k,25*k2), --body
    0,  --timer
    20, -- invTimer
    0, -- atack
    60, --atackTimer
    0, -- dash
    15, --dashTimer
    0.035, --color1 
    0.184, --color2
    0.196, --color3
    100, -- scale
    0, -- angleMouth 
    0, -- angleBody
    0, -- angleMouthFlag
    12,  -- damage
    false, -- f
    -100*k, --  x  
    -100*k2, -- y  
    0,  -- ax 
    0,  -- ay
    3, --health
    3, --healthM
    {}, -- traces
    0, --climbFlag
    100, -- climbAtack
    100, --climbAtackTimer
    0, -- meleeAtack
    10, --meleeAtackTimer
    0 , -- dopAngle
    "player", --target
    0 , --targetX
    screenWidth, --targetY
    0, -- targetDestroy
    90, --targetDestroyTimer
    5,--cost
}

enemyMeleeClass = Class{
    init = function(self,w,h,tip,body,timer,invTimer,atack,atackTimer,dash,dashTimer,color1,color2,color3 ,scale,angleMouth,angleBody,angleMouthFlag,damage,f,x,y,ax,ay,health,healthM,traces,climbFlag,climbAtack,climbAtackTimer,meleeAtack,meleeAtackTimer,dopAngle,target,targetX,targetY,targetDestroy,targetDestroyTimer,cost)
        self.w = w
        self.h = h 
        self.tip = tip 
        self.body =body
        self.timer = timer  
        self.invTimer = invTimer
        self.atack = atack
        self.atackTimer = atackTimer
        self.dash =dash
        self.dashTimer = dashTimer
        self.climbFlag = climbFlag
        self.climbAtack = climbAtack
        self.climbAtackTimer = climbAtackTimer
        self.meleeAtack = meleeAtack 
        self.meleeAtackTimer = meleeAtackTimer
        self.dopAngle = dopAngle
        self.color1 =color1
        self.color2=color2
        self.color3 =color3
        self.scale = scale
        self.angleMouth = angleMouth
        self.angleBody =  angleBody
        self.angleMouthFlag = angleMouthFlag
        self.damage = damage
        self.f = f
        self.x  =x
        self.y =y
        self.ax  =ax
        self.ay =ay
        self.health = health
        self.healthM = healthM
        self.traces = traces
        self.target = target
        self.targetX = targetX
        self.targetY = targetY
        self.targetDestroy = targetDestroy
        self.targetDestroyTimer = targetDestroyTimer
        self.cost = cost
    end;
    newBody =  function(self)
        local bodyEn  = HC.rectangle(self.x,self.y, enemyMeleeTable[1]*k, enemyMeleeTable[2]*k)
        self.body = bodyEn
    end;
    IndexInRegulS =  function(self,scaleS)
        return math.floor((self.x-scaleS/2*k)/(scaleS*k)) + math.floor((self.y-scaleS/2*k2)/(scaleS*k2))*math.floor((screenWidth/(scaleS*k))+1)
    end;
    insertInRegulS =  function(self,i)
        local IenRegulS = self.IndexInRegulS(self,80)
        if (self.inScreen(self)) then
            if (enRegulS[IenRegulS]) then
                table.insert(enRegulS[IenRegulS],i)
            else
                enRegulS[IenRegulS] = {i}
            end
        end   
    end;
    inScreen = function(self)
        return (self.x>camera.x-screenWidth/2-math.max(self.w,self.h)*k and  self.x<screenWidth+camera.x-screenWidth/2+20*k+math.max(self.w,self.h)*k and  self.y>camera.y-screenHeight/2-math.max(self.w,self.h)*k2 and self.y<screenHeight+camera.y-screenHeight/2+20*k2+math.max(self.w,self.h)*k2)
    end;
    invTimerUpdate = function(self,dt) 
        if ( self.invTimer) then
            if ( self.timer < self.invTimer) then
                self.timer  = self.timer - dt* 40
            end
            if ( self.timer < 0) then
                self.timer  = self.invTimer
            end
        end
    end;
    atackStart = function(self)
        if (self.dash and self.dash==self.dashTimer and self.atack and self.atack==self.atackTimer and self.invTimer ==           self.timer and (math.sqrt(math.pow((player.x-self.x),2)+math.pow((player.y-self.y),2))) <=100*k ) then
           self.atack = self.atackTimer-0.001
           self.dash = self.dashTimer-0.001
        end
    end;
    atackTimerUpdate = function(self,dt)
        if ( self.atack <  self.atackTimer) then
            self.atack  = self.atack  - 30*dt
        end
        if ( self.atack < 0) then
            self.atack  = self.atackTimer
        end
        if ( self.meleeAtack <  self.meleeAtackTimer) then
            self.meleeAtack  = self.meleeAtack  - 30*dt
        end
        if ( self.meleeAtack < 0) then
            self.meleeAtack  = self.meleeAtackTimer
        end
        if ( self.dash <  self.dashTimer) then
            self.dash  = self.dash  - 30*dt
        end
        if ( self.dash < 0) then
            self.dash  = self.dashTimer
        end
        if ( self.climbAtack <  self.climbAtackTimer) then
            self.climbAtack  = self.climbAtack  - 30*dt
        end
        if ( self.climbAtack < 0) then
            self.climbAtack  = self.climbAtackTimer
            self.climbFlag = 0 
            self.atack  = self.atackTimer - 0.0001
        end
        
        if ( self.targetDestroy <  self.targetDestroyTimer) then
            self.targetDestroy  = self.targetDestroy  - 10*dt
        end
        if ( self.targetDestroy < 0) then
            self.targetDestroy  = self.targetDestroyTimer
        end
        
        
    end;
    angleBodyTr = function(self,angle,dt)
        if ( self.angleBody == 0) then
            self.angleBody=0.00000001
        end
        if ( self.angleBody < -math.pi) then
            self.angleBody=math.pi
        end
        if ( self.angleBody > math.pi) then
            self.angleBody=-math.pi
        end
        if ( angle == 0) then
            angle=0.00000001
        end
        if ((angle -  self.angleBody > 2.1*dt) or (angle -  self.angleBody) <  -2.1*dt ) then
            if (angle/math.abs(angle)==self.angleBody/math.abs(self.angleBody))then
                if ( angle>self.angleBody) then
                    self.angleBody = self.angleBody+5*dt
                else 
                    self.angleBody = self.angleBody-5*dt
                end
            else
                if (math.abs(angle)+math.abs(self.angleBody)> 2*math.pi - math.abs(angle)-math.abs(self.angleBody)) then
                    if (self.angleBody>0) then 
                        self.angleBody = self.angleBody+5*dt
                    else
                        self.angleBody = self.angleBody-5*dt
                    end
                else 
                    if (self.angleBody>0) then 
                        self.angleBody = self.angleBody-5*dt
                    else
                        self.angleBody = self.angleBody+5*dt
                    end
                end
            end
        end
    end;
    angleMouthTr = function(self,dt)
        if ( self.angleMouth> 1 ) then
            --self.angleMouth = 0.1 
            self.angleMouthFlag = 1 
        end
        if ( self.angleMouth< 0 ) then
          --self.angleMouth = 0 
            self.angleMouthFlag = 0 
        end
      
        if ( self.dash <  self.dashTimer ) then
            self.angleMouth = -0.3
        else
            if ( self.angleMouthFlag ==  0 ) then
                self.angleMouth = self.angleMouth + 4*dt
            else
                self.angleMouth = self.angleMouth - 4*dt
            end
        end
    end;
    collWithEn =  function(self,IenRegulS,i,dt)
        enCollWithenInRegularSMelee(IenRegulS,i,dt)
        enCollWithenInRegularSMelee(IenRegulS+1,i,dt)
        enCollWithenInRegularSMelee(IenRegulS+math.floor((screenWidth/(80*k))+1),i,dt)
        enCollWithenInRegularSMelee(IenRegulS+math.floor((screenWidth/(80*k))+1)+1,i,dt)
        enCollWithenInRegularSMelee(IenRegulS-math.floor((screenWidth/(80*k))+1)+1,i,dt)  
    end;
    collWithObj = function( self,IenRegulS,i,dt) 
        self.targetY = math.pow(player.x-self.x,2) + math.pow(player.y-self.y,2)
        self.targetX = -1
        enCollWithobjInRegularS(IenRegulS,i,dt)
        enCollWithobjInRegularS(IenRegulS-1,i,dt)
        enCollWithobjInRegularS(IenRegulS+1,i,dt)
        enCollWithobjInRegularS(IenRegulS-math.floor((screenWidth/(120*k))+1),i,dt)
        enCollWithobjInRegularS(IenRegulS+math.floor((screenWidth/(120*k))+1),i,dt)
        enCollWithobjInRegularS(IenRegulS+math.floor((screenWidth/(120*k))+1)+1,i,dt)
        enCollWithobjInRegularS(IenRegulS+math.floor((screenWidth/(120*k))+1)-1,i,dt)
        enCollWithobjInRegularS(IenRegulS-math.floor((screenWidth/(120*k))+1)+1,i,dt)
        enCollWithobjInRegularS(IenRegulS-math.floor((screenWidth/(120*k))+1)-1,i,dt)
        if (self.targetX > 0) then
            self.target = "obj"
        else
            self.target = "player"
        end
    end;
    move =  function(self,dt)
        self.body:moveTo(self.x, self.y)
        self.body:setRotation(-self.angleBody) 
        if ( self.climbFlag == 0) then 
            if (self.invTimer and  self.invTimer == self.timer) then
                self.moveNormal(self,dt)
            else
                self.moveWounded(self,dt)
            end
        else
            local anglePlayerEn = math.atan2(player.x-self.x,player.y-self.y)
            self.angleBody = anglePlayerEn
            self.angleMouthTr(self,dt)
            self.x =self.x + ((player.x -(playerAbility.scaleBody+5)*k*math.sin(controler.angle + self.dopAngle)) - self.x)*dt*20*k
            self.y = self.y + (( player.y -(playerAbility.scaleBody+5)*k2*math.cos(controler.angle + self.dopAngle)) - self.y)*dt*20*k2
        end
    end;
    moveNormal = function(self,dt)
        local anglePlayerEn =0
        if (self.target =="player") then 
            anglePlayerEn = math.atan2(player.x-self.x,player.y-self.y)
        else
            if (obj[self.targetX] and obj[self.targetX].x) then
                anglePlayerEn = math.atan2(obj[self.targetX].x-self.x,obj[self.targetX].y-self.y)
            end
        end
        if (self.dash and self.dash==self.dashTimer ) then
            self.angleBodyTr(self,anglePlayerEn,dt)
            self.angleMouthTr(self,dt)
            self.ax=self.ax+80*k*math.sin(self.angleBody)*dt
            self.ay=self.ay+80*k2*math.cos(self.angleBody)*dt
            if ((math.abs(anglePlayerEn) -  math.abs(self.angleBody)) > 2.01*dt or (math.abs(anglePlayerEn) -  math.abs(self.angleBody)) <  -2.01*dt ) then
                self.x= self.x+self.ax*dt*5
                self.y= self.y+self.ay*dt*5
            else
                self.x= self.x+self.ax*dt*7
                self.y= self.y+self.ay*dt*7
            end
            self.x= self.x+math.sin(self.y/20)*dt*30
            self.y= self.y+math.cos(self.x/20)*dt*30
            if (  self.ax >22*k) then
                self.ax=22*k
            end
            if (  self.ax <-22*k) then
                self.ax=-22*k
            end
            if (  self.ay >22*k2) then
                self.ay=22*k2
            end
            if (  self.ay <-22*k2) then
                self.ay=-22*k2
            end
        else
            
            self.x= self.x+math.sin(self.angleBody)*dt*300*k -- движение противника ускорение
            self.y= self.y+math.cos(self.angleBody)*dt*300*k2
        end
    end;
    moveWounded =  function(self,dt)
        if (self.ax>0)then
            self.ax =self.ax-50*dt
        else
            self.ax =self.ax+50*dt
        end
        if (self.ay>0)then
           	self.ay =self.ay-50*dt
        else
            self.ay =self.ay+50*dt
        end
        self.x= self.x-self.ax*dt*3----
        self.y= self.y-self.ay*dt*3---
    end;
    draw =  function(self,i)
        if ( self.invTimer and self.invTimer ~= self.timer) then
            local clow1X =self.x +15*k*math.sin(self.angleBody+math.pi/8)
            local clow1Y =self.y +15*k2*math.cos(self.angleBody+math.pi/8)
            local clow2X =self.x +15*k*math.sin(self.angleBody-math.pi/8)
            local clow2Y =self.y +15*k2*math.cos(self.angleBody-math.pi/8)
            enBatch:setColor(1,0.5,0.5,1)
            enBatch:add(enQuads.clow1Melee,clow1X,clow1Y,-self.angleBody-math.pi+self.angleMouth,k/6,k2/6,36, 44)
            enBatch:add(enQuads.clow2Melee,clow2X,clow2Y,-self.angleBody-math.pi-self.angleMouth,k/6,k2/6,36, 44)
            enBatch:add(enQuads.bodyMelee,self.x,self.y,-self.angleBody+math.pi,k/6,k2/6,60, 88)
          --  self.body:draw('fill')
        else
            local clow1X =self.x +15*k*math.sin(self.angleBody+math.pi/8)
            local clow1Y =self.y +15*k2*math.cos(self.angleBody+math.pi/8)
            local clow2X =self.x +15*k*math.sin(self.angleBody-math.pi/8)
            local clow2Y =self.y +15*k2*math.cos(self.angleBody-math.pi/8)
            enBatch:setColor(1,1,1,1)
            enBatch:add(enQuads.clow1Melee,clow1X,clow1Y,-self.angleBody-math.pi+self.angleMouth,k/6,k2/6,36, 44)
            enBatch:add(enQuads.clow2Melee,clow2X,clow2Y,-self.angleBody-math.pi-self.angleMouth,k/6,k2/6,36, 44)
            enBatch:add(enQuads.bodyMelee,self.x,self.y,-self.angleBody+math.pi,k/6,k2/6,60, 88)
            enBatchDop:setColor(1,0.5,0.5,0.4)
            enBatchDop:add(enQuads.clow1Melee,clow1X-camera.x+40*k/2+screenWidth/2,clow1Y-camera.y+40*k2/2+screenHeight/2,-self.angleBody-math.pi+self.angleMouth,k/6,k2/6,36, 44)
            enBatchDop:add(enQuads.clow2Melee,clow2X-camera.x+40*k/2+screenWidth/2,clow2Y-camera.y+40*k2/2+screenHeight/2,-self.angleBody-math.pi-self.angleMouth,k/6,k2/6,36, 44)
            --self.body:draw('fill')
        end
    end;
    traceSpawn = function(self)
        local trace = {
            angle = self.angleBody,
            ax =-2*k*math.sin(self.angleBody) ,
            ay =-2*k2*math.cos(self.angleBody),
            x = -10*k*math.sin(self.angleBody) ,
            y = -10*k2*math.cos(self.angleBody) , 
            r = 2*k ,
        }
        table.insert(self.traces,trace)
        if ( #self.traces >9) then
           table.remove(self.traces,1)
        end
    end;
    traceDraw = function(self,dt)
        for i = 1, #self.traces do
            local trace = self.traces[i]
            local radius =trace.r/6*i
            trace.x = trace.x+80*trace.ax*dt
            trace.y = trace.y+80*trace.ay*dt
            love.graphics.setColor(0.09/7*i,0.5/7*i,0.5/7*i) 
            love.graphics.circle("fill",self.x+  trace.x+math.cos(self.y+trace.y)+k*math.sin(self.angleBody-math.pi/2) ,self.y + trace.y+math.sin(self.x+trace.x) +k2*math.cos(self.angleBody-math.pi/2),radius)
        end
    end;
    hit  = function(self,a,i,dt)
        if ( a == 0 ) then
            if (self.invTimer == self.timer and self.climbAtack == self.climbAtackTimer and self.dash  ~= self.dashTimer)  then
                self.climbFlag = 1 
                self.climbAtack = self.climbAtackTimer - 0.0001
                self.dopAngle = self.angleBody-controler.angle
            end 
            if ( self.climbFlag == 1 and self.meleeAtackTimer == self.meleeAtack )  then 
                self.meleeAtack = self.meleeAtackTimer - 0.0001
                flaginv = false 
                enAtackPlayer(self.damage,'m',self)
            end
        else
            if (playerFrontAtack(i) and self.invTimer and  self.invTimer ==self.timer) then
                playerAtackEn(self,dt)
                self.climbFlag = 0
                self.climbAtack = self.climbAtackTimer
                self.timer =  self.invTimer-0.001
                self.dash = self.dashTimer
                self.ax =self.ax - player.ax
                self.ay =self.ay -  player.ay
                spawnResHitEn(i)
            end  
            if (self.invTimer and  self.invTimer ==self.timer) then
                self.climbFlag = 0
                self.climbAtack = self.climbAtackTimer
                self.dash = self.dashTimer
            end  
        end
    end;
    kill =  function(self,i) 
        if (en[i].health and en[i].health<=0 ) then
            spawnResKillEn(i)
            local clow1X =self.x +15*k*math.sin(self.angleBody+math.pi/8)
            local clow1Y =self.y +15*k2*math.cos(self.angleBody+math.pi/8)
            local clow2X =self.x +15*k*math.sin(self.angleBody-math.pi/8)
            local clow2Y =self.y +15*k2*math.cos(self.angleBody-math.pi/8)
      
            local enDrawDie = {
                timer = 4, 
                quad = enQuads.bodyMelee,
                x = self.x,
                y = self.y,
                ax = self.ax,
                ay = self.ay,
                r = -self.angleBody+math.pi,
                ra = math.random(-3,-1),
                koff = k/6,
                koff2 = k2/6,
                ox = 60,
                oy = 88
            }
            table.insert(enAfterDieTex,enDrawDie)
            local enDrawDie2 = {
                timer = 4, 
                quad = enQuads.clow2Melee,
                x = clow2X,
                y = clow2Y,
                ax = self.ax/5+math.random(-1.5*k,1.5*k)*7,
                ay = self.ay/5+math.random(-1.5*k,1.5*k)*7,
                r = -self.angleBody-math.pi-self.angleMouth,
                ra = math.random(-3,-1),
                koff = k/6,
                koff2 = k2/6,
                ox = 36,
                oy = 44
            }
            table.insert(enAfterDieTex,enDrawDie2)
            local enDrawDie3 = {
                timer = 4, 
                quad = enQuads.clow1Melee,
                x = clow1X,
                y = clow1Y,
                ax = self.ax/5+math.random(-1.5*k,1.5*k)*7,
                ay = self.ay/5+math.random(-1.5*k,1.5*k)*7,
                r = -self.angleBody-math.pi+self.angleMouth,
                ra = math.random(1,3),
                koff = k/6,
                koff2 = k2/6,
                ox = 36,
                oy = 44
            }
            expl(54*k,screenHeight/2-(colWave*250*k2/waves[2])/2,10)
            expl(54*k,screenHeight/2+(colWave*250*k2/waves[2])/2,10)
            colWave =  colWave - en[i].cost
            
            table.insert(enAfterDieTex,enDrawDie3)
            table.remove(en,i)
        end  
    end;
}

enemyMelee = enemyMeleeClass(unpack(enemyMeleeTable))
return  enClassMelee