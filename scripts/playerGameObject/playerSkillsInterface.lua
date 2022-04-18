local playerSkillsInterface = {}

function Player.Skills.Hp.Interface:print(x,y,scale)
    love.graphics.print("HP "..tostring(math.ceil(100/(1-Player.Skills.Hp.value))).."%",x,y,-3.14/2,scale*k,scale*k)
end

function Player.Skills.Energy.Interface:print(x,y,scale)
    love.graphics.print("EN "..tostring(math.ceil(100/(1-Player.Skills.Energy.value))).."%",x,y,-3.14/2,scale*k,scale*k)
end

function Player.Skills.MeleeDefense.Interface:print(x,y,scale)
    love.graphics.print("RES "..tostring(math.ceil(100*(Player.Skills.MeleeDefense.value))).."%",x,y,-3.14/2,scale*k,scale*k)
end

function Player.Skills.RangeDefense.Interface:print(x,y,scale)
    love.graphics.print("RES "..tostring(math.ceil(100*(Player.Skills.RangeDefense.value))).."%",x,y,-3.14/2,scale*k,scale*k)
end

function Player.Skills.Damage.Interface:print(x,y,scale)
    love.graphics.print("AT "..tostring(math.ceil(100*(Player.Skills.Damage.value))).."%",x,y,-3.14/2,scale*k,scale*k)
end

function Player.Skills.Speed.Interface:print(x,y,scale)
     love.graphics.print("SP "..tostring(math.ceil(100*(Player.Skills.Speed.value))).."%",x,y,-3.14/2,scale*k,scale*k)
end

function Player.Skills.Collect.Interface:print(x,y,scale)
    love.graphics.print("RAN "..tostring(math.ceil(100*(Player.Skills.Collect.value))).."%",x,y,-3.14/2,scale*k,scale*k)
end

function Player.Skills.SpikeArmor.Interface:print(x,y,scale)
    love.graphics.print("REF "..tostring(math.ceil(100*(Player.Skills.SpikeArmor.value))).."%",x,y,-3.14/2,scale*k,scale*k)
end

function Player.Skills.EnergyArmor.Interface:print(x,y,scale)
    love.graphics.print("EN "..tostring(math.ceil(100*(Player.Skills.EnergyArmor.value))).."%",x,y,-3.14/2,scale*k,scale*k) 
end

function Player.Skills.Trade.Interface:print(x,y,scale)
    love.graphics.print("SW "..tostring(math.ceil(100*(Player.Skills.Trade.value))).."%",x,y,-3.14/2,scale*k,scale*k)
end  

function Player.Skills.SpecialAtack.Wave.Interface:print(x,y,scale)
    love.graphics.print("AT "..tostring(math.ceil(100*(Player.Skills.SpecialAtack.Wave.value))).."%",x,y,-3.14/2,scale*k,scale*k)
end  

function Player.Skills.SpecialAtack.Bloody.Interface:print(x,y,scale)
    love.graphics.print("AT "..tostring(math.ceil(100*(Player.Skills.SpecialAtack.Bloody.value))).."%",x,y,-3.14/2,scale*k,scale*k)
end  

function Player.Skills.SpecialAtack.Electric.Interface:print(x,y,scale)
    love.graphics.print("AT "..tostring(math.ceil(100*(Player.Skills.SpecialAtack.Electric.value))).."%",x,y,-3.14/2,scale*k,scale*k)
end  

function Player.Skills.SpecialAtack.Vampir.Interface:print(x,y,scale)
    love.graphics.print("VP "..tostring(math.ceil(100*(Player.Skills.SpecialAtack.Vampir.value))).."%",x,y,-3.14/2,scale*k,scale*k)
end  

return playerSkillsInterface