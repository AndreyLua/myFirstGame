------------------LIBS -----------
gamestate = require "libs/gamestate" 
Timer = require 'libs/hump.timer' 
Class = require "libs/hump.class"
HC = require 'libs/HC'
moonshine = require 'moonshine'

effect = moonshine(moonshine.effects.boxblur)
                  .chain(moonshine.effects.filmgrain)
                  .chain(moonshine.effects.vignette)
effect.disable("boxblur", "filmgrain")
effect.enable("filmgrain")
  
------------------SETS-----------------------------
meteorSet = love.graphics.newImage("assets/meteorSet.png")
enSet = love.graphics.newImage("assets/enSet.png")
playerSet = love.graphics.newImage("assets/playerSet.png")
---------------------------------------------------
playerBatch = love.graphics.newSpriteBatch(playerSet)
enBatch = love.graphics.newSpriteBatch(enSet)
enBatchDop = love.graphics.newSpriteBatch(enSet)

playerQuads = {
  body = love.graphics.newQuad(0,  0,  464, 384, playerSet:getDimensions()),
  clow1 = love.graphics.newQuad(465,  0,  200, 152, playerSet:getDimensions()),
  clow2 = love.graphics.newQuad(665,  0,  200, 152, playerSet:getDimensions()),
  tail = love.graphics.newQuad(867,  0,  96, 120,playerSet:getDimensions()),
  cristal = love.graphics.newQuad(942,  173,  80, 136,playerSet:getDimensions()),
  wings = love.graphics.newQuad(465,  153,  448, 256,playerSet:getDimensions()),
}
enQuads = {
  bodyMelee = love.graphics.newQuad(0,  0,  120,176, enSet:getDimensions()),
  clow1Melee = love.graphics.newQuad(120,  0,  72, 88, enSet:getDimensions()),
  clow2Melee = love.graphics.newQuad(193,  0,  72, 88, enSet:getDimensions()),
  bodyShooter = love.graphics.newQuad(0,  177,  126,296, enSet:getDimensions()),
  clow1Shooter = love.graphics.newQuad(111,  177,  80, 64, enSet:getDimensions()),
  clow2Shooter = love.graphics.newQuad(192,  177,  80, 64, enSet:getDimensions()),
  wing1Shooter = love.graphics.newQuad(127,  242,  224, 272, enSet:getDimensions()),
  wing2Shooter = love.graphics.newQuad(0,  515, 224, 272, enSet:getDimensions()),
  bodyHammer = love.graphics.newQuad(248, 522, 240, 310, enSet:getDimensions()),
  bodyBomb = love.graphics.newQuad(360,  249, 217, 218, enSet:getDimensions()),
  clow1Bomb = love.graphics.newQuad(597,  190,  59, 86, enSet:getDimensions()),
  clow2Bomb = love.graphics.newQuad(657,  190,  59, 86, enSet:getDimensions()),
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
----------------------------------

--myShader = love.graphics.newShader[[
--vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
 -- vec4 pixel = Texel(texture, texture_coords );
  --number average = (pixel.r+pixel.b+pixel.g)/3.0;
 -- number factor = screen_coords.x/1920;
 -- pixel.r = pixel.r + (average-pixel.r) * factor;
--  pixel.g = pixel.g + (average-pixel.g) * factor;
 -- pixel.b = pixel.b + (average-pixel.b) * factor;
 -- return pixel;
--}

--  myShader = love.graphics.newShader[[
--vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
--  vec4 pixel = Texel(texture, texture_coords );//This is the current pixel color
--  return pixel;
--}
--vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
--{
---    vec4 texturecolor = Texel(tex, texture_coords);
--    return texturecolor * color;
--}
 -- ]]
 
screenWidth = love.graphics.getWidth()
screenHeight = love.graphics.getHeight()
k  = screenWidth/1920*2.5
k2 = screenHeight/1080*2.5
--------------STATES--------------
game = require "game"
bulletFunction = require "bulletFunction"
playerFunction = require "playerFunction"
enFunction = require "enFunction"
enClassMelee = require "enClassMelee" 
enClassHammer = require "enClassHammer" 
enClassShooter = require "enClassShooter" 
enClassBomb = require "enClassBomb" 
resFunction = require "resFunction" 
objFunction = require "objFunction" 
pause = require "pause" 
skills = require "skills" 
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
mouse = {
  x=0,
  y=0
}
playerAbility = {
      mass =200,
      radiusCollect = 100,
      damage = 100,
      invTimer = 0.5,
      maxSpeed = 30,
      speed = 6,
      speedA  = 10,
      debaffStrenght =0.2,
      scaleBody = 35,
      boostRegen = 100,
      boostWaste = 250,
}
-------------CONST AND FLAGS------
lvl =0
volume = 50
sens = 50
flagVibr = false
gradientR = 1
gradientG = 0 
gradientB = 0 
gradientI = 1
----------------------------------

function love.load()
  if arg[#arg] == "-debug" then require("mobdebug").start() end
  io.stdout:setvbuf("no") 
  math.randomseed(os.time()) 
  love.window.setFullscreen(true,"desktop")
  font = love.graphics.newFont("fonts/kenvector_future.ttf",40)
  love.graphics.setFont(font)  
  kek= love.graphics.newCanvas(screenWidth ,screenHeight)
  kek2= love.graphics.newCanvas(screenWidth ,screenHeight)
  kek3= love.graphics.newCanvas(screenWidth ,screenHeight)
  gamestate.registerEvents()
  gamestate.switch(game)
end