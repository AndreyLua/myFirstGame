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
    
    move = function(self,dt)
        if (self.tip == 1) then
            self.x= self.x+self.ax*dt*5*k
            self.y= self.y+self.ay*dt*5*k2
        end
        if (self.tip == 2) then
            self.x= self.x+self.ax*dt*4*k
            self.y= self.y+self.ay*dt*4*k2
        end
        if (self.tip == 3) then
            self.x= self.x+self.ax*dt*2*k
            self.y= self.y+self.ay*dt*2*k2
        end
        if (self.tip == 4) then
            self.x= self.x+self.ax*dt*5*k
            self.y= self.y+self.ay*dt*5*k2
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
        if ( player.a==0  ) then 
             if (self.timer == self.invTimer and (math.sqrt(math.pow((player.x-self.x),2)+math.pow((player.y-self.y),2))) < playerAbility.radiusCollect*k) then
                local x1 = (player.x)-self.x+1*k
                local y1 = (player.y)-self.y+1*k2          
                local ugol = math.atan2(x1,y1)
                player.clowRflag =3
                if ( self.ax> 17*k*math.sin(ugol)) then
                    self.ax = self.ax - 2*k 
                else
                    self.ax = self.ax + 2*k 
                end
                if ( self.ay> 17*k2*math.cos(ugol)) then
                    self.ay = self.ay - 2*k2
                else
                    self.ay = self.ay + 2*k2 
                end
            end
        end
    end;
    
    
    collWithPlayer = function(self,i)
        if (self.timer == self.invTimer and  checkCollision(player.x-20*k,player.y-20*k2, 40*k, 40*k2,self.x,self.y,1*k,1*k2)) then
            if ( self.tip == 4) then
                hp.long=hp.long+50*k2
                resRemove(i)
            else
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
    end;
    traceSpawn = function(self)
      --[[
        if ( self.tip == 1 or self.tip == 2 or self.tip == 3) then 
            local trace = {
                ax =-math.sin(math.atan2(self.ax,self.ay))*k*math.abs(self.ax),
                ay =-math.cos(math.atan2(self.ax,self.ay))*k2*math.abs(self.ay),
                x = 0 ,
                y = 0 , 
                r = 2*k ,
            }
            table.insert(self.traces,trace)
            if ( #self.traces >5) then
               table.remove(self.traces,1)
            end
        end
        ]]--
    end;
    traceDraw = function(self,dt)
      --[[
        if ( self.tip == 1 or self.tip == 2 or self.tip == 3) then 
            for i = 1, #self.traces do
                local trace = self.traces[i]
             --   local radius =self.r/2*i
                trace.x = trace.x+5*trace.ax*dt
                trace.y = trace.y+5*trace.ay*dt
                love.graphics.setColor(self.color1/3*i,self.color2/3*i,self.color3/3*i,0.5) 
                 if ( self.tip == 1 ) then
                    rot('fill',self.x+trace.x,self.y + trace.y,3.5*k,3.5*k2,self.r,3.5*k/2,3.5*k2/2)
                end
                if ( self.tip == 2 ) then
                    rot('fill',self.x+trace.x,self.y + trace.y,6.5*k,5.5*k2,self.r,6.5*k/2,6.5*k2/2)
                end
                if ( self.tip == 3 ) then
                    rot('fill',self.x+trace.x,self.y + trace.y,8.5*k,8.5*k2,self.r,8.5*k/2,8.5*k2/2)
                end
            end
        end
        ]]--
    end;
    
    border = function(self,i)
        if ( self.x > screenWidth*2) then 
            self.ax = -self.ax
            self.x =screenWidth*2 - 0.1*k
        end
        if ( self.x <  -screenWidth) then 
            self.ax = -self.ax
            self.x = -screenWidth + 0.1*k
        end
        if ( self.y < -screenHeight) then 
            self.ay = -self.ay
            self.y = -screenHeight+0.1*k2
        end
        if ( self.y > screenHeight*2) then 
            self.ay = -self.ay
            self.y = screenHeight*2 - 0.1*k2
        end
        if ( self.x > screenWidth*2 or self.x < -screenWidth or self.y < -screenHeight or  self.y > screenHeight*2 ) then
            table.remove(obj,i)
        end    
    end;
}

--resSimple = resClass(unpack(resSimpleTable))
return  resSimpleClass