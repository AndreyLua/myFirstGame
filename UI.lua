local UI = {}


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
                UIBatch:add(UIQuads.butDirect,x,y,angle,k/4,k2/4,90,160)
                UIBatch:setColor(1,1,1,1) 
            else
                UIBatch:add(UIQuads.butDirect,x,y,angle,k/4,k2/4,90,160)
            end
        else
            if (flag) then 
                UIBatch:setColor(1,1,1,0.6)
                UIBatch:add(UIQuads.butDirect,x,y,angle,k/4,k2/4,90,160)
                UIBatch:setColor(1,1,1,1) 
            else
                UIBatch:add(UIQuads.butDirect,x,y,angle,k/4,k2/4,90,160)
            end
        end
    end
end

function textButton(name,x,y,flag,scale)
    if not(scale) then
        scale = 1 
    end
    local fontWidth = font:getWidth(name)
    local fontHeight = font:getHeight(name)
    if (flag) then 
        love.graphics.setColor(1,1,1,0.6)
        love.graphics.print(name, x-fontHeight/1.9*k2*scale,y+fontWidth/2*k*scale,-math.pi/2,k*scale,k2*scale)
        love.graphics.setColor(1,1,1,1)
    else
        love.graphics.print(name, x-fontHeight/1.9*k2*scale,y+fontWidth/2*k*scale,-math.pi/2,k*scale,k2*scale)
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
        UIBatch:add(UIQuads.tableSkill,x,y,-math.pi/2,k*scale*1.2,k2*scale*1.2,160,160)       
        skillBatch:add(img,x,y,-math.pi/2,k*scale,k2*scale,160,160)
    else
        if ( money == 0) then 
            UIBatch:add(UIQuads.tableSkillDestr,x,y,-math.pi/2,k*scale*1.2,k2*scale*1.2,160,160)
        else
            UIBatch:add(UIQuads.tableSkill,x,y,-math.pi/2,k*scale*1.2,k2*scale*1.2,160,160)   
        end
    end    
end
function slot(img,x,y,ox,oy,scale,light)
    if ( light == nil ) then
        light = 1 
    end

    UIBatch:setColor(light,light,light,light)
    skillBatch:setColor(light,light,light,light)
    if (img) then 
        UIBatch:add(UIQuads.tableSkill,x,y,-math.pi/2,k*scale*1.2,k2*scale*1.2,160,160)       
        skillBatch:add(img,x,y,-math.pi/2,k*scale,k2*scale,ox,oy)
    else
        UIBatch:add(UIQuads.tableSkill,x,y,-math.pi/2,k*scale*1.2,k2*scale*1.2,160,160)       
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

function sc(x,y)
    love.graphics.setLineWidth(2*k)
    love.graphics.setColor(0.731,0.845,0.873)
    love.graphics.rectangle('line',x,y-100*k2,35*k,200*k2)
    love.graphics.setColor(1,1,1,1)
end

function playerHP(dt)
    if ( hp.long/screenHeight*100> 100) then
        hp.long = screenHeight
        hp.long2 = screenHeight 
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
    if ( boost.long/screenHeight*100 > 100) then
        boost.long = screenHeight
        boost.long2 = screenHeight
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
    if  (boost.long>screenHeight) then
        boost.long = screenHeight
    end
end

function playerBoostDop(dt)
    if ( boostDop.long/screenHeight*100 > 100) then
        boostDop.long = screenHeight
        boostDop.long2 = screenHeight
    end
    
    if ( boostDop.long2>boostDop.long) then
        boostDop.long2 = boostDop.long2-70*dt
    end
    if ( boostDop.long2<boostDop.long) then
        boostDop.long2 = boostDop.long2+playerAbility.boostRegen *dt*2
    end
    
    if ( boostDop.long <= 0 ) then
        boostDop.long =0
    end
    
    if ( player.a==1) then
        boostDop.long = boostDop.long - (playerAbility.boostWaste-(playerAbility.boostWaste*playerSkillParametrs.enK))*dt
    else
       boostDop.long = boostDop.long + playerAbility.boostRegen *dt
    end
    if  (boostDop.long>screenHeight) then
        boostDop.long = screenHeight
    end
end

function Health_Boost()
    love.graphics.setColor(0.02,0.3,0.02,1)
    love.graphics.rectangle("fill",player.x-(playerAbility.scaleBody+15)*k,player.y+31*k2,3*k2,-screenHeight/7)
    love.graphics.setColor(0.04,0.85,0.04,1)
    love.graphics.rectangle("fill",player.x-(playerAbility.scaleBody+15)*k,player.y+31*k2,3*k2,-hp.long2/7)
    love.graphics.setColor(0.02,0.6,0.02,1)
    love.graphics.rectangle("fill",player.x-(playerAbility.scaleBody+15)*k,player.y+31*k2,3*k2,-hp.long3/7)
    
    love.graphics.setColor(0,0.32,0.225,1)
    love.graphics.rectangle("fill",player.x-(playerAbility.scaleBody+10)*k,player.y+31*k2,2*k2,-screenHeight/7)
    love.graphics.setColor(0,0.85,0.75,1)
    love.graphics.rectangle("fill",player.x-(playerAbility.scaleBody+10)*k,player.y+31*k2,2*k2,-boost.long2/7)
    love.graphics.setColor(0,0.643,0.502,1)
    love.graphics.rectangle("fill",player.x-(playerAbility.scaleBody+10)*k,player.y+31*k2,2*k2,-boost.long/7)     
    ---skill
    --love.graphics.setColor(1,1,0.4,1)
    --love.graphics.rectangle("fill",player.x-(playerAbility.scaleBody+10)*k,player.y+31*k2,2*k2,-boostDop.long2/7)
    --love.graphics.setColor(0.9,0.9,0,1)
    --love.graphics.rectangle("fill",player.x-(playerAbility.scaleBody+10)*k,player.y+31*k2,2*k2,-boostDop.long/7) 
    --skill
    love.graphics.setColor(1,1,1,1)
end

function exit(x,y)
  if (mouse.x > 0 and  mouse.x <60*k and mouse.y > 0 and  mouse.y <60 *k2 and ((flagtouch==true and flagtouch1== true) or flagtouch2 == true or flagtouch3 == true) )  then
      UIBatch:setColor(1,1,1,0.6)
      UIBatch:add(UIQuads.add,x+120/4*k2,y+125/4*k,-math.pi/2,k/4,k2/4,120, 125)
      UIBatch:setColor(1,1,1,1)
  else
      UIBatch:add(UIQuads.add,x+120/4*k2,y+125/4*k,-math.pi/2,k/4,k2/4,120, 125)
  end
  love.graphics.setColor(1,1,1,1)
end

function lineW()
    love.graphics.setColor(0.431,0.545,0.573)
    love.graphics.rectangle("line",50*k,screenHeight/2-(colWave*250*k2/waves[2])/2,8*k,colWave*250*k2/waves[2])
    love.graphics.setColor(1,1,1,1)
end 

return UI