local bulletFunction = {}

    function bulletsUpdate(dt)
        for i = 1, #enemyBullets do
            if ( enemyBullets[i]) then
                bulletsMove(i,dt)
                bulletsColl(i)
                bulletsBorder(i)
            end
        end
      
    end
    function bulletsColl(i)
        if (player.a == 1) then
            if ( (   math.sqrt(math.pow((player.x-enemyBullets[i].x),2)+math.pow((player.y-enemyBullets[i].y),2)   )) <playerAbility.scaleBody*k) then
                table.remove(enemyBullets,i)
            end
        else
            if ( (   math.sqrt(math.pow((player.x-enemyBullets[i].x),2)+math.pow((player.y-enemyBullets[i].y),2)   )) < playerAbility.scaleBody*k) then
                flaginv = false 
                shake = 2
                hp.long = hp.long -enemyBullets[i].damage
                hp.long3  = hp.long
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
        for i = 1, #enemyBullets do
          love.graphics.circle('line',enemyBullets[i].x,enemyBullets[i].y,2*k)
        end
    end
  
return bulletFunction