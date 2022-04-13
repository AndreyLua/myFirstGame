local skills = {}

local playerSkills= {}

local but1 = false
local but2 = false
local but3 = false
local butSmall = false
local masSkill = {}
local mousePosX = 0 
local mousePosY = 0 
local speedR = 0 
local xR = -math.pi/6*2
local indexRSave = -2
local texti = 0 
local textL = ""
local textK = 0 

local flagAcceptMenu  = false
local lightKoff = 1
local butYes = false
local butNo = false

local flagRes = -0.1
local flagResBool = true


local difButton = (screenWidth-35*k-0.4*1.2*320*k-60*k-0.196*1.2*320*k-320*k/3-0.15*k*240)

local xTextPanel = (35*k)+0.2*difButton*1.12+(160/3*k)
local xBigSlot = (xTextPanel+ 160/3*k)+0.2*difButton*1.12+(0.4*1.2*160*k)
local xSmallSlot =(0.4*1.2*160*k)+0.2*difButton*1.12+(0.196*1.2*160*k)
local xButton = xBigSlot+xSmallSlot+(0.196*1.2*160*k)+0.2*difButton*1.12+(30*k)
local xSmallButton = xButton+30*k+0.15*k*120+0.05*difButton

function skills:init()
     for skillIndex, skill in pairs(Player.Skills) do
        if (skill.isOpened~=nil) then 
            if (skill.isOpened == true) then
                table.insert(playerSkills,skill)
            end
        else
            for atackSkillIndex, atackSkill in pairs(skill) do
                if (atackSkill.isOpened == true) then
                    table.insert(playerSkills,atackSkill)
                end
            end
        end
    end
end

