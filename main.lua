------------------LIBS -----------
gamestate = require "libs/gamestate" 
Timer = require 'libs/hump.timer' 
Class = require "libs/hump.class"
HC = require 'libs/HC'
moonshine = require 'moonshine'

effect1 = moonshine(moonshine.effects.pixelate)
effect1.pixelate.size =2

------------------SETS-----------------------------
meteorSet = love.graphics.newImage("assets/meteorSet.png")
enSet = love.graphics.newImage("assets/enSet.png")
resSet = love.graphics.newImage("assets/resSet.png")
playerSet = love.graphics.newImage("assets/playerSet.png")
UISet = love.graphics.newImage("assets/UISet.png")
skillSet = love.graphics.newImage("assets/skillSet.png")
enBoomAnSet = love.graphics.newImage("assets/enBoomAn.png")

---------------------------------------------------
boomBatch =  love.graphics.newSpriteBatch(enBoomAnSet)
UIBatch = love.graphics.newSpriteBatch(UISet)
skillBatch = love.graphics.newSpriteBatch(skillSet)
playerBatch = love.graphics.newSpriteBatch(playerSet)
enBatch = love.graphics.newSpriteBatch(enSet)
resBatch = love.graphics.newSpriteBatch(resSet)
enBatchDop = love.graphics.newSpriteBatch(enSet)
enBatchAfterDie = love.graphics.newSpriteBatch(enSet)

boomQuads = { }
boomQuads[1] = love.graphics.newQuad(0,  0,  320, 320, enBoomAnSet:getDimensions())
boomQuads[2] = love.graphics.newQuad(320,  0,  320, 320, enBoomAnSet:getDimensions())
boomQuads[3] = love.graphics.newQuad(620,  0,  320, 320, enBoomAnSet:getDimensions())
boomQuads[4] = love.graphics.newQuad(940,  0,  320, 320, enBoomAnSet:getDimensions())
boomQuads[5] = love.graphics.newQuad(0,  320,  320, 320, enBoomAnSet:getDimensions())
boomQuads[6] = love.graphics.newQuad(320,  320,  320, 320, enBoomAnSet:getDimensions())
boomQuads[7] = love.graphics.newQuad(620,  320,  320, 320, enBoomAnSet:getDimensions())
boomQuads[8] = love.graphics.newQuad(940,  320,  320, 320, enBoomAnSet:getDimensions())
boomQuads[9] = love.graphics.newQuad(0,  640,  320, 320, enBoomAnSet:getDimensions())
boomQuads[10] = love.graphics.newQuad(320,  640,  320, 320, enBoomAnSet:getDimensions())

UIQuads = { 
  add = love.graphics.newQuad(241,  0,  240, 250, UISet:getDimensions()),
  ex= love.graphics.newQuad(0,  0,  240, 250, UISet:getDimensions()),
  no= love.graphics.newQuad(241,  251,  240, 240, UISet:getDimensions()),
  yes= love.graphics.newQuad(0,  251,  240, 240, UISet:getDimensions()),
  panel = love.graphics.newQuad(0,  648,  1000, 240, UISet:getDimensions()),
  tableSkill = love.graphics.newQuad(482,  0, 320, 320, UISet:getDimensions()),
  tableSkillDestr = love.graphics.newQuad(482,  321, 320, 320, UISet:getDimensions()),
  butDirect = love.graphics.newQuad(803,  0, 180, 320, UISet:getDimensions()),
}

skillQuads = { 
  hp = love.graphics.newQuad(0,  0,  320, 320, skillSet:getDimensions()),
  energy = love.graphics.newQuad(320,  0,  320, 320, skillSet:getDimensions()),  
  atack = love.graphics.newQuad(640,  0,  320, 320, skillSet:getDimensions()),
  meleeDef = love.graphics.newQuad(0,  640,  320, 320, skillSet:getDimensions()),
  rangedDef = love.graphics.newQuad(320,  640,  320, 320, skillSet:getDimensions()),
  vampir = love.graphics.newQuad(0,  960,  320, 320, skillSet:getDimensions()),
  
}

