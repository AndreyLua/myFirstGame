local slicerFunction = {}

function slicerSled()
if (player.a==0) then
    if ( flagclass =='slicer') then 
        if ( lvl == 0 ) then 
            sled = {
                color  = 0,
                x = player.x + math.cos(player.y)*1.1*k,
                y = player.y + math.sin(player.x)*1.1*k2,
                angle  = 0 , 
                size = 1
            }
        end    
        if (lvl == 1) then 
            sled = {
                color  = 0,
                x = player.x+ math.cos(player.y)*1.1*k+math.cos(-controler.angle-1.57)*28*k, 
                y = player.y+ math.sin(player.x)*1.1*k2+math.sin(-controler.angle-1.57)*28*k2 ,
                angle  = 0 , 
                size = 0.25
            }
            sled2 = {
                color  = 0,
                x = player.x+ math.cos(player.y)*1.1*k+math.cos(-controler.angle-1.37)*28*k, 
                y = player.y+ math.sin(player.x)*1.1*k2+math.sin(-controler.angle-1.37)*28*k2 ,
                angle  = 0 , 
                size = 0.25
            }
            sled3 = {
                color  = 0,
                x = player.x+ math.cos(player.y)*1.1*k+math.cos(-controler.angle-1.77)*28*k, 
                y = player.y+ math.sin(player.x)*1.1*k2+math.sin(-controler.angle-1.77)*28*k2 ,
                angle  = 0 , 
                size = 0.25
            }
        end
        if ( lvl == 2 ) then 
            sled2 = {
                color  = 0,
                x = player.x+ math.cos(player.y)*1.1*k+math.cos(-controler.angle-0.8)*28*k, 
                y = player.y+ math.sin(player.x)*1.1*k2+math.sin(-controler.angle-0.8)*28*k2 ,
                angle  = 0 , 
                size = 0.25
            }
            sled3 = {
                color  = 0,
                x = player.x+ math.cos(player.y)*1.1*k+math.cos(-controler.angle-2.3)*28*k, 
                y = player.y+ math.sin(player.x)*1.1*k2+math.sin(-controler.angle-2.3)*28*k2 ,
                angle  = 0 , 
                size = 0.25
            }
        end
        if ( lvl == 3 ) then 
            sled = {
                color  = 0,
                x = player.x,
                y = player.y,
                angle  = 0 , 
                size = 1
            }
        end
        if ( lvl == 5 ) then 
            sled = {
                color  = 0,
                x = player.x+ math.cos(player.y)*1.1*k+math.cos(-controler.angle-math.pi/2-0.46)*45*k, 
                y = player.y+ math.sin(player.x)*1.1*k2+math.sin(-controler.angle-math.pi/2-0.46)*45*k2 ,
                angle  = 0 , 
                size = 0.25
            }
        end
    else
        sled = {
            color  = 0,
            x =  player.x,
            y =  player.y,
            angle  = 0 , 
            size = 1
        }
    end
else
    if ( flagclass =='slicer') then 
        if ( lvl == 0 ) then 
            sled = {
                color  = 0,
                x = player.x,
                y = player.y ,
                angle  = 0 , 
                size = 1
            }
        end
        if ( lvl == 1 ) then 
            sled = {
                color  = 0,
                x = player.x+ math.cos(player.y)*1.1*k+math.cos(-controler.angle-1.57)*26*k, 
                y = player.y+ math.sin(player.x)*1.1*k2+math.sin(-controler.angle-1.57)*26*k2 ,
                angle  = 0 , 
                size = 0.25
            }
        end
        if ( lvl == 2 ) then 
            sled2 = {
                color  = 0,
                x = player.x+ math.cos(player.y)*1.1*k+math.cos(-controler.angle-1.57)*28*k, 
                y = player.y+ math.sin(player.x)*1.1*k2+math.sin(-controler.angle-1.57)*28*k2 ,
                angle  = 0 , 
                size = 0.3
            }
            sled3 = {
                color  = 0,
                x = player.x+ math.cos(player.y)*1.1*k+math.cos(-controler.angle-1.57)*28*k, 
                y = player.y+ math.sin(player.x)*1.1*k2+math.sin(-controler.angle-1.57)*28*k2 ,
                angle  = 0 , 
                size = 0.3
            }
        end
        if ( lvl == 3 ) then 
            sled = {
                color  = 0,
                x = player.x,
                y = player.y,
                angle  = 0 , 
                size = 1
            }
        end
        if ( lvl == 5 ) then 
            sled = {
                color  = 0,
                x = player.x+ math.cos(player.y)*1.1*k+math.cos(-controler.angle-math.pi/2-0.46)*45*k, 
                y = player.y+ math.sin(player.x)*1.1*k2+math.sin(-controler.angle-math.pi/2-0.46)*45*k2 ,
                angle  = 0 , 
                size = 0.25
            }
        end
    else
        sled = {
            color  = 0,
            x =  player.x,
            y =  player.y,
            angle  = 0 , 
            size = 1
        }
    end