function skills:update(dt)
    mouse.x,mouse.y=love.mouse.getPosition()
    local indexR = xR / (math.pi/6)
    if ( xR%(math.pi/6) > math.pi/12) then
        indexR = math.ceil(xR / (math.pi/6))
    else
        indexR = math.floor(xR / (math.pi/6))
    end
    if love.mouse.isDown(1)  then
        if ( flagtouch3 == false) then 
            mousePosX = mouse.x
            mousePosY = mouse.y
        end 
        if (flagAcceptMenu == false) then 
            if (mouse.x > xButton-k2/4*120 and  mouse.x <xButton+ k2/4*120 and mouse.y > screenHeight/2-math.cos(-math.pi/2)*310*k-500*k/4 and  mouse.y <screenHeight/2-math.cos(-math.pi/2)*310*k+500*k/4) then
                but1 = true
            end
            if (  mouse.x > (xBigSlot)+xSmallSlot+(0.196*1.2*160*k)-k2/3*160 and  mouse.x <(xBigSlot)+xSmallSlot+(0.196*1.2*160*k)+ k2/3*70 and mouse.y > screenHeight/2-math.cos(-math.pi/1.4)*300*k-160*k/3 and  mouse.y <screenHeight/2-math.cos(-math.pi/1.4)*300*k+90*k/3) then
                but2 = true
            end
            if (  mouse.x > (xBigSlot)+xSmallSlot+(0.196*1.2*160*k)-k2/3*160 and  mouse.x <(xBigSlot)+xSmallSlot+(0.196*1.2*160*k)+ k2/3*70 and mouse.y > screenHeight/2-math.cos(-math.pi/3.5)*300*k-90*k/3 and  mouse.y <screenHeight/2-math.cos(-math.pi/3.5)*300*k+160*k/3) then
                but3 = true
            end
            if ( playerSkills[indexR+4] and (playerSkills[indexR+4].numb == 8 or playerSkills[indexR+4].numb == 9 or playerSkills[indexR+4].numb == 10 or playerSkills[indexR+4].numb == 14))  then
                if (  mouse.x > xSmallButton-0.15*k*120 and  mouse.x <xSmallButton+0.15*k*120 and mouse.y > screenHeight/2-math.cos(-math.pi/2)*310*k-0.15*k*500 and  mouse.y <screenHeight/2-math.cos(-math.pi/2)*310*k+0.15*k*500) then
                    butSmall = true
                end
            end
            
        else
            if (mouse.x >(xBigSlot)+xSmallSlot+(0.196*1.2*160*k)-0.4*k*120  and  mouse.x <(xBigSlot)+xSmallSlot+(0.196*1.2*160*k) +0.4*k*120 and mouse.y > screenHeight/2-math.cos(-math.pi/1.4)*120*k -0.4*k*120  and  mouse.y <screenHeight/2-math.cos(-math.pi/1.4)*120*k+0.4*k*120 ) then
                butYes = true
            end
            if (mouse.x >(xBigSlot)+xSmallSlot+(0.196*1.2*160*k)-0.4*k*120  and  mouse.x <(xBigSlot)+xSmallSlot+(0.196*1.2*160*k) +0.4*k*120 and mouse.y > screenHeight/2-math.cos(-math.pi/3.5)*120*k -0.4*k*120  and  mouse.y <screenHeight/2-math.cos(-math.pi/3.5)*120*k+0.4*k*120 ) then
                butNo = true
            end
        end
        flagtouch3 =true
    else
        if ( playerSkills[indexR+4] and (playerSkills[indexR+4].numb == 8 or playerSkills[indexR+4].numb == 9 or playerSkills[indexR+4].numb == 10 or playerSkills[indexR+4].numb == 14))  then
            if ( ( mouse.x > xSmallButton-0.15*k*120 and  mouse.x <xSmallButton+0.15*k*120 and mouse.y > screenHeight/2-math.cos(-math.pi/2)*310*k-0.15*k*500 and  mouse.y <screenHeight/2-math.cos(-math.pi/2)*310*k+0.15*k*500) and butSmall == true ) then
                AddSound(uiSelect,0.3)
                if (playerSkills[indexR+4].numb == 8 ) then
                    playerSkillParametrs.waveAtFlag = not(playerSkillParametrs.waveAtFlag)
                    if ( playerSkillParametrs.waveAtFlag == true) then
                        playerSkillParametrs.bloodAtFlag  =  false
                        playerSkillParametrs.sealAtFlag = false
                        playerSkillParametrs.vampirFlag = false
                    end
                end
                if (playerSkills[indexR+4].numb == 9 ) then
                    playerSkillParametrs.bloodAtFlag = not(playerSkillParametrs.bloodAtFlag)
                    if ( playerSkillParametrs.bloodAtFlag == true) then
                        playerSkillParametrs.waveAtFlag  =  false
                        playerSkillParametrs.sealAtFlag = false
                        playerSkillParametrs.vampirFlag = false
                    end
                end
                if (playerSkills[indexR+4].numb == 10 ) then
                    playerSkillParametrs.sealAtFlag = not(playerSkillParametrs.sealAtFlag)
                    if ( playerSkillParametrs.sealAtFlag == true) then
                        playerSkillParametrs.waveAtFlag  =  false
                        playerSkillParametrs.bloodAtFlag = false
                        playerSkillParametrs.vampirFlag = false
                    end
                end
                if (playerSkills[indexR+4].numb == 14 ) then
                    playerSkillParametrs.vampirFlag = not(playerSkillParametrs.vampirFlag)
                    if ( playerSkillParametrs.vampirFlag == true) then
                        playerSkillParametrs.waveAtFlag  =  false
                        playerSkillParametrs.bloodAtFlag = false
                        playerSkillParametrs.sealAtFlag = false
                    end
                end
            end
        end
        if ( mouse.x > 0 and  mouse.x <60*k and mouse.y > 0 and  mouse.y <60*k2 and flagtouch3 == true) then
            exp = {}
            AddSound(uiClick,0.3)
            gamestate.switch(menu)
        end 
        if ( flagAcceptMenu == false) then 
          
            if (mouse.x > xButton-k2/4*120 and  mouse.x <xButton+ k2/4*120 and mouse.y > screenHeight/2-math.cos(-math.pi/2)*310*k-500*k/4 and  mouse.y <screenHeight/2-math.cos(-math.pi/2)*310*k+500*k/4 and but1 == true) then
                local indexR = xR / (math.pi/6)
                if ( xR%(math.pi/6) > math.pi/12) then
                    indexR = math.ceil(xR / (math.pi/6))
                else
                    indexR = math.floor(xR / (math.pi/6))
                end
                if (speedR == 0 and playerSkills[indexR+4] and  ((playerSkills[indexR+4].lvl)*skillCostUpgrade[(playerSkills[indexR+4].numb)])<= score) then
                    AddSound(uiSelect,0.3)
                    flagAcceptMenu = true
                    flagRes = -0.1
                    flagResBool = true
                else
                    AddSound(uiError,0.3)
                    ---------------------------------
                    if ( playerSkills[indexR+4]) then 
                        if (flagRes == nil or  flagRes < 0) then 
                            flagRes = 0
                        end
                        flagResBool = true
                    end
                  ---------------------------------
                end
            end
            
            if (  mouse.x > (xBigSlot)+xSmallSlot+(0.196*1.2*160*k)-k2/3*160 and  mouse.x <(xBigSlot)+xSmallSlot+(0.196*1.2*160*k)+ k2/3*70 and mouse.y > screenHeight/2-math.cos(-math.pi/1.4)*300*k-160*k/3 and  mouse.y <screenHeight/2-math.cos(-math.pi/1.4)*300*k+90*k/3 and but2 == true) then
                speedR =2.2
                texti = 0 
                textL = ""
                textK = 0 
            end
            if ( mouse.x > (xBigSlot)+xSmallSlot+(0.196*1.2*160*k)-k2/3*160 and  mouse.x <(xBigSlot)+xSmallSlot+(0.196*1.2*160*k)+ k2/3*70 and mouse.y > screenHeight/2-math.cos(-math.pi/3.5)*300*k-90*k/3 and  mouse.y <screenHeight/2-math.cos(-math.pi/3.5)*300*k+160*k/3 and but3 == true ) then
                speedR =-2.2
                texti = 0 
                textL = ""
                textK = 0 
            end
            
            if (flagtouch3 == true and  math.abs( mouse.y - mousePosY ) > 40*k and mouse.x > xBigSlot and  mouse.x < xButton   ) then 
                texti = 0 
                textL = ""
                textK = 0 
                if (  mouse.y >  mousePosY) then 
                    speedR = speedR- 10*math.abs( mouse.y - mousePosY )/screenHeight
                else
                    speedR = speedR+ 10*math.abs( mouse.y - mousePosY )/screenHeight
                end
                if ( math.abs( speedR) < 2) then
                    speedR =2.2* speedR / math.abs( speedR)
                end
            end
        else
            if (mouse.x >(xBigSlot)+xSmallSlot+(0.196*1.2*160*k)-0.4*k*120  and  mouse.x <(xBigSlot)+xSmallSlot+(0.196*1.2*160*k) +0.4*k*120 and mouse.y > screenHeight/2-math.cos(-math.pi/1.4)*120*k -0.4*k*120  and  mouse.y <screenHeight/2-math.cos(-math.pi/1.4)*120*k+0.4*k*120 and butYes == true ) then
                AddSound(uiSelect,0.3)
                local indexR = xR / (math.pi/6)
                if ( xR%(math.pi/6) > math.pi/12) then
                    indexR = math.ceil(xR / (math.pi/6))
                else
                    indexR = math.floor(xR / (math.pi/6))
                end
                if (speedR == 0 and playerSkills[indexR+4] and  skillCostUpgrade[(playerSkills[indexR+4].numb)]*(playerSkills[indexR+4].lvl)<= score) then
                    score = score -skillCostUpgrade[(playerSkills[indexR+4].numb)]*(playerSkills[indexR+4].lvl)
                    playerSkills[indexR+4].lvl = playerSkills[indexR+4].lvl+1
                    lvlParametrs()
                end
            end
            if (mouse.x >(xBigSlot)+xSmallSlot+(0.196*1.2*160*k)-0.4*k*120  and  mouse.x <(xBigSlot)+xSmallSlot+(0.196*1.2*160*k) +0.4*k*120 and mouse.y > screenHeight/2-math.cos(-math.pi/3.5)*120*k -0.4*k*120  and  mouse.y <screenHeight/2-math.cos(-math.pi/3.5)*120*k+0.4*k*120 and butNo == true) then
                AddSound(uiClose,0.2)
                flagAcceptMenu = false
                lightKoff = 1
            end
        end
        butSmall = false
        butNo = false
        butYes = false
        but3 = false
        but2 = false
        but1 = false
        flagtouch3 =false
    end
    if ( flagAcceptMenu == true) then
        lightKoff = 0.2
    end
   
