local enemyFunction = {}
--:unpack() x1,y1,x2,y2
function destroyMet(mas,i)
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
        if (#masGl>6) then
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
                local masDopGl ={unpack(anglePlus({xf2,yf2,unpack(masGl2,start,finish+1)}))}
                table.remove(masDopGl,#masDopGl)
                finish2 =finish+1
                local x1 , y1   = BODY:center()
                local xc , yc   = BODY2:center()
                local colorRGB = 0.2
                local colorDop1 = math.random()/4
                local colorDop2 = math.random()/4
                local colorDop3 = math.random()/4
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
                    xc  = xc, 
                    yc =  yc , 
                    tip =  mas[i].tip,
                    r =mas[i].r ,
                    timer =4-0.001,
                    flag =true,
                    color1 = colorRGB + colorDop1,
                    color2= colorRGB + colorDop2,
                    color3 =colorRGB + colorDop3,
                    f = false,
                    x  = x1, 
                    y =  y1 ,  
                    ax  =17*k*math.sin(angle)+ math.random(-6*k,6*k), 
                    ay =17*k*math.cos(angle)+ math.random(-6*k,6*k), 
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
            local masDopGl ={unpack(anglePlus({xf2,yf2,masGl2[1],masGl2[2],unpack(masGl2,finish2-1,#masGl2)}))}
            table.remove(masDopGl,#masDopGl)
            local x1 , y1   = BODY:center()
            local xc , yc   = BODY2:center()
            local colorRGB =0.2
            local colorDop1 = math.random()/4
            local colorDop2 = math.random()/4
            local colorDop3 = math.random()/4
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
                color1 = colorRGB + colorDop1,
                color2= colorRGB + colorDop2,
                color3 =colorRGB + colorDop3,
                f = false,
                x  = x1, 
                y =  y1 ,  
                xc  = xc, 
                yc =  yc , 
                ax  =17*k*math.sin(angle)+ math.random(-6*k,6*k), 
                ay =17*k*math.cos(angle)+ math.random(-6*k,6*k), 
                met =mas[i].met,
                ra =1,
            }
            start = finish
            table.insert(obj,ee)
        else
            kill(mas,i)
        end
    end
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

function GeoMeteor(Geo)
      if (Geo==1) then
        return -3*50*k,math.random(0,screenHeight),math.random(1*k,6*k),math.random(-6*k,6*k), math.random(0.5,1)
      end
      if (Geo==2) then
        return  math.random(0,screenWidth),-3*40*k2,math.random(-6*k,6*k),math.random(1*k,6*k),math.random(-1,-0.5)
      end
      if (Geo==3) then
        return  math.random(0,screenWidth),screenHeight+3*40*k2,math.random(-6*k,6*k),math.random(-6*k2,-1*k2),math.random(0.5,1) 
      end
      if (Geo==4) then
        return  (screenWidth+3*40*k),math.random(0,screenHeight),math.random(-6*k,-1*k),math.random(-6*k,6*k), math.random(-1,-0.6)
      end
end


function spawnAll(mas,Geo,Tip)
    if ( mas == obj) then
        local colorRGB = 0.2
        local colorDop1 = math.random()/4
        local colorDop2 = math.random()/4
        local colorDop3 = math.random()/4
        local Body =math.random(1,2)
        local x,y,ax,ay,ra = GeoMeteor(Geo)
        local health = 1
        local e = {
            body = objTip(Body),
            timer = 0 ,
            invTimer = 20,
            ot = false,
            tip = Tip, 
            ugol =  0,
            r =0,
            rDop =0,
            flagr = 0 ,
            color1 =colorRGB +colorDop1,
            color2= colorRGB +colorDop2,
            color3 =colorRGB +colorDop3,
            f = false,
            pok = 0,
            met =Body,
            x  = x, 
            y = y,  
            ax  =ax,
            ay = ay,
            ra =0,
            health = health
            }
        e.body:moveTo(e.x, e.y)
       
        table.insert(mas,e)
    end
------------------------------------------------------------------------  
------------------------------------------------------------------------  
    if ( mas == en) then
        local x,y,ax,ay,ra = GeoMeteor(Geo)
        if ( Tip ==1) then
            local health = 3
            local damage = 1
            local e = {
                tip = Tip, 
                body =HC.rectangle(-10*k,-10*k2,1*k,1*k2),
                timer = 0 , 
                invTimer = 20,
                atack = 0,
                atackTimer = 60,
                dash = 0,
                dashTimer = 20,
                r = 0 ,
                ugol =  0,
                flagr = 0 ,
                damage = damage , 
                f = false,
                x  = x, 
                y = y ,  
                ax  =ax, 
                ay = ay, 
                health = health,
                healthM = health
                }
            table.insert(mas,e)
        end
        if ( Tip ==2) then 
            local health = 2
            local damage = 10
            local e = {
                body =HC.rectangle(-10*k,-10*k2,1*k,1*k2),
                damage = damage, 
                invTimer = 20,
                timer = 0 , 
                atack = 0,
                atackTimer = 30,
                tip = Tip, 
                ugol =  0,
                r = 0 ,
                flagr = 0 ,
                f = false,
                x  = x, 
                y = y ,  
                ax  =ax, 
                ay = ay, 
                health = health,
                healthM = health
                }
            table.insert(mas,e)
        end
    end
    
end

function anglePlus(mas)
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
BODY = HC.polygon(  6.4255952380952*k,   -33.206349206349*k2,  30.310267857143*k,   -16.444444444444*k2,  37.424851190476*k,    27.238095238095*k2,  5.4092261904762*k,    46.031746031746*k2, -30.16369047619*k,    40.952380952381*k2, -53.540178571429*k,    27.238095238095*k2, -60.146577380952*k,   -3.2380952380953*k2, -33.212797619048*k,   -39.809523809524*k2)

end

if  t == 5 then

BODY =  HC.polygon(  -20*k,    -41.333333333333*k2,  -43.376488095238*k,    -29.142857142857*k2,  -55.064732142857*k,    7.4285714285714*k2,  -51.50744047619*k,    35.365079365079*k2,  -0.18080357142862*k,    55.68253968254*k2,  46.063988095238*k,    57.206349206349*k2,  63.342261904762*k,    37.396825396825*k2,  59.276785714286*k,    -5.7777777777778*k2,  45.047619047619*k,    -29.650793650794*k2,  18.113839285714*k,    -38.285714285714*k2)

end


----------------------------------------------med
if  t == 6 then
BODY =  HC.polygon(  8.9665178571429*k,  -33.714285714286*k2,  -11.869047619048*k,  -34.730158730159*k2, -29.655505952381*k, -10.857142857143*k2, -     13.393601190476*k,  8.952380952381*k2,  18.113839285714*k,  5.3968253968254*k2,  27.261160714286*k, -22.539682539683*k2)
   
end
if  t == 7 then
BODY =  HC.polygon(  35.245535714286*k,  -7.3015873015873*k2,  27.622767857143*k,   15.047619047619*k2,  12.885416666667*k,   27.746031746032*k2, -8.4583333333334*k,   27.746031746032*k2, -23.195684523809*k,   0.82539682539683*k2, -27.769345238095*k,  -20.507936507937*k2, -5.4092261904762*k,  -27.619047619048*k2)
  
end

if  t == 8 then
BODY =  HC.polygon(  26.244791666667*k,    -21.52380952381*k2,  31.326636904762*k,     14.031746031746*k2,  17.097470238095*k,     34.349206349206*k2, -35.245535714286*k,    10.47619047619*k2, -23.557291666667*k,   -17.968253968254*k2,  6.9337797619047*k,    -28.126984126984*k2)

  
end
----------------------------------------------litle
if  t == 9 then
   
  BODY =  HC.polygon( -15.064732142857*k,  -12.888888888889*k2, -30.310267857143*k,   2.3492063492064*k2, -29.293898809524*k,   19.111111111111*k2, -12.52380952381*k,   23.68253968254*k2,  13.901785714286*k,   17.587301587302*k2,  2.2135416666667*k,   2.3492063492064*k2)
  
end

if  t == 10 then
 
 BODY =  HC.polygon( -2.8683035714286*k,   2.8571428571429*k2,  15.934523809524*k,   1.3333333333333*k2, 20.50818452381*k,  -18.47619047619*k2, 9.328125*k,  -29.650793650794*k2, -14.556547619048*k,  -27.111111111111*k2, -19.638392857143*k,  -11.365079365079*k2, -17.097470238095*k,  -0.69841269841269*k2)
  
end

return BODY

end

function enTip(i,tip,t)
if ( tip == 1 ) then
   en[i].body =  HC.rectangle(en[i].x-8*k,en[i].y-1*k2,16*k,25*k2)
end
if ( tip == 2 ) then
   en[i].body =  HC.rectangle(en[i].x-6*k,en[i].y,16*k,16*k2)
end

end

function angle(x0,x1,x2,x3,y0,y1,y2,y3)
   if ((((x1 - x0) * (y2 - y1) - (x2 - x1) * (y1 - y0))==0) or (((x2 - x0) * (y3 - y2) - (x3 - x2) * (y2 - y0))==0) or (((x3 - x0) * (y1 - y3) - (x1 - x3) * (y3 - y0))==0) or((((x1 - x0) * (y2 - y1) - (x2 - x1) * (y1 - y0))>0) and (((x2 - x0) * (y3 - y2) - (x3 - x2) * (y2 - y0))>0) and (((x3 - x0) * (y1 - y3) - (x1 - x3) * (y3 - y0))>0)) or ((((x1 - x0) * (y2 - y1) - (x2 - x1) * (y1 - y0))<0) and (((x2 - x0) * (y3 - y2) - (x3 - x2) * (y2 - y0))<0) and (((x3 - x0) * (y1 - y3) - (x1 - x3) * (y3 - y0))<0))) then
     return true
   else
     return false
     end
end

function Fire(x,y,x2,y2,angleEn,damage)
    local ugol = math.atan2(x-x2,y-y2)
    bullet = {
        x = x2 + 25*k*math.sin(angleEn),
        y = y2 + 25*k2*math.cos(angleEn),
        ax = 22*k*math.sin(ugol),
        ay = 22*k2*math.cos(ugol),
        damage = damage
    }
    table.insert(enemyBullets,bullet)
end

function recoveryVect()
    for i= 1, lenVect do
        local texCordi = {
            0, 0, 
            0, 0,
            1, 1, 1,
        }
        table.insert(vect,texCordi)
    end
    meshMeteors = love.graphics.newMesh(vect, "triangles")
    meshMeteors:setTexture(setMet) 
end

function meteorVect(i)
    local parametrs = tableMeteorsPar[obj[i].met]
    local texCord = {
        {
            obj[i].x-parametrs.collW*k/2, obj[i].y-parametrs.collH*k2/2, 
            parametrs.texX, parametrs.texY, 
            1, 1, 1, 
        },
        {
            obj[i].x+parametrs.collW*k/2, obj[i].y-parametrs.collH*k2/2, 
            parametrs.texW/setMetW+parametrs.texX, parametrs.texY, 
            1, 1, 1, 
        },
        {
            obj[i].x+parametrs.collW*k/2, obj[i].y+parametrs.collH*k2/2,
            parametrs.texW/setMetW+parametrs.texX, parametrs.texH/setMetH+parametrs.texY, 
            1, 1, 1, 
        },
                              
        {
            obj[i].x-parametrs.collW*k/2, obj[i].y-parametrs.collH*k2/2, 
            parametrs.texX, parametrs.texY, 
            1, 1, 1, 
        },
        {
            obj[i].x-parametrs.collW*k/2, obj[i].y+parametrs.collH*k2/2, 
            parametrs.texX, parametrs.texH/setMetH+parametrs.texY, 
            1, 1, 1,
        },
        {
            obj[i].x+parametrs.collW*k/2, obj[i].y+parametrs.collH*k2/2, 
            parametrs.texW/setMetW+parametrs.texX, parametrs.texH/setMetH+parametrs.texY, 
            1, 1, 1,
        },
    }
     
    for j= 1, #texCord do
        local point = texCord[j]
        local transform = love.math.newTransform(obj[i].x,obj[i].y,obj[i].r,1,1,obj[i].x,obj[i].y)
        point[1], point[2] = transform:transformPoint(point[1], point[2] )
        table.insert(vect,texCord[j])
    end   
end

function fragmVect(i)
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
            parametrs.texCX-((centrX-cordX)*(parametrs.texW/parametrs.collW))/setMetW/k,parametrs.texCY-((centrY-cordY)*(parametrs.texH/parametrs.collH))/setMetH/k2, 
            1,1,1
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


return enemyFunction