local enClassСleaner =  {} 

enemyСleanerTable = {
    20, --w
    25,  --h
    5,  -- tip
    HC.rectangle(-100*k,-100*k2,16*k,25*k2), --body
    0,  --timer
    20, -- invTimer
    0, -- atack
    10, --atackTimer
    0, -- dash
    5, --dashTimer
    0.553, --color1 
    0.133, --color2
    0.173, --color3
    100, -- scale
    0, -- angleMouth 
    0, -- angleBody
    0, -- angleMouthFlag
    5,  -- damage
    false, -- f
    -100*k, --  x  
    -100*k2, -- y  
    0,  -- ax 
    0,  -- ay
    3, --health
    3, --healthM
    {}, -- traces
    0,--angleWing
    0,--angleWingFlag
    0,--numberTarget ( targetX ) 
    screenWidth, --targetY
    5,--cost
}

enemyСleanerClass = Class{
    init = function(self,w,h,tip,body,timer,invTimer,atack,atackTimer,dash,dashTimer,color1,color2,color3 ,scale,angleMouth,angleBody,angleMouthFlag,damage,f,x,y,ax,ay,health,healthM,traces,angleWing,angleWingFlag,targetX,targetY,cost)
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
        self.angleWing = angleWing
        self.angleWingFlag = angleWingFlag
        self.targetX = targetX
        self.targetY = targetY
        self.cost = cost
    end;
    newBody =  function(self)
        local bodyEn  = HC.rectangle(self.x,self.y, enemyСleanerTable[1]*k, enemyСleanerTable[2]*k)
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
        if (obj[self.targetX] and self.dash and self.dash==self.dashTimer and self.invTimer == self.timer and (math.sqrt(math.pow((obj[self.targetX].x-self.x),2)+math.pow((obj[self.targetX].y-self.y),2))) <=obj[self.targetX].collScale/2*k+70*k ) then
           self.atack = self.atackTimer-0.001
           self.dash = self.dashTimer-0.001
        end
    end;
    atackTimerUpdate = function(self,dt)
        if ( self.atack <  self.atackTimer) then
            self.atack  = self.atack  - 20*dt
        end
        if ( self.atack < 0) then
            self.atack  = self.atackTimer
        end
        if ( self.dash <  self.dashTimer) then
            self.dash  = self.dash  - 600*dt
        end
        if ( self.dash < 0) then
            self.dash  = self.dashTimer
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
                    self.angleBody = self.angleBody+3*dt
                else 
                    self.angleBody = self.angleBody-3*dt
                end
            else
                if (math.abs(angle)+math.abs(self.angleBody)> 2*math.pi - math.abs(angle)-math.abs(self.angleBody)) then
                    if (self.angleBody>0) then 
                        self.angleBody = self.angleBody+3*dt
                    else
                        self.angleBody = self.angleBody-3*dt
                    end
                else 
                    if (self.angleBody>0) then 
                        self.angleBody = self.angleBody-3*dt
                    else
                        self.angleBody = self.angleBody+3*dt
                    end
                end
            end
        end
    end;
    angleWingTr = function(self,dt)
        if ( self.angleWing> 0.6 ) then
            self.angleWingFlag = 0.6 
        end
        if ( self.angleWing< 0 ) then
            self.angleWingFlag = 0 
        end
        if ( self.angleWingFlag ==0) then
            self.angleWing  = self.angleWing +1.5*dt
        else
            self.angleWing  = self.angleWing -1.5*dt
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
        if ( self.angleMouthFlag ==0) then
            self.angleMouth  = self.angleMouth +1.1*dt*math.random(5,10)/7
        else
            self.angleMouth  = self.angleMouth -1.1*dt*math.random(5,10)/7
        end
    end;
    collWithEn =  function(self,IenRegulS,i,dt)
        enCollWithenInRegularS(IenRegulS,i,dt)
        enCollWithenInRegularS(IenRegulS+1,i,dt)
        enCollWithenInRegularS(IenRegulS+math.floor((screenWidth/(80*k))+1),i,dt)
        enCollWithenInRegularS(IenRegulS+math.floor((screenWidth/(80*k))+1)+1,i,dt)
        enCollWithenInRegularS(IenRegulS-math.floor((screenWidth/(80*k))+1)+1,i,dt)  
    end;
    collWithObj = function( self,IenRegulS,i,dt) 
        self.targetY =1000000000000
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

        if not(self.dash and self.dash==self.dashTimer) then
              enCollWithobjInRegularSCleaner(IenRegulS,i,dt)
              enCollWithobjInRegularSCleaner(IenRegulS-1,i,dt)
              enCollWithobjInRegularSCleaner(IenRegulS+1,i,dt)
              enCollWithobjInRegularSCleaner(IenRegulS-math.floor((screenWidth/(120*k))+1),i,dt)
              enCollWithobjInRegularSCleaner(IenRegulS+math.floor((screenWidth/(120*k))+1),i,dt)
              enCollWithobjInRegularSCleaner(IenRegulS+math.floor((screenWidth/(120*k))+1)+1,i,dt)
              enCollWithobjInRegularSCleaner(IenRegulS+math.floor((screenWidth/(120*k))+1)-1,i,dt)
              enCollWithobjInRegularSCleaner(IenRegulS-math.floor((screenWidth/(120*k))+1)+1,i,dt)
              enCollWithobjInRegularSCleaner(IenRegulS-math.floor((screenWidth/(120*k))+1)-1,i,dt)
        end
    end;
    move =  function(self,dt)
        self.border(self,dt)
        self.body:moveTo(self.x, self.y)
        self.body:setRotation(-self.angleBody) 
        if (self.invTimer and  self.invTimer == self.timer) then
            self.moveNormal(self,dt)
        else
            self.moveWounded(self,dt)
        end
    end;
    moveNormal = function(self,dt)
        local anglePlayerEn = math.atan2(player.x-self.x,player.y-self.y)
        if ( self.targetX > 0 and obj[self.targetX] ) then
            anglePlayerEn = math.atan2(obj[self.targetX].x-self.x,obj[self.targetX].y-self.y)
            if (self.dash and self.dash==self.dashTimer) then
                self.angleBodyTr(self,anglePlayerEn,dt)
                self.angleMouthTr(self,dt)
                self.angleWingTr(self,dt)
                self.ax=self.ax+80*k*math.sin(self.angleBody)*dt
                self.ay=self.ay+80*k2*math.cos(self.angleBody)*dt
                self.x= self.x+self.ax*dt*5
                self.y= self.y+self.ay*dt*5 --- нормальное движение
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
                self.angleBodyTr(self,anglePlayerEn,dt)
                self.angleMouthTr(self,dt)
                self.angleWingTr(self,dt)
                self.ax = self.ax/1.5
                self.ay = self.ay/1.5
                self.x= self.x+self.ax*dt*5
                self.y= self.y+self.ay*dt*5 --- нормальное движение
            end
        else   
            self.angleBodyTr(self,anglePlayerEn,dt)
            self.angleMouthTr(self,dt)
            self.angleWingTr(self,dt)
            self.ax=self.ax+80*k*math.sin(self.angleBody)*dt
            self.ay=self.ay+80*k2*math.cos(self.angleBody)*dt
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
            self.x= self.x+self.ax*dt*7
            self.y= self.y+self.ay*dt*7 
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
        self.x= self.x-self.ax*dt*3
        self.y= self.y-self.ay*dt*3   
    end;
    draw =  function(self,i)
        if ( self.invTimer and self.invTimer ~= self.timer) then
            enBatch:setColor(1,0.5,0.5,1)
            enBatch:add(enQuads.bodyСleaner,self.x,self.y,-self.angleBody+math.pi,k/10,k2/10,119, 182)
            enBatch:add(enQuads.wing1Сleaner,self.x,self.y,-self.angleBody-math.pi+math.pi/10-self.angleWing,k/10,k2/10,246, 21)
            enBatch:add(enQuads.wing2Сleaner,self.x,self.y,-self.angleBody-math.pi-math.pi/10+self.angleWing,k/10,k2/10,-29, 21)
         --   self.body:draw('fill')
        else
            enBatch:setColor(1,1,1,1)
            enBatch:add(enQuads.bodyСleaner,self.x,self.y,-self.angleBody+math.pi,k/10,k2/10,119, 182)
            enBatch:add(enQuads.wing1Сleaner,self.x,self.y,-self.angleBody-math.pi+math.pi/10-self.angleWing,k/10,k2/10,246, 21)
            enBatch:add(enQuads.wing2Сleaner,self.x,self.y,-self.angleBody-math.pi-math.pi/10+self.angleWing,k/10,k2/10,-29, 21)
            --self.body:draw('fill')
        end
    end;
     traceSpawn = function(self)
        local trace = {
            angle = self.angleBody,
            ax =-2*k*math.sin(self.angleBody) ,
            ay =-2*k2*math.cos(self.angleBody),
            x = -15*k*math.sin(self.angleBody) ,
            y = -15*k2*math.cos(self.angleBody) , 
            r = 3*k ,
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
            love.graphics.setColor(0.44/7*i,0.26/7*i,0.26/7*i) 
            love.graphics.circle("fill",self.x+  trace.x+math.cos(self.y+trace.y)+k*math.sin(self.angleBody-math.pi/2) ,self.y + trace.y+math.sin(self.x+trace.x) +k2*math.cos(self.angleBody-math.pi/2),radius)
        end
    end;
    hit  = function(self,a,i,dt)
        if ( a == 0 ) then
        else
            if (playerFrontAtack(i) and self.invTimer and  self.invTimer ==self.timer) then
                playerAtackEn(self,dt)
                self.timer =  self.invTimer-0.001
                self.ax =self.ax - player.ax
                self.ay =self.ay -  player.ay
                spawnResHitEn(i)
            end  
        end
    end;
    kill =  function(self,i) 
        if (en[i].health and en[i].health<=0 ) then
            numberCleaner = numberCleaner-1
            spawnResKillEn(i)
          
            local enDrawDie = {
              timer = 4, 
              quad = enQuads.bodyСleaner,
              x = self.x,
              y = self.y,
              ax = self.ax,
              ay = self.ay,
              r = -self.angleBody+math.pi,
              ra = math.random(-3,-1),
              koff = k/10,
              koff2 = k2/10,
              ox =119, 
              oy = 182
            }
            table.insert(enAfterDieTex,enDrawDie)
            local enDrawDie2 = {
                timer = 4, 
                quad = enQuads.wing1Сleaner,
                x = self.x,
                y = self.y,
                ax = self.ax/5+math.random(-1.5*k,1.5*k)*7,
                ay = self.ay/5+math.random(-1.5*k,1.5*k)*7,
                r = -self.angleBody-math.pi+math.pi/10-self.angleWing,
                ra = math.random(-2,-1),
                koff = k/10,
                koff2 = k2/10,
                ox = 246,
                oy = 21
            }
            table.insert(enAfterDieTex,enDrawDie2)
            local enDrawDie3 = {
                timer = 4, 
                quad = enQuads.wing2Сleaner,
                x = self.x,
                y = self.y,
                ax = self.ax/5+math.random(-1.5*k,1.5*k)*7,
                ay = self.ay/5+math.random(-1.5*k,1.5*k)*7,
                r = -self.angleBody-math.pi-math.pi/10-self.angleWing,
                ra = math.random(1,2),
                koff = k/10,
                koff2 = k2/10,
                ox = 29,
                oy = 21
            }
            table.insert(enAfterDieTex,enDrawDie3)
            expl(54*k,screenHeight/2-(colWave*250*k2/waves[2])/2,10)
            expl(54*k,screenHeight/2+(colWave*250*k2/waves[2])/2,10)
            colWave =  colWave - en[i].cost
            table.remove(en,i)
        end  
    end;
    border = function(self,dt)
        if ( self.x > borderWidth*2-20*k or self.x < -borderWidth+20*k or self.y < -borderHeight+20*k or  self.y > borderHeight*2-20*k ) then
            local anglePlayerEn = math.atan2(player.x-self.x,player.y-self.y)
            self.ax=self.ax+80*k*math.sin(self.angleBody)*dt
            self.ay=self.ay+80*k2*math.cos(self.angleBody)*dt
            self.dash=self.dashTimer
            self.atack  = self.atackTimer - 0.0001
        end
    end;
    
}





enemyСleaner = enemyСleanerClass(unpack(enemyСleanerTable))

return  enClassСleaner