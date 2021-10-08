------------------LIBS -----------
gamestate = require "libs/gamestate" 
Timer = require 'libs/hump.timer' 
HC = require 'libs/HC'
moonshine = require 'moonshine'
meteorSet = love.graphics.newImage("assets/meteorSet.png")
playerSet = love.graphics.newImage("assets/playerSet.png")
playerBatch = love.graphics.newSpriteBatch(playerSet)

playerIm = love.graphics.newImage("assets/player/player.png")
playerQuads = {
  body = love.graphics.newQuad(0,  0,  464, 384, playerSet:getDimensions()),
  clow1 = love.graphics.newQuad(465,  0,  200, 152, playerSet:getDimensions()),
  clow2 = love.graphics.newQuad(665,  0,  200, 152, playerSet:getDimensions()),
  tail = love.graphics.newQuad(867,  0,  96, 120,playerSet:getDimensions()),
  cristal = love.graphics.newQuad(942,  173,  80, 136,playerSet:getDimensions()),
  wings = love.graphics.newQuad(465,  153,  448, 256,playerSet:getDimensions()),
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
  },
  -------------------
   {
    texX =259/meteorSetW,
    texY =0,
    texCX = (259+248/2)/meteorSetW,
    texCY =(0+256/2)/meteorSetH,
    texW = 248,
    texH = 256,
    collW = 74.1949,
    collH = 76.6983,
  },
     {
    texX =259/meteorSetW,
    texY =0,
    texCX = (259+248/2)/meteorSetW,
    texCY =(0+256/2)/meteorSetH,
    texW = 248,
    texH = 256,
    collW = 74.1949,
    collH = 76.6983,
  },
  
   {
    texX =259/meteorSetW,
    texY =0,
    texCX = (259+248/2)/meteorSetW,
    texCY =(0+256/2)/meteorSetH,
    texW = 248,
    texH = 256,
    collW = 74.1949,
    collH = 76.6983,
  },
     {
    texX =259/meteorSetW,
    texY =0,
    texCX = (259+248/2)/meteorSetW,
    texCY =(0+256/2)/meteorSetH,
    texW = 248,
    texH = 256,
    collW = 74.1949,
    collH = 76.6983,
  },
  
   {
    texX =259/meteorSetW,
    texY =0,
    texCX = (259+248/2)/meteorSetW,
    texCY =(0+256/2)/meteorSetH,
    texW = 248,
    texH = 256,
    collW = 74.1949,
    collH = 76.6983,
  },
     {
    texX =259/meteorSetW,
    texY =0,
    texCX = (259+248/2)/meteorSetW,
    texCY =(0+256/2)/meteorSetH,
    texW = 248,
    texH = 256,
    collW = 74.1949,
    collH = 76.6983,
  },
  
   {
    texX =259/meteorSetW,
    texY =0,
    texCX = (259+248/2)/meteorSetW,
    texCY =(0+256/2)/meteorSetH,
    texW = 248,
    texH = 256,
    collW = 74.1949,
    collH = 76.6983,
  },
  
}
effect = moonshine(moonshine.effects.godsray)
--.chain(moonshine.effects.crt)
--effect.godsray.samples = 2
--effect.godsray.density = 0.04
--effect.godsray.decay = 0.8
               --   .chain(moonshine.effects.filmgrain)

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

----------------------------------
 myShader = love.graphics.newShader[[
vec4 effect( vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords ){
    vec4 texturecolor = Texel(tex, texture_coords);
    if (texture_coords.x < 0.1 || texture_coords.y < 0.1 || texture_coords.y > 0.9 || texture_coords.x > 0.9) { 
        return texturecolor * color*vec4(1.0,0.5,0.5,1.0);
    }else
    {
        return texturecolor * color*vec4(0.0,0.5,1.0,1.0);
    }
    
 }
]]
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
      radiusCollect = 100,
      damage = 1,
      invTimer = 0.5,
      maxSpeed = 27,
      speed = 13,
      speedA  = 6,
      debaffStrenght =0.2,
      scaleBody = 35,
  
  }
----------------------------------

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




love.graphics.setDefaultFilter('nearest')
love.graphics.setLineStyle('rough')


function love.load()
  if arg[#arg] == "-debug" then require("mobdebug").start() end
  io.stdout:setvbuf("no") 
  math.randomseed(os.time()) 
  love.window.setFullscreen(true,"desktop")
  
  screenWidth = love.graphics.getWidth()
  screenHeight = love.graphics.getHeight()
  
  d1 = screenWidth
  d2 = screenHeight
  
  sx =  screenWidth/gw
  sy = screenHeight/gh
  
  screenWidth = gw
  screenHeight = gh
  
  k  = gw/1366*1.4
  k2 = gh/768*1.4

  font = love.graphics.newFont("fonts/kenvector_future.ttf",40)
  love.graphics.setFont(font) 
   -- love.window.setMode(sx*gw,sy*gh)  
  kek= love.graphics.newCanvas(gw,gh)
  kek2= love.graphics.newCanvas(gw,gh)
  kek3= love.graphics.newCanvas(gw,gh)
  gamestate.registerEvents()
  gamestate.switch(game)
end