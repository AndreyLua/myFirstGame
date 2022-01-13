local bulletFunction = {}

function bulletsUpdate(dt)
    for i = 1, #enemyBullets do
        if ( enemyBullets[i]) then
            bulletsMove(i,dt)
            bulletsBorder(i)
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
            if (en[kek[i]] and en[kek[i]].body and enemyBullets[j] and (math.pow((en[kek[i]].x - (enemyBullets[j].x)),2) + math.pow((en[kek[i]].y - (enemyBullets[j].y)),2))<=math.pow((2*k+math.max(en[kek[i]].w,en[kek[i]].h)/2*k),2))  then
                local bulletBody  =  HC.circle(enemyBullets[j].x,enemyBullets[j].y,2*k)
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
        for i =1, #kek do
            if (obj[kek[i]] and obj[kek[i]].body and enemyBullets[j] and (math.pow((obj[kek[i]].x - (enemyBullets[j].x)),2) + math.pow((obj[kek[i]].y - (enemyBullets[j].y)),2))<=math.pow((2*k+obj[kek[i]].collScale/2*k),2))  then
                local bulletBody  =  HC.circle(enemyBullets[j].x,enemyBullets[j].y,2*k)
                if ( bulletBody:collidesWith(obj[kek[i]].body)) then
                    table.remove(enemyBullets,j)
                end
            end
        end
    end
end

function bulletsCollWithPlayer(index,i)
    local playerIndex =math.floor((player.x-40*k)/(120*k)) + math.floor((player.y-40*k2)/(120*k2))*math.floor((screenWidth/(120*k))+1) 
    if ( index == playerIndex) then 
        bulletsColl(i)
    end
end

    function bulletsColl(i)
        if (player.a == 1) then
            if ((math.pow((player.x-enemyBullets[i].x),2)+math.pow((player.y-enemyBullets[i].y),2)) < math.pow(playerAbility.scaleBody*k,2)) then
                table.remove(enemyBullets,i)
            end
        else
            if ((math.pow((player.x-enemyBullets[i].x),2)+math.pow((player.y-enemyBullets[i].y),2)) < math.pow(playerAbility.scaleBody*k,2)) then
                flaginv = false 
                enAtackPlayer(enemyBullets[i].damage,'r')
                table.remove(enemyBullets,i)
            end
        end      
    end
      
      
      
      
      
    function bulletsBorder(i)
        if not(enemyBullets[i] and  enemyBullets[i].x>camera.x-screenWidth/2-20*k and  enemyBullets[i].x<screenWidth+camera.x-screenWidth/2+20*k+20*k and  enemyBullets[i].y>camera.y-screenHeight/2-20*k2 and enemyBullets[i].y<screenHeight+camera.y-screenHeight/2+20*k2+20*k2) then
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
        love.graphics.setColor(0.8,0.5,0.5,1)
        for i = 1, #enemyBullets do
          love.graphics.circle('line',enemyBullets[i].x,enemyBullets[i].y,2*k)
        end
    end
  
return bulletFunction