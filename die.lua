local die = {}
local timer = 100

function die:update(dt)
    timer = timer -30 *dt
    if (timer < 0) then
        timer = 100
        game:init()
        gamestate.switch(game)
    end
end
function die:draw()
    love.graphics.setColor(1,1,1,timer/150+0.6)
        love.graphics.draw(kek,0,0,0,1,1)  
    love.graphics.setColor(1,1,1,1)
end


return die