local saveFunction = {}

function loadSave()
    if love.filesystem.getInfo('save.lua') then
        local TableSave = love.filesystem.read('save.lua')
        TableSave =unpack(binser.deserialize(TableSave))
        if (TableSave) then 
            if ( TableSave[2]) then 
                score =TableSave[2]
            end
            if ( TableSave[3]) then 
                Wave.number = TableSave[3]
            end
            if ( TableSave[4]) then 
                loadParticle(TableSave[4])
            end
            if  (TableSave[5]) then 
                local playerSettings = TableSave[5]
                if ( playerSettings[1]) then 
                    MusicVolume = playerSettings[1]
                end
                if ( playerSettings[2]) then 
                    SoundsVolume = playerSettings[2]
                end
                if ( playerSettings[3]) then 
                    Sensitivity = playerSettings[3] 
                end
                if ( playerSettings[4]) then 
                    controllerChoose = playerSettings[4] 
                end
            end
            if ( TableSave[6]) then 
                Player.tip = TableSave[6][1]
                tablePlayerTipOpened = TableSave[6][2]
                loadPlayerSkills(TableSave[6][3])
            end
        end
    end
end

function makeSave()
    local SettingsData = {MusicVolume, SoundsVolume, Sensitivity, controllerChoose}
    local ParticlData = saveFunction:saveParticle() 
    local PlayerSkillsData = saveFunction:savePlayerSkills()
    local PlayerData ={Player.tip,tablePlayerTipOpened,PlayerSkillsData}
    save = {version,score,Wave.number,ParticlData,SettingsData,PlayerData}
    
    love.filesystem.write('save.lua',  binser.serialize(save))
end

function saveFunction:savePlayerSkills()
    local playerSkills = {}
    local saveSkills = {}
    Player.Skills:skillsTable(playerSkills)
    Player.Skills:sortSkillsTable(playerSkills)
    for i=1,#playerSkills do
        local savePlayerSkill = {
            lvl = playerSkills[i].lvl,
            numb = playerSkills[i].number,
            isUsed = playerSkills[i].isUsed,
        }
        table.insert(saveSkills,savePlayerSkill)
    end
    return saveSkills
end

function saveFunction:saveParticle()
    local particlSaveMas = {}
    for i =1, #Particle.list do
        local saveParticle ={
            x = Particle.list[i].x,
            y = Particle.list[i].y,
            side = Particle.list[i].side,
            ran = Particle.list[i].ran,
            ax = Particle.list[i].ax,
            ay = Particle.list[i].ay,
        }
        table.insert(particlSaveMas,saveParticle)
    end
    return particlSaveMas
end

function loadParticle(particlSaveMas)
    Particle.list = {}
    for i =1, #particlSaveMas do
        local Color1,Color2,Color3  = Particle:color()
        local particl = {
            side = particlSaveMas[i].side, 
            ran = particlSaveMas[i].ran,
            body =  HC.circle(particlSaveMas[i].x,particlSaveMas[i].y,10*k),
            flag = false,
            color1 = Color1,
            color2= Color2,
            color3 = Color3,
            x = particlSaveMas[i].x, 
            y = particlSaveMas[i].y,  
            xx = particlSaveMas[i].x,
            yy = particlSaveMas[i].y,
            ax = particlSaveMas[i].ax,
            ay = particlSaveMas[i].ay, 
        }
        table.insert(Particle.list,particl)
    end
end

function loadPlayerSkills(saveSkills)
    local linksPlayerSkills=saveFunction:getPlayerSkillLinks()
    for i =1, #saveSkills do
        for j=1,saveSkills[i].lvl-1 do 
            linksPlayerSkills[saveSkills[i].numb]:upgrade()   
        end
        linksPlayerSkills[saveSkills[i].numb].isUsed = saveSkills[i].isUsed
    end
end

function saveFunction:getPlayerSkillLinks()
    local links = {}
    for skillIndex, skill in pairs(Player.Skills) do
        if ( type(skill)=='table') then 
            if (skill.isOpened~=nil) then 
                links[skill.number]=skill
            else
                for atackSkillIndex, atackSkill in pairs(skill) do
                    links[atackSkill.number]=atackSkill
                end
            end
        end
    end
    return links
end

return saveFunction