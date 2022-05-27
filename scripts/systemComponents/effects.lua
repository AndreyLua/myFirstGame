local effects = {}

explosionEffect = {
    particles = {}
}

function explosionEffect:reset()
    self.particles= {}
end

function explosionEffect:new(x,y,count,colorR,colorG,colorB)
    for i =0, count do
        local particl = {
            flag  =false,
            tip = 1,
            r = 0 ,
            color1 = colorR,
            color2 = colorG,
            color3 = colorB,
            f = false,
            x  = x, 
            y =  y,  
            xx  = x, 
            yy =  y,
            ax = math.random(-1.72*k*30,1.73*k*30), 
            ay = math.random(-1.73*k*30,1.73*k*30), 
            scale =0.15
        }
        table.insert(self.particles,particl)
    end
end

function explosionEffect:update(dt)
    for i =#self.particles,1,-1 do
        if( self.particles[i]) then
            self.particles[i].x= self.particles[i].x+self.particles[i].ax*dt*k
            self.particles[i].y= self.particles[i].y+self.particles[i].ay*dt*k2
            if (  self.particles[i].flag ==false) then 
                if ( self.particles[i].ax > 0 ) then
                    self.particles[i].ax  = self.particles[i].ax -70*dt*k
                else
                    self.particles[i].ax  = self.particles[i].ax + 70*dt*k
                end
                if ( self.particles[i].ay > 0 ) then
                    self.particles[i].ay  = self.particles[i].ay -70*dt*k2
                else
                    self.particles[i].ay  = self.particles[i].ay + 70*dt*k2
                end
            end
            if ( (self.particles[i].ay<3*k2 and  self.particles[i].ay>-3*k2) or (self.particles[i].ax<3*k and  self.particles[i].ax>-3*k)) then
                table.remove(self.particles,i)
            end
        end
    end
end

function explosionEffect:draw()
    for i=1,#self.particles do 
        if (self.particles[i].color1) then 
            love.graphics.setColor(self.particles[i].color1,self.particles[i].color2,self.particles[i].color3,1)
        else
            love.graphics.setColor(1,1,1,1)
        end
        love.graphics.rectangle("fill",self.particles[i].x,self.particles[i].y,self.particles[i].scale*20*k,self.particles[i].scale*20*k2,4*self.particles[i].scale*k)
    end
end

DamageVisualizator = {
    timer = 1,
    printNumbers = {}
}

function DamageVisualizator:new(value,x,y,flagCrit)
    local number = {
        value = value,
        x = x,
        y = y, 
        flagCrit =flagCrit,
        timer = self.timer,
    }
    table.insert(self.printNumbers,number)
end

function DamageVisualizator:update(dt)
    for i=#self.printNumbers, 1,-1 do 
        if (self.printNumbers[i].timer > 0 ) then 
            self.printNumbers[i].timer = self.printNumbers[i].timer - 1*dt
        else
            table.remove(self.printNumbers,i)
        end
    end
end

function DamageVisualizator:draw()
    for i=#self.printNumbers, 1,-1 do 
        local printDamageWidth = font:getWidth(tostring(self.printNumbers[i].value))
        if (self.printNumbers[i].flagCrit) then 
            love.graphics.setColor(1,0.2,0.2,(self.printNumbers[i].timer)/self.timer)
            love.graphics.print(self.printNumbers[i].value,self.printNumbers[i].x,self.printNumbers[i].y+printDamageWidth/2*k2/2,-math.pi/2,k*0.5+math.random()/4,k2*0.5+math.random()/4)
        else
            love.graphics.setColor(1,1,1,(self.printNumbers[i].timer)/self.timer)
            love.graphics.print(self.printNumbers[i].value,self.printNumbers[i].x,self.printNumbers[i].y+printDamageWidth/2*k2/2,-math.pi/2,k*0.4,k2*0.4) 
        end    
    end
end

LightEffect = {
    minLength = 100*k,
}

