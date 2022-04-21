------------------LIBS ----------------------------
binser = require "libs/binser/binser"
gamestate = require "libs/gamestate" 
Timer = require 'libs/hump.timer' 
Class = require "libs/hump.class"
HC = require 'libs/HC'
moonshine = require 'moonshine'

save = {}

MusicVolume = 1
SoundsVolume = 1
Sensitivity = 1
controllerChoose = 1

---------------------------------------------------
------------------EFFECTS -------------------------
effect1 = moonshine(moonshine.effects.pixelate)
effect1.pixelate.size =2
-- fog типо туман
--effect2 = moonshine(moonshine.effects.fog)
---------------------------------------------------
------------------SOUNDS---------------------------
soundEffects = {} 
bgMusicI = 1
delayMusic = 0
bg1 ="music/bg1.mp3"
bg2 ="music/bg2.mp3"
bg3 ="music/bg3.mp3"
bgMusicTableMix = { bg1,bg1,bg2,bg2,bg3,bg3 }
bgMusic = love.audio.newSource(bgMusicTableMix[bgMusicI],"stream",false)
bgMusic:setVolume(0.2)
bgMusic:play()

objCrash1 = love.audio.newSource("sounds/obj/crash1.ogg", "static",false)
objCrash2 = love.audio.newSource("sounds/obj/crash2.ogg", "static",false)
objCrash3 = love.audio.newSource("sounds/obj/crash3.ogg", "static",false)
objCrashSounds = {objCrash1,objCrash2,objCrash2}

playerHit1 = love.audio.newSource("sounds/player/hit/1.wav", "static",false)
playerHit2 = love.audio.newSource("sounds/player/hit/2.wav", "static",false)
playerHit3 = love.audio.newSource("sounds/player/hit/3.wav", "static",false)
playerHit4 = love.audio.newSource("sounds/player/hit/4.wav", "static",false)
playerHitSounds = {playerHit1,playerHit2,playerHit3,playerHit4}

playerHurt1 = love.audio.newSource("sounds/player/hurt/1.wav", "static",false)
playerHurt2 = love.audio.newSource("sounds/player/hurt/2.wav", "static",false)
playerHurt3 = love.audio.newSource("sounds/player/hurt/3.wav", "static",false)
playerHurt4 = love.audio.newSource("sounds/player/hurt/4.wav", "static",false)
playerHurtSounds = {playerHurt1,playerHurt2,playerHurt3,playerHurt4}

uiClick = love.audio.newSource("sounds/ui/click/2.ogg", "static",false)
uiSelect = love.audio.newSource("sounds/ui/click/1.ogg", "static",false)
uiClose = love.audio.newSource("sounds/ui/close/11.ogg", "static",false)
uiSwitch = love.audio.newSource("sounds/ui/switch/4.ogg" , "static",false)
uiScroll = love.audio.newSource("sounds/ui/scroll/2.wav", "static",false)
uiError = love.audio.newSource( "sounds/ui/error/1.ogg", "static",false)
uiParticle =love.audio.newSource("sounds/ui/particl/1.ogg","static",false)
uiParticleDestroy =love.audio.newSource("sounds/ui/particl/3.ogg","static",false)

pickUp = love.audio.newSource("sounds/player/pickUp/1.wav", "static",false)
enExpl = love.audio.newSource("sounds/en/atack/expl.wav", "static",false)
---------------------------------------------------

------------------SETS_And_FON---------------------
meteorSet = love.graphics.newImage("assets/meteorSet.png")
enSet = love.graphics.newImage("assets/enSet.png")
resSet = love.graphics.newImage("assets/resSet.png")
playerSet = love.graphics.newImage("assets/playerSet.png")
UISet = love.graphics.newImage("assets/UISet.png")
skillSet = love.graphics.newImage("assets/skillSet.png")
enBoomAnSet = love.graphics.newImage("assets/enBoomAn.png")
fon1 =love.graphics.newImage("assets/fons/fon1.png") 
fon2 =love.graphics.newImage("assets/fons/fon2.png") 
fon3 =love.graphics.newImage("assets/fons/fon3.png") 

