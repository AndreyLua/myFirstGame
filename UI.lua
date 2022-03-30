local UI = {}

function butChange(x,y,xPoint,maxPointX)
    UIBatch:setColor(1,1,1,1)    
    UIBatch:add(UIQuads.butChange,x,y,-math.pi/2,k/5,k2/5,1340/2, 146/2)
    UIBatch:add(UIQuads.butPoint,x,y+1340*k/5/2-1340*k/5*xPoint/maxPointX,-math.pi/2,k/4,k2/4,120/2, 200/2)
end

function setButtonFlag(xMinRegion,xMaxRegion,yMinRegion,yMaxRegion)
    local flagBut = false
    if ( (mouse.x > xMinRegion) and (mouse.x <xMaxRegion) and (mouse.y >yMinRegion) and (mouse.y < yMaxRegion) ) then
        flagBut = true
    end
    return flagBut
end

function bodyButton(x,y,flag,dopLight)
    if (dopLight) then 
        if (flag) then 
            UIBatch:setColor(1-dopLight,1-dopLight,1-dopLight,0.6-dopLight)
            UIBatch:add(UIQuads.panel,x,y,-math.pi/2,k/4,k2/4,500,120)
            UIBatch:setColor(1,1,1,1) 
        else
            UIBatch:setColor(1-dopLight,1-dopLight,1-dopLight,1-dopLight)
            UIBatch:add(UIQuads.panel,x,y,-math.pi/2,k/4,k2/4,500,120)
            UIBatch:setColor(1,1,1,1) 
        end
    else
        if (flag) then 
            UIBatch:setColor(1,1,1,0.6)
            UIBatch:add(UIQuads.panel,x,y,-math.pi/2,k/4,k2/4,500,120)
            UIBatch:setColor(1,1,1,1) 
        else
            UIBatch:add(UIQuads.panel,x,y,-math.pi/2,k/4,k2/4,500,120)
        end
    end
end

function bodyButtonScale(x,y,flag,scale)
    if (flag) then 
        UIBatch:setColor(1,1,1,0.6)
        UIBatch:add(UIQuads.panel,x,y,-math.pi/2,k*scale,k2*scale,500,120)
        UIBatch:setColor(1,1,1,1) 
    else
        UIBatch:setColor(1,1,1,1)
        UIBatch:add(UIQuads.panel,x,y,-math.pi/2,k*scale,k2*scale,500,120)
    end
end

function bodyTextPanel(x,y)
    UIBatch:add(UIQuads.textPanel,x,y,-math.pi/2,k/3,k2/3,500,160)
end

function bodyButtonDirect(x,y,flag,direct,angle,scale)
    if ( angle == nil) then 
        if ( direct == 'left') then
            if (flag) then 
                UIBatch:setColor(1,1,1,0.6)
                UIBatch:add(UIQuads.butDirect,x,y,-math.pi/4-math.pi/2,k/3,k2/3,90,160)
                UIBatch:setColor(1,1,1,1) 
            else
                UIBatch:add(UIQuads.butDirect,x,y,-math.pi/4-math.pi/2,k/3,k2/3,90,160)
            end
        else
            if (flag) then 
                UIBatch:setColor(1,1,1,0.6)
                UIBatch:add(UIQuads.butDirect,x,y,-math.pi/4-math.pi,k/3,k2/3,90,160)
                UIBatch:setColor(1,1,1,1) 
            else
                UIBatch:add(UIQuads.butDirect,x,y,-math.pi/4-math.pi,k/3,k2/3,90,160)
            end
        end
    else
        if ( direct == 'left') then
            if (flag) then 
                UIBatch:setColor(1,1,1,0.6)
                UIBatch:add(UIQuads.butDirectRotated,x,y,angle,k/4,k2/4,160,160)
                UIBatch:setColor(1,1,1,1) 
            else
                UIBatch:add(UIQuads.butDirectRotated,x,y,angle,k/4,k2/4,160,160)
            end
        else
            if (flag) then 
                UIBatch:setColor(1,1,1,0.6)
                UIBatch:add(UIQuads.butDirectRotated,x,y,angle,k/4,k2/4,160,160)
                UIBatch:setColor(1,1,1,1) 
            else
                UIBatch:add(UIQuads.butDirectRotated,x,y,angle,k/4,k2/4,160,160)
            end
        end
    end
