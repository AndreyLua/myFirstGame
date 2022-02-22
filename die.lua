local die = {}
local timer = 150

function die:update(dt)
    timer = timer -30 *dt
    if (timer < 0) then
        timer = 150
        game:init()
        gamestate.switch(game)
    end
end
function die:draw()
    love.graphics.setColor(1,1,1,timer/200+0.3)
        love.graphics.draw(kek,0,0,0,1,1)  
    love.graphics.setColor(1,1,1,1)
    local fontWidth = font:getWidth('You die')
    love.graphics.print("You die",screenWidth/3,screenHeight/2+fontWidth/2*k,-math.pi/2,k,k)
end


return die