local bulletFunction = {}

function bulletsUpdate(dt)
    for i = 1, #enemyBullets do
        if ( enemyBullets[i]) then
            if (enemyBullets[i].pre) then 
                if ( enemyBullets[i].scale < enemyBullets[i].normalScale ) then
                    enemyBullets[i].scale  = enemyBullets[i].scale + 30*dt
                else
                    local ugol = math.atan2(Player.x- enemyBullets[i].x,Player.y- enemyBullets[i].y)
                    local bullet = {
                        en = enemyBullets[i].en,
                        x = enemyBullets[i].x,
                        y = enemyBullets[i].y,
                        ax = 22*k*math.sin(ugol),
                        ay = 22*k2*math.cos(ugol),
                        damage = enemyBullets[i].damage,
                        scale = enemyBullets[i].normalScale,
                    }
                    enemyBullets[i] = bullet
                end
            else
                bulletsMove(i,dt)
                bulletsBorder(i)
            end
            if ( enemyBullets[i]) then
                local index = IndexBulletInRegulS(120,i)
                bulletsCollWithPlayer(index,i)
                bulletsCollWithPlayer(index-1,i)
                bulletsCollWithPlayer(index+1,i)
                bulletsCollWithPlayer(index-math.floor((screenWidth/(120*k))+1),i)
                bulletsCollWithPlayer(index+math.floor((screenWidth/(120*k))+1),i)
                bulletsCollWithPlayer(index+math.floor((screenWidth/(120*k))+1)+1,i)
                bulletsCollWithPlayer(index+math.floor((screenWidth/(120*k))+1)-1,i)
                bulletsCollWithPlayer(index-math.floor((screenWidth/(120*k))+1)+1,i)
                bulletsCollWithPlayer(index-math.floor((screenWidth/(120*k))+1)-1,i)
            end
            if ( enemyBullets[i]) then
                local index = IndexBulletInRegulS(120,i)
                bulletsCollWithObj(index,dt,i)
                bulletsCollWithObj(index-1,dt,i)
                bulletsCollWithObj(index+1,dt,i)
                bulletsCollWithObj(index-math.floor((screenWidth/(120*k))+1),dt,i)
                bulletsCollWithObj(index+math.floor((screenWidth/(120*k))+1),dt,i)
                bulletsCollWithObj(index+math.floor((screenWidth/(120*k))+1)+1,dt,i)
                bulletsCollWithObj(index+math.floor((screenWidth/(120*k))+1)-1,dt,i)
                bulletsCollWithObj(index-math.floor((screenWidth/(120*k))+1)+1,dt,i)
                bulletsCollWithObj(index-math.floor((screenWidth/(120*k))+1)-1,dt,i)
            end
        end
    end
end

function IndexBulletInRegulS(scaleS,i)
    return math.floor((enemyBullets[i].x-scaleS/2*k)/(scaleS*k)) + math.floor((enemyBullets[i].y-scaleS/2*k2)/(scaleS*k2))*math.floor((screenWidth/(scaleS*k))+1)
end
function bulletsCollWithEn(index,dt,j)
    if ( enRegulS[index]) then 
        local kek = enRegulS[index]
        for i =1, #kek do
            if (en[kek[i]] and en[kek[i]].body and enemyBullets[j] and (math.pow((en[kek[i]].x - (enemyBullets[j].x)),2) + math.pow((en[kek[i]].y - (enemyBullets[j].y)),2))<=math.pow((enemyBullets[j].scale*k+math.max(en[kek[i]].w,en[kek[i]].h)/2*k),2))  then
                local bulletBody  =  HC.circle(enemyBullets[j].x,enemyBullets[j].y,enemyBullets[j].scale*k)
                if ( bulletBody:collidesWith(en[kek[i]].body)) then
                    table.remove(enemyBullets,j)
                end
            end
        end
    end
end

function bulletsCollWithObj(index,dt,j)
    if ( objRegulS[index]) then 
        local kek = objRegulS[index]
        for i =#kek , 1,-1 do
            if (obj[kek[i]] and obj[kek[i]].body and enemyBullets[j] and (math.pow((obj[kek[i]].x - (enemyBullets[j].x)),2) + math.pow((obj[kek[i]].y - (enemyBullets[j].y)),2))<=math.pow((enemyBullets[j].scale*k+obj[kek[i]].collScale/2*k),2))  then
                local bulletBody  =  HC.circle(enemyBullets[j].x,enemyBullets[j].y,enemyBullets[j].scale*k)
                if ( bulletBody:collidesWith(obj[kek[i]].body)) then
                    if ( enemyBullets[j].scale < 5) then 
                        table.remove(enemyBullets,j)
                    else 
                        obj[kek[i]].health = -1
                    end
                end
            end
        end
    end
end

function bulletsCollWithPlayer(index,i)
    local playerIndex =math.floor((Player.x-40*k)/(120*k)) + math.floor((Player.y-40*k2)/(120*k2))*math.floor((screenWidth/(120*k))+1) 
    if ( index == playerIndex) then 
        bulletsColl(i)
    end
end

    function bulletsColl(i)
        if (Player.a == 1) then
            if ((math.pow((Player.x-enemyBullets[i].x),2)+math.pow((Player.y-enemyBullets[i].y),2)) < math.pow(Player.scaleBody*k+enemyBullets[i].scale*k,2)) then
                table.remove(enemyBullets,i)
            end
        else
            if ((math.pow((Player.x-enemyBullets[i].x),2)+math.pow((Player.y-enemyBullets[i].y),2)) < math.pow(Player.scaleBody*k+enemyBullets[i].scale*k,2)) then
                Player:takeDamage(enemyBullets[i].damage,'r',enemyBullets[i].en)
                table.remove(enemyBullets,i)
            end
        end      
    end
      
      
      
      
      
    function bulletsBorder(i)
        if not(enemyBullets[i] and  enemyBullets[i].x>Player.Camera.x-screenWidth/2-20*k and  enemyBullets[i].x<screenWidth+Player.Camera.x-screenWidth/2+20*k+20*k and  enemyBullets[i].y>Player.Camera.y-screenHeight/2-20*k2 and enemyBullets[i].y<screenHeight+Player.Camera.y-screenHeight/2+20*k2+20*k2) then
            table.remove(enemyBullets,i)
        end
    end

    function bulletsMove(i,dt)
        if ( enemyBullets[i]) then
            enemyBullets[i].x = enemyBullets[i].x +  enemyBullets[i].ax*dt*10
            enemyBullets[i].y = enemyBullets[i].y +  enemyBullets[i].ay*dt*10 
        end
    end
    
    function bulletsDraw()
        enBatch:setColor(1,1,1,1)
        for i = 1, #enemyBullets do
            if (enemyBullets[i].scale < 5) then 
                enBatch:add(enQuads.bulletShooter,enemyBullets[i].x,enemyBullets[i].y,0,k/15*enemyBullets[i].scale,k2/15*enemyBullets[i].scale,25, 25)
            else
                enBatch:add(enQuads.bulletInvader,enemyBullets[i].x,enemyBullets[i].y,0,k/50*enemyBullets[i].scale,k2/50*enemyBullets[i].scale,65, 65)
            end
          
        --    love.graphics.circle('line',enemyBullets[i].x,enemyBullets[i].y,enemyBullets[i].scale*k)
        end
    end
  
return bulletFunction