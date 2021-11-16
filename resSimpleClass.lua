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
    traceSpawn = function(self)
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
    end;
    traceDraw = function(self,dt)
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
              --  love.graphics.circle("fill",self.x+trace.x,self.y + trace.y,radius)
            end
        end
    end;
}

--resSimple = resClass(unpack(resSimpleTable))
return  resSimpleClass