end

function skills:draw()
local dt = love.timer.getDelta()
speedRUpdate(dt)
UIBatch:clear()
skillBatch:clear()
love.graphics.setColor(1,1,1,lightKoff)
love.graphics.draw(fon1,0,0,0,k,k2)
love.graphics.draw(fon2,0,0,0,k,k2)
love.graphics.draw(fon3,0,0,0,k,k2)

add(0,0)
love.graphics.setColor(1,1,1,lightKoff)
sc(0,screenHeight/2)

local indexR = xR / (math.pi/6)
if ( xR%(math.pi/6) > math.pi/12) then
    indexR = math.ceil(xR / (math.pi/6))
else
    indexR = math.floor(xR / (math.pi/6))
end

if ( playerSkills[indexR+4]) then 
    if ( speedR == 0 ) then 
      --  print(playerSkills[1])
       -- textUpdate(playerSkills[indexR+4].text,1,dt) 
    else
        texti = 0 
        textL = ""
        textK = 0 
    end
    slot(indexR+4,xBigSlot,screenHeight/2,160,160,0.4) 
else
    texti = 0 
    textL = ""
    textK = 0 
    slot(nil,xBigSlot,screenHeight/2,160,160,0.4)   
end


for i = 1 , 20 do 
    local angle = -i*math.pi/6+math.pi/6+ xR
    local light = 0.7
    if ( angle < -math.pi- math.pi /6 ) then
        angle = -math.pi - math.pi /6
    end 
    if ( angle > math.pi/6 ) then
        angle = math.pi/6
    end 
    local scale =0
    if ( angle>= -math.pi /2 and  angle < 0 ) then
          scale = scale+math.abs(angle)/8
          light = light+math.abs(angle)/2
    else
          scale = (scale+math.abs(math.pi/2)/8) - math.abs(angle+math.pi/2)/8
          light = (light+math.abs(math.pi/2)/2) - math.abs(angle+math.pi/2)/2
    end 
    if ( scale <0) then
        scale = 0 
    end
  
    if (playerSkills[i]) then 
        slot(i,(xBigSlot)-math.sin(angle)*xSmallSlot,screenHeight/2- math.cos(angle)*180*k,160,160,scale*1.2,light) 
    else
        slot(nil,(xBigSlot)-math.sin(angle)*xSmallSlot,screenHeight/2- math.cos(angle)*180*k,160,160,scale*1.2,light) 
    end