playerQuads = {
{
  body = love.graphics.newQuad(0,  0,  464, 384, playerSet:getDimensions()),
  clow1 = love.graphics.newQuad(465,  0,  200, 152, playerSet:getDimensions()),
  clow2 = love.graphics.newQuad(665,  0,  200, 152, playerSet:getDimensions()),
  tail = love.graphics.newQuad(867,  0,  96, 120,playerSet:getDimensions()),
  cristal = love.graphics.newQuad(942,  173,  80, 136,playerSet:getDimensions()),
  wings = love.graphics.newQuad(465,  153,  448, 256,playerSet:getDimensions()),
},
{
  body = love.graphics.newQuad(0,  385,  480, 384, playerSet:getDimensions()),
  clow1 = love.graphics.newQuad(473+15,  410,  192, 144, playerSet:getDimensions()),
  clow2 = love.graphics.newQuad(666+15,  410,  192, 144, playerSet:getDimensions()),
  tail = love.graphics.newQuad(924,  540,  99, 120,playerSet:getDimensions()),
  cristal = love.graphics.newQuad(929,  427,  80, 112,playerSet:getDimensions()),
  wings = love.graphics.newQuad(473+15,  555,  432, 240,playerSet:getDimensions()),
},
{
  body = love.graphics.newQuad(0, 795,  480, 384, playerSet:getDimensions()),
  clow1 = love.graphics.newQuad(534,  814,  184, 144, playerSet:getDimensions()),
  clow2 = love.graphics.newQuad(719,  814,  184, 144, playerSet:getDimensions()),
  tail = love.graphics.newQuad(128,  1180,  99, 120,playerSet:getDimensions()),
  cristal = love.graphics.newQuad(0,  1180,  128, 112,playerSet:getDimensions()),
  wings = love.graphics.newQuad(481,  959,  480, 264,playerSet:getDimensions()),
}
}
enQuads = {
  -----------------------------------------------------------------------------
  bodyMelee = love.graphics.newQuad(0,  0,  120,176, enSet:getDimensions()),
  clow1Melee = love.graphics.newQuad(120,  0,  72, 88, enSet:getDimensions()),
  clow2Melee = love.graphics.newQuad(193,  0,  72, 88, enSet:getDimensions()),
  -----------------------------------------------------------------------------
  bodyShooter = love.graphics.newQuad(0,  177,  126,296, enSet:getDimensions()),
  clow1Shooter = love.graphics.newQuad(111,  177,  80, 64, enSet:getDimensions()),
  clow2Shooter = love.graphics.newQuad(192,  177,  80, 64, enSet:getDimensions()),
  wing1Shooter = love.graphics.newQuad(127,  242,  224, 272, enSet:getDimensions()),
  wing2Shooter = love.graphics.newQuad(0,  515, 224, 272, enSet:getDimensions()),
  -----------------------------------------------------------------------------
  bodyHammer = love.graphics.newQuad(248, 522, 240, 310, enSet:getDimensions()),
  -----------------------------------------------------------------------------
  bodyBomb = love.graphics.newQuad(360,  249, 217, 218, enSet:getDimensions()),
  clow1Bomb = love.graphics.newQuad(597,  190,  59, 86, enSet:getDimensions()),
  clow2Bomb = love.graphics.newQuad(657,  190,  59, 86, enSet:getDimensions()),
  -----------------------------------------------------------------------------
  bodyСleaner = love.graphics.newQuad(0,  833, 238, 364, enSet:getDimensions()),
  wing1Сleaner = love.graphics.newQuad(239,  833,  217, 154, enSet:getDimensions()),
  wing2Сleaner = love.graphics.newQuad(239,  988, 217, 154, enSet:getDimensions()),
  -----------------------------------------------------------------------------
  bodyClower = love.graphics.newQuad(457,  983, 182, 217, enSet:getDimensions()),
  clow1Clower = love.graphics.newQuad(489,  530, 175, 245, enSet:getDimensions()),
  clow2Clower = love.graphics.newQuad(640,  955, 175, 245, enSet:getDimensions()),
  -----------------------------------------------------------------------------
  bodyInvader = love.graphics.newQuad(717,  0, 224, 420, enSet:getDimensions()),
  wing1Invader = love.graphics.newQuad(942,  22, 252, 364, enSet:getDimensions()),
  wing2Invader = love.graphics.newQuad(912,  405, 252, 364, enSet:getDimensions()),
}
resQuads = {
  boost =   love.graphics.newQuad(0,0,130,210, resSet:getDimensions()),
  hp =   love.graphics.newQuad(131,0,210,210, resSet:getDimensions()),
  res1 =   love.graphics.newQuad(366,20,14,7, resSet:getDimensions()),
  res2 =   love.graphics.newQuad(366,0,14,14, resSet:getDimensions()),
  res3 =   love.graphics.newQuad(386,0,14,21, resSet:getDimensions()),
}