end

if ( player.a~=0 and  player.a~=3 ) then
    if ( #sledi <= player.length1) then 
        table.insert(sledi,sled)
        if ( lvl == 1 and player.a == 1 ) then 
          
        else
            if ( sled2) then
                table.insert(sledi,sled2)
            end
            if (  sled3) then
                table.insert(sledi,sled3)
            end
        end
    end
else
    if ( #sledi <=player.length2) then 
        table.insert(sledi,sled)
        if ( sled2) then
            table.insert(sledi,sled2)
        end
        if ( sled3) then
            table.insert(sledi,sled3)
        end
    end
end

end
function SlicerIm(number)
    if ( number == 1 ) then
        love.graphics.line(-5.2626488095238*k,24.190476190476*k2,6.4255952380952*k,24.190476190476*k2,13.031994047619*k,23.174603174603*k2,16.589285714286*k,20.634920634921*k2,21.162946428571*k, 18.603174603175*k2,24.720238095238*k,11.492063492064*k2,28.277529761905*k,3.8730158730159*k2,26.752976190476*k,-6.7936507936508*k2,23.703869047619*k,-13.904761904762*k2,19.638392857143*k         ,-18.984126984127*k2,13.031994047619*k,-22.539682539683*k2,12.52380952381*k,-27.619047619048*k2,9.9828869047619*k,-33.714285714286*k2,3.8846726190476*k,-36.253968253968*k2,-             1.7053571428572*k,-36.253968253968*k2,-3.295386904762*k,-35.238095238095*k2,2.295386904762*k,-35.238095238095*k2,1.7053571428572*k,-36.253968253968*k2,-3.8846726190476*k,-36.253968253968*k2,-9.9828869047619*k,-33.714285714286*k2,-12.52380952381*k,-27.619047619048*k2,-13.031994047619*k,-22.539682539683*k2,-19.638392857143*k,-18.984126984127*k2,-23.703869047619*k,-13.904761904762*k2,-26.752976190476*k,-6.7936507936508*k2,-28.277529761905*k,3.8730158730159*k2,-24.720238095238*k,11.492063492064*k2,-21.162946428571*k,18.603174603175*k2,-16.589285714286*k,20.634920634921*k2,-13.031994047619*k,23.174603174603*k2,-6.4255952380952*k,24.190476190476*k2,5.2626488095238*k,24.190476190476*k2)
        love.graphics.line(-2.2135416666667*k,-28.634920634921*k2,0.8355654761905*k,-29.142857142857*k2,4.3928571428571*k,-27.619047619048*k2,5.9174107142857*k,-25.079365079365*k2,5.9174107142857*k,-22.031746031746*k2,4.3928571428571*k,-19.492063492063*k2,1.34375*k,-18.47619047619*k2,-0.1*k,-17.968253968254*k2,0,-17.968253968254*k2,-1.34375*k,-18.47619047619*k2,-4.3928571428571*k,-19.492063492063*k2,-5.9174107142857*k,-22.031746031746*k2,-5.9174107142857*k,-25.079365079365*k2,-4.3928571428571*k,-27.619047619048*k2,-0.8355654761905*k,-29.142857142857*k2,2.2135416666667*k,-28.634920634921*k2)
        love.graphics.line(24.720238095238*k,10.47619047619*k2,19.638392857143*k,-6.2857142857143*k2,15.064732142857*k,-3.7460317460318*k2,17.097470238095*k,21.142857142857*k2,9.4747023809524*k,24.698412698413*k2,5.9174107142857*k,-1.7142857142857*k2,0,-1.2063492063492*k2,0,-1.2063492063492*k2,-5.9174107142857*k,-1.7142857142857*k2,-9.4747023809524*k,24.698412698413*k2,-17.097470238095*k,21.142857142857*k2,-15.064732142857*k,-3.7460317460318*k2,-19.638392857143*k,-6.2857142857143*k2,-24.720238095238*k,10.47619047619*k2)
        love.graphics.line(-6.2790178571428*k,-0.69841269841269*k2,4.9010416666666*k,-0.19047619047618*k2)
    if ( player.a==1) then
        love.graphics.setColor(1,0.5,0)
    else
        love.graphics.setColor(0,0.7,1)
    end
    love.graphics.polygon('fill',14.556547619048*k,-1.7142857142857*k2,20.146577380952*k,-5.7777777777778*k2,24.212053571429*k,9.4603174603175*k2,17.605654761905*k,18.095238095238*k2,21.162946428571*k,18.095238095238*k2,22.17931547619*k,15.555555555556*k2,23.195684523809*k,14.539682539683*k2,24.720238095238*k,13.015873015873*k2)
    love.graphics.polygon('fill',-16.442708333333*k,21.650793650794*k2,-15.426339285714*k,-0.19047619047618*k2,-19.49181547619*k,-5.7777777777778*k2,-24.573660714286*k,10.984126984127*k2)
    love.graphics.polygon('fill',8.9665178571429*k,24.698412698413*k2,5.9174107142857*k,1.8412698412698*k2,-6.7872023809524*k,0.82539682539683*k2,-8.311755952381*k,23.174603174603*k2)
    end 
  if ( number == 2 ) then
love.graphics.setColor(0,255,0)

-- love.graphics.translate( screenWidth/2,screenHeight/2 )
  love.graphics.push()
  love.graphics.scale(0.95)
if ( player.a==1) then
  love.graphics.setColor(1,0.1,0)
  else
love.graphics.setColor(0,0.4,0.9)
end
love.graphics.line(-7.8035714285715*k,37.396825396825*k2,6.4255952380952*k,36.888888888889*k2,23.195684523809*k,-5.7777777777778*k2,8.4583333333334*k,-8.3174603174603*k2,4.9010416666666*k,-30.666666666667*k2,1*k,-29.650793650794*k2,0,-29.650793650794*k2,-4.9010416666666*k,-30.666666666667*k2,-8.4583333333334*k,-8.3174603174603*k2,-23.195684523809*k,-5.7777777777778*k2,-6.4255952380952*k,36.888888888889*k2,7.8035714285715*k,37.396825396825*k2)

love.graphics.line(-25.081845238095*k,-9.8412698412698*k2,-12.885416666667*k,-11.365079365079*k2,-16.442708333333*k,-21.52380952381*k2,-26.606398809524*k,-18.47619047619*k2,-25.590029761905*k,-9.8412698412698*k2)
love.graphics.line(25.590029761905*k,-9.8412698412698*k2,26.606398809524*k,-18.47619047619*k2,16.442708333333*k,-21.52380952381*k2,12.885416666667*k,-11.365079365079*k2,25.081845238095*k,-9.8412698412698*k2)
if ( player.a==1) then
  love.graphics.setColor(1,0.5,0)
  else
love.graphics.setColor(0,0.7,1)
end
love.graphics.polygon( 'fill',-4.2462797619048*k,1.3333333333333*k2,3.8846726190476*k,0.82539682539683*k2,2.3601190476191*k,27.238095238095*k2,-3.2299107142857*k,27.238095238095*k2,3.2299107142857*k,27.238095238095*k2,-2.3601190476191*k,27.238095238095*k2,-3.8846726190476*k,0.82539682539683*k2,4.2462797619048*k,1.3333333333333*k2)
if ( player.a==1) then
love.graphics.setColor(1,0.2,0)
  else
love.graphics.setColor(0,0.4,0.9)
end
love.graphics.line(-5.2626488095238*k,1.3333333333333*k2,4.3928571428571*k,1.8412698412698*k2,3.3764880952381*k,28.253968253968*k2,2*k,28.253968253968*k2,-2.7217261904762*k,28.253968253968*k2,-3.3764880952381*k,28.253968253968*k2,-4.3928571428571*k,1.8412698412698*k2,5.2626488095238*k,1.3333333333333*k2)
 love.graphics.pop()
 -- love.graphics.translate( -screenWidth/2,-screenHeight/2 )

 end 
   if ( number == 3 ) then
love.graphics.setBlendMode("replace")
love.graphics.setColor(0,0,0,0)
love.graphics.circle('fill',0,0,22*k)
love.graphics.polygon('fill',-22*k, 0, 22*k, 0, 0, 50*k2)
love.graphics.setBlendMode("alpha")



if ( player.a==1) then
  love.graphics.setColor(0.8,0,0)
  else
love.graphics.setColor(0,0,1)
end
love.graphics.line(0.3273809523809*k,54.15873015873*k2,21.671130952381*k,1.3333333333333*k2,21.162946428571*k,-4.2539682539683*k2,19.638392857143*k,-9.8412698412698*k2,15.572916666667*k,-16.952380952381*k2,6.4255952380952*k,-22.031746031746*k2,-0.68898809523814*k,-21.015873015873*k2,0,-20.507936507937*k2,0,-20.507936507937*k2,0.68898809523814*k,-21.015873015873*k2,-6.4255952380952*k,-22.031746031746*k2,-15.572916666667*k,-16.952380952381*k2,-19.638392857143*k,-9.8412698412698*k2,-21.162946428571*k,-4.2539682539683*k2,-21.671130952381*k,1.3333333333333*k2,-0.3273809523809*k,54.15873015873*k2)
  love.graphics.setLineWidth(1.5)
  love.graphics.setColor(0,0.8,1)
  --[[
  if ( #drel<7) then
  drell:update(dt2)

drell:every(1, function()
  local jkl =
  {
    x = 0,
    y = 0,
    scale =0,
  }
  
table.insert(drel,jkl)
end)
else
 table.remove(drel,1)
end


for i = 1 , #drel do

  if (  spped< 550 and flagsp == false ) then
    spped = spped+100*dt2
  else
   flagsp =true
 end
if (  spped>470 and flagsp == true) then
   spped = spped-500*dt2
  else
   flagsp =false
 end

  drel[i].y = drel[i].y+300*k2*dt2
 -- drel[i].scale =  drel[i].scale + 65*dt2
if (flagsp ==false) then 
   love.graphics.push()

--love.graphics.line( -19.49181547619*k+drel[i].scale,-10.349206349206*k2+drel[i].y,19.130208333333*k-drel[i].scale,5.3968253968254*k2+drel[i].y)
  love.graphics.pop()
 --love.graphics.line(drel[i].x,drel[i].y,drel[i].x+drel[i].scale,drel[i].y+drel[i].scale) 
else
  -- love.graphics.rotate(0.2) 

end

end
]]--


--love.graphics.circle('line',0,0,25*k)    
--love.graphics.circle('line',0,17*k,17*k)
--love.graphics.circle('line',0,32*k,12*k)
--love.graphics.circle('line',0,42*k,7*k)
--love.graphics.circle('line',0,47*k,5*k)
  

  love.graphics.setLineWidth(2)
end 
  if ( number == 4 ) then
love.graphics.line( -1.7053571428572*k,33.333333333333*k2,6.4255952380952*k,33.333333333333*k2,10.491071428571*k,23.174603174603*k2,15.572916666667*k,21.142857142857*k2,17.097470238095*k,19.619047619048*k2,20.146577380952*k,26.730158730159*k2,29.802083333333*k,20.126984126984*k2,22.17931547619*k,12.507936507937*k2,25.228422619048*k,1.8412698412698*k2,26.244791666667*k,-6.2857142857143*k2,22.6875*k,-15.936507936508*k2,27.261160714286*k,-35.238095238095*k2,14.048363095238*k,-19.492063492063*k2,14.556547619048*k,-46.920634920635*k2,0.3273809523809*k,-19.492063492063*k2,-0.18080357142862*k,-17.968253968254*k2,0.18080357142862*k,-17.968253968254*k2,-0.3273809523809*k,-19.492063492063*k2,-14.556547619048*k,-46.920634920635*k2,-14.048363095238*k,-19.492063492063*k2,-27.261160714286*k,-35.238095238095*k2,-22.6875*k,-15.936507936508*k2,-26.244791666667*k,-6.2857142857143*k2,-25.228422619048*k,1.8412698412698*k2,-22.17931547619*k,12.507936507937*k2,-29.802083333333*k,20.126984126984*k2,-20.146577380952*k,26.730158730159*k2,-17.097470238095*k,19.619047619048*k2,-15.572916666667*k,21.142857142857*k2,-10.491071428571*k,23.174603174603*k2,-6.4255952380952*k,33.333333333333*k2,1.7053571428572*k,33.333333333333*k2)

love.graphics.line(-2.2135416666667*k,-5.7777777777778*k2,0.8355654761905*k,-5.7777777777778*k2,5.9174107142857*k,-3.7460317460318*k2,7.9501488095238*k,0.82539682539683*k2,13.540178571429*k,0.31746031746033*k2,16.589285714286*k,1.3333333333333*k2,17.097470238095*k,1.3333333333333*k2,17.605654761905*k,1.3333333333333*k2,17.097470238095*k,8.952380952381*k2,16.081101190476*k,9.968253968254*k2,13.031994047619*k,11.492063492064*k2,8.9665178571429*k,11.492063492064*k2,7.4419642857142*k,9.968253968254*k2,5.9174107142857*k,7.4285714285714*k2,3.8846726190476*k,5.9047619047619*k2,2.3601190476191*k,5.9047619047619*k2,0.3273809523809*k,5.9047619047619*k2,-1.7053571428572*k,5.9047619047619*k2,2*k,5.9047619047619*k2,-0.3273809523809*k,5.9047619047619*k2,-2.3601190476191*k,5.9047619047619*k2,-3.8846726190476*k,5.9047619047619*k2,-5.9174107142857*k,7.4285714285714*k2,-7.4419642857142*k,9.968253968254*k2,-8.9665178571429*k,11.492063492064*k2,-13.031994047619*k,11.492063492064*k2,-16.081101190476*k,9.968253968254*k2,-17.097470238095*k,8.952380952381*k2,-17.605654761905*k,1.3333333333333*k2,-17.097470238095*k,1.3333333333333*k2,-16.589285714286*k,1.3333333333333*k2,-13.540178571429*k,0.31746031746033*k2,-7.9501488095238*k,0.82539682539683*k2,-7.9174107142857*k,-3.7460317460318*k2,-0.8355654761905*k,-5.7777777777778*k2,6.2135416666667*k,-5.7777777777778*k2)
love.graphics.line(4.3928571428571*k,6.4126984126984*k2,-4.7544642857143*k,6.4126984126984*k2)
 end 
    if ( number == 5 ) then
      if (player.a == 0) then
      love.graphics.setColor(0,1,1)
    else
    
      love.graphics.setColor(0.8,0.4,0)
    end
love.graphics.polygon('fill',-0.18080357142862*k,-33.714285714286*k2,10.491071428571*k,-2.2222222222222*k2,-0.18080357142862*k,21.650793650794*k2,-10.852678571429*k,-1.2063492063492*k2,10.852678571429*k,-1.2063492063492*k2,0.18080357142862*k,21.650793650794*k2,-10.491071428571*k,-2.2222222222222*k2,0.18080357142862*k,-33.714285714286*k2)
 if (player.a == 0) then
  love.graphics.setColor(0,0.8,0.8)
    else
    
      love.graphics.setColor(0.8,0.3,0)
    end
love.graphics.polygon('fill',-0.68898809523814*k,21.650793650794*k2,6.4255952380952*k,28.253968253968*k2,-0.18080357142862*k,41.460317460317*k2,-6.2790178571428*k,29.777777777778*k2,6.2790178571428*k,29.777777777778*k2,0.18080357142862*k,41.460317460317*k2,-6.4255952380952*k,28.253968253968*k2,0.68898809523814*k,21.650793650794*k2)

    if (player.a == 0) then
    love.graphics.setColor(0,0.45,0.45)
    else
    
      love.graphics.setColor(0.8,0.03,0)
    end
love.graphics.line(0.3273809523809*k,42.984126984127*k2,27.261160714286*k,12.507936507937*k2,9.4747023809524*k,19.619047619048*k2,36.408482142857*k,-15.428571428571*k2,11.50744047619*k,-2.7301587301587*k2,-0.18080357142862*k,-35.746031746032*k2,-10.852678571429*k,-1.7142857142857*k2,-0.18080357142862*k,20.634920634921*k2,-6.7872023809524*k,27.746031746032*k2,0.3273809523809*k,40.952380952381*k2,-0.3273809523809*k,40.952380952381*k2,6.7872023809524*k,27.746031746032*k2,0.18080357142862*k,20.634920634921*k2,10.852678571429*k,-1.7142857142857*k2,0.18080357142862*k,-35.746031746032*k2,-11.50744047619*k,-2.7301587301587*k2,-36.408482142857*k,-15.428571428571*k2,-9.4747023809524*k,19.619047619048*k2,-27.261160714286*k,12.507936507937*k2,-0.3273809523809*k,42.984126984127*k2)
end 

end


return slicerF

