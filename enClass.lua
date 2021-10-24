local enClass =  {} 

function enClassSpawn(tip,Geo)
  if ( tip == 1 ) then 
      local enemyExample = enemyMelee:clone()
      local x,y = enGeo(Geo)
      enemyExample.x = x 
      enemyExample.y = y 
  end
end


enemyMelee = Class{
    init = function(self,w,h,tip,body,timer,invTimer,atack,atackTimer,dash,dashTimer,color1,color2,color3,scale,r,ugol,flagr,damage,f,x,y,ax,ay,health,healthM)
        self.w = 16 
        self.h = 25 
        self.tip = 1 
        self.body =HC.rectangle(-1000*k,-1000*k2,16*k,25*k2)
        self.timer = 0  
        self.invTimer = 20
        self.atack = 0
        self.atackTimer = 60
        self.dash = 0
        self.dashTimer = 20
        self.color1 =0.8
        self.color2=0.2
        self.color3 =0.2
        self.scale = 100
        self.r = 0 
        self.ugol =  0
        self.flagr = 0 
        self.damage = 1  
        self.f = false
        self.x  = -1000*k
        self.y = -1000*k2
        self.ax  =0
        self.ay =0
        self.health = 3
        self.healthM = 3
    end;
  --  kek =  function(self)
  --    return self.size * self.weight
  --  end;
}



return  enClass