function LightEffect:get(x1,y1,x2,y2,numberSegments)
    local segments = {{{x1,y1},{x2,y2}}}
    local length = math.sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1))
    if ( length < self.minLength) then 
        local offset =length/5
        for i=1,numberSegments do
            for j =1,#segments do
                local segment = segments[j]
                local beginSegm = segment[1]
                local endSegm = segment[2]
                local ran =offset
                if ( math.random(1,2) == 1 ) then 
                    ran = -ran 
                end
                local angle =math.pi-math.atan2((endSegm[1] -beginSegm[1]),(endSegm[2] -beginSegm[2]))
                local midX  =(beginSegm[1]+endSegm[1])/2+math.cos(angle)*ran
                local midY  =(beginSegm[2]+endSegm[2])/2+math.sin(angle)*ran
                if ( math.random(1,4) == 1  )then 
                    local lengthDopPoint = math.sqrt((midX-beginSegm[1])*(midX-beginSegm[1])+(midY-beginSegm[2])*(midY-beginSegm[2]))
                    local dopAngle = -math.atan2((endSegm[1]-beginSegm[1]),(endSegm[2]-beginSegm[2]))
                    local dopPointX = midX+math.cos(dopAngle+math.pi/2-math.random()*1.2*math.random(-1,1))*lengthDopPoint*0.7
                    local dopPointY = midY+math.sin(dopAngle+math.pi/2-math.random()*1.2*math.random(-1,1))*lengthDopPoint*0.7
                    table.insert(segments,{{midX,midY},{dopPointX,dopPointY}})
                end
                table.remove(segments,j)
                table.insert(segments,{{beginSegm[1],beginSegm[2]},{midX,midY}})
                table.insert(segments,{{midX,midY},{endSegm[1],endSegm[2]}})
            end
            offset = offset/2
        end
        return segments
    end
end

function LightEffect:draw(segments) 
    if ( segments~=nil) then 
        for i = 1,#segments do
            local vert = {}
            local mouth =  segments[i]
            local versh = mouth[1]
            local versh2 = mouth[2]
            table.insert(vert,versh[1])
            table.insert(vert,versh[2])
            table.insert(vert,versh2[1])
            table.insert(vert,versh2[2])
            love.graphics.setColor(0.4,1,1,1)
            love.graphics.setLineWidth( 2*k )
            love.graphics.line(vert)
            love.graphics.setColor(0.8,1,1,1)
            love.graphics.setLineWidth( 1*k )
            love.graphics.line(vert)
        end
    end
end

WaveEffect = {
    particls = {},
    regulNetwork = {},
    timer = 10,
    numberCopies  =3,
}
function WaveEffect:new(x,y)
    local waveParticl = {
      x =x ,
      y =y, 
      r = 1*k,
      timer =  self.timer,
      count =self.numberCopies,
    }
    table.insert(self.particls,waveParticl)
    for i = 1, math.ceil(Player.Skills.SpecialAtack.Wave.count)+math.random(-1,1) do
        waveParticl = {
          x =x+math.random(-50,50)*k ,
          y =y+math.random(-50,50)*k , 
          r = 0.1*k,
          timer =  self.timer/2,
          count =self.numberCopies,
        }
        table.insert(self.particls,waveParticl)
    end
end

function WaveEffect:update(dt)
    for i = #self.particls,1, -1 do
        if ( self.particls[i].timer > 0 ) then 
            self.particls[i].r = self.particls[i].r + 30*k*dt
            self.particls[i].timer  = self.particls[i].timer - 30*dt
        else
           if (self.particls[i].count >1 ) then
                self.particls[i].count = self.particls[i].count - 1 
                self.particls[i].r = 0 *k 
                self.particls[i].timer = 10
            else
                table.remove(self.particls,i)  
            end
        end
        
        if ( self.particls[i]) then 
            local indexInRegulNetwork =math.floor((self.particls[i].x-40*k)/(80*k)) + math.floor((self.particls[i].y-40*k2)/(80*k2))*math.floor((screenWidth/(80*k))+1)
            if (self.regulNetwork[indexInRegulNetwork]) then
                table.insert(self.regulNetwork[indexInRegulNetwork],i)
            else
                self.regulNetwork[indexInRegulNetwork] = {i}
            end
        end
    end  
end

function WaveEffect:draw()
    for i = #self.particls,1, -1 do
        love.graphics.setColor(0.6,1,1,self.particls[i].timer/8)
        love.graphics.circle('line',self.particls[i].x,self.particls[i].y,self.particls[i].r/2*self.particls[i].count)
        love.graphics.circle('line',self.particls[i].x,self.particls[i].y,self.particls[i].r/1.5*self.particls[i].count)
        love.graphics.circle('line',self.particls[i].x,self.particls[i].y,self.particls[i].r/1.2*self.particls[i].count)
        love.graphics.circle('line',self.particls[i].x,self.particls[i].y,self.particls[i].r*self.particls[i].count)
    end
