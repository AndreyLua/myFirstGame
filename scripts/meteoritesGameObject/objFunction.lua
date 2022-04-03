local objFunction = {}

function objTip(t)
local BODY 

if  t == 1 then
    BODY  =  HC.polygon( -2.7217261904762*k, -40.825396825397*k2, -25.590029761905*k, -27.619047619048*k2, -42.360119047619*k, -11.365079365079*k2, -     28.130952380952*k,   23.68253968254*k2,  14.048363095238*k,  39.428571428571*k2,  32.343005952381*k,  23.68253968254*k2,  36.916666666667*k, -             5.2698412698413*k2,  38.949404761905*k, -28.126984126984*k2,  18.113839285714*k, -45.904761904762*k2) 
 end  
if  t == 2 then
    BODY =  HC.polygon(  37.424851190476*k,   -9.8412698412698*k2,  40.473958333333*k,    34.857142857143*k2,  8.4583333333334*k,    43.492063492064*k2, -12.377232142857*k,    44.507936507937*k2, -33.720982142857*k,    21.142857142857*k2, -18.475446428571*k,   -26.095238095238*k2,  12.52380952381*k,   -32.190476190476*k2)
end   
if  t == 3 then 
    BODY = HC.polygon(  39.965773809524*k,   -48.952380952381*k2,  48.096726190476*k,    7.9365079365079*k2,  17.605654761905*k,    37.396825396825*k2, -10.852678571429*k,    37.396825396825*k2, -29.147321428571*k,    5.9047619047619*k2, -35.245535714286*k,   -40.825396825397*k2, -11.869047619048*k,   -63.174603174603*k2)
end
if  t == 4 then  
    BODY =  HC.polygon(  35.245535714286*k,  -7.3015873015873*k2,  27.622767857143*k,   15.047619047619*k2,  12.885416666667*k,   27.746031746032*k2, -8.4583333333334*k,   27.746031746032*k2, -23.195684523809*k,   0.82539682539683*k2, -27.769345238095*k,  -20.507936507937*k2, -5.4092261904762*k,  -27.619047619048*k2)
end
if  t == 5 then
    BODY =  HC.polygon( -2.8683035714286*k,   2.8571428571429*k2,  15.934523809524*k,   1.3333333333333*k2, 20.50818452381*k,  -18.47619047619*k2, 9.328125*k,  -29.650793650794*k2, -14.556547619048*k,  -27.111111111111*k2, -19.638392857143*k,  -11.365079365079*k2, -17.097470238095*k,  -0.69841269841269*k2)
end
----------------------------------------------med
if  t == 6 then
end
if  t == 7 then
end
if  t == 8 then
end
----------------------------------------------litle
if  t == 9 then  
end
if  t == 10 then
end

return BODY
end

function objBody(i,dt)
    local xF,yF = obj[i].body:center()
    obj[i].body:moveTo(obj[i].x, obj[i].y)
    local xF2,yF2 = obj[i].body:center()
    local Glr = obj[i].ra*dt
    obj[i].body:rotate(Glr,obj[i].x,obj[i].y) 
    obj[i].r = obj[i].r + Glr
    if ( obj[i].r> math.pi*2) then
        obj[i].r = obj[i].r- math.pi*2
    end
    if ( obj[i].bodyDop) then
        obj[i].rDop2 = obj[i].rDop2 + Glr
        for j = 1 ,#obj[i].bodyDop,2 do
            local kekkl = obj[i].bodyDop
            kekkl[j] = kekkl[j]  + xF2 -xF
            kekkl[j+1] = kekkl[j+1]  + yF2 -yF
        end
        obj[i].centrTX = obj[i].centrTX + xF2 -xF
        obj[i].centrTY = obj[i].centrTY + yF2 -yF
    end
end

function objColorAndScale(t)
    if  t == 1 then 
        return 0.478,0.239,0.373,200,95 -- big
    end
    if  t == 2 then 
        return  0.165,0.243,0.357,210,100 -- big
    end
    if  t == 3 then 
        return 0.212,0.224,0.404,300,120 -- big
    end
    if  t == 4 then 
        return 0.208,0.208,0.208,100,67 -- small
    end
    if  t == 5 then 
        return 0.267,0.075,0.188,80,50 -- small
    end
