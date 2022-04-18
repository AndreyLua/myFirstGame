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




function playerLiDraw(dt)
    if (Player.Skills.SpecialAtack.Electric.sealAtFlag == true) then 
        for i=#masli,1,-1 do
            if (masli[i].table and masli[i].timer > 0  ) then
                masli[i].timer = masli[i].timer - 50*dt
                light22Draw(light22(Player.x+35*k2*math.sin(Player.angleBody+math.pi/8)+math.random(-4,4)*k,Player.y+35*k2*math.cos(Player.angleBody+math.pi/8)+math.random(-4,4)*k,masli[i].table.x+math.random(-10,10)*k,masli[i].table.y+math.random(-10,10)*k,5))
                light22Draw(light22(Player.x+35*k2*math.sin(Player.angleBody-math.pi/8)+math.random(-4,4)*k,Player.y+35*k2*math.cos(Player.angleBody-math.pi/8)+math.random(-4,4)*k,masli[i].table.x+math.random(-10,10)*k,masli[i].table.y+math.random(-10,10)*k,5))
            else
                table.remove(masli,i)
            end
        end
        if ( Player.a == 1 and #masli == 0 ) then 
            light22Draw(light22(Player.x+35*k2*math.sin(Player.angleBody)+math.random(-2,2)*k,Player.y+35*k2*math.cos(Player.angleBody)+math.random(-2,2)*k,Player.x+35*k2*math.sin(Player.angleBody+math.pi/4)+math.random(-2,2)*k,Player.y+35*k2*math.cos(Player.angleBody+math.pi/4)+math.random(-2,2)*k,4))
            light22Draw(light22(Player.x+35*k2*math.sin(Player.angleBody)+math.random(-2,2)*k,Player.y+35*k2*math.cos(Player.angleBody)+math.random(-2,2)*k,Player.x+35*k2*math.sin(Player.angleBody-math.pi/4)+math.random(-2,2)*k,Player.y+35*k2*math.cos(Player.angleBody-math.pi/4)+math.random(-2,2)*k,4))
        end
    end
end

function playerBoostDop(dt)
    if ( Player.Skills.EnergyArmor.dopEnFlag == true) then 
        angleBoostDop(dt,Player.Controller.angle)
        if ( boostDop.long/720*100 > 100) then
            boostDop.long = 720
        end
        if (boostDop.recovery == boostDop.recoveryTimer) then 
            boostDop.long = boostDop.long + Player.Energy.regen/1.5 *dt*k
            boostDop.shakeK = 0
        end
        if ( boostDop.long <= 0 ) then
            boostDop.long =0
        end
        if  (boostDop.long>720) then
            boostDop.long = 720
        end
        boostDop.shake = math.random()*math.random(-1,1)*boostDop.shakeK
        if ( boostDop.shakeK > 1 ) then 
            boostDop.shakeK  = boostDop.shakeK - 10 *dt
        end
        
        if ( boostDop.recovery < boostDop.recoveryTimer) then 
            boostDop.recovery =boostDop.recovery - 3*dt
            if ( boostDop.recovery < 0 )then 
                boostDop.recovery = boostDop.recoveryTimer
            end
        end
    else
        boostDop.long = 0 
    end
end


function angleBoostDop (dt,angle) 
    if ( boostDop.angle == 0) then
        boostDop.angle=0.00000001
    end
    if ( boostDop.angle < -math.pi) then
        boostDop.angle=math.pi
    end
    if ( boostDop.angle > math.pi) then
        boostDop.angle=-math.pi
    end
    if ( angle == 0) then
        angle=0.00000001
    end
    if ((angle -  boostDop.angle > 2.1*dt) or (angle -  boostDop.angle) <  -2.1*dt ) then
        if (angle/math.abs(angle)==boostDop.angle/math.abs(boostDop.angle))then
            if ( angle>boostDop.angle) then
                boostDop.angle = boostDop.angle+2*dt
            else 
                boostDop.angle = boostDop.angle-2*dt
            end
        else
            if (math.abs(angle)+math.abs(boostDop.angle)> 2*math.pi - math.abs(angle)-math.abs(boostDop.angle)) then
                if (boostDop.angle>0) then 
                    boostDop.angle = boostDop.angle+2*dt
                else
                    boostDop.angle = boostDop.angle-2*dt
                end
            else 
                if (boostDop.angle>0) then 
                    boostDop.angle = boostDop.angle-2*dt
                else
                    boostDop.angle = boostDop.angle+2*dt
                end
            end
        end
    end
end

return playerSkills