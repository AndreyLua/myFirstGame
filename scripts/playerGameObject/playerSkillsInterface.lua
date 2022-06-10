local playerSkillsInterface = {}

function Player.Skills.Hp.Interface:print(x,y,scale)
    love.graphics.print("HP "..tostring(math.ceil(Player.Skills.Hp.value/(Player.Skills:getStartValue(Player.Skills.Hp))*100)).."%",x,y,-3.14/2,scale*k,scale*k)
end

function Player.Skills.Energy.Interface:print(x,y,scale)
    love.graphics.print("EN "..tostring(math.ceil(Player.Skills.Energy.value/Player.Skills:getStartValue(Player.Skills.Energy)*100)).."%",x,y,-3.14/2,scale*k,scale*k)
end

function Player.Skills.MeleeDefense.Interface:print(x,y,scale)
    love.graphics.print("RES "..tostring(math.ceil(Player.Skills.MeleeDefense.value*100)).."%",x,y,-3.14/2,scale*k,scale*k)
end

function Player.Skills.RangeDefense.Interface:print(x,y,scale)
    love.graphics.print("RES "..tostring(math.ceil(Player.Skills.RangeDefense.value*100)).."%",x,y,-3.14/2,scale*k,scale*k)
end

function Player.Skills.Damage.Interface:print(x,y,scale)
    love.graphics.print("AT "..tostring(math.ceil(Player.Skills.Damage.value/Player.Skills:getStartValue(Player.Skills.Damage)*100)).."%",x,y,-3.14/2,scale*k,scale*k)
end

function Player.Skills.Speed.Interface:print(x,y,scale)
     love.graphics.print("SP "..tostring(math.ceil(Player.Skills.Speed.value/Player.Skills:getStartValue(Player.Skills.Speed)*100)).."%",x,y,-3.14/2,scale*k,scale*k)
end

function Player.Skills.Collect.Interface:print(x,y,scale)
    love.graphics.print("RAN "..tostring(math.ceil(Player.Skills.Collect.value/Player.Skills:getStartValue(Player.Skills.Collect)*100)).."%",x,y,-3.14/2,scale*k,scale*k)
end

function Player.Skills.SpikeArmor.Interface:print(x,y,scale)
    love.graphics.print("REF "..tostring(math.ceil(Player.Skills.SpikeArmor.value/Player.Skills:getStartValue(Player.Skills.SpikeArmor)*100)).."%",x,y,-3.14/2,scale*k,scale*k)
end

function Player.Skills.EnergyArmor.Interface:print(x,y,scale)
    love.graphics.print("EN "..tostring(math.ceil(Player.Skills.EnergyArmor.value/Player.Skills:getStartValue(Player.Skills.EnergyArmor)*100)).."%",x,y,-3.14/2,scale*k,scale*k)
end

function Player.Skills.Trade.Interface:print(x,y,scale)
    love.graphics.print("SW "..tostring(math.ceil(Player.Skills.Trade.value/Player.Skills:getStartValue(Player.Skills.Trade)*100)).."%",x,y,-3.14/2,scale*k,scale*k)
end  

function Player.Skills.SpecialAtack.Wave.Interface:print(x,y,scale)
    love.graphics.print("AT "..tostring(math.ceil(Player.Skills.SpecialAtack.Wave.value/Player.Skills:getStartValue(Player.Skills.SpecialAtack.Wave)*100)).."%",x,y,-3.14/2,scale*k,scale*k)
end  

function Player.Skills.SpecialAtack.Bloody.Interface:print(x,y,scale)
    love.graphics.print("AT "..tostring(math.ceil(Player.Skills.SpecialAtack.Bloody.value/Player.Skills:getStartValue(Player.Skills.SpecialAtack.Bloody)*100)).."%",x,y,-3.14/2,scale*k,scale*k)
end  

function Player.Skills.SpecialAtack.Electric.Interface:print(x,y,scale)
    love.graphics.print("AT "..tostring(math.ceil(Player.Skills.SpecialAtack.Electric.value/Player.Skills:getStartValue(Player.Skills.SpecialAtack.Electric)*100)).."%",x,y,-3.14/2,scale*k,scale*k)
end  

function Player.Skills.SpecialAtack.Vampir.Interface:print(x,y,scale)
    love.graphics.print("VP "..tostring(math.ceil(Player.Skills.SpecialAtack.Vampir.value/Player.Skills:getStartValue(Player.Skills.SpecialAtack.Vampir)*100)).."%",x,y,-3.14/2,scale*k,scale*k)
end  

return playerSkillsInterface