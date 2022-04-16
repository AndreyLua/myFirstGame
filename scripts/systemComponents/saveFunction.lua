local saveFunction = {}

--local convert = require "scripts/gameStates/menuSections/convert"

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
            Wave.number = TableSave[2]
        end
        if ( TableSave[4]) then 
            loadPlayerSkills(TableSave[4])
        end
        if ( TableSave[5]) then 
            loadParticle(TableSave[5])
        end
        if ( TableSave[6]) then 
            local usedSkills = TableSave[6]
            Player.Skills.SpecialAtack.Wave.waveAtFlag = usedSkills[1]
            Player.Skills.SpecialAtack.Bloody.bloodAtFlag =usedSkills[2]
            Player.Skills.SpecialAtack.Electric.sealAtFlag =usedSkills[3]
            Player.Skills.SpecialAtack.Vampir.vampirFlag =usedSkills[4]
        end
    end
end

function makeSave()
    local playerSettings = {MusicVolume, SoundsVolume, Sensitivity, controllerChoose}
    local particlSaveMas = saveParticle() 
    local playerSkillsSaveMas ={}
    savePlayerSkills(playerSkillsSaveMas)
  --  print(#playerSkillsSaveMas)
    local usedSkills = { Player.Skills.SpecialAtack.Wave.waveAtFlag,Player.Skills.SpecialAtack.Bloody.bloodAtFlag,Player.Skills.SpecialAtack.Electric.sealAtFlag,Player.Skills.SpecialAtack.Vampir.vampirFlag}
    save = {score,Wave.number,playerSettings,playerSkillsSaveMas,particlSaveMas,usedSkills}
    love.filesystem.write('save.lua',  binser.serialize(save))
end

function savePlayerSkills(playerSkillsSaveMas)
    for skillIndex, skill in pairs(Player.Skills) do
        if ( type(skill)=='table') then 
            if (skill.isOpened~=nil) then 
                if (skill.isOpened == true) then
                    local savePlayerSkill ={
                     --   link = skill,
                        lvl = skill.lvl,
                        numb = skill.numb,
                        value = skill.value,
                    }
                    table.insert(playerSkillsSaveMas,savePlayerSkill)
                end
            else
                for atackSkillIndex, atackSkill in pairs(skill) do
                    if (atackSkill.isOpened == true) then
                        local savePlayerSkill ={
                     --       link = skill,
                            lvl = skill.lvl,
                            numb = skill.numb,
                            value = skill.value,
                        }
                        table.insert(playerSkillsSaveMas,savePlayerSkill)
                    end
                end
            end
        end
    end
end

function saveParticle()
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
        local Color1,Color2,Color3  = particlColor() 
        local e = {
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
        table.insert(Particle.list,e)
    end
end

function loadPlayerSkills(playerSkillsSaveMas)
 -- print(#playerSkillsSaveMas)
    for i =1, #playerSkillsSaveMas do
        Player.Skills[i].link.value = playerSkillsSaveMas[i].value
        Player.Skills[i].link.number = playerSkillsSaveMas[i].number
        Player.Skills[i].link.lvl = playerSkillsSaveMas[i].lvl
    end
end
return saveFunction