end

BloodyEffect = {
    particls = {},
    timer = 10,
    timerTick = 10,
}

function BloodyEffect:new(target)
    if ( target~= nil) then 
        local bloodParticl = {
            enemy = target,
            timer = self.timer,
            timerTick = self.timerTick,
            parts = {},
        }
        table.insert(self.particls,bloodParticl)
    end
end

function BloodyEffect:update(dt)
    for i = #self.particls,1, -1 do
        if ( self.particls[i].timer > 0 and self.particls[i].enemy.health and self.particls[i].enemy.health>0 ) then 
            if ( self.particls[i].timerTick == 10 and self.particls[i].enemy.health >0) then 
                self.particls[i].timerTick = self.particls[i].timerTick - 0.001
                Player.Skills.SpecialAtack.Bloody:debaff(self.particls[i].enemy)
            end
            self:newPart(self.particls[i],1)
            self:timerUpdate(self.particls[i],dt)
        else
            table.remove(self.particls,i)
        end
    end
end

function BloodyEffect:timerUpdate(particl,dt)
    if ( particl.timerTick < 10) then 
        particl.timerTick = particl.timerTick - 5*dt
    end
    particl.timer =particl.timer - 2 * dt
    if ( particl.timerTick < 0 ) then 
        particl.timerTick = 10
    end
end

function BloodyEffect:draw(dt)
    love.graphics.setColor(0.8,0,0,1) 
    for i = #self.particls,1, -1 do
        if (self.particls[i] and self.particls[i].enemy.health and self.particls[i].enemy.health>0) then 
            for j= #self.particls[i].parts,1,-1 do
                self.particls[i].parts[j].x= self.particls[i].parts[j].x+self.particls[i].parts[j].ax*dt*k
                self.particls[i].parts[j].y= self.particls[i].parts[j].y+self.particls[i].parts[j].ay*dt*k2
                if ( self.particls[i].parts[j].ax > 0 ) then
                    self.particls[i].parts[j].ax  =self.particls[i].parts[j].ax -70*dt*k
                else
                    self.particls[i].parts[j].ax  = self.particls[i].parts[j].ax + 70*dt*k
                end
                if ( self.particls[i].parts[j].ay > 0 ) then
                    self.particls[i].parts[j].ay  = self.particls[i].parts[j].ay -70*dt*k2
                else
                    self.particls[i].parts[j].ay  = self.particls[i].parts[j].ay + 70*dt*k2
                end
             
                love.graphics.rectangle("fill",self.particls[i].parts[j].x,self.particls[i].parts[j].y,self.particls[i].parts[j].scale*5*k,self.particls[i].parts[j].scale*5*k2,4)
                
                if ( (math.abs(self.particls[i].parts[j].ay)<3*k2) or (math.abs(self.particls[i].parts[j].ax)<3*k)) then
                    table.remove(self.particls[i].parts,j)
                end
            end
        else
            table.remove(self.particls,i)
        end
    end
end

function BloodyEffect:newPart(particl,amount)
    for n=1, amount do
        local part = {
            x  = particl.enemy.x, 
            y =  particl.enemy.y,  
            ax  =math.random(-1.72*k*30,1.73*k*30), 
            ay = math.random(-1.73*k*30,1.73*k*30), 
            scale =math.random()
        }
        table.insert(particl.parts,part)
    end
end

SpikeArmorEffect = {
    particls = {},
}

function SpikeArmorEffect:new(target)
    if ( target~= nil) then
        local SpikeArmorParticl  ={
            enemy = target,
            x = Player.x, 
            y = Player.y,
            speed =math.random(200,260)*k,
        }
        table.insert(self.particls,SpikeArmorParticl)
    end 
end

