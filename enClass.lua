local enClass =  {} 

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
    0.8, --color1 
    0.2, --color2
    0.2, --color3
    100, -- scale
    0, -- angleMouth 
    0, -- angleBody
    0, -- angleMouthFlag
    1,  -- damage
    false, -- f
    -100*k, --  x  
    -100*k2, -- y  
    0,  -- ax 
    0,  -- ay
    3, --health
    3 --healthM
}

enemyMeleeClass = Class{
    init = function(self,w,h,tip,body,timer,invTimer,atack,atackTimer,dash,dashTimer,color1,color2,color3 ,scale,angleMouth,angleBody,angleMouthFlag,damage,f,x,y,ax,ay,health,healthM)
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
    end;
    newBody =  function(self)
        local bodyEn  = HC.rectangle(self.x,self.y, enemyMeleeTable[1]*k, enemyMeleeTable[2]*k)
        self.body = bodyEn
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
        if ( self.angleMouth> 0.1 ) then
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
        if (self.dash and self.dash==self.dashTimer) then
            self.angleBodyTr(self,anglePlayerEn,dt)
            self.angleMouthTr(self,dt)
            self.ax=self.ax+80*k*math.sin(anglePlayerEn)*dt
            self.ay=self.ay+80*k2*math.cos(anglePlayerEn)*dt
            self.x= self.x+self.ax*dt*7
            self.y= self.y+self.ay*dt*7 --- нормальное движение
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
            if ((math.abs(anglePlayerEn) -  math.abs(self.angleBody)) > 2.01*dt or (math.abs(anglePlayerEn) -  math.abs(self.angleBody)) <  -2.01*dt ) then
                self.ax = 0
                self.ay = 0 
            end
        else
            self.x= self.x+self.ax*dt*17 -- движение противника ускорение
            self.y= self.y+self.ay*dt*17
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
    draw =  function(self)
        if ( self.invTimer and self.invTimer ~= self.timer) then
            local clow1X =xDraw +26*k*math.sin(controler.angle+0.17219081452294)
            local clow1Y =yDraw +26*k2*math.cos(controler.angle+0.17219081452294)
            local clow2X =xDraw +26*k*math.sin(controler.angle-0.17219081452294)
            local clow2Y =yDraw+26*k2*math.cos(controler.angle-0.17219081452294)
            enBatch:add(enQuads.clow1,clow1X,clow1Y,-controler.angle+math.pi+player.clowR,k/7,k2/7,176, 80)
            enBatch:add(enQuads.clow2,clow2X,clow2Y,-controler.angle+math.pi-player.clowR,k/7,k2/7,16, 80)
            
            enBatch:setColor(1,0.5,0.5,1)
            enBatch:add(enQuads.body,self.x,self.y,-self.angleBody+math.pi,k/10,k2/10,240/2, 352/2)
            
            self.body:draw('fill')
        else
            enBatch:setColor(1,1,1,1)
            enBatch:add(enQuads.body,self.x,self.y,-self.angleBody+math.pi,k/10,k2/10,240/2, 352/2)
            self.body:draw('fill')
        end
    end;
}

enemyMelee = enemyMeleeClass(unpack(enemyMeleeTable))
return  enClass