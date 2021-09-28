local objFunction = {}

function objTip(t)
 ------------------------big
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

function objBody(i,tip,t)
    if ( tip == 1 ) then
        local xF,yF = obj[i].body:center()
        obj[i].body:moveTo(obj[i].x, obj[i].y)
        local xF2,yF2 = obj[i].body:center()
        local Glr = obj[i].ra*dt2
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
            obj[i].centrTY = obj[i].centrTY  + yF2 -yF
        end
    end
end

function objColor(t)
    if  t == 1 then 
        return 0.631,0.435,0.345,'m' -- big
    end
    if  t == 2 then 
        return 0.404,0.463,0.545,'m' -- big
    end
     if  t == 3 then 
        return 0.404,0.463,0.545,'k' -- big
    end
     if  t == 4 then 
        return 0.404,0.463,0.545,'s' -- small
    end
      if  t == 5 then 
        return 0.404,0.463,0.545,'xs' -- small
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
        local angle = math.atan2(mas[i].x- player.x,mas[i].y- player.y)
        local kolMeteor = 6 
       
        if ( mas[i].scale == 'xs') then
            kolMeteor = 8
        end
        if (#masGl>kolMeteor) then
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
              --  local masDopGl ={xf2,yf2,unpack(masGl2,start,finish+1)}
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
                    invTimer = 4,
                    health = 1,
                    ot = false,
                    body   =  BODY, 
                    bodyDop = masDopGl,
                    rDop = mas[i].r,
                    rDop2 = 0,
                    scale = mas[i].scale,
                    xc  = xc, 
                    yc =  yc , 
                    tip =  mas[i].tip,
                    r =mas[i].r ,
                    timer =4-0.001,
                    flag =true,
                    color1 =colorDop1,
                    color2=colorDop2,
                    color3 =colorDop3,
                    f = false,
                    x  = x1, 
                    y =  y1 ,  
                    ax  =27*k*math.sin(angle)+ math.random(-6*k,6*k), 
                    ay =27*k*math.cos(angle)+ math.random(-6*k,6*k), 
                    met = mas[i].met,
                    ra =1,
                
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
                invTimer = 4,
                health =1,
                ot = false,
                body   =  BODY, 
                bodyDop = masDopGl,
                rDop2 = 0,
                rDop = mas[i].r,
                tip =  mas[i].tip,
                r =0 ,
                timer = 4-0.0001,
                flag =true,
                color1 =colorDop1,
                color2=colorDop2,
                color3 =colorDop3,
                scale = mas[i].scale,
                f = false,
                x  = x1, 
                y =  y1 ,  
                xc  = xc, 
                yc =  yc , 
                ax  =27*k*math.sin(angle)+ math.random(-6*k,6*k), 
                ay =27*k*math.cos(angle)+ math.random(-6*k,6*k), 
                met =mas[i].met,
                ra =1,
            }
            start = finish
            table.insert(obj,ee)
        else
            allDecompose(mas,i)
        end
    end
end

function objDestroyAngle(mas)
   local masDop = {}
   local angle = 0
   local leng = 0 
   local sinx = 0
   local cosy = 0 
   local Gk = k * 16
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

function objMove(i) 
    if (obj[i]) then
        objBody(i,obj[i].tip,obj[i].met)
        if ( obj[i].f == true ) then 
        -----------------------------------------------      
            if ( obj[i].tip == 1) then
                obj[i].ot =false
                obj[i].x= obj[i].x+obj[i].ax*dt2*5
                obj[i].y= obj[i].y+obj[i].ay*dt2*5
                if ( obj[i].ax >5) then
                    obj[i].ax = obj[i].ax-20*dt2
                end
                if ( obj[i].ay >5) then
                    obj[i].ay = obj[i].ay-20*dt2
                end
            end
        -----------------------------------------------  
        else
        -----------------------------------------------   
            if ( obj[i].tip == 1) then
                obj[i].ot =false
                obj[i].x= obj[i].x+obj[i].ax*dt2*10
                obj[i].y= obj[i].y+obj[i].ay*dt2*10
            end  
        -----------------------------------------------  
        end
    end