end

function textButton(name,x,y,flag,scale)
    if not(scale) then
        scale = 1 
    end
    local fontWidth = font:getWidth(name)
    local fontHeight = font:getHeight()
    if (flag) then 
        love.graphics.setColor(1,1,1,0.6)
        love.graphics.print(name, x-fontHeight/2*k2*scale,y+fontWidth/2*k*scale,-math.pi/2,k*scale,k2*scale)
        love.graphics.setColor(1,1,1,1)
    else
        love.graphics.print(name, x-fontHeight/2*k2*scale,y+fontWidth/2*k*scale,-math.pi/2,k*scale,k2*scale)
    end
end

function textButtonFixed(nameMas,x,y,flag,scale,state)
    if not(scale) then
        scale = 1 
    end
    local fontWidth = font:getWidth(nameMas[state])
    local fontHeight = font:getHeight()
    if (flag) then
        love.graphics.setColor(1,1,1,0.6)
        love.graphics.print(nameMas[state], x-fontHeight/2*k2*scale,y+fontWidth/2*k*scale,-math.pi/2,k*scale,k2*scale)
        love.graphics.setColor(1,1,1,1)
    else
        love.graphics.print(nameMas[state], x-fontHeight/2*k2*scale,y+fontWidth/2*k*scale,-math.pi/2,k*scale,k2*scale)
    end
end

function acceptBut(x,y,scale,flag) 
    if (flag) then 
        UIBatch:setColor(1,1,1,0.6)
        UIBatch:add(UIQuads.yes,x,y,-math.pi/2,k*scale,k2*scale,120,120)    
        UIBatch:setColor(1,1,1,1)
    else
        UIBatch:add(UIQuads.yes,x,y,-math.pi/2,k*scale,k2*scale,120,120)    
    end
end

function rejectBut(x,y,scale,flag) 
   if (flag) then 
        UIBatch:setColor(1,1,1,0.6)
        UIBatch:add(UIQuads.no,x,y,-math.pi/2,k*scale,k2*scale,120,120)  
        UIBatch:setColor(1,1,1,1)
    else
        UIBatch:add(UIQuads.no,x,y,-math.pi/2,k*scale,k2*scale,120,120)    
    end
end


function rewardSlot(img,x,y,scale,money)
    if (img) then 
        if ( img > 11 ) then 
            img = allSkills[img]
            UIBatch:add(UIQuads.tableSkillLegend,x,y,-math.pi/2,k*scale*1.2,k2*scale*1.2,180,180)      
            skillBatch:add(img,x,y,-math.pi/2,k*scale,k2*scale,160,160)
        else
            if ( img > 7 ) then 
                img = allSkills[img]
                UIBatch:add(UIQuads.tableSkillRare,x,y,-math.pi/2,k*scale*1.2,k2*scale*1.2,180,180)         
                skillBatch:add(img,x,y,-math.pi/2,k*scale,k2*scale,160,160)
            else
                img = allSkills[img]
                UIBatch:add(UIQuads.tableSkillNormal,x,y,-math.pi/2,k*scale*1.2,k2*scale*1.2,160,160)       
                skillBatch:add(img,x,y,-math.pi/2,k*scale,k2*scale,160,160)
            end
        end
    else
        if ( money == 0) then 
            UIBatch:add(UIQuads.tableSkillDestr,x,y,-math.pi/2,k*scale*1.2,k2*scale*1.2,160,160)
        else
            UIBatch:add(UIQuads.tableSkillNormal,x,y,-math.pi/2,k*scale*1.2,k2*scale*1.2,160,160)   
        end
    end    
