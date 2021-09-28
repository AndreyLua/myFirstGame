local bulletFunction = {}

    function bulletsUpdate()
        for i = 1, #enemyBullets do
            if ( enemyBullets[i]) then
                bulletsMove(i)
                bulletsColl(i)
                bulletsBorder(i)
            end
        end
      
    end
    function bulletsColl(i)
        if (player.a == 1) then
            if ( (   math.sqrt(math.pow((player.x+40*k/2-enemyBullets[i].x),2)+math.pow((player.y+40*k2/2-enemyBullets[i].y),2)   )) < 35*k) then
                table.remove(enemyBullets,i)
            end
        else
            if ( (   math.sqrt(math.pow((player.x+40*k/2-enemyBullets[i].x),2)+math.pow((player.y+40*k2/2-enemyBullets[i].y),2)   )) < 20*k) then
                flaginv = false 
                shake = 2
                hp.long = hp.long -enemyBullets[i].damage
                hp.long3  = hp.long
                table.remove(enemyBullets,i)
            end
        end      
    end
      
      
      
      
      
    function bulletsBorder(i)
          if ( enemyBullets[i] and (enemyBullets[i].x<0 or  enemyBullets[i].x>screenWidth or enemyBullets[i].y<0 or enemyBullets[i].y>screenHeight)) then
                table.remove(enemyBullets,i)
          end
    end

    function bulletsMove(i)
        if ( enemyBullets[i]) then
            enemyBullets[i].x = enemyBullets[i].x +  enemyBullets[i].ax*dt2*10
            enemyBullets[i].y = enemyBullets[i].y +  enemyBullets[i].ay*dt2*10 
        end
    end
    
    function bulletsDraw()
        for i = 1, #enemyBullets do
          love.graphics.circle('line',enemyBullets[i].x,enemyBullets[i].y,2*k)
        end
    end
  
return bulletFunction