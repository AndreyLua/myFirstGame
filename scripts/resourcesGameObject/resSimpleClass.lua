local resSimpleClass =  {} 
            
resClass = Class {
    init = function(self,timer,invTimer,tip,r,color1,color2,color3,x,y,ax,ay,traces)
        self.timer = timer
        self.invTimer  = invTimer 
        self.tip = tip
        self.r = r 
        self.color1 = color1
        self.color2 = color2
        self.color3 = color3
        self.x = x
        self.y = y 
        self.ax = ax
        self.ay = ay 
        self.traces = traces
    end;
    IndexInRegulS =  function(self,scaleS)
        return math.floor((self.x-scaleS/2*k)/(scaleS*k)) + math.floor((self.y-scaleS/2*k2)/(scaleS*k2))*math.floor((screenWidth/(scaleS*k))+1)
    end;
    move = function(self,dt)
        if (self.tip == 1) then
            self.x= self.x+self.ax*dt*6*k
            self.y= self.y+self.ay*dt*6*k2
        end
        if (self.tip == 2) then
            self.x= self.x+self.ax*dt*4*k
            self.y= self.y+self.ay*dt*4*k2
        end
        if (self.tip == 3) then
            self.x= self.x+self.ax*dt*4*k
            self.y= self.y+self.ay*dt*4*k2
        end
        if (self.tip == 4) then
            self.x= self.x+self.ax*dt*6*k
            self.y= self.y+self.ay*dt*6*k2
        end
        if (self.tip == 5) then
            self.x= self.x+self.ax*dt*6*k
            self.y= self.y+self.ay*dt*6*k2
        end
        if (self.tip == 6) then
            if ( self.timer == self.invTimer) then 
                self.x= self.x+self.ax*dt*15*k
                self.y= self.y+self.ay*dt*15*k2
            else
                self.x= self.x+self.ax*dt*30*k
                self.y= self.y+self.ay*dt*30*k2
            end
        end
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
        
        if ( self.timer < self.invTimer) then
            self.timer  = self.timer - dt* 40
        end
        if ( self.timer < 0) then
            self.timer  = self.invTimer
        end
    end;
    GravityWithPlayer = function(self)
        if ( self.timer == self.invTimer and  self.tip == 6 ) then
            local x1 = (Player.x)-self.x+1*k
            local y1 = (Player.y)-self.y+1*k2          
            local ugol = math.atan2(x1,y1) -0.8 * self.r
            self.ax = 23*k*math.sin(ugol)
            self.ay = 23*k*math.cos(ugol)
        else
            if ( Player.a==0) then 
                 if ((self.timer == self.invTimer and (math.sqrt(math.pow((Player.x-self.x),2)+math.pow((Player.y-self.y),2))) < Player.radiusCollect*k*playerSkillParametrs.collectRangeK)) then
                    local x1 = (Player.x)-self.x+1*k
                    local y1 = (Player.y)-self.y+1*k2          
                    local ugol = math.atan2(x1,y1)
                    Player.Clows.flag =3
                    if ( self.ax> 17*k*math.sin(ugol)*playerSkillParametrs.collectRangeK ) then
                        self.ax = self.ax - 4*k 
                    else
                        self.ax = self.ax + 4*k
                    end
                    if ( self.ay> 17*k2*math.cos(ugol)*playerSkillParametrs.collectRangeK ) then
                        self.ay = self.ay - 4*k2
                    else
                        self.ay = self.ay + 4*k2 
                    end
                end
            end
        end
    end;
    collWithEn = function(self,index,j,dt)
        if ( res[j] and enRegulS[index]) then 
            local kek = enRegulS[index]
            if (kek) then
                for i = #kek, 1, -1 do
                    if (kek[i] and en[kek[i]] and res[j] and ((en[kek[i]].tip == 1) or (en[kek[i]].tip == 5) )) then
                        if (en[kek[i]].dash~=en[kek[i]].dashTimer and  en[kek[i]].tip == 5 and math.abs(en[kek[i]].x - res[j].x)<200*k and math.abs(en[kek[i]].y - res[j].y)<200*k2 and  (math.pow((en[kek[i]].x - res[j].x),2) + math.pow((en[kek[i]].y - res[j].y),2))<=math.pow((200*k),2) ) then 
                            local angleD = math.atan2(res[j].x-en[kek[i]].x,res[j].y-en[kek[i]].y)
                            local flagresZone = false
                            if (angleD/math.abs(angleD)==en[kek[i]].angleBody/math.abs(en[kek[i]].angleBody))then
                                if (math.abs(math.abs(angleD) - math.abs(en[kek[i]].angleBody)) <  math.pi/4) then 
                                    flagresZone = true
                                end
                            else
                                if (math.abs(angleD)+math.abs(en[kek[i]].angleBody)> 2*math.pi - math.abs(angleD)-math.abs(en[kek[i]].angleBody)) then
                                    if ((2*math.pi - math.abs(angleD)-math.abs(en[kek[i]].angleBody)) <  math.pi/4) then 
                                        flagresZone = true
                                    end
                                else 
                                    if ((math.abs(angleD)+math.abs(en[kek[i]].angleBody)) <  math.pi/4) then 
                                        flagresZone = true
                                    end
                                end
                            end
                            if (flagresZone) then 
                                res[j].ax=-2000*dt*k*math.sin(angleD)
                                res[j].ay=-2000*dt*k*math.cos(angleD)
                            end
                        end          
  
                        if (res[j] and math.abs(en[kek[i]].x - res[j].x)<12*k and math.abs(en[kek[i]].y - res[j].y)<12*k2 and  (math.pow((en[kek[i]].x - res[j].x),2) + math.pow((en[kek[i]].y - res[j].y),2))<=math.pow((12*k),2)) then
                            if ( en[kek[i]].tip == 1  )then 
                                en[kek[i]].angleMouth = 0.5
                            end
                            table.remove(res,j) 
                            break   
                        end
                    end
                end
            end
        end
    end;
    
    collWithPlayer = function(self,i)
        if (self.timer == self.invTimer and  checkCollision(Player.x-20*k,Player.y-20*k2, 40*k, 40*k2,self.x,self.y,1*k,1*k2)) then
            if ( self.tip == 4 or self.tip == 5 or self.tip == 6) then
                if ( self.tip == 4 ) then 
                    for i =1,math.random(3,5) do 
                        newGreenPlayerEffect()
                    end
                    Player:heal(50)
                    resRemove(i)
                end
                if ( self.tip == 5 ) then
                    Player:rechargeEnergy(50)
                    resRemove(i)
                end
                if ( self.tip == 6 ) then
                    newGreenPlayerEffect()
                    Player:heal(playerSkillParametrs.vampirK*playerSkillParametrs.damageK*50) -- skill
                    resRemove(i)
                end
            else
                AddSound(pickUp,0.1)
                score = score +1
                resRemove(i)
            end
        end
    end;
    draw = function(self)
        if ( self.tip == 1) then
            love.graphics.setColor(self.color1,self.color2,self.color3)
            rot('fill',self.x,self.y,4*k,4*k2,1,2*k,2*k2)
        end
        if ( self.tip == 2) then
              love.graphics.setColor(self.color1,self.color2,self.color3)
              rot('fill',self.x,self.y,7*k,7*k2,1,3.5*k,3.5*k2)
        end
        if ( self.tip == 3) then
            love.graphics.setColor(self.color1,self.color2,self.color3)
            rot('fill',self.x,self.y,9*k,9*k2,1,4.5*k,4.5*k2)
        end
        if ( self.tip == 4) then
            resBatch:add(resQuads.hp,self.x,self.y,self.r+math.pi/2,k/19,k2/19,105,105)
        end
        if ( self.tip == 5) then
            resBatch:add(resQuads.boost,self.x,self.y,self.r+math.pi/2,k/13,k2/13,65,105)
        end
        if ( self.tip == 6) then
            love.graphics.setColor(self.color1,self.color2,self.color3)
            rot('fill',self.x,self.y,4*k,4*k2,1,2*k,2*k2)
        end
    end;
    traceSpawn = function(self)
        if ( self.tip == 6) then
            local trace = {
                ax =-math.sin(math.atan2(self.ax,self.ay))*k*math.abs(self.ax),
                ay =-math.cos(math.atan2(self.ax,self.ay))*k2*math.abs(self.ay),
                x = 0 ,
                y = 0 , 
                r = 2*k ,
            }
            table.insert(self.traces,trace)
            if ( #self.traces >7) then
               table.remove(self.traces,1)
            end
        end
       
    end;
    traceDraw = function(self,dt)
     
        if ( self.tip == 6) then 
            for i = 1, #self.traces do
                local trace = self.traces[i]
             --   local radius =self.r/2*i
                trace.x = trace.x+5*trace.ax*dt
                trace.y = trace.y+5*trace.ay*dt
                love.graphics.setColor(self.color1/3*i,self.color2/3*i,self.color3/3*i,0.6) 
               --  if ( self.tip == 1 ) then
               --     rot('fill',self.x+trace.x,self.y + trace.y,3.5*k,3.5*k2,self.r,3.5*k/2,3.5*k2/2)
               -- end
               -- if ( self.tip == 2 ) then
               --     rot('fill',self.x+trace.x,self.y + trace.y,6.5*k,5.5*k2,self.r,6.5*k/2,6.5*k2/2)
              --  end
              --  if ( self.tip == 3 ) then
              --      rot('fill',self.x+trace.x,self.y + trace.y,8.5*k,8.5*k2,self.r,8.5*k/2,8.5*k2/2)
              -- end
                rot('fill',self.x+trace.x,self.y + trace.y,3.5*k,3.5*k2,self.r,3.5*k/2,3.5*k2/2)
            end
        end
        
    end;
    
    border = function(self,i)
        if ( self.x > borderWidth*2+4*k or self.x < -borderWidth-4*k or self.y < -borderHeight-4*k or  self.y > borderHeight*2+4*k ) then
            table.remove(res,i)
        end 
    end;
}

--resSimple = resClass(unpack(resSimpleTable))
return  resSimpleClass