end
function slot(img,x,y,ox,oy,scale,light)
    if ( light == nil ) then
        light = 1 
    end
    UIBatch:setColor(light,light,light,light)
    skillBatch:setColor(light,light,light,light)
    if (img and playerSkills[img].img ) then
        if ( playerSkills[img].numb  > 11 ) then 
            UIBatch:add(UIQuads.tableSkillLegend,x,y,-math.pi/2,k*scale*1.2,k2*scale*1.2,180,180)       
            skillBatch:add(playerSkills[img].img,x,y,-math.pi/2,k*scale,k2*scale,160,160)
        else
            if ( playerSkills[img].numb  > 7 ) then 
                UIBatch:add(UIQuads.tableSkillRare,x,y,-math.pi/2,k*scale*1.2,k2*scale*1.2,180,180)    
                skillBatch:add(playerSkills[img].img,x,y,-math.pi/2,k*scale,k2*scale,160,160)
            else
                UIBatch:add(UIQuads.tableSkillNormal,x,y,-math.pi/2,k*scale*1.2,k2*scale*1.2,160,160)      
                skillBatch:add(playerSkills[img].img,x,y,-math.pi/2,k*scale,k2*scale,160,160)
            end
        end
        skillBatch:add(playerSkills[img].img,x,y,-math.pi/2,k*scale,k2*scale,ox,oy)
    else
        UIBatch:add(UIQuads.tableSkillNormal,x,y,-math.pi/2,k*scale*1.2,k2*scale*1.2,160,160)       
    end
    UIBatch:setColor(1,1,1,1)
    skillBatch:setColor(1,1,1,1)
end

function noRes(x,y,scale,par,dt,flag)
    if (par~= nil and flag~=nil and par >= 0) then 
        local fontWidth = font:getWidth('Need more resources')
        love.graphics.setColor(1,1,1,par) 
        love.graphics.print('Need more resources', x,y+fontWidth*k2*scale/2,-math.pi/2,k*scale,k2*scale)
        love.graphics.setColor(1,1,1,1)
        if ( par <=3 and flag ==true ) then
            return par+1*dt, flag
        else
            if ( par > 2 and flag ==true ) then 
                return par-1*dt,false
            else
                if (flag ==false and par >=0 ) then 
                    return par-1*dt,false
                end
            end
        end
    end
end

function noFill(par,dt,flag)
    if (par~= nil and flag~=nil and par >= 0) then 
        love.graphics.setColor(1,par,par,1)
        if ( par <=3 and flag ==true ) then
            return par+5*dt, true
        else
            if ( par > 2 and flag ==true ) then 
                return par-5*dt,false
            else
                if (flag ==false and par >=0 ) then 
                    return par-5*dt,false
                end
            end
        end
    end
end

function sc(x,y)
    love.graphics.setLineWidth(2*k)
    love.graphics.setColor(0.731,0.845,0.873)
    love.graphics.rectangle('line',x,y-100*k2,35*k,200*k2)
    love.graphics.setColor(1,1,1,1)
end

function playerHP(dt)
    if ( hp.long/720*100> 100) then
        hp.long = 720
        hp.long2 = 720 
    end
    if (hp.long > hp.long2) then
        hp.long2= hp.long
    end
    if (hp.long<hp.long2 ) then
        hp.long2 = hp.long2-70*dt
    end
    if ( hp.long> hp.long3) then
        hp.long3 = hp.long3+ 100*dt
    else
        hp.long3  = hp.long
    end
    if ( flaginv == false) then
        inv:update(dt)
        inv:every(playerAbility.invTimer, function()
            inv:clear() 
            shake  = 0    
            flaginv =  true
        end)
    end
end

function playerBoost(dt)
    if ( boost.long/720*100 > 100) then
        boost.long = 720
        boost.long2 = 720
    end
    
    if ( boost.long2>boost.long) then
        boost.long2 = boost.long2-70*dt
    end
    if ( boost.long2<boost.long) then
        boost.long2 = boost.long2+playerAbility.boostRegen *dt*2
    end
    
    if ( boost.long <= 30*k2 ) then
        player.a=0
        boost.long =30*k2
    end
    
    if ( player.a==1) then
        boost.long = boost.long - (playerAbility.boostWaste-(playerAbility.boostWaste*playerSkillParametrs.enK))*dt
    else
        boost.long = boost.long + playerAbility.boostRegen *dt
    end
    if  (boost.long>720) then
        boost.long = 720
        if (playerSkillParametrs.tradeFlag == true and hp.long<720 and flaginv == true) then 
            newTradeEffect()
            hp.long = hp.long +10*dt
        end
    end
