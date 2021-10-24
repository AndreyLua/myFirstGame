------------------LIBS -----------
gamestate = require "libs/gamestate" 
Timer = require 'libs/hump.timer' 
Class = require "libs/hump.class"
HC = require 'libs/HC'
moonshine = require 'moonshine'
------------------SETS-----------------------------
meteorSet = love.graphics.newImage("assets/meteorSet.png")
enSet = love.graphics.newImage("assets/enSet.png")
playerSet = love.graphics.newImage("assets/playerSet.png")
---------------------------------------------------
playerBatch = love.graphics.newSpriteBatch(playerSet)
enBatch = love.graphics.newSpriteBatch(enSet)

playerQuads = {
  body = love.graphics.newQuad(0,  0,  464, 384, playerSet:getDimensions()),
  clow1 = love.graphics.newQuad(465,  0,  200, 152, playerSet:getDimensions()),
  clow2 = love.graphics.newQuad(665,  0,  200, 152, playerSet:getDimensions()),
  tail = love.graphics.newQuad(867,  0,  96, 120,playerSet:getDimensions()),
  cristal = love.graphics.newQuad(942,  173,  80, 136,playerSet:getDimensions()),
  wings = love.graphics.newQuad(465,  153,  448, 256,playerSet:getDimensions()),
}
enQuads = {
  body = love.graphics.newQuad(0,  0,  240, 352, enSet:getDimensions()),
  clow1 = love.graphics.newQuad(241,  0,  144, 176, enSet:getDimensions()),
  clow2 = love.graphics.newQuad(386,  0,  144, 176, enSet:getDimensions()),
}

meteorSetW,meteorSetH =  meteorSet:getDimensions()
tableMeteorsPar ={
  {
    texX =0,
    texY =0,
    texCX = (0+228/2)/meteorSetW,
    texCY = (0+256/2)/meteorSetH,
    texW = 228,
    texH = 256,
    collW = 81.3095,
    collH = 85.3333,
  },
    {
    texX =259/meteorSetW,
    texY =0,
    texCX = (259+248/2)/meteorSetW,
    texCY =(0+256/2)/meteorSetH,
    texW = 248,
    texH = 256,
    collW = 74.1949,
    collH = 76.6984,
  },
  ------------------------------------
   {
    texX =1073/meteorSetW,
    texY =0,
    texCX = (1073+216/2)/meteorSetW,
    texCY =(0+256/2)/meteorSetH,
    texW = 216,
    texH = 256,
    collW = 83.3422,
    collH = 100.5714,
  },
  ----------------------------
   {
    texX =518/meteorSetW,
    texY =0,
    texCX = (518+248/2)/meteorSetW,
    texCY =(0+216/2)/meteorSetH,
    texW = 248,
    texH = 216,
    collW = 63.0148,
    collH = 55.3650,
  },
     {
    texX =777/meteorSetW,
    texY =0,
    texCX = (777+256/2)/meteorSetW,
    texCY =(0+208/2)/meteorSetH,
    texW = 256,
    texH = 208,
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
--------------STATES--------------
game = require "game"
bulletFunction = require "bulletFunction"
playerFunction = require "playerFunction"
enFunction = require "enFunction" 
enClass = require "enClass" 
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
      damage = 1,
      invTimer = 0.5,
      maxSpeed = 27,
      speed = 6,
      speedA  = 10,
      debaffStrenght =0.2,
      scaleBody = 35,
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
  screenWidth = love.graphics.getWidth()
  screenHeight = love.graphics.getHeight()
  k  = screenWidth/1920*2.5
  k2 = screenHeight/1080*2.5
  font = love.graphics.newFont("fonts/kenvector_future.ttf",40)
  love.graphics.setFont(font)  
  kek= love.graphics.newCanvas(screenWidth ,screenHeight)
  kek2= love.graphics.newCanvas(screenWidth ,screenHeight)
  kek3= love.graphics.newCanvas(screenWidth ,screenHeight)
  gamestate.registerEvents()
  gamestate.switch(game)
end