meteorSetW,meteorSetH =  meteorSet:getDimensions()
tableMeteorsPar ={
  {
    texX =434/meteorSetW,
    texY =0,
    texCX = (434+416/2)/meteorSetW,
    texCY = (0+440/2)/meteorSetH,
    texW = 416,
    texH = 440,
    collW = 81.3095,--
    collH = 85.3333,
  },
    {
    texX =860/meteorSetW,
    texY =0,
    texCX = (860+384/2)/meteorSetW,
    texCY =(0+392/2)/meteorSetH,
    texW = 384,
    texH = 392,
    collW = 74.1949,
    collH = 76.6984,
  },
  ------------------------------------
   {
    texX =0/meteorSetW,
    texY =0,
    texCX = (0+424/2)/meteorSetW,
    texCY =(0+512/2)/meteorSetH,
    texW = 424,
    texH = 512,--
    collW = 83.3422,
    collH = 100.5714,
  },
  ----------------------------
   {
    texX =1254/meteorSetW,
    texY =0,
    texCX = (1254+328/2)/meteorSetW,
    texCY =(0+288/2)/meteorSetH,
    texW = 328,
    texH = 288,--
    collW = 63.0148,
    collH = 55.3650,
  },
     {
    texX =1592/meteorSetW,
    texY =0,
    texCX = (1592+216/2)/meteorSetW,
    texCY =(0+168/2)/meteorSetH,
    texW = 216,
    texH = 168,--
    collW = 40.14657,
    collH = 32.50793,
  }
  -------------------
}

vect = {}
lenVect = 1000
for i= 1, lenVect do
    local texCordi = {
        0, 0, 
        0, 0,
        1, 1, 1,
    }
    table.insert(vect,texCordi)
end
kekKK= 0 
meshMeteors = love.graphics.newMesh(vect, "triangles")
meshMeteors:setTexture(meteorSet)

fon1 =love.graphics.newImage("assets/fons/fon1.png") 
fon2 =love.graphics.newImage("assets/fons/fon2.png") 
fon3 =love.graphics.newImage("assets/fons/fon3.png") 

screenWidth = love.graphics.getWidth()
screenHeight = love.graphics.getHeight()
--k  = screenWidth/1920*2.5
k2 = screenHeight/1080*2.5
k = k2 