end

function playerBoostDop(dt)
    if ( playerSkillParametrs.dopEnFlag == true) then 
        angleBoostDop(dt,controler.angle)
        if ( boostDop.long/720*100 > 100) then
            boostDop.long = 720
        end
        if (boostDop.recovery == boostDop.recoveryTimer) then 
            boostDop.long = boostDop.long + playerAbility.boostRegen/1.5 *dt*k
            boostDop.shakeK = 0
        end
        if ( boostDop.long <= 0 ) then
            boostDop.long =0
        end
        if  (boostDop.long>720) then
            boostDop.long = 720
        end
        boostDop.shake = math.random()*math.random(-1,1)*boostDop.shakeK
        if ( boostDop.shakeK > 1 ) then 
            boostDop.shakeK  = boostDop.shakeK - 10 *dt
        end
        
        if ( boostDop.recovery < boostDop.recoveryTimer) then 
            boostDop.recovery =boostDop.recovery - 3*dt
            if ( boostDop.recovery < 0 )then 
                boostDop.recovery = boostDop.recoveryTimer
            end
        end
    else
        boostDop.long = 0 
    end
end


function angleBoostDop (dt,angle) 
    if ( boostDop.angle == 0) then
        boostDop.angle=0.00000001
    end
    if ( boostDop.angle < -math.pi) then
        boostDop.angle=math.pi
    end
    if ( boostDop.angle > math.pi) then
        boostDop.angle=-math.pi
    end
    if ( angle == 0) then
        angle=0.00000001
    end
    if ((angle -  boostDop.angle > 2.1*dt) or (angle -  boostDop.angle) <  -2.1*dt ) then
        if (angle/math.abs(angle)==boostDop.angle/math.abs(boostDop.angle))then
            if ( angle>boostDop.angle) then
                boostDop.angle = boostDop.angle+2*dt
            else 
                boostDop.angle = boostDop.angle-2*dt
            end
        else
            if (math.abs(angle)+math.abs(boostDop.angle)> 2*math.pi - math.abs(angle)-math.abs(boostDop.angle)) then
                if (boostDop.angle>0) then 
                    boostDop.angle = boostDop.angle+2*dt
                else
                    boostDop.angle = boostDop.angle-2*dt
                end
            else 
                if (boostDop.angle>0) then 
                    boostDop.angle = boostDop.angle-2*dt
                else
                    boostDop.angle = boostDop.angle+2*dt
                end
            end
        end
    end
end
        
