local saveFunction = {}

function loadSave()
    if love.filesystem.getInfo('save.lua') then
        local TableSave = love.filesystem.read('save.lua')
        TableSave =unpack(binser.deserialize(TableSave))
        if  (TableSave[3]) then 
            local playerSettings = TableSave[3]
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
        if ( TableSave[1]) then 
            score =TableSave[1]
        end
        if ( TableSave[2]) then 
            numberWave = TableSave[2]
        end
        if ( TableSave[4]) then 
            loadPlayerSkills(TableSave[4])
        end
        if ( TableSave[5]) then 
            loadParticl(TableSave[5])
        end
    end
end

function makeSave()
    local playerSettings = {MusicVolume, SoundsVolume, Sensitivity, controllerChoose}
    local particlSaveMas = saveParticl() 
    local playerSkillsSaveMas = savePlayerSkills()
    save = {score,numberWave,playerSettings,playerSkillsSaveMas,particlSaveMas}
    love.filesystem.write('save.lua',  binser.serialize(save))
end

function savePlayerSkills()
    local playerSkillsSaveMas = {}
    for i =1, #playerSkills do
        local savePlayerSkill ={
            lvl = playerSkills[i].lvl,
            numb = playerSkills[i].numb
        }
        table.insert(playerSkillsSaveMas,savePlayerSkill)
    end
    return playerSkillsSaveMas
end

function saveParticl()
    local particlSaveMas = {}
    for i =1, #particl do
        local saveParticl ={
            x = particl[i].x,
            y = particl[i].y,
            side = particl[i].side,
            ran = particl[i].ran,
            ax = particl[i].ax,
            ay = particl[i].ay,
        }
        table.insert(particlSaveMas,saveParticl)
    end
    return particlSaveMas
end

function loadParticl(particlSaveMas)
    particl = {}
    for i =1, #particlSaveMas do
        local Color1,Color2,Color3  = particlColor() 
        local e = {
            side = particlSaveMas[i].side, 
            ran = particlSaveMas[i].ran,
            body =  HC.circle(particlSaveMas[i].x,particlSaveMas[i].y,10*k),
            flag  =false,
            color1 = Color1,
            color2= Color2,
            color3 = Color3,
            x  = particlSaveMas[i].x, 
            y =  particlSaveMas[i].y,  
            xx  = particlSaveMas[i].x, 
            yy =  particlSaveMas[i].y,
            ax  =particlSaveMas[i].ax, 
            ay = particlSaveMas[i].ay, 
        }
        table.insert(particl,e)
    end
end

function loadPlayerSkills(playerSkillsSaveMas)
    playerSkills = {} 
    for i =1, #playerSkillsSaveMas do
        local skill = {
            img = allSkills[playerSkillsSaveMas[i].numb],
            numb = playerSkillsSaveMas[i].numb,
            lvl = playerSkillsSaveMas[i].lvl
        }
        table.insert(playerSkills,skill)
    end
end
return saveFunction