--------------STATES--------------
game = require "game"
bulletFunction = require "bulletFunction"
playerFunction = require "playerFunction"
enFunction = require "enFunction"
resSimpleClass =  require "resSimpleClass" 
enClassMelee = require "enClassMelee" 
enClassHammer = require "enClassHammer" 
enClassShooter = require "enClassShooter" 
enClassInvader = require "enClassInvader" 
enClassBomb = require "enClassBomb" 
enClassСleaner = require "enClassCleaner" 
resFunction = require "resFunction" 
objFunction = require "objFunction" 
wavesFunction = require "wavesFunction" 
pause = require "pause" 
skills = require "skills" 
convert = require "convert"
character = require "character"
settings = require "settings" 
effects = require "effects" 
system = require "system" 
UI= require "UI"
----------------------------------
-----------TIMERS-----------------
inv = Timer.new()
hp1 = Timer.new()
hp2 = Timer.new()
hp3 = Timer.new()
boost1 = Timer.new()
boost2 = Timer.new()
textT  =  Timer.new()
wavetimer=  Timer.new()
----------------------------------
-------------MASIIIIIIV-----------
exp =  {}
particl =  {}
mouse = {
  x=0,
  y=0
}
-------------------------------------------------------------------
allSkills = {}
--######################COMMON###########################################
allSkills[1] = skillQuads.hp
allSkills[2] = skillQuads.energy
allSkills[3] = skillQuads.meleeDef
allSkills[4] = skillQuads.rangedDef
allSkills[5] = skillQuads.atack
allSkills[6] = skillQuads.atack---------
allSkills[7] = skillQuads.atack-----------
-------------------------------------------------------------------


  
playerDrawPar = {
    {
      bodyW  = 464, 
      bodyH  = 384, 
      clowW1 = 176,
      clowW2 = 16,
      clowX = 26,
      clowH = 80,
      clowR = 0.17219081452294,
      tailW = 96,
      tailH = 120,
      cristalW = 80,
      cristalH = 136,
      wingsW = 448,
      wingsH = 256,
      wingsX = 40,
      cristalX = 20,
    },
    {
      bodyW  = 472, 
      bodyH  = 384, 
      clowW1 = 152,
      clowW2 = 40,
      clowR = 0.28219081452294,
      clowX = 23,
      clowH = 96,
      tailW = 99,
      tailH = 120,
      cristalW = 74,
      cristalH = 112,
      wingsW = 424,
      wingsH = 241,
      wingsX = 40,
      cristalX = 24,
    },
    {
      bodyW  = 480, 
      bodyH  = 384, 
      clowW1 = 184,
      clowW2 = 0,
      clowH = 131,
      clowX = 17,
      clowR = 0.17219081452294,
      tailW = 99,
      tailH = 120,
      cristalW = 128,
      cristalH = 112,
      wingsW = 480,
      wingsH = 264,
      wingsX =44,
      cristalX = 55,
    }, 
}

playerAbility = {
    tip =3 , 
    mass =200,
    radiusCollect = 100,
    damage = 1,
    invTimer = 0.5,
    maxSpeed = 30,
    speed = 6,
    speedA  = 10,
    debaffStrenght =0.2,
    scaleBody = 35,
    boostRegen = 100,
    boostWaste = 150,
}
playerSkills = {}
playerSkills[1] ={
img =skillQuads.hp,
lvl = 0,
}
playerSkills[2] ={
img =skillQuads.energy,
}
playerSkills[3] ={
img =skillQuads.atack,
}
playerSkills[4] ={
img =skillQuads.meleeDef,
}
playerSkills[5] ={
img =skillQuads.rangedDef,
}
playerSkills[6] ={
img =skillQuads.vampir,
}

-------------CONST AND FLAGS------
volume = 50
sens = 50
flagVibr = false
gradientR = 1
gradientG = 0 
gradientB = 0 
gradientI = 1

scoreForParticle =10
colbaPar =  0
----------------------------------

function love.load()
    if arg[#arg] == "-debug" then require("mobdebug").start() end
    io.stdout:setvbuf("no") 
    math.randomseed(os.time()) 
    love.window.setFullscreen(true,"desktop")
    font = love.graphics.newFont("fonts/1.ttf",60)
    font:setFilter("nearest")
    love.graphics.setFont(font)  
    kek= love.graphics.newCanvas(screenWidth ,screenHeight)
    kek2= love.graphics.newCanvas(screenWidth ,screenHeight)
    kek3= love.graphics.newCanvas(screenWidth ,screenHeight)
    gamestate.registerEvents()
    gamestate.switch(game)
end