function SpikeArmorEffect:update(dt) 
    for i = #self.particls,1, -1 do
        if ( self.particls[i] and self.particls[i].enemy ~= nil and self.particls[i].enemy.health>0 ) then 
            local angle = math.atan2( self.particls[i].enemy.x -  self.particls[i].x, self.particls[i].enemy.y -  self.particls[i].y)
            self.particls[i].x = self.particls[i].x +self.particls[i].speed*math.sin(angle)*dt 
            self.particls[i].y = self.particls[i].y +self.particls[i].speed*math.cos(angle)*dt 
            if ( math.abs(self.particls[i].enemy.x -  self.particls[i].x) < 5*k and  math.abs(self.particls[i].enemy.y -  self.particls[i].y) < 5*k) then
                Player.Skills.SpikeArmor:atack(self.particls[i].enemy)
                table.remove(self.particls,i)  
            end
        else
            table.remove(self.particls,i)
        end
    end
end
----------------------------------------!!!!!!!!!!!!!!!!!!!!!!
function SpikeArmorEffect:draw() 
    for i = #self.particls,1, -1 do
        local angle = math.atan2( self.particls[i].enemy.x -  self.particls[i].x, self.particls[i].enemy.y -  self.particls[i].y)
        love.graphics.setColor(0.27,0.80,0.63,1)
        love.graphics.circle('fill',self.particls[i].x,self.particls[i].y,3*k)
        love.graphics.circle('fill',self.particls[i].x-self.particls[i].speed*math.sin(angle)*0.04*math.random() *2,self.particls[i].y-self.particls[i].speed*math.cos(angle)*0.04*math.random()*2,1*k)
        love.graphics.circle('fill',self.particls[i].x-self.particls[i].speed*math.sin(angle)*0.02*math.random()*2 ,self.particls[i].y-self.particls[i].speed*math.cos(angle)*0.02*math.random()*2,2*k)
    end
end


VampirEffect = {
    particls = {}
}

function VampirEffect:new(target)
    for i =1, math.random(3,5) do
        local vampirParticl = {
            timer = 10-0.00001, 
            invTimer = 10, 
            angle = math.random(-1,1),
            colorR = 0, 
            colorG = 1,
            colorB = 0.67,
            x = target.x,
            y = target.y,
            ax = math.random(-2*k,2*k2)*1.5, 
            ay = math.random(-2*k,2*k2)*1.5,  
            traces = {},
        }
        table.insert(self.particls,vampirParticl)
    end
end

function VampirEffect:update(dt)
    for i=#self.particls,1,-1 do 
        self:timerUpdate(self.particls[i],dt)
        self:move(self.particls[i],dt)
        self:traceSpawn(self.particls[i])
        self:collWithPlayer(self.particls[i],i)
    end
end

function VampirEffect:move(particl,dt)
    if ( particl.timer == particl.invTimer) then
        local distanceX = (Player.x)-particl.x+1*k
        local distanceY = (Player.y)-particl.y+1*k2          
        local angle = math.atan2(distanceX,distanceY) -0.8 * particl.angle
        particl.ax = 23*k*math.sin(angle)
        particl.ay = 23*k*math.cos(angle)
        
        particl.x= particl.x+particl.ax*dt*15*k
        particl.y= particl.y+particl.ay*dt*15*k2
    else
        particl.x= particl.x+particl.ax*dt*30*k
        particl.y= particl.y+particl.ay*dt*30*k2
    end
end;

function VampirEffect:collWithPlayer(particl,i)
    if (particl.timer == particl.invTimer and  checkCollision(Player.x-20*k,Player.y-20*k2, 40*k, 40*k2, particl.x,particl.y,1*k,1*k2)) then
        Player.Skills.SpecialAtack.Vampir:getHeal()
        table.remove(self.particls,i)
    end   
end

function VampirEffect:timerUpdate(particl,dt)
    if ( particl.timer < particl.invTimer) then
        particl.timer  = particl.timer - dt* 40
    end
    if ( particl.timer < 0) then
        particl.timer  = particl.invTimer
    end 
end;

function VampirEffect:draw(dt)
    for i=1, #self.particls do 
        love.graphics.setColor(self.particls[i].colorR,self.particls[i].colorG,self.particls[i].colorB)
        rot('fill',self.particls[i].x,self.particls[i].y,4*k,4*k2,1,2*k,2*k2)
        self:traceDraw(self.particls[i],dt)
    end
end;

