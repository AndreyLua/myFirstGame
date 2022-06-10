local playerSkills = {}

local playerFunction = require "scripts/playerGameObject/playerFunction"

function Player.Skills:skillsTable(tableSkills)
    for skillIndex, skill in pairs(self) do
        if ( type(skill)=='table') then 
            if (skill.isOpened~=nil) then 
                if (skill.isOpened == true) then
                    table.insert(tableSkills,skill)
                end
            else
                for atackSkillIndex, atackSkill in pairs(skill) do
                    if (atackSkill.isOpened == true) then
                        table.insert(tableSkills,atackSkill)
                    end
                end
            end
        end
    end
end

function Player.Skills:sortSkillsTable(table)
    for i =1,#table do
        for j =1,#table-i do
            if (table[j].number > table[j+1].number) then 
                table[j],table[j+1]=table[j+1],table[j]
            end
        end
    end
end

function Player.Skills:raritySkills(tableSkills,rare)
    for skillIndex, skill in pairs(self) do
        if ( type(skill)=='table') then 
            if (skill.rare~=nil) then  
                if (skill.rare==rare) then 
                    table.insert(tableSkills,skill)
                end
            else
                for atackSkillIndex, atackSkill in pairs(skill) do
                    if (atackSkill.rare==rare) then 
                        table.insert(tableSkills,atackSkill)
                    end
                end
            end
        end
    end
end

function Player.Skills:upgrade(playerSkill)
    playerSkill:upgrade()
end

function Player.Skills:getStartValue(playerSkill)
    perUpgradeComponent = 1
    if ( playerSkill.lvl>1 ) then
        perUpgradeComponent =(1+playerSkill.perUpgrade)
    end
    for i=1, playerSkill.lvl-2 do
        perUpgradeComponent =perUpgradeComponent+perUpgradeComponent*playerSkill.perUpgrade
    end
    return playerSkill.value/perUpgradeComponent
end

function playerLiDraw(dt)
    if (Player.Skills.SpecialAtack.Electric.isUsed) then 
        for i=#masli,1,-1 do
            if (masli[i].table and masli[i].timer > 0  ) then
                masli[i].timer = masli[i].timer - 50*dt
                LightEffect:draw(LightEffect:get(Player.x+35*k2*math.sin(Player.angleBody+math.pi/8)+math.random(-4,4)*k,Player.y+35*k2*math.cos(Player.angleBody+math.pi/8)+math.random(-4,4)*k,masli[i].table.x+math.random(-10,10)*k,masli[i].table.y+math.random(-10,10)*k,5))
                LightEffect:draw(LightEffect:get(Player.x+35*k2*math.sin(Player.angleBody-math.pi/8)+math.random(-4,4)*k,Player.y+35*k2*math.cos(Player.angleBody-math.pi/8)+math.random(-4,4)*k,masli[i].table.x+math.random(-10,10)*k,masli[i].table.y+math.random(-10,10)*k,5))
            else
                table.remove(masli,i)
            end
        end
        if ( Player.a == 1 and #masli == 0 ) then 
            LightEffect:draw(LightEffect:get(Player.x+35*k2*math.sin(Player.angleBody)+math.random(-2,2)*k,Player.y+35*k2*math.cos(Player.angleBody)+math.random(-2,2)*k,Player.x+35*k2*math.sin(Player.angleBody+math.pi/4)+math.random(-2,2)*k,Player.y+35*k2*math.cos(Player.angleBody+math.pi/4)+math.random(-2,2)*k,4))
            LightEffect:draw(LightEffect:get(Player.x+35*k2*math.sin(Player.angleBody)+math.random(-2,2)*k,Player.y+35*k2*math.cos(Player.angleBody)+math.random(-2,2)*k,Player.x+35*k2*math.sin(Player.angleBody-math.pi/4)+math.random(-2,2)*k,Player.y+35*k2*math.cos(Player.angleBody-math.pi/4)+math.random(-2,2)*k,4))
        end
    end
end

function Player.Skills.SpecialAtack.Wave:atack(target)
    WaveEffect:new(Player.x,Player.y) -- damage
end

function Player.Skills.SpecialAtack.Wave:damage(target)
    target.health = target.health - Player.damage*Player.Skills.Damage.value*Player.Skills.SpecialAtack.Wave.value
    target.timer = target.invTimer-0.0001
end

function Player.Skills.SpecialAtack.Wave:collision(index,j,dt)
    if ( WaveEffect.regulNetwork[index]) then 
        local regulNetworkElement = WaveEffect.regulNetwork[index]
        local enemyScale = 0
        if (regulNetworkElement) then
            if ( en[j]) then
                enemyScale = math.max(en[j].w,en[j].h)/2
            end
            for i = #regulNetworkElement, 1, -1 do
                if (regulNetworkElement[i] and WaveEffect.particls[regulNetworkElement[i]] and en[j]) then
                    if (math.abs(WaveEffect.particls[regulNetworkElement[i]].x - en[j].x)<WaveEffect.particls[regulNetworkElement[i]].r*k+enemyScale*k and math.abs(WaveEffect.particls[regulNetworkElement[i]].y - en[j].y)<WaveEffect.particls[regulNetworkElement[i]].r*k2+enemyScale*k2 and  (math.pow((WaveEffect.particls[regulNetworkElement[i]].x - en[j].x),2) + math.pow((WaveEffect.particls[regulNetworkElement[i]].y - en[j].y),2))<=math.pow((WaveEffect.particls[regulNetworkElement[i]].r*k+enemyScale*k),2)) then
                        if (en[j].timer == en[j].invTimer ) then 
                            self:damage(en[j])
                        end
                    end
                end
            end
        end
    end
end


function Player.Skills.SpecialAtack.Bloody:atack(target)
    BloodyEffect:new(target)  -- damage
end

function Player.Skills.SpecialAtack.Bloody:debaff(target)
    target.ax = target.ax*(1-Player.Skills.SpecialAtack.Bloody.value)
    target.ay = target.ay*(1-Player.Skills.SpecialAtack.Bloody.value)
    target.health = target.health -Player.damage*Player.Skills.Damage.value*Player.Skills.SpecialAtack.Bloody.value
    target.timer = target.invTimer / 2
end
function Player.Skills.SpecialAtack.Vampir:atack(target)
    VampirEffect:new(target)
end

function Player.Skills.SpecialAtack.Vampir:getHeal()
    Player:heal(Player.Skills.SpecialAtack.Vampir.value) 
end

function Player.Skills.SpecialAtack.Electric:atack(target)
    table.insert(masli,{table = target, timer = 10,flag = nil})
    target.health  =  target.health - Player.damage*Player.Skills.Damage.value*Player.Skills.SpecialAtack.Electric.value 
end

function Player.Skills.SpikeArmor:atack(target)
    target.timer = target.invTimer/2
    target.health = target.health -  target.damage*Player.Skills.SpikeArmor.value
end

function Player.Skills.EnergyArmor:getAtack(dmg)
    EnergyArmorEffect.recovery =EnergyArmorEffect.recoveryTimer - 0.0000001
    if (EnergyArmorEffect.value>0) then 
        EnergyArmorEffect.value = EnergyArmorEffect.value - (dmg-(dmg*self.value))*4
        EnergyArmorEffect.shakeK = 20
        return 0 
    else
        return dmg
    end
end

function Player.Skills.Trade:regen(dt)
    Player.Hp.value = Player.Hp.value +10*dt
end

return playerSkills