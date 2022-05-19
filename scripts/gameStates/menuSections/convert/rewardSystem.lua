local rewardSystem = {}

Reward = {
    count = 0,
    flagMenu = false ,
    money  = 0,
    skill  = nil,
    newSet = nil,
    slotScale = 0,  
}

function Reward:give(table)
    score = score + Reward.money
    if ( Reward.newSet ~= nil) then 
        tablePlayerTipOpened[Reward.newSet] = true
    else
        if ( Reward.skill ~= nil) then 
            if (Reward.skill.isOpened) then 
                Reward.skill.lvl = Reward.skill.lvl + 1
            else
                Reward.skill.isOpened = true
                Reward.skill.number = #table+1
            end
        end
    end
    Reward.money = 0 
    Reward.skill = nil
    Reward.newSet = nil
end

function Reward:updateSlotScale(dt)
    if ( Reward.slotScale < 0.6 and Reward.flagMenu == true ) then 
        Reward.slotScale = Reward.slotScale + 1 * dt
    end
    if ( Reward.slotScale > 0 and Reward.flagMenu == false) then 
        Reward.slotScale = Reward.slotScale - 1 * dt
    end
end

function Reward:draw()
    if ( self.newSet~=nil) then 
        playerDrawCharacter(screenWidth/2,screenHeight/2,self.newSet,self.slotScale)
        love.graphics.draw(playerBatch)
    else
        if (self.skill == 0) then 
            rewardSlot(nil,screenWidth/2,screenHeight/2,self.slotScale,self.money)
        else
            rewardSlot(self.skill,screenWidth/2,screenHeight/2,self.slotScale,self.money)
        end
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
    local listPlayerNotUnlockSet = {}
    for i=1,#tablePlayerTipOpened do
        if ( tablePlayerTipOpened[i]==false) then 
            table.insert(listPlayerNotUnlockSet,i)
        end
    end
    if ( math.random(1,100) > 95 and #listPlayerNotUnlockSet >0) then 
        Reward.newSet = listPlayerNotUnlockSet[math.random(1,#listPlayerNotUnlockSet)]
        tablePlayerTipOpened[Reward.newSet] = true
    else
        if ( math.random(1,100) > 80) then 
            local playerLegendSkills = {}
            Player.Skills:raritySkills(playerLegendSkills,"legend")
            self.skill  = playerLegendSkills[math.random(1,#playerLegendSkills)]
        else
            self:getNormal(count)
        end
    end
end

function Reward:getNormal(count)
    if ( math.random(1,100) > 70) then 
        local playerRareSkills = {}
        Player.Skills:raritySkills(playerRareSkills,"rare")
        self.skill  = playerRareSkills[math.random(1,#playerRareSkills)]
    else
        self:getSmall(count)
    end
end


function Reward:getSmall(count)
    if ( math.random(1,100) >70) then 
        local playerCommonSkills = {}
        Player.Skills:raritySkills(playerCommonSkills,"common")
        self.skill  = playerCommonSkills[math.random(1,#playerCommonSkills)]
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