function Health_Boost()
    love.graphics.setColor(0.02,0.3,0.02,1)
    love.graphics.rectangle("fill",player.x-(playerAbility.scaleBody+17)*k,player.y+720/11*k/2,4*k2,-720/11*k)
    love.graphics.setColor(0.19,1,0.19,1)
    love.graphics.rectangle("fill",player.x-(playerAbility.scaleBody+17)*k,player.y+720/11*k/2,4*k2,(-hp.long2/720*720/11)*k)
    love.graphics.setColor(0.02,0.6,0.02,1)
    love.graphics.rectangle("fill",player.x-(playerAbility.scaleBody+17)*k,player.y+720/11*k/2,4*k2,(-hp.long3/720*720/11)*k)

    love.graphics.setColor(0,0.32,0.225,1)
    love.graphics.rectangle("fill",player.x-(playerAbility.scaleBody+11)*k,player.y+720/11*k/2,3*k2,-720/11*k)
    love.graphics.setColor(0.15,1,0.9,1)
    love.graphics.rectangle("fill",player.x-(playerAbility.scaleBody+11)*k,player.y+720/11*k/2,3*k2,(-boost.long2/720*720/11)*k)
    love.graphics.setColor(0,0.643,0.502,1)
    love.graphics.rectangle("fill",player.x-(playerAbility.scaleBody+11)*k,player.y+720/11*k/2,3*k2,(-boost.long/720*720/11)*k)     
   
    if ( playerSkillParametrs.dopEnFlag == true) then 
        love.graphics.setLineWidth(2*k)
        love.graphics.setColor(0,1,1,boostDop.long/720)
        local kek1 =  love.math.newBezierCurve(player.x-(playerAbility.scaleBody/2)*k,player.y-(playerAbility.scaleBody+2)*k, player.x,player.y-(playerAbility.scaleBody+10)*k,player.x+(playerAbility.scaleBody/2)*k,player.y-(playerAbility.scaleBody+2)*k) 
        kek1:rotate(-boostDop.angle-math.pi/2,player.x,player.y)
        kek1:scale(boostDop.long/720,player.x,player.y)
        kek1:translate((1-boostDop.long/720)*40*k*-1*math.cos(boostDop.angle),(1-boostDop.long/720)*40*k*math.sin(boostDop.angle))
        love.graphics.line(kek1:render())
        local colorRandom =1 -- math.random()/2*math.random(-1,1)
        --boostDop.shake = 0
        love.graphics.setColor(0,0.8+colorRandom,1+colorRandom,boostDop.long/720/7)
        love.graphics.circle('fill',player.x,player.y,(playerAbility.scaleBody+6)*k)
        love.graphics.setColor(0,0.8+colorRandom,1+colorRandom,boostDop.long/720/2)
        
        love.graphics.circle('line',player.x,player.y,(playerAbility.scaleBody+6)*k+boostDop.shake*k)
        
        love.graphics.setColor(0,0.8+colorRandom,1+colorRandom,boostDop.long/720/4)
        
        love.graphics.circle('line',player.x,player.y,(playerAbility.scaleBody+6)*k-2*k+boostDop.shake*k)
        love.graphics.setColor(0,0.8+colorRandom,1+colorRandom,boostDop.long/720/6)
        
        love.graphics.circle('line',player.x,player.y,(playerAbility.scaleBody+6)*k-4*k+boostDop.shake*k)
    end
  
    love.graphics.setColor(1,1,1,1)
end

function add()
  local x = 0
  local y = 0 
  if (mouse.x > 0 and  mouse.x <60*k and mouse.y > 0 and  mouse.y <60 *k2 and ((flagtouch==true and flagtouch1== true) or flagtouch2 == true or flagtouch3 == true) )  then
      UIBatch:setColor(1,1,1,0.6)
      UIBatch:add(UIQuads.add,x+120/4*k2,y+125/4*k,-math.pi/2,k/4,k2/4,120, 125)
      UIBatch:setColor(1,1,1,1)
  else
      UIBatch:setColor(1,1,1,1)
      UIBatch:add(UIQuads.add,x+120/4*k2,y+125/4*k,-math.pi/2,k/4,k2/4,120, 125)
  end
  love.graphics.setColor(1,1,1,1)
end

function exit()
  local x = 0
  local y = 0 
  if (mouse.x > 0 and  mouse.x <60*k and mouse.y > 0 and  mouse.y <60 *k2 and ((flagtouch==true and flagtouch1== true) or flagtouch2 == true or flagtouch3 == true) )  then
      UIBatch:setColor(1,1,1,0.6)
      UIBatch:add(UIQuads.ex,x+120/4*k2,y+125/4*k,-math.pi/2,k/4,k2/4,120, 125)
      UIBatch:setColor(1,1,1,1)
  else
      UIBatch:setColor(1,1,1,1)
      UIBatch:add(UIQuads.ex,x+120/4*k2,y+125/4*k,-math.pi/2,k/4,k2/4,120, 125)
  end
  love.graphics.setColor(1,1,1,1)
end

function lineW()
    love.graphics.setColor(0.431,0.545,0.573)
    love.graphics.rectangle("line",50*k,screenHeight/2-(colWave*250*k2/waves[2])/2,8*k,colWave*250*k2/waves[2])
    love.graphics.setColor(1,1,1,1)
end 

return UI