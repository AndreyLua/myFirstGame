local enClassBomb =  {} 

enemyBombTable = {
    25, --w
    30,  --h
    2,  -- tip
    HC.rectangle(-100*k,-100*k2,16*k,25*k2), --body
    0,  --timer
    20, -- invTimer
    30, -- atack
    30, --atackTimer
    0.286, --color1 
    0.333, --color2
    0.435, --color3
    100, -- scale
    0, -- angleMouth 
    0, -- angleBody
    0, -- angleMouthFlag
    150,  -- damage
    false, -- f
    -100*k, --  x  
    -100*k2, -- y  
    0,  -- ax 
    0,  -- ay
    2, --health
    2, --healthM
    {}, -- traces
    0,--flagBomb
    0,--prepar
    3,--preparTimer
    3,--animat
    3,--animatTimer
    10,--cost
}

enemyBombClass = Class{
    init = function(self,w,h,tip,body,timer,invTimer,atack,atackTimer,color1,color2,color3 ,scale,angleMouth,angleBody,angleMouthFlag,damage,f,x,y,ax,ay,health,healthM,traces,flagBomb,prepar,preparTimer,animat,animatTimer,cost)
        self.w = w
        self.h = h 
        self.tip = tip 
        self.body =body
        self.timer = timer  
        self.invTimer = invTimer
        self.atack = atack
        self.atackTimer = atackTimer
        self.prepar = prepar 
        self.preparTimer = preparTimer
        self.animat = animat
        self.animatTimer = animatTimer
        self.color1 =color1
        self.color2=color2
        self.color3 =color3
        self.scale = scale
        self.angleMouth = angleMouth
        self.angleBody =  angleBody
        self.angleMouthFlag = angleMouthFlag
        self.damage = damage
        self.flagBomb = flagBomb
        self.f = f
        self.x  =x
        self.y =y
        self.ax  =ax
        self.ay =ay
        self.health = health
        self.healthM = healthM
        self.traces = traces
        self.cost = cost
    end;
    newBody =  function(self)
        local bodyEn  = HC.rectangle(self.x,self.y, enemyBombTable[1]*k, enemyBombTable[2]*k)
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
        if (self.atack and self.atack==self.atackTimer and self.invTimer ==self.timer and (math.sqrt(math.pow((player.x-self.x),2)+math.pow((player.y-self.y),2))) <= 50*k ) then
            self.atack = self.atackTimer-0.001
        end
    end;
    atackTimerUpdate = function(self,dt)
        if ( self.atack <  self.atackTimer) then
            self.atack  = self.atack  - 30*dt
            if ( self.prepar == self.preparTimer) then
                self.prepar  = self.preparTimer - 0.0001
            end
        end
        if ( self.prepar <  self.preparTimer) then
            self.prepar  = self.prepar  - 10*dt
        end
        if ( self.prepar < 0) then
            self.prepar  = self.preparTimer
        end
        
        if ( self.animat <  self.animatTimer) then
            self.animat  = self.animat  - 15*dt
        end
        if ( self.animat < 0) then
            self.atack  = self.atackTimer
            self.flagBomb = 1 
            self.w = 100
            if (player.a ==0 and  (math.sqrt(math.pow((player.x-self.x),2)+math.pow((player.y-self.y),2))) <= self.w*k+playerAbility.scaleBody*k ) then
                flaginv = false 
                enAtackPlayer(self.damage,'e')
            end
        end
        if ( self.atack < 0) then
            self.animat  = self.animat  - 0.0001
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
        if ((math.abs(angle) -  math.abs(self.angleBody)) > 2.01*dt or (math.abs(angle) -  math.abs(self.angleBody)) <  -2.01*dt ) then
            if (angle/math.abs(angle)==self.angleBody/math.abs(self.angleBody))then
                if ( angle>self.angleBody) then
                    self.angleBody = self.angleBody+4*dt
                else 
                    self.angleBody = self.angleBody-4*dt
                end
            else
                if (math.abs(angle)+math.abs(self.angleBody)> 2*math.pi - math.abs(angle)-math.abs(self.angleBody)) then
                    if (self.angleBody>0) then 
                        self.angleBody = self.angleBody+4*dt
                    else
                        self.angleBody = self.angleBody-4*dt
                    end
                else 
                    if (self.angleBody>0) then 
                        self.angleBody = self.angleBody-4*dt
                    else
                        self.angleBody = self.angleBody+4*dt
                    end
                end
            end
        end
    end;
    angleMouthTr = function(self,dt)
        if ( self.angleMouth> 1 ) then
            self.angleMouthFlag = 1 
        end
        if ( self.angleMouth< 0 ) then
            self.angleMouthFlag = 0 
        end
        if ( self.angleMouthFlag ==0) then
            self.angleMouth  = self.angleMouth +1.1*dt
        else
            self.angleMouth  = self.angleMouth -1.1*dt
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
        if (self.flagBomb == 0 ) then 
            enCollWithobjInRegularS(IenRegulS,i,dt)
            enCollWithobjInRegularS(IenRegulS-1,i,dt)
            enCollWithobjInRegularS(IenRegulS+1,i,dt)
            enCollWithobjInRegularS(IenRegulS-math.floor((screenWidth/(120*k))+1),i,dt)
            enCollWithobjInRegularS(IenRegulS+math.floor((screenWidth/(120*k))+1),i,dt)
            enCollWithobjInRegularS(IenRegulS+math.floor((screenWidth/(120*k))+1)+1,i,dt)
            enCollWithobjInRegularS(IenRegulS+math.floor((screenWidth/(120*k))+1)-1,i,dt)
            enCollWithobjInRegularS(IenRegulS-math.floor((screenWidth/(120*k))+1)+1,i,dt)
            enCollWithobjInRegularS(IenRegulS-math.floor((screenWidth/(120*k))+1)-1,i,dt)
        else
            enCollWithobjInRegularSBomb(IenRegulS,i,dt)
            enCollWithobjInRegularSBomb(IenRegulS-1,i,dt)
            enCollWithobjInRegularSBomb(IenRegulS+1,i,dt)
            enCollWithobjInRegularSBomb(IenRegulS-math.floor((screenWidth/(120*k))+1),i,dt)
            enCollWithobjInRegularSBomb(IenRegulS+math.floor((screenWidth/(120*k))+1),i,dt)
            enCollWithobjInRegularSBomb(IenRegulS+math.floor((screenWidth/(120*k))+1)+1,i,dt)
            enCollWithobjInRegularSBomb(IenRegulS+math.floor((screenWidth/(120*k))+1)-1,i,dt)
            enCollWithobjInRegularSBomb(IenRegulS-math.floor((screenWidth/(120*k))+1)+1,i,dt)
            enCollWithobjInRegularSBomb(IenRegulS-math.floor((screenWidth/(120*k))+1)-1,i,dt)
            ---
            enCollWithobjInRegularSBomb(IenRegulS-2*math.floor((screenWidth/(120*k))+1)-2,i,dt)
            enCollWithobjInRegularSBomb(IenRegulS-2*math.floor((screenWidth/(120*k))+1)-1,i,dt)
            enCollWithobjInRegularSBomb(IenRegulS-2*math.floor((screenWidth/(120*k))+1),i,dt)
            enCollWithobjInRegularSBomb(IenRegulS-2*math.floor((screenWidth/(120*k))+1)+1,i,dt)
            enCollWithobjInRegularSBomb(IenRegulS-2*math.floor((screenWidth/(120*k))+1)+2,i,dt)
            
            enCollWithobjInRegularSBomb(IenRegulS-math.floor((screenWidth/(120*k))+1)-2,i,dt)
            enCollWithobjInRegularSBomb(IenRegulS-math.floor((screenWidth/(120*k))+1)+2,i,dt)
            
            enCollWithobjInRegularSBomb(IenRegulS-2,i,dt)
            enCollWithobjInRegularSBomb(IenRegulS+2,i,dt)
            
            enCollWithobjInRegularSBomb(IenRegulS+math.floor((screenWidth/(120*k))+1)-2,i,dt)
            enCollWithobjInRegularSBomb(IenRegulS+math.floor((screenWidth/(120*k))+1)+2,i,dt)
            
            
            enCollWithobjInRegularSBomb(IenRegulS+2*math.floor((screenWidth/(120*k))+1)-2,i,dt)
            enCollWithobjInRegularSBomb(IenRegulS+2*math.floor((screenWidth/(120*k))+1)-1,i,dt)
            enCollWithobjInRegularSBomb(IenRegulS+2*math.floor((screenWidth/(120*k))+1),i,dt)
            enCollWithobjInRegularSBomb(IenRegulS+2*math.floor((screenWidth/(120*k))+1)+1,i,dt)
            enCollWithobjInRegularSBomb(IenRegulS+2*math.floor((screenWidth/(120*k))+1)+2,i,dt)
            
        end
        if ( self.flagBomb == 1) then
            self.flagBomb =0 
            self.w =enemyBombTable[1]*k
            self.health = -1 
            local enBoomAnTabl =
            {
              an = 1,
              timer = 1,
              x = self.x,
              y = self.y,
              r = self.angleBody
            }
            table.insert(enBoomAnimat,enBoomAnTabl)
        end
    end;
    move =  function(self,dt)
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
        self.angleBodyTr(self,anglePlayerEn,dt)
        self.angleMouthTr(self,dt)
        if ( (math.sqrt(math.pow((player.x-self.x),2)+math.pow((player.y-self.y),2))) >= 20*k ) then
            self.ax=self.ax+80*k*math.sin(anglePlayerEn)*dt
            self.ay=self.ay+80*k2*math.cos(anglePlayerEn)*dt
        else
            self.ax = 0 
            self.ay = 0 
        end
        if ( self.atack == self.atackTimer) then 
            self.x= self.x+self.ax*dt*5
            self.y= self.y+self.ay*dt*5 --- нормальное движение
            self.x= self.x+math.sin(self.y/20)*dt*40
            self.y= self.y+math.cos(self.x/20)*dt*40
        else
            self.ax = 0 
            self.ay = 0 
        end
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
        if ((math.abs(anglePlayerEn) -  math.abs(self.angleBody)) > 2.01*dt or (math.abs(anglePlayerEn) -  math.abs(self.angleBody)) <  -2.01*dt ) then
            self.ax = 0
            self.ay = 0 
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
            local clow1X =self.x +17*k*math.sin(self.angleBody+math.pi/5)
            local clow1Y =self.y +17*k2*math.cos(self.angleBody+math.pi/5)
            local clow2X =self.x +17*k*math.sin(self.angleBody-math.pi/5)
            local clow2Y =self.y +17*k2*math.cos(self.angleBody-math.pi/5)
            enBatch:setColor(1,0.2,0.2,1)
            enBatch:add(enQuads.clow1Bomb,clow1X,clow1Y,-self.angleBody-math.pi+self.angleMouth,k/7,k2/7,29.5, 43)
            enBatch:add(enQuads.clow2Bomb,clow2X,clow2Y,-self.angleBody-math.pi-self.angleMouth,k/7,k2/7,29.5, 43)
            enBatch:add(enQuads.bodyBomb,self.x,self.y,-self.angleBody+math.pi,k/7,k2/7,108.5, 109)
        else
            local clow1X =self.x +17*k*math.sin(self.angleBody+math.pi/5)
            local clow1Y =self.y +17*k2*math.cos(self.angleBody+math.pi/5)
            local clow2X =self.x +17*k*math.sin(self.angleBody-math.pi/5)
            local clow2Y =self.y +17*k2*math.cos(self.angleBody-math.pi/5)
            if (self.atack==self.atackTimer)  then
                enBatch:setColor(1,1,1,1)
                enBatch:add(enQuads.clow1Bomb,clow1X,clow1Y,-self.angleBody-math.pi+self.angleMouth,k/7,k2/7,29.5, 43)
                enBatch:add(enQuads.clow2Bomb,clow2X,clow2Y,-self.angleBody-math.pi-self.angleMouth,k/7,k2/7,29.5, 43)
                enBatch:add(enQuads.bodyBomb,self.x,self.y,-self.angleBody+math.pi,k/7,k2/7,108.5, 109)
            else 
                if ( self.prepar > self.preparTimer/2) then
                    enBatch:setColor(1,0.5,0.5,1)
                    enBatch:add(enQuads.clow1Bomb,clow1X,clow1Y,-self.angleBody-math.pi+self.angleMouth,k/7*(4-self.animat),k2/7*(4-self.animat),29.5, 43)
                    enBatch:add(enQuads.clow2Bomb,clow2X,clow2Y,-self.angleBody-math.pi-self.angleMouth,k/7*(4-self.animat),k2/7*(4-self.animat),29.5, 43)
                    enBatch:add(enQuads.bodyBomb,self.x,self.y,-self.angleBody+math.pi,k/7*(4-self.animat),k2/7*(4-self.animat),108.5, 109)
                else
                    enBatch:setColor(1,1,1,1)
                    enBatch:add(enQuads.clow1Bomb,clow1X,clow1Y,-self.angleBody-math.pi+self.angleMouth,k/7*(4-self.animat),k2/7*(4-self.animat),29.5, 43)
                    enBatch:add(enQuads.clow2Bomb,clow2X,clow2Y,-self.angleBody-math.pi-self.angleMouth,k/7*(4-self.animat),k2/7*(4-self.animat),29.5, 43)
                    enBatch:add(enQuads.bodyBomb,self.x,self.y,-self.angleBody+math.pi,k/7*(4-self.animat),k2/7*(4-self.animat),108.5, 109)
            --        love.graphics.circle('line',self.x,self.y,self.w/2)
                end
            end
            --self.body:draw('fill')
        --   love.graphics.circle('line',self.x,self.y,100*k)
        end
    end;
    traceSpawn = function(self)
        local trace = {
            angle = self.angleBody,
            ax =-2*k*math.sin(self.angleBody) ,
            ay =-2*k2*math.cos(self.angleBody),
            x = -14*k*math.sin(self.angleBody) ,
            y = -14*k2*math.cos(self.angleBody) , 
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
            love.graphics.setColor(0.5/7*i,0.2/7*i,0.2/7*i) 
            love.graphics.circle("fill",self.x+  trace.x ,self.y + trace.y,radius)
        end
    end;
    hit  = function(self,a,i,dt)
        if ( a == 0 ) then
            
        else
            if ( self.invTimer and  self.invTimer ==self.timer) then
                playerAtackEn(self,dt)
                self.timer =  self.invTimer-0.001
                self.ax =self.ax - player.ax
                self.ay =self.ay -  player.ay
                spawnResHitEn(i)
            end  
        end
    end;
    kill =  function(self,i) 
        if (en[i].health and en[i].health<=0 and en[i].flagBomb ~= 1) then
            spawnResKillEn(i)
            local clow1X =self.x +17*k*math.sin(self.angleBody+math.pi/5)
            local clow1Y =self.y +17*k2*math.cos(self.angleBody+math.pi/5)
            local clow2X =self.x +17*k*math.sin(self.angleBody-math.pi/5)
            local clow2Y =self.y +17*k2*math.cos(self.angleBody-math.pi/5)
        
            local enDrawDie = {
              timer = 4, 
              quad = enQuads.bodyBomb,
              x = self.x,
              y = self.y,
              ax = self.ax,
              ay = self.ay,
              r = -self.angleBody+math.pi,
              ra = math.random(-3,-1),
              koff = k/7,
              koff2 = k2/7,
              ox = 108.5, 
              oy = 109,
            }
            table.insert(enAfterDieTex,enDrawDie)
            
            local enDrawDie2 = {
              timer = 4, 
              quad = enQuads.clow1Bomb,
              x = clow2X,
              y = clow2Y,
              ax = self.ax/5+math.random(-1.5*k,1.5*k)*10,
              ay = self.ay/5+math.random(-1.5*k,1.5*k)*10,
              r = -self.angleBody-math.pi-self.angleMouth,
              ra = math.random(-5,-1),
              koff = k/7,
              koff2 = k2/7,
              ox = 29.5, 
              oy = 43 ,
            }
            table.insert(enAfterDieTex,enDrawDie2)
            
            local enDrawDie3 = {
              timer = 4, 
              quad = enQuads.clow2Bomb,
              x = clow1X,
              y = clow1Y,
              ax = self.ax/5+math.random(-1.5*k,1.5*k)*10,
              ay = self.ay/5+math.random(-1.5*k,1.5*k)*10,
              r = -self.angleBody-math.pi+self.angleMouth,
              ra = math.random(-5,-1),
              koff = k/7,
              koff2 = k2/7,
              ox = 29.5, 
              oy = 43 ,
            }
            expl(54*k,screenHeight/2-(colWave*250*k2/waves[2])/2,10)
            expl(54*k,screenHeight/2+(colWave*250*k2/waves[2])/2,10)
            colWave =  colWave - en[i].cost
            
            table.insert(enAfterDieTex,enDrawDie3)
            table.remove(en,i)
        else
            if (en[i].health and en[i].health<=0) then
                table.remove(en,i) 
            end
        end  
    end;
}

enemyBomb = enemyBombClass(unpack(enemyBombTable))
return  enClassBomb