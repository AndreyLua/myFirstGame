local playerFunction = {} 

function lvlplayer()
    if ( lvl == 0) then
        if ( player.a == 0 )then
            player.body = HC.circle(player.x+40*k/2,player.y+40*k2/2,20*k)
        else
            player.body =HC.circle(player.x+40*k/2,player.y+40*k2/2,35*k)
        end
    end
    if ( lvl == 1) then
        player.body = HC.circle(player.x+40*k/2,player.y+40*k/2,26*k)
    end
    if ( lvl == 2) then 
        player.body = HC.rectangle(player.x,player.y,45*k,45*k2)
    end
end

function playerControl()
    mouse.x,mouse.y=love.mouse.getPosition()
    mouse.x = mouse.x/sx
    mouse.y = mouse.y/sy
    if ( love.mouse.isDown(1) ) then
        if ( controler.flag == false and mouse.x > screenWidth / 9) then 
            controler.x0 = mouse.x
            controler.y0 = mouse.y
            controler.flag = true
        end
        if ( controler.flag == true and mouse.x > screenWidth / 9) then 
            controler.x = mouse.x -   controler.x0
            controler.y = mouse.y -   controler.y0
            player.aa = 3
            player.a = 0
            if ( math.abs(controler.x) >1*k or math.abs(controler.y)>1*k2) then
                controler.angle = math.atan2(controler.x,controler.y)
            end  
            if (( math.abs(controler.x) >1*k or math.abs(controler.y)>1*k2)) then
                player.ax  = math.sin(controler.angle)*k*math.abs(controler.x*screenWidth/screenHeight/3.5)
                player.ay  = math.cos(controler.angle)*k2*math.abs(controler.y*screenWidth/screenHeight/3.5)
                if ( player.ax > 27*k) then
                    player.ax = 27*k 
                end
                if ( player.ax < -27*k) then
                    player.ax = -27*k 
                end
                if ( player.ay > 27*k2) then
                    player.ay = 27*k2 
                end
                if ( player.ay < -27*k2) then
                    player.ay = -27*k2 
                end
            end
        else
            controler.flag = true
        end
    else
        controler.flag =false
    end
    
    if (( flagclass =='slicer' and player.a ==0 and #love.touch.getTouches()>1 and boost.flag == true) or (love.keyboard.isDown('t')  and boost.flag == true ) ) then
        player.a = 1 
    end
end


function Health_Boost()
    love.graphics.setColor(0.64,0,0.02)
    love.graphics.rectangle("line",screenWidth-40*k+10*k,screenHeight-(hp.long2-20*k2)/2-10*k2,25*k,(hp.long2-20*k2)/2,5)
    love.graphics.setColor(1,0,0.02)
    love.graphics.rectangle("line",screenWidth-40*k+10*k,screenHeight-(hp.long2-20*k2)/2-10*k2,25*k,(hp.long-20*k2)/2,5)
    love.graphics.setColor(0,0.32,0.225)
    love.graphics.rectangle("line",screenWidth-40*k+10*k,-(boost.long2-20*k2)/2+screenHeight/2-10*k2,25*k,(boost.long2-20*k2)/2,5)
    love.graphics.setColor(0,0.643,0.502)
    love.graphics.rectangle("line",screenWidth-40*k+10*k,-(boost.long-20*k2)/2+screenHeight/2-10*k2,25*k,(boost.long-20*k2)/2,5)
end


return playerFunction