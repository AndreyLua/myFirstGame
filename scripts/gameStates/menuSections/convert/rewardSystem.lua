local rewardSystem = {}

Reward = {
    count = 0,
    flagMenu = false ,
    money  = 0,
    skill  = 0,
    slotScale = 0,  
}

function Reward:give()
    score = score + Reward.money
    if ( Reward.skill ~= 0) then 
        local flagPlHave = false
        for i =1, #playerSkills do 
            local masSkill = playerSkills[i] 
            if (flagPlHave ==false and  masSkill.img == allSkills[Reward.skill] ) then 
                flagPlHave = true
                Reward.skill = i 
                break
            end
        end
        if ( flagPlHave) then 
            playerSkills[Reward.skill].lvl = playerSkills[Reward.skill].lvl + 1
        else
            table.insert(playerSkills,{img = allSkills[Reward.skill],lvl  = 1,numb = Reward.skill  } ) 
        end
    end
    Reward.money = 0 
    Reward.skill = 0
end

function Reward:updateSlotScale(dt)
    if ( Reward.slotScale < 0.6 and Reward.flagMenu == true ) then 
        Reward.slotScale = Reward.slotScale + 1 * dt
    end
    if ( Reward.slotScale > 0 and Reward.flagMenu == false) then 
        Reward.slotScale = Reward.slotScale - 1 * dt
    end
end

function Reward:get(count)
    self.flagMenu = true 
    if ( count == 140) then 
        self:getBig(count)
    else
        if (math.ceil(count/1.4)>=60) then
            self:getNormal(count)
        else
            self:getSmall(count)
        end
    end
end

function Reward:getBig(count)
    if ( math.random(1,100) > 80) then 
        self.skill  = math.random(12,14) 
    else
        self:getNormal(count)
    end
end

function Reward:getNormal(count)
    if ( math.random(1,100) > 70) then 
        self.skill  = math.random(8,11) 
    else
        self:getSmall(count)
    end
end


function Reward:getSmall(count)
    if ( math.random(1,100) > 70) then 
        self.skill  = math.random(1,7) 
    else
        if ( math.random(1,100) > 80) then
            self.money  = math.ceil(count*scoreForParticle*0.7)
        else
            if ( math.random(1,100) > 50) then
                self.money  = math.ceil(count*scoreForParticle*0.5)
            else
                self.money  = 0
            end
        end
    end 
end

return rewardSystem