end
love.graphics.setColor(1,1,1,lightKoff)
bodyTextPanel(xTextPanel,screenHeight/2)
bodyButtonDirect((xBigSlot)+xSmallSlot+(0.196*1.2*160*k),screenHeight/2-math.cos(-math.pi/1.4)*300*k,but2,'left')
bodyButtonDirect((xBigSlot)+xSmallSlot+(0.196*1.2*160*k),screenHeight/2-math.cos(-math.pi/3.5)*300*k,but3,'right')
bodyButton(xButton,screenHeight/2-math.cos(-math.pi/2)*310*k,but1)

if ( playerSkills[indexR+4] and (playerSkills[indexR+4].numb == 8 or playerSkills[indexR+4].numb == 9 or playerSkills[indexR+4].numb == 10 or playerSkills[indexR+4].numb == 14))  then
    bodyButtonScale(xSmallButton,screenHeight/2-math.cos(-math.pi/2)*310*k,butSmall,0.15)
end

love.graphics.setColor(1,1,1,lightKoff)
love.graphics.draw(UIBatch)
love.graphics.draw(skillBatch)
UIBatch:clear()
skillBatch:clear()
if (flagAcceptMenu == true) then 
    love.graphics.setColor(1,1,1,1)
    add()
    slot(indexR+4,xBigSlot,screenHeight/2,160,160,0.4) 
    acceptBut((xBigSlot)+xSmallSlot+(0.196*1.2*160*k),screenHeight/2-math.cos(-math.pi/1.4)*120*k,0.4,butYes) 
    rejectBut((xBigSlot)+xSmallSlot+(0.196*1.2*160*k),screenHeight/2-math.cos(-math.pi/3.5)*120*k,0.4,butNo)
    love.graphics.draw(UIBatch)
    love.graphics.draw(skillBatch)
    love.graphics.setColor(1,1,1,lightKoff)