end

function objDestroy(mas,i)
    if ( mas[i].body) then 
        local centrTX = 0
        local centrTY = 0
        local start = 1
        local finish = 1
        local finish2 = 1
        local pok =  mas[i].pok
        local count = 0 
        local xf , yf  = mas[i].body:center()
        local masGl = {mas[i].body:unpackHC()}
        if (mas[i].pok>1) then
             mas[i].body:rotate(-mas[i].rDop,mas[i].centrTX,mas[i].centrTY)
        else
             mas[i].body:rotate(-mas[i].r,mas[i].centrTX,mas[i].centrTY)
        end
        local masGl2 = {mas[i].body:unpackHC()}
        local xf2 , yf2  = mas[i].body:center()
        if ( pok == 0 ) then 
            centrTX = xf2
            centrTY = yf2
        else
            centrTX = mas[i].centrTX
            centrTY = mas[i].centrTY
        end
        local angle = math.atan2(mas[i].x- Player.x,mas[i].y- Player.y)
        local kolMeteor = 6 
       
        if ( mas[i].scale <50 ) then
            kolMeteor = 8
        end
        if (#masGl>kolMeteor) then
            spawnResCrackMet(i)
            for kkl = 1, #masGl/2-1 do 
                if ( #masGl> 8) then
                    finish = finish+4 
                else
                    finish = finish+2
                end
                if (finish+1> #masGl) then
                    break    
                end
                local BODY = HC.polygon(xf,yf,unpack(masGl,start,finish+1))
                local BODY2 = HC.polygon(xf2,yf2,unpack(masGl2,start,finish+1))
                local masDopGl ={unpack(objDestroyAngle({xf2,yf2,unpack(masGl2,start,finish+1)}))}
                table.remove(masDopGl,#masDopGl)
                finish2 =finish+1
                local x1 , y1   = BODY:center()
                local xc , yc   = BODY2:center()
                local colorDop1 = mas[i].color1
                local colorDop2 = mas[i].color2
                local colorDop3 = mas[i].color3
                local ee = {
                    centrTX = centrTX,
                    centrTY = centrTY,
                    pok = pok+1,
                    invTimer = 8,
                    health = 1,
                    ot = false,
                    body   =  BODY, 
                    bodyDop = masDopGl,
                    rDop = mas[i].r,
                    rDop2 = 0,
                    scale = mas[i].scale/4,
                    collScale = mas[i].collScale/1.5,
                    xc  = xc, 
                    yc =  yc , 
                    r =mas[i].r ,
                    timer =8-0.0001,
                    flag =true,
                    color1 =colorDop1,
                    color2=colorDop2,
                    color3 =colorDop3,
                    f = false,
                    x  = x1, 
                    y =  y1 ,  
                    ax = mas[i].ax+mas[i].ax*math.random(-5,5)/10, 
                    ay = mas[i].ay+mas[i].ay*math.random(-5,5)/10,  
                    met = mas[i].met,
                    ra =math.random()*math.random(-1,1),
                
                }
                start = finish
                table.insert(obj,ee)
                count = count + 1
            end
            local BODY = HC.polygon(xf,yf,masGl[1],masGl[2],unpack(masGl,finish2-1,#masGl))
            local BODY2 = HC.polygon(xf2,yf2,masGl2[1],masGl2[2],unpack(masGl2,finish2-1,#masGl2))
           -- local masDopGl ={xf2,yf2,masGl2[1],masGl2[2],unpack(masGl2,finish2-1,#masGl2)}
            local masDopGl ={unpack(objDestroyAngle({xf2,yf2,masGl2[1],masGl2[2],unpack(masGl2,finish2-1,#masGl2)}))}
            table.remove(masDopGl,#masDopGl)
            local x1 , y1   = BODY:center()
            local xc , yc   = BODY2:center()
            local colorDop1 = mas[i].color1
            local colorDop2 = mas[i].color2
            local colorDop3 = mas[i].color3
            local ee = {
                centrTX = centrTX,
                centrTY = centrTY,
                pok = pok+1,
                invTimer = 8,
                health =1,
                ot = false,
                body   =  BODY, 
                bodyDop = masDopGl,
                rDop2 = 0,
                rDop = mas[i].r,
                r =0 ,
                timer = 8-0.00001,
                flag =false,
                color1 =colorDop1,
                color2=colorDop2,
                color3 =colorDop3,
                scale = mas[i].scale/4,
                collScale = mas[i].collScale/1.5,
                f = true,
                x  = x1, 
                y =  y1 ,  
                xc  = xc, 
                yc =  yc , 
                ax = mas[i].ax+mas[i].ax*math.random(-5,5)/10, 
                ay = mas[i].ay+mas[i].ay*math.random(-5,5)/10,   
                met =mas[i].met,
                ra =math.random()*math.random(-1,1),
            }
            start = finish
            table.insert(obj,ee)
        else
            spawnDelMet(i)
        end
    end
end

function objDestroyAngle(mas)
   local masDop = {}
   local angle = 0
   local leng = 0 
   local sinx = 0
   local cosy = 0 
   --local Gk = k * 16
   for i = 3, #mas-1, 2 do
     angle = math.atan2(mas[i]-mas[i-2],mas[i+1]- mas[i-1]) 
     leng =  math.sqrt(math.pow(mas[i]-mas[i-2],2)+math.pow(mas[i+1]- mas[i-1],2))
     sinx = math.sin(angle)
     cosy = math.cos(angle)
     table.insert(masDop,mas[i-2]+sinx*leng/10)
     table.insert(masDop,mas[i-1]+cosy*leng/10)
     table.insert(masDop,mas[i]-sinx*leng/10)
     table.insert(masDop,mas[i+1]-cosy*leng/10)
    end 
     angle = math.atan2(mas[#mas-1]-mas[1],mas[#mas]- mas[2]) 
     leng =  math.sqrt(math.pow(mas[#mas-1]-mas[1],2)+math.pow(mas[#mas]- mas[2],2))
     sinx = math.sin(angle)
     cosy = math.cos(angle)
     table.insert(masDop,mas[#mas-1]-sinx*leng/10)
     table.insert(masDop,mas[#mas]-cosy*leng/10)
     table.insert(masDop,mas[1]+sinx*leng/10)
     table.insert(masDop,mas[2]+cosy*leng/10)
     table.insert(masDop,mas[2]+cosy*leng/10)
   return masDop
end

function objMove(i,dt) 
    if (obj[i]) then
        objBody(i,dt)
        if ( obj[i].f == true ) then 
        -----------------------------------------------      
            obj[i].ot =false
            obj[i].x= obj[i].x+obj[i].ax*dt
            obj[i].y= obj[i].y+obj[i].ay*dt
        -----------------------------------------------  
        else
        -----------------------------------------------   
            obj[i].ot =false
            obj[i].x= obj[i].x+obj[i].ax*dt
            obj[i].y= obj[i].y+obj[i].ay*dt
        -----------------------------------------------  
      end
      if ( obj[i].ax > 200*k) then 
          obj[i].ax =200*k
      end 
      if ( obj[i].ax < -200*k ) then 
        obj[i].ax =-200*k
      end 
      if ( obj[i].ay > 200*k2 ) then 
           obj[i].ay =200*k2
      end 
      if ( obj[i].ay < -200*k2 ) then 
          obj[i].ay =-200*k2
      end 
      
      
      
      if ( obj[i].ax > 100*k) then 
          obj[i].ax =obj[i].ax - 10*dt*k
      end 
      if ( obj[i].ax < -100*k ) then 
          obj[i].ax =obj[i].ax + 10*dt*k
      end 
      if ( obj[i].ay > 100*k2 ) then 
          obj[i].ay =obj[i].ay - 10*dt*k2
      end 
      if ( obj[i].ay < -100*k2 ) then 
          obj[i].ay =obj[i].ay + 10*dt*k2
      end 
    end
end

function objCollWithPlayerInRegularS(index,dt)
    if ( objRegulS[index]) then 
        local kek = objRegulS[index]
        for i = #kek, 1, -1 do
            if (obj[kek[i]] and obj[kek[i]].body and obj[kek[i]].invTimer==obj[kek[i]].timer and math.abs(obj[kek[i]].x - (Player.x))<Player.scaleBody*k+obj[kek[i]].collScale/2*k and math.abs(obj[kek[i]].y - (Player.y))<Player.scaleBody*k2+obj[kek[i]].collScale/2*k2  and  (math.pow((obj[kek[i]].x - (Player.x)),2) + math.pow((obj[kek[i]].y - (Player.y)),2))<=math.pow((Player.scaleBody*k+obj[kek[i]].collScale/2*k),2))  then
                local collisFlag, intVectorX ,intVectorY = Player.body:collidesWith(obj[kek[i]].body)
                if (collisFlag) then
                    objCollWithPlayerResult(kek[i],dt,intVectorX ,intVectorY)
                end
            end
        end
    end
end

function objCollWithPlayerResult(i, dt,intVectorX ,intVectorY)
    local angleD = math.atan2(Player.x-obj[i].x,Player.y-obj[i].y)
    local sumMas = obj[i].scale + Player.mass
    if ( Player.a == 1 ) then 
        obj[i].ax= obj[i].ax-80000*dt*k*math.sin(angleD)/obj[i].scale +(Player.ax*Player.speedA*k*dt*Player.debaffStrenght)/obj[i].scale*1000
        obj[i].ay=  obj[i].ay-80000*dt*k2*math.cos(angleD)/obj[i].scale +(Player.ay*Player.speedA*k2*dt*Player.debaffStrenght)/obj[i].scale*1000
    else
        obj[i].ax= obj[i].ax-40000*dt*k*math.sin(angleD)/obj[i].scale +(Player.ax*Player.speed*k*dt*Player.debaffStrenght)/obj[i].scale*500
        obj[i].ay=  obj[i].ay-40000*dt*k2*math.cos(angleD)/obj[i].scale +(Player.ay*Player.speed*k2*dt*Player.debaffStrenght)/obj[i].scale*500
    end
    ---
    if ((intVectorX*intVectorX+intVectorY*intVectorY>=math.pow(0.05*obj[i].collScale*k,2))) then
        obj[i].x  = obj[i].x - intVectorX*dt*5
        obj[i].y = obj[i].y - intVectorY*dt*5
    end
    ----
    Player.debaffStrenght =(1-obj[i].scale/sumMas)
    obj[i].health = obj[i].health -2*Player.damage
    obj[i].timer= obj[i].invTimer - 0.001

end



function objCollWithObjInRegularS(index,j,dt)
    if ( objRegulS[index]) then 
        local kek = objRegulS[index]
        if (kek) then
            for i = #kek, 1, -1 do
                if (kek[i] and obj[kek[i]] and obj[j]) then
                    if ( kek[i]~=j and math.abs(obj[kek[i]].x - obj[j].x)<obj[kek[i]].collScale*k/2+obj[j].collScale*k/2 and math.abs(obj[kek[i]].y - obj[j].y)<obj[kek[i]].collScale*k2/2+obj[j].collScale*k2/2 and  (math.pow((obj[kek[i]].x - obj[j].x),2) + math.pow((obj[kek[i]].y - obj[j].y),2))<=math.pow((obj[kek[i]].collScale*k/2+obj[j].collScale*k/2),2)) then
                        local collisFlag, intVectorX ,intVectorY = obj[j].body:collidesWith(obj[kek[i]].body)
                        if (collisFlag) then
                            local lenIntVector = math.sqrt(intVectorX*intVectorX+intVectorY*intVectorY)
                            local rvX, rvY = obj[kek[i]].ax-obj[j].ax,  obj[kek[i]].ay -obj[j].ay
                            local deepX = intVectorX
                            local deepY = intVectorY
                            
                            intVectorX = (intVectorX/lenIntVector)
                            intVectorY = (intVectorY/lenIntVector)
                            local velAlNorm  = rvX*intVectorX + rvY*intVectorY
                            if ( velAlNorm > 0) then
                                local e =0.5
                                local scImp = -(1+e)*velAlNorm
                                scImp = scImp/(1/obj[kek[i]].scale+1/obj[j].scale)
                                local sumMas = obj[kek[i]].scale + obj[j].scale
                                local impulsX, impulsY = scImp * intVectorX, scImp* intVectorY
                                obj[kek[i]].ax= obj[kek[i]].ax+dt*80*(1/obj[kek[i]].scale*impulsX)*obj[kek[i]].scale/sumMas
                                obj[kek[i]].ay= obj[kek[i]].ay+dt*80*(1/obj[kek[i]].scale*impulsY)*obj[kek[i]].scale/sumMas
                                obj[j].ax=obj[j].ax - dt*80*(1/obj[j].scale*impulsX)*obj[j].scale/sumMas
                                obj[j].ay=obj[j].ay - dt*80*(1/obj[j].scale*impulsY)*obj[j].scale/sumMas
                            end
                            if ((deepX*deepX+deepY*deepY>=math.pow(0.05*obj[j].collScale*k,2))) then
                                obj[kek[i]].x  = obj[kek[i]].x - deepX*dt*5
                                obj[kek[i]].y = obj[kek[i]].y - deepY*dt*5
                                obj[j].x  = obj[j].x + deepX*dt*5
                                obj[j].y = obj[j].y +  deepY*dt*5
                                obj[j].ra = obj[j].ra * 0.98
                                obj[kek[i]].ra = obj[kek[i]].ra * 0.98
                            end
                        end 
                    end
                end
            end
        end
    end
end
  
  
  
  
  
  
  
  
  --[[
  
              
                    local collisFlag, intVectorX ,intVectorY = obj[j].body:collidesWith(obj[i].body)
                    if (collisFlag) then
                        local rvX, rvY = obj[j].x - obj[i].x, obj[j].y - obj[i].y
                        local velAlNorm  = rvX*intVectorX + rvY*intVectorY
                        if ( velAlNorm > 0) then
                            local e = 1
                            local scImp = -(1+e)*velAlNorm
                            scImp = scImp/(1/obj[i].scale+1/obj[j].scale)
                            local sumMas = obj[i].scale + obj[j].scale
                            local impulsX, impulsY = scImp * intVectorX, scImp* intVectorY
                            obj[i].ax= obj[i].ax + 0.001*(1/obj[i].scale*impulsX)*obj[i].scale/sumMas
                            obj[i].ay= obj[i].ay + 0.001*(1/obj[i].scale*impulsY)*obj[i].scale/sumMas
                            
                            obj[j].ax=obj[j].ax - 0.001*(1/obj[j].scale*impulsX)*obj[j].scale/sumMas
                            obj[j].ay=obj[j].ay - 0.001*(1/obj[j].scale*impulsY)*obj[j].scale/sumMas
                          
                            if ((math.abs(intVectorX)+math.abs(intVectorY))>0.07*obj[j].collScale*k) then
                                obj[i].x  = obj[i].x - intVectorX*0.1
                                obj[i].y = obj[i].y - intVectorY*0.1
                                obj[j].x  = obj[j].x + intVectorX*0.1
                                obj[j].y = obj[j].y + intVectorY*0.1
                                
                                obj[i].ra = obj[i].ra *0.99
                                obj[j].ra = obj[j].ra *0.99
                            end
                        end
                    end 
                end
            end
            ]]--







function  objVect(i,color1,color2,color3)
    local parametrs = tableMeteorsPar[obj[i].met]

    local kHalf  = k/2 
    local k2Half  = k2/2 
    local collWK =  parametrs.collW*kHalf
    local collHK =  parametrs.collH*k2Half
    local texCord = {
        {
            obj[i].x-collWK, obj[i].y-collHK, 
            parametrs.texX, parametrs.texY, 
            color1,color2,color3, 
        },
        {
            obj[i].x+collWK, obj[i].y-collHK, 
            parametrs.texW/meteorSetW+parametrs.texX, parametrs.texY, 
            color1,color2,color3, 
        },
        {
            obj[i].x+collWK, obj[i].y+collHK,
            parametrs.texW/meteorSetW+parametrs.texX, parametrs.texH/meteorSetH+parametrs.texY, 
            color1,color2,color3, 
        },
                              
        {
            obj[i].x-collWK, obj[i].y-collHK, 
            parametrs.texX, parametrs.texY, 
            color1,color2,color3, 
        },
        {
            obj[i].x-collWK, obj[i].y+collHK, 
            parametrs.texX, parametrs.texH/meteorSetH+parametrs.texY, 
            color1,color2,color3,
        },
        {
            obj[i].x+collWK, obj[i].y+collHK, 
            parametrs.texW/meteorSetW+parametrs.texX, parametrs.texH/meteorSetH+parametrs.texY, 
            color1,color2,color3,
        },
    }
     
    for j= 1, #texCord do
        local point = texCord[j]
        local transform = love.math.newTransform(obj[i].x,obj[i].y,obj[i].r,1,1,obj[i].x,obj[i].y)
        point[1], point[2] = transform:transformPoint(point[1], point[2] )
        table.insert(vect,texCord[j])
    end   
end

function objFragmVect(i,color1,color2,color3)
    local kekXY =obj[i].bodyDop 
    local centrX = obj[i].centrTX
    local centrY = obj[i].centrTY
    local parametrs = tableMeteorsPar[obj[i].met]
    local GlElement = {}
    local GlElement2 = {}
    for j = 1 ,#obj[i].bodyDop,2 do
        local cordX = kekXY[j] 
        local cordY = kekXY[j+1] 
        local element = {
            cordX, cordY,
            parametrs.texCX-((centrX-cordX)*(parametrs.texW/parametrs.collW))/meteorSetW/k,parametrs.texCY-((centrY-cordY)*(parametrs.texH/parametrs.collH))/meteorSetH/k2, 
            color1,color2,color3
        }
        table.insert(GlElement,element)
        table.insert(GlElement2,element)
        if (#GlElement2==3) then
            local transform = love.math.newTransform(centrX , centrY ,obj[i].rDop,1,1, centrX ,centrY ) 
            local transform2 = love.math.newTransform(obj[i].x , obj[i].y ,obj[i].rDop2,1,1, obj[i].x ,obj[i].y ) 
            for iPointMesh = 1,3 do
                if ( j<=5) then
                    local Glk = GlElement2[iPointMesh]
                    Glk[1],Glk[2] =transform:transformPoint(Glk[1],Glk[2])
                    Glk[1],Glk[2] =transform2:transformPoint(Glk[1],Glk[2])
                    table.insert(vect,Glk)
                else
                    local Glk = GlElement2[iPointMesh]
                    local Glk2 = GlElement2[iPointMesh-2]
                    if  (iPointMesh == 3) then 
                        Glk[1],Glk[2] =transform:transformPoint(Glk[1],Glk[2])
                        Glk[1],Glk[2] =transform2:transformPoint(Glk[1],Glk[2])
                    end
                    table.insert(vect,Glk)
                end
            end
            GlElement2 = tableСopy(GlElement)
            table.remove(GlElement,#GlElement-1)
            table.remove(GlElement2,#GlElement2-1)
        end
    end
end

function objRecoveryVect()
    for i= 1, lenVect do
        local texCordi = {
            0, 0, 
            0, 0,
            1, 1, 1,
        }
        table.insert(vect,texCordi)
    end
    meshMeteors = love.graphics.newMesh(vect, "triangles")
    meshMeteors:setTexture(meteorSet) 
end

return objFunction