local resourceClass =  {} 
            
resourceClass = Class {
    timerReceiveText = 1,
    value = 1, 
    init = function(self,timer,invTimer,angle,color1,color2,color3,x,y,ax,ay)
        self.timer = timer
        self.invTimer  = invTimer 
        self.angle = angle 
        self.color1 = color1
        self.color2 = color2
        self.color3 = color3
        self.x = x
        self.y = y 
        self.ax = ax
        self.ay = ay
    end;

    IndexInRegulS =  function(self,scaleS)
        return math.floor((self.x-scaleS/2*k)/(scaleS*k)) + math.floor((self.y-scaleS/2*k2)/(scaleS*k2))*math.floor((screenWidth/(scaleS*k))+1)
    end;
   
    update = function(self,dt)
        self.move(self,dt)
        self.slowDown(self,dt)
        self.timerUpdate(self,dt)
    end;
    
    timerUpdate = function(self,dt)
        if ( self.timer < self.invTimer) then
            self.timer  = self.timer - dt* 40
        end
        if ( self.timer < 0) then
            self.timer  = self.invTimer
        end 
    end;
    
    slowDown = function(self,dt)
        if ( self.ax > 0 ) then
            self.ax  = self.ax - 4*dt*k
        else
            self.ax  = self.ax + 4*dt*k
        end
        if ( self.ay > 0 ) then
            self.ay  = self.ay - 4*dt*k2
        else
            self.ay  = self.ay + 4*dt*k2
        end
    end;
    
    move = function(self,dt)
        self.x= self.x+self.ax*dt*6*k
        self.y= self.y+self.ay*dt*6*k2
    end;
    
    GravityWithPlayer = function(self)
        if ( Player.a==0) then 
            if ((self.timer == self.invTimer and (math.sqrt(math.pow((Player.x-self.x),2)+math.pow((Player.y-self.y),2))) < Player.radiusCollect*k*Player.Skills.Collect.value)) then
                local x1 = (Player.x)-self.x+1*k
                local y1 = (Player.y)-self.y+1*k2          
                local ugol = math.atan2(x1,y1)
                Player.Clows.flag =3
                if ( self.ax> 17*k*math.sin(ugol)*Player.Skills.Collect.value ) then
                    self.ax = self.ax - 4*k 
                else
                    self.ax = self.ax + 4*k
                end
                if ( self.ay> 17*k2*math.cos(ugol)*Player.Skills.Collect.value ) then
                    self.ay = self.ay - 4*k2
                else
                    self.ay = self.ay + 4*k2 
                end
            end
        end
    end;
    
    collWithEn = function(self,index,j,dt)
        if ( resource[j] and enRegulS[index]) then 
            local kek = enRegulS[index]
            if (kek) then
                for i = #kek, 1, -1 do
                    if (kek[i] and en[kek[i]] and resource[j] and ((en[kek[i]].tip == 1) or (en[kek[i]].tip == 5) )) then
                        if (en[kek[i]].dash~=en[kek[i]].dashTimer and  en[kek[i]].tip == 5 and math.abs(en[kek[i]].x - resource[j].x)<200*k and math.abs(en[kek[i]].y - resource[j].y)<200*k2 and  (math.pow((en[kek[i]].x - resource[j].x),2) + math.pow((en[kek[i]].y - resource[j].y),2))<=math.pow((200*k),2) ) then 
                            local angleD = math.atan2(resource[j].x-en[kek[i]].x,resource[j].y-en[kek[i]].y)
                            local flagresourceZone = false
                            if (angleD/math.abs(angleD)==en[kek[i]].angleBody/math.abs(en[kek[i]].angleBody))then
                                if (math.abs(math.abs(angleD) - math.abs(en[kek[i]].angleBody)) <  math.pi/4) then 
                                    flagresourceZone = true
                                end
                            else
                                if (math.abs(angleD)+math.abs(en[kek[i]].angleBody)> 2*math.pi - math.abs(angleD)-math.abs(en[kek[i]].angleBody)) then
                                    if ((2*math.pi - math.abs(angleD)-math.abs(en[kek[i]].angleBody)) <  math.pi/4) then 
                                        flagresourceZone = true
                                    end
                                else 
                                    if ((math.abs(angleD)+math.abs(en[kek[i]].angleBody)) <  math.pi/4) then 
                                        flagresourceZone = true
                                    end
                                end
                            end
                            if (flagresourceZone) then 
                                resource[j].ax=-2000*dt*k*math.sin(angleD)
                                resource[j].ay=-2000*dt*k*math.cos(angleD)
                            end
                        end          
  
                        if (resource[j] and math.abs(en[kek[i]].x - resource[j].x)<12*k and math.abs(en[kek[i]].y - resource[j].y)<12*k2 and  (math.pow((en[kek[i]].x - resource[j].x),2) + math.pow((en[kek[i]].y - resource[j].y),2))<=math.pow((12*k),2)) then
                            if ( en[kek[i]].tip == 1  )then 
                                en[kek[i]].angleMouth = 0.5
                            end
                            table.remove(resource,j) 
                            break   
                        end
                    end
                end
            end
        end
    end;
    
    collWithPlayer = function(self,i)
        if (self.timer == self.invTimer and  checkCollision(Player.x-20*k,Player.y-20*k2, 40*k, 40*k2,self.x,self.y,1*k,1*k2)) then
            AddSound(pickUp,0.1)
            score = score + self.value
            resourceRemove(i)
        end
    end;
    
    draw = function(self)
        love.graphics.setColor(self.color1,self.color2,self.color3)
        rot('fill',self.x,self.y,4*k,4*k2,1,2*k,2*k2) 
    end;
    
    drawReceiveText = function(self)
        love.graphics.setColor(0.235,0.616,0.816,self.timerReceiveText)
        love.graphics.print("+1",self.x,self.y,-math.pi/2,0.3*k)    
    end;
    
    updateTimerReceiveText = function(self,dt)
        self.timerReceiveText = self.timerReceiveText - 1.2*dt
    end;
    
    border = function(self,i)
        if ( self.x > borderWidth*2+4*k or self.x < -borderWidth-4*k or self.y < -borderHeight-4*k or  self.y > borderHeight*2+4*k ) then
            table.remove(resource,i)
        end 
    end;
}
--resourceSimple = resourceClass(unpack(resourceSimpleTable))
return  resourceClass