end
textButton("Update",xButton,screenHeight/2-math.cos(-math.pi/2)*310*k,but1,0.9)

if ( playerSkills[indexR+4] and (playerSkills[indexR+4].numb == 8 or playerSkills[indexR+4].numb == 9 or playerSkills[indexR+4].numb == 10 or playerSkills[indexR+4].numb == 14))  then
    if ( playerSkills[indexR+4].numb == 8) then 
        if ( playerSkillParametrs.waveAtFlag == true) then
            textButton("Used",xSmallButton,screenHeight/2-math.cos(-math.pi/2)*310*k,butSmall,0.4)
        else
            textButton("Use",xSmallButton,screenHeight/2-math.cos(-math.pi/2)*310*k,butSmall,0.4)
        end
    end
    if ( playerSkills[indexR+4].numb ==9) then 
        if ( playerSkillParametrs.bloodAtFlag == true) then
            textButton("Used",xSmallButton,screenHeight/2-math.cos(-math.pi/2)*310*k,butSmall,0.4)
        else
            textButton("Use",xSmallButton,screenHeight/2-math.cos(-math.pi/2)*310*k,butSmall,0.4)
        end
    end
    if ( playerSkills[indexR+4].numb ==10) then 
        if ( playerSkillParametrs.sealAtFlag == true) then
            textButton("Used",xSmallButton,screenHeight/2-math.cos(-math.pi/2)*310*k,butSmall,0.4)
        else
            textButton("Use",xSmallButton,screenHeight/2-math.cos(-math.pi/2)*310*k,butSmall,0.4)
        end
    end
    if ( playerSkills[indexR+4].numb ==14) then 
        if ( playerSkillParametrs.vampirFlag == true) then
            textButton("Used",xSmallButton,screenHeight/2-math.cos(-math.pi/2)*310*k,butSmall,0.4)
        else
            textButton("Use",xSmallButton,screenHeight/2-math.cos(-math.pi/2)*310*k,butSmall,0.4)
        end
    end
end

love.graphics.setColor(1,1,1,1)
local fontWidth = font:getWidth(tostring(score))
love.graphics.print(score,50*k/12, screenHeight/2+fontWidth/2*k2/2,-math.pi/2,k/2,k2/2)
if ( indexR~= indexRSave) then 
    AddSound(uiScroll,0.1,false)