UISet:setFilter("nearest")
meteorSet:setFilter("nearest")
enSet:setFilter("nearest")
playerSet:setFilter("nearest")
fon1:setFilter("nearest")
fon2:setFilter("nearest")
fon3:setFilter("nearest")
---------------------------------------------------

------------------BATCHS---------------------------
boomBatch =  love.graphics.newSpriteBatch(enBoomAnSet)
UIBatch = love.graphics.newSpriteBatch(UISet)
skillBatch = love.graphics.newSpriteBatch(skillSet)
playerBatch = love.graphics.newSpriteBatch(playerSet)
enBatch = love.graphics.newSpriteBatch(enSet)
resBatch = love.graphics.newSpriteBatch(resSet)
enBatchDop = love.graphics.newSpriteBatch(enSet)
enBatchAfterDie = love.graphics.newSpriteBatch(enSet)
---------------------------------------------------
UIQuads = { 
    add = love.graphics.newQuad(241,  0,  240, 250, UISet:getDimensions()),
    ex= love.graphics.newQuad(0,  0,  240, 250, UISet:getDimensions()),
    no= love.graphics.newQuad(241,  251,  240, 240, UISet:getDimensions()),
    yes= love.graphics.newQuad(0,  251,  240, 240, UISet:getDimensions()),
    panel = love.graphics.newQuad(0,  648,  1000, 240, UISet:getDimensions()),
    tableSkillNormal = love.graphics.newQuad(482,  0, 320, 320, UISet:getDimensions()),
    tableSkillRare = love.graphics.newQuad(1001,  361, 360, 360, UISet:getDimensions()),
    tableSkillLegend = love.graphics.newQuad(984,  0, 360, 360, UISet:getDimensions()),
    tableSkillDestr = love.graphics.newQuad(482,  321, 320, 320, UISet:getDimensions()),
    butDirect = love.graphics.newQuad(803,  0, 180, 320, UISet:getDimensions()),
    butDirectRotated = love.graphics.newQuad(1316,  791, 320, 320, UISet:getDimensions()),
    textPanel = love.graphics.newQuad(0,  889, 1000, 320, UISet:getDimensions()), 
    butChange = love.graphics.newQuad(0,  1210, 1340, 146, UISet:getDimensions()), 
    butPoint = love.graphics.newQuad(1017,  751, 120, 200, UISet:getDimensions()), 
}
resQuads = {
    boost =   love.graphics.newQuad(0,0,130,210, resSet:getDimensions()),
    hp =   love.graphics.newQuad(131,0,210,210, resSet:getDimensions()),
    res1 =   love.graphics.newQuad(366,20,14,7, resSet:getDimensions()),
    res2 =   love.graphics.newQuad(366,0,14,14, resSet:getDimensions()),
    res3 =   love.graphics.newQuad(386,0,14,21, resSet:getDimensions()),
}

screenWidth = love.graphics.getWidth()
screenHeight = love.graphics.getHeight()
--k  = screenWidth/1920*2.5
k2 = screenHeight/1080*2.5
k = k2 

--------------STATES--------------
system = require "scripts/systemComponents/system" 
soundFunction = require "scripts/systemComponents/soundFunction"
saveFunction = require "scripts/systemComponents/saveFunction" 
effects = require "scripts/systemComponents/effects" 
UI= require "scripts/systemComponents/UI"
game = require "scripts/gameStates/gameLoop/game"

----------------------------------

----------------------------------

-------------MASIIIIIIV-----------
exp =  {}
mouse = 
{
  x=0,
  y=0
}
-------------CONST AND FLAGS------

gradientR = 1
gradientG = 0 
gradientB = 0 
gradientI = 1
scoreForParticle =15

canvasToEffect= love.graphics.newCanvas(screenWidth ,screenHeight)
-----------------------------------

function love.load()
    if arg[#arg] == "-debug" then 
        require("mobdebug").start() 
    end
    io.stdout:setvbuf("no") 
    math.randomseed(os.time()) 
    love.window.setFullscreen(true,"desktop")
    font = love.graphics.newFont("fonts/1.ttf",60)
    font:setFilter("nearest")
    love.graphics.setFont(font)  
    gamestate.registerEvents()
    gamestate.switch(game)
end