function VampirEffect:traceSpawn(particl)
    local trace = {
        ax =-math.sin(math.atan2(particl.ax,particl.ay))*k*math.abs(particl.ax),
        ay =-math.cos(math.atan2(particl.ax,particl.ay))*k2*math.abs(particl.ay),
        x = 0 ,
        y = 0 , 
        r = 2*k ,
    }
    table.insert(particl.traces,trace)
    if ( #particl.traces >7) then
        table.remove(particl.traces,1)
    end
end;

function VampirEffect:traceDraw(particl,dt)
    for i = 1, #particl.traces do
        local trace = particl.traces[i]
        trace.x = trace.x+5*trace.ax*dt
        trace.y = trace.y+5*trace.ay*dt
        love.graphics.setColor(particl.colorR/3*i,particl.colorG/3*i,particl.colorB/3*i,0.6) 
        rot('fill',particl.x+trace.x,particl.y + trace.y,3.5*k,3.5*k2,particl.angle,3.5*k/2,3.5*k2/2)
    end
end;

HealEffect = {
    particls = {},
}

function HealEffect:new()
    local healParticl = {
        x =math.random(-20*k,20*k2)*1.5, 
        y =math.random(-20*k,20*k2)*1.5,  
        scale = math.random()*7, 
        timer = 10,
    }
    table.insert(self.particls,healParticl)
end

function HealEffect:update(dt)
    for i = #self.particls,1,-1 do
        if ( self.particls[i].timer > 0 ) then
            self.particls[i].timer =  self.particls[i].timer -30*dt
            self.particls[i].scale = self.particls[i].scale  +10*dt
        else
            self.particls[i].scale = self.particls[i].scale  -30*dt
            if ( self.particls[i].scale < 0 ) then 
                table.remove(self.particls,i)
            end
        end
    end
end

function HealEffect:draw()
    love.graphics.setColor(0,1,0.67,1)
    love.graphics.setLineWidth(1.1*k)
              
    for i = #self.particls,1,-1 do
        if ( self.particls[i].timer > 0 ) then
            love.graphics.line(Player.x+ self.particls[i].x,Player.y +  self.particls[i].y-0.5*k*self.particls[i].scale,Player.x+ self.particls[i].x,Player.y +  self.particls[i].y+0.5*k*self.particls[i].scale)
            love.graphics.line(Player.x+ self.particls[i].x-0.5*k*self.particls[i].scale,Player.y +  self.particls[i].y,Player.x+ self.particls[i].x+0.5*k*self.particls[i].scale,Player.y +  self.particls[i].y)
        else
            love.graphics.line(Player.x+ self.particls[i].x,Player.y +  self.particls[i].y-0.5*k*self.particls[i].scale,Player.x+ self.particls[i].x,Player.y +  self.particls[i].y+0.5*k*self.particls[i].scale)
            love.graphics.line(Player.x+ self.particls[i].x-0.5*k*self.particls[i].scale,Player.y +  self.particls[i].y,Player.x+ self.particls[i].x+0.5*k*self.particls[i].scale,Player.y +  self.particls[i].y)
        end
    end
end

TradeEffect = {
    particls = {},
    timer = 10,
}

function TradeEffect:new()
    local tradeParticl = {
        x =math.random()*k*math.random(-1,1)/1.3, 
        y =math.random()*k*math.random(-1,1)/1.3,  
        speed = math.random(),
        colorR =0.82,
        colorG =1,
        colorB = 0.59,
        timer = self.timer,
        trace = {},
    }
    table.insert(self.particls,tradeParticl)  
end

function TradeEffect:draw(dt)
    for i = #self.particls,1,-1 do
        if ( self.particls[i].timer > 0 ) then
            local trace = {
                x = self.particls[i].x,
                y = self.particls[i].y,
            }
            table.insert(self.particls[i].trace,trace)
            for j =#self.particls[i].trace,1,-1 do
                local sled = self.particls[i].trace
                love.graphics.setColor(self.particls[i].colorR*self.particls[i].speed,self.particls[i].colorG*self.particls[i].speed,self.particls[i].colorB*self.particls[i].speed,0.25*j*self.particls[i].timer/10)
                love.graphics.circle('fill',Player.x+62*math.sin(-math.pi/2-math.pi/4.3)*k+ sled[j].x,Player.y+62*math.cos(-math.pi/2-math.pi/4.3)*k +  sled[j].y,1.2*k)    
            end
            if ( #self.particls[i].trace > 4) then 
                table.remove(self.particls[i].trace,1) 
            end
            love.graphics.setColor(self.particls[i].colorR*self.particls[i].speed,self.particls[i].colorG*self.particls[i].speed,self.particls[i].colorB*self.particls[i].speed,self.particls[i].timer/10)
            
            local angle = math.atan2( -self.particls[i].x,-self.particls[i].y)+1.5
            self.particls[i].x = self.particls[i].x +80*math.sin(angle)*dt*k * (1+self.particls[i].speed)/3
            self.particls[i].y =self.particls[i].y +80*math.cos(angle)*dt*k * (1+self.particls[i].speed)/3
            
            love.graphics.circle('fill',Player.x+62*math.sin(-math.pi/2-math.pi/4.3)*k+self.particls[i].x,Player.y +62*math.cos(-math.pi/2-math.pi/4.3)*k+  self.particls[i].y,1.2*k)
            
            self.particls[i].timer =  self.particls[i].timer -4*dt  
        else
            table.remove(self.particls,i)
        end
    end
end

GetDamageEffect = {
    particls = {},
    timer = 10,
}

function GetDamageEffect:new(x,y,amount)
    local angleToPlayer = math.atan2(Player.x-x,Player.y-y)-math.pi
    for n =0, amount do
        local getDamageParticl = {
            colorR =Player.Color.colorR,
            colorG= Player.Color.colorG,
            colorB =Player.Color.colorB,
            x = Player.x+(Player.scaleBody-5)*k*math.sin(angleToPlayer), 
            y = Player.y+(Player.scaleBody-5)*k*math.cos(angleToPlayer), 
            ax  =60*k*math.sin(angleToPlayer+math.random()*1.6), 
            ay = 60*k*math.cos(angleToPlayer+math.random()*1.6), 
            scale =math.random()*1.5,
            timer = self.timer,
        }
        table.insert(self.particls,getDamageParticl)
    end
end

function GetDamageEffect:update(dt)
    for i=#self.particls,1,-1 do 
        if ( self.particls[i].timer>0) then 
            self.particls[i].timer = self.particls[i].timer - 20*dt
            self.particls[i].x= self.particls[i].x+self.particls[i].ax*dt*k
            self.particls[i].y= self.particls[i].y+self.particls[i].ay*dt*k2
            
            if ( self.particls[i].ax > 0 ) then
                self.particls[i].ax  = self.particls[i].ax -70*dt*k
            else
                self.particls[i].ax  = self.particls[i].ax + 70*dt*k
            end
            if ( self.particls[i].ay > 0 ) then
                self.particls[i].ay  = self.particls[i].ay -70*dt*k2
            else
                self.particls[i].ay  = self.particls[i].ay + 70*dt*k2
            end
        else
            table.remove(self.particls,i)
        end
    end
end

function GetDamageEffect:draw(dt)
    for i =#self.particls, 1,-1 do
        love.graphics.setColor(self.particls[i].colorR,self.particls[i].colorG,self.particls[i].colorB,self.particls[i].timer/6)
        love.graphics.rectangle("fill",self.particls[i].x,self.particls[i].y,self.particls[i].scale*3*k,self.particls[i].scale*3*k2,4*k)
    end  
end

EnergyArmorEffect = {
    value = 0,
    maxValue = 400,
    regen = 100,
    recovery = 10,
    recoveryTimer = 10,
    angle = 0,
    shake = 1,
    shakeK = 1,
}

function EnergyArmorEffect:update(dt)
    if ( Player.Skills.EnergyArmor.isOpened == true) then 
        self:angleUpdate(dt,Player.Controller.angle)
        if ( self.value>self.maxValue ) then
            self.value = self.maxValue
        end
        if (self.recovery == self.recoveryTimer) then 
            self.value = self.value + self.regen*dt
            self.shakeK = 0
        end
        if ( self.value <= 0 ) then
            self.value =0
        end
        self.shake = math.random()*math.random(-1,1)*self.shakeK
        if ( self.shakeK > 1 ) then 
            self.shakeK  = self.shakeK - 10 *dt
        end
        
        if ( self.recovery < self.recoveryTimer) then 
            self.recovery =self.recovery - 3*dt
            if ( self.recovery < 0 )then 
                self.recovery = self.recoveryTimer
            end
        end
    else
        self.value = 0 
    end
end


function EnergyArmorEffect:angleUpdate(dt,angle) 
    if ( self.angle == 0) then
        self.angle=0.00000001
    end
    if ( self.angle < -math.pi) then
        self.angle=math.pi
    end
    if ( self.angle > math.pi) then
        self.angle=-math.pi
    end
    if ( angle == 0) then
        angle=0.00000001
    end
    if ((angle -  self.angle > 2.1*dt) or (angle -  self.angle) <  -2.1*dt ) then
        if (angle/math.abs(angle)==self.angle/math.abs(self.angle))then
            if ( angle>self.angle) then
                self.angle = self.angle+2*dt
            else 
                self.angle = self.angle-2*dt
            end
        else
            if (math.abs(angle)+math.abs(self.angle)> 2*math.pi - math.abs(angle)-math.abs(self.angle)) then
                if (self.angle>0) then 
                    self.angle = self.angle+2*dt
                else
                    self.angle = self.angle-2*dt
                end
            else 
                if (self.angle>0) then 
                    self.angle = self.angle-2*dt
                else
                    self.angle = self.angle+2*dt
                end
            end
        end
    end
end

function EnergyArmorEffect:draw() 
    if ( Player.Skills.EnergyArmor.isOpened == true) then 
        love.graphics.setLineWidth(2*k)
        love.graphics.setColor(0,1,1,self.value/self.maxValue)
        local curve =  love.math.newBezierCurve(Player.x-(Player.scaleBody/2)*k,Player.y-(Player.scaleBody+2)*k, Player.x,Player.y-(Player.scaleBody+10)*k,Player.x+(Player.scaleBody/2)*k,Player.y-(Player.scaleBody+2)*k) 
        curve:rotate(-self.angle-math.pi/2,Player.x,Player.y)
        curve:scale(self.value/self.maxValue,Player.x,Player.y)
        curve:translate((1-self.value/self.maxValue)*40*k*-1*math.cos(self.angle),(1-self.value/self.maxValue)*40*k*math.sin(self.angle))
        love.graphics.line(curve:render())
        local colorRandom =1 -- math.random()/2*math.random(-1,1)
        love.graphics.setColor(0,0.8+colorRandom,1+colorRandom,self.value/self.maxValue/7)
        love.graphics.circle('fill',Player.x,Player.y,(Player.scaleBody+6)*k)
        love.graphics.setColor(0,0.8+colorRandom,1+colorRandom,self.value/self.maxValue/2)
        
        love.graphics.circle('line',Player.x,Player.y,(Player.scaleBody+6)*k+self.shake*k)
        
        love.graphics.setColor(0,0.8+colorRandom,1+colorRandom,self.value/self.maxValue/4)
        
        love.graphics.circle('line',Player.x,Player.y,(Player.scaleBody+6)*k-2*k+self.shake*k)
        love.graphics.setColor(0,0.8+colorRandom,1+colorRandom,self.value/self.maxValue/6)
        
        love.graphics.circle('line',Player.x,Player.y,(Player.scaleBody+6)*k-4*k+self.shake*k)
    end
end


function gradient(dt)
    if (gradientI == 1 ) then
        gradientOp1(dt)
    end
    if (gradientI  == 2 ) then 
        gradientOp2(dt)
    end
    if (gradientI  == 3 ) then 
        gradientOp3(dt)
    end
    return gradientR+0.8,gradientG+0.8,gradientB+0.8
end
function gradientOp1(dt)
    if ( gradientR>0) then
        gradientR = gradientR - 0.4*dt
        gradientG = gradientG + 0.4*dt
    else
        gradientR = 0
        gradientG = 1
        gradientI = 2
    end
end
function gradientOp2(dt)
    if ( gradientG>0) then
        gradientG = gradientG - 0.4*dt
        gradientB = gradientB + 0.4*dt
    else
        gradientG = 0
        gradientB = 1
        gradientI = 3
    end
end
function gradientOp3(dt)
    if ( gradientB>0) then
        gradientB = gradientB - 0.4*dt
        gradientR = gradientR + 0.4*dt
    else
        gradientB = 0
        gradientR = 1
        gradientI = 1
    end
end

return effects