end

function objColl(i, tip, a)
    if ( obj[i].scale == 'm') then
        if ( obj[i].pok == 0) then
            player.debaffStrenght = 0.2  
        end
        if ( obj[i].pok == 1) then
            player.debaffStrenght = 0.4  
        end
        if ( obj[i].pok == 2) then
            player.debaffStrenght = 0.6  
        end
    end
    if ( obj[i].scale == 's') then
        if ( obj[i].pok == 0) then
            player.debaffStrenght = 0.3  
        end
        if ( obj[i].pok == 1) then
            player.debaffStrenght = 0.5  
        end
        if ( obj[i].pok == 2) then
            player.debaffStrenght = 0.7  
        end
    end
    if ( obj[i].scale == 'xs') then
        if ( obj[i].pok == 0) then
            player.debaffStrenght = 0.5  
        end
        if ( obj[i].pok == 1) then
            player.debaffStrenght = 0.7  
        end
    end
    --player.debaffStrenght =obj[i].scale
  
    local angleD = math.atan2(player.x-obj[i].x+20*k*player.scale,player.y-obj[i].y+20*k*player.scale)
    if ( a == 1) then
        if ( obj[i].tip == 1) then
            if ( obj[i] and obj[i].health ) then
                obj[i].health = obj[i].health -2*playerAbility.damage
            --    player.ax = 0.2 * player.ax 
            --    player.ay = 0.2 * player.ay
                obj[i].ax =-40*k*math.sin(angleD)
                obj[i].ay =-40*k2*math.cos(angleD)
            end
            obj[i].timer= obj[i].invTimer - 0.001
            if (obj[i].health<0) then 
                objDestroy(obj,i) 
                table.remove(obj,i)
            end
           
        else
            if (obj[i].tip == 2) then
              
            end
        end   
    else
        if ( obj[i].tip == 1) then
            local angl = math.atan2(-player.ax,-player.ay)
            if ( obj[i] and obj[i].health ) then
                obj[i].health = obj[i].health -1*playerAbility.damage
            --    player.ax = 0.2 * player.ax 
             --   player.ay = 0.2 * player.ay
                obj[i].ax =-40*k*math.sin(angleD)
                obj[i].ay =-40*k2*math.cos(angleD)
                
            end
            obj[i].timer= obj[i].invTimer- 0.001
            if (obj[i].health<0) then 
                objDestroy(obj,i) 
                table.remove(obj,i)
            end
           
        else
            if ( obj[i].tip == 2) then 
       
            end
        end 
    end
end

function  objVect(i,color1,color2,color3)
    local parametrs = tableMeteorsPar[obj[i].met]
    local texCord = {
        {
            obj[i].x-parametrs.collW*k/2, obj[i].y-parametrs.collH*k2/2, 
            parametrs.texX, parametrs.texY, 
            color1,color2,color3, 
        },
        {
            obj[i].x+parametrs.collW*k/2, obj[i].y-parametrs.collH*k2/2, 
            parametrs.texW/meteorSetW+parametrs.texX, parametrs.texY, 
            color1,color2,color3, 
        },
        {
            obj[i].x+parametrs.collW*k/2, obj[i].y+parametrs.collH*k2/2,
            parametrs.texW/meteorSetW+parametrs.texX, parametrs.texH/meteorSetH+parametrs.texY, 
            color1,color2,color3, 
        },
                              
        {
            obj[i].x-parametrs.collW*k/2, obj[i].y-parametrs.collH*k2/2, 
            parametrs.texX, parametrs.texY, 
            color1,color2,color3, 
        },
        {
            obj[i].x-parametrs.collW*k/2, obj[i].y+parametrs.collH*k2/2, 
            parametrs.texX, parametrs.texH/meteorSetH+parametrs.texY, 
            color1,color2,color3,
        },
        {
            obj[i].x+parametrs.collW*k/2, obj[i].y+parametrs.collH*k2/2, 
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
            local transform = love.math.newTransform(centrX , centrY ,obj[i].rDop+kekKK,1,1, centrX ,centrY ) 
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