end
if ( playerSkills[indexR+4]) then 
    text(xTextPanel-(160/3*k)+20*k,screenHeight/2+140*k,0.42)
    --textPar(playerSkills[indexR+4].numb,xTextPanel-(160/3*k)+20*k,screenHeight/2-60*k,0.43)
    local fontWidth = font:getWidth(tostring(playerSkills[indexR+4].lvl))
    love.graphics.setColor(0,0,0,0.5) 
    xBigSlot = (xTextPanel+ 160/3*k)+0.2*difButton+(0.4*1.2*160*k)
    love.graphics.setColor(1,1,1,1)
    love.graphics.print(tostring(playerSkills[indexR+4].lvl),xBigSlot-(0.4*1.2*160*k)+10*k,screenHeight/2-160*k*0.4*1.2+fontWidth*k2/2+14*k,-math.pi/2,k/2,k2/2)
    if (  flagAcceptMenu == true) then 
        fontWidth = font:getWidth(tostring(playerSkills[indexR+4].lvl+1))
        love.graphics.print('^',xBigSlot-(0.4*1.2*160*k)+47*k,screenHeight/2-160*k*0.4*1.2+16*k,math.pi/2,k/2,k2/2)
        love.graphics.print(tostring(playerSkills[indexR+4].lvl+1),xBigSlot-(0.4*1.2*160*k)+40*k,screenHeight/2-160*k*0.4*1.2+fontWidth*k2/2+14*k,-math.pi/2,k/2,k2/2)
        fontWidth = font:getWidth("Cost of upgrade "..tostring(skillCostUpgrade[(playerSkills[indexR+4].numb)]*(playerSkills[indexR+4].lvl)))
        love.graphics.print("Cost of upgrade "..tostring(skillCostUpgrade[(playerSkills[indexR+4].numb)]*(playerSkills[indexR+4].lvl)),xBigSlot-(0.4*1.2*160*k)-70*k,screenHeight/2+fontWidth*k2/3,-math.pi/2,k/1.5,k2/1.5)
    end
end

flagRes,flagResBool = noRes(xBigSlot-(0.4*1.2*160*k)-difButton*0.16 ,screenHeight/2,0.4,flagRes,dt,flagResBool)
love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 100, 10,0,k/2,k2/2)

indexRSave = indexR
end

function textPar(i,x,y,scale)
    local indexR = xR / (math.pi/6)
    if ( xR%(math.pi/6) > math.pi/12) then
        indexR = math.ceil(xR / (math.pi/6))
    else
        indexR = math.floor(xR / (math.pi/6))
    end
    if (playerSkills[indexR+4]) then 
        love.graphics.print("COST "..tostring(skillCostUpgrade[i]*(playerSkills[indexR+4].lvl)),x+30*k,y,-3.14/2,scale*k,scale*k) end
    if (i == 1 ) then 
        love.graphics.print("HP "..tostring(math.ceil(100/(1-playerSkillParametrs.hpK))).."%",x,y,-3.14/2,scale*k,scale*k)
    end
    if (i == 2 ) then 
        love.graphics.print("EN "..tostring(math.ceil(100/(1-playerSkillParametrs.enK))).."%",x,y,-3.14/2,scale*k,scale*k)
    end
    if (i == 3 ) then 
        love.graphics.print("RES "..tostring(math.ceil(100*(playerSkillParametrs.meleeDefK))).."%",x,y,-3.14/2,scale*k,scale*k)
    end
    if (i == 4 ) then 
        love.graphics.print("RES "..tostring(math.ceil(100*(playerSkillParametrs.rangeDefK))).."%",x,y,-3.14/2,scale*k,scale*k)
    end
    if (i == 5 ) then 
        love.graphics.print("AT "..tostring(math.ceil(100*(playerSkillParametrs.damageK))).."%",x,y,-3.14/2,scale*k,scale*k)
    end
    if (i == 6 ) then 
        love.graphics.print("SP "..tostring(math.ceil(100*(playerSkillParametrs.speedK))).."%",x,y,-3.14/2,scale*k,scale*k)
    end
    if (i == 7 ) then 
        love.graphics.print("RAN "..tostring(math.ceil(100*(playerSkillParametrs.collectRangeK))).."%",x,y,-3.14/2,scale*k,scale*k)
    end
    if (i == 8 ) then 
        love.graphics.print("AT "..tostring(math.ceil(100*(playerSkillParametrs.waveAt))).."%",x,y,-3.14/2,scale*k,scale*k)
    end
    if (i == 9 ) then 
        love.graphics.print("AT "..tostring(math.ceil(100*(playerSkillParametrs.bloodAt))).."%",x,y,-3.14/2,scale*k,scale*k)
    end
    if (i == 10 ) then 
        love.graphics.print("AT "..tostring(math.ceil(100*(playerSkillParametrs.sealAt))).."%",x,y,-3.14/2,scale*k,scale*k)
    end
    if (i == 11 ) then 
        love.graphics.print("REF "..tostring(math.ceil(100*(playerSkillParametrs.spike))).."%",x,y,-3.14/2,scale*k,scale*k)
    end
    if (i == 12 ) then 
        love.graphics.print("EN "..tostring(math.ceil(100*(playerSkillParametrs.dopEn))).."%",x,y,-3.14/2,scale*k,scale*k)
    end
    if (i == 13 ) then 
        love.graphics.print("SW "..tostring(math.ceil(100*(playerSkillParametrs.tradeK))).."%",x,y,-3.14/2,scale*k,scale*k)
    end
    if (i == 14 ) then 
        love.graphics.print("VP "..tostring(math.ceil(100*(playerSkillParametrs.vampirK))).."%",x,y,-3.14/2,scale*k,scale*k)
    end
end

function textUpdate(text,speed,dt) 
    if (texti<=#text) then 
        texti = texti+1
        textK = textK+1
        local textkek = "" 
        if (textL:sub(#textL,#textL)=="_") then
            textL = textL:sub(0,#textL-1)
        end
        textkek = text:sub(texti,texti)
        if ( textK>13 and text:sub(texti,texti) == " ") then
            textK = 0 
            textkek =textkek.."\n"
        end
        textL = textL..textkek.."_"
    end
end

function text(x,y,scale)
    love.graphics.setColor(1,1,1,lightKoff)
    love.graphics.print(textL,x,y,-3.14/2,scale*k,scale*k)
end

function slot(img,x,y,ox,oy,scale,light)
    if ( light == nil ) then
        light = 1 
    end
    UIBatch:setColor(light,light,light,light)
    skillBatch:setColor(light,light,light,light)
    if (img and playerSkills[img].image ) then
--        if ( playerSkills[img].numb  > 11 ) then 
            UIBatch:add(UIQuads.tableSkillLegend,x,y,-math.pi/2,k*scale*1.2,k2*scale*1.2,180,180)       
            skillBatch:add(playerSkills[img].image,x,y,-math.pi/2,k*scale,k2*scale,160,160)
    --[[    else
            if ( playerSkills[img].numb  > 7 ) then 
                UIBatch:add(UIQuads.tableSkillRare,x,y,-math.pi/2,k*scale*1.2,k2*scale*1.2,180,180)    
                skillBatch:add(playerSkills[img].img,x,y,-math.pi/2,k*scale,k2*scale,160,160)
            else
                UIBatch:add(UIQuads.tableSkillNormal,x,y,-math.pi/2,k*scale*1.2,k2*scale*1.2,160,160)      
                skillBatch:add(playerSkills[img].img,x,y,-math.pi/2,k*scale,k2*scale,160,160)
            end
        end
        ]]--
        skillBatch:add(playerSkills[img].image,x,y,-math.pi/2,k*scale,k2*scale,ox,oy)
    else
        UIBatch:add(UIQuads.tableSkillNormal,x,y,-math.pi/2,k*scale*1.2,k2*scale*1.2,160,160)       
    end
    UIBatch:setColor(1,1,1,1)
    skillBatch:setColor(1,1,1,1)
end

function speedRUpdate(dt)
    if ( speedR > 0.4) then
        speedR = speedR -5*dt
    else
        if ( (xR / (math.pi/6))%1   <0.06 and math.abs(speedR)< 1.5) then
            speedR = 0
        else
            xR = xR+ speedR*dt
        end
    end
    if ( speedR < -0.4) then
        speedR = speedR+5*dt
    else
        if ( (xR / (math.pi/6))%1   <0.06 and math.abs(speedR)< 1.5) then
            speedR = 0
        else
            xR = xR+ speedR*dt
        end
    end
    if ( xR <= -math.pi/6*3+0.03) then
        xR = -math.pi/6*3+0.03
        speedR = 0 
    end
    if ( xR >=math.pi*2.5+math.pi/6-0.03) then
        xR =math.pi*2.5+math.pi/6-0.03
        speedR = 0 
    end
end

return skills