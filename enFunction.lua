local enFunction = {}

function enCollWithPlayerInRegularS(index,dt)
     if ( enRegulS[index]) then 
        local kek = enRegulS[index]
        for i = #kek, 1, -1 do
            if (en[kek[i]] and en[kek[i]].body and en[kek[i]].invTimer==en[kek[i]].timer and math.abs(en[kek[i]].x - (player.x))<playerAbility.scaleBody*k+math.max(en[kek[i]].w,en[kek[i]].h)/2*k and math.abs(en[kek[i]].y - (player.y))<playerAbility.scaleBody*k2+math.max(en[kek[i]].w,en[kek[i]].h)/2*k2  and  (math.pow((en[kek[i]].x - (player.x)),2) + math.pow((en[kek[i]].y - (player.y)),2))<=math.pow((playerAbility.scaleBody*k+math.max(en[kek[i]].w,en[kek[i]].h)/2*k),2))  then
                local collisFlag, intVectorX ,intVectorY = player.body:collidesWith(en[kek[i]].body)
                if (collisFlag) then
                    enCollWithPlayerResult(kek[i],dt,intVectorX ,intVectorY,player.a,en[kek[i]].tip)
                end
            end
        end
    end
end

function enCollWithPlayerResult(i, dt,intVectorX ,intVectorY,a,tip)
    if ((intVectorX*intVectorX+intVectorY*intVectorY>=math.pow(0.05*math.max(en[i].w,en[i].h)*k,2))) then
        en[i].ax = 0 
        en[i].ay = 0 
        en[i].x  = en[i].x -intVectorX*dt*10
        en[i].y = en[i].y - intVectorY*dt*10
    end
    en[i]:hit(player.a,i,dt)
end

function enCollWithenInRegularS(index,j,dt)
    if ( enRegulS[index]) then 
        local kek = enRegulS[index]
        local enJScale = 0
        if (kek) then
            if ( en[j]) then
                enJScale = math.max(en[j].w,en[j].h)/2
            end
            for i = #kek, 1, -1 do
                if (kek[i] and en[kek[i]] and en[j]) then
                    local enIScale = math.max(en[kek[i]].w,en[kek[i]].h)/2
                    if ( kek[i]~=j and math.abs(en[kek[i]].x - en[j].x)<enIScale*k+enJScale*k and math.abs(en[kek[i]].y - en[j].y)<enIScale*k2+enJScale*k2 and  (math.pow((en[kek[i]].x - en[j].x),2) + math.pow((en[kek[i]].y - en[j].y),2))<=math.pow((enIScale*k+enJScale*k),2)) then
                        local collisFlag, intVectorX ,intVectorY = en[j].body:collidesWith(en[kek[i]].body)
                        if ( collisFlag) then 
                            if ((intVectorX*intVectorX+intVectorY*intVectorY >=math.pow(0.05*math.max(en[j].w,en[j].h)*k,2))) then
                                en[kek[i]].x  = en[kek[i]].x - intVectorX*dt*5
                                en[kek[i]].y = en[kek[i]].y - intVectorY*dt*5
                                en[j].x  = en[j].x + intVectorX*dt*5
                                en[j].y = en[j].y +  intVectorY*dt*5
                            end
                        end 
                    end
                end
            end
        end
    end
end

function enCollWithenInRegularSMelee(index,j,dt)
    if ( enRegulS[index]) then 
        local kek = enRegulS[index]
        local enJScale = 0
        if (kek) then
            if ( en[j]) then
                enJScale = math.max(en[j].w,en[j].h)/2
            end
            for i = #kek, 1, -1 do
                if (kek[i] and en[kek[i]] and en[j]) then
                    local enIScale = math.max(en[kek[i]].w,en[kek[i]].h)/2
                    if ( kek[i]~=j and not(en[kek[i]].climbFlag == 1 and en[j].climbFlag == 1)   and math.abs(en[kek[i]].x - en[j].x)<enIScale*k+enJScale*k and math.abs(en[kek[i]].y - en[j].y)<enIScale*k2+enJScale*k2 and  (math.pow((en[kek[i]].x - en[j].x),2) + math.pow((en[kek[i]].y - en[j].y),2))<=math.pow((enIScale*k+enJScale*k),2)) then
                        local collisFlag, intVectorX ,intVectorY = en[j].body:collidesWith(en[kek[i]].body)
                        if ( collisFlag) then 
                            if ((intVectorX*intVectorX+intVectorY*intVectorY >=math.pow(0.05*math.max(en[j].w,en[j].h)*k,2))) then
                                en[kek[i]].x  = en[kek[i]].x - intVectorX*dt*5
                                en[kek[i]].y = en[kek[i]].y - intVectorY*dt*5
                                en[j].x  = en[j].x + intVectorX*dt*5
                                en[j].y = en[j].y +  intVectorY*dt*5
                            end
                        end 
                    end
                end
            end
        end
    end
end


function enCollWithobjInRegularS(index,j,dt)
    if ( objRegulS[index]) then 
        local kek = objRegulS[index]
        local enScale = 0
        if (kek) then
            if ( en[j]) then
                enScale = math.max(en[j].w,en[j].h)/2
            end
            for i = #kek, 1, -1 do
                if (kek[i] and obj[kek[i]] and en[j]) then
                    local objScale = obj[kek[i]].collScale/2
                    if ( en[j] and en[j].tip == 1 and en[j].targetDestroy ==en[j].targetDestroyTimer ) then
                        if ( en[j].targetY > (math.pow((obj[kek[i]].x - en[j].x),2) + math.pow((obj[kek[i]].y - en[j].y),2)) ) then
                            en[j].targetX =kek[i]
                            en[j].targetY =(math.pow((obj[kek[i]].x - en[j].x),2) + math.pow((obj[kek[i]].y - en[j].y),2))
                        end
                    end
                    
                    if (math.abs(obj[kek[i]].x - en[j].x)<enScale*k+objScale*k and math.abs(obj[kek[i]].y - en[j].y)<objScale*k2+enScale*k2 and (math.pow((obj[kek[i]].x - en[j].x),2) + math.pow((obj[kek[i]].y - en[j].y),2))<=math.pow((objScale*k+enScale*k),2)) then
                        local collisFlag, intVectorX ,intVectorY = en[j].body:collidesWith(obj[kek[i]].body)
                        if ( collisFlag) then 
                            local sumMas = obj[kek[i]].scale +en[j].scale
                            local deepX = intVectorX
                            local deepY = intVectorY
                            obj[kek[i]].ax= obj[kek[i]].ax +(en[j].ax*k*dt)*5*sumMas/obj[kek[i]].scale
                            obj[kek[i]].ay= obj[kek[i]].ay  +(en[j].ay*k*dt)*5*sumMas/obj[kek[i]].scale
                            en[j].ax  = en[j].ax*0.8
                            en[j].ay = en[j].ay*0.8
                            if ((deepX*deepX+deepY*deepY >=math.pow(0.05*enScale*k,2))) then
                                obj[kek[i]].x  = obj[kek[i]].x - deepX*dt*10
                                obj[kek[i]].y = obj[kek[i]].y - deepY*dt*10
                                en[j].x  = en[j].x + deepX*dt*10
                                en[j].y = en[j].y +  deepY*dt*10
                            end
                            if ( en[j] and en[j].tip == 1 and en[j].target =="obj" and en[j].atack == en[j].atackTimer ) then
                                en[j].targetDestroy = en[j].targetDestroyTimer - 0.001
                                obj[kek[i]].health = obj[kek[i]].health - 2
                                en[j].atack = en[j].atackTimer-0.001
                            end
                        end 
                    end
                end
            end
        end
    end
end

function enCollWithobjInRegularSBomb(index,j,dt)
    if ( objRegulS[index]) then 
        local kek = objRegulS[index]
        local enScale = 0
        if (kek) then
            if ( en[j]) then
                enScale = math.max(en[j].w,en[j].h)/2
            end
            for i = #kek, 1, -1 do
                if (kek[i] and obj[kek[i]] and en[j]) then
                    local objScale = obj[kek[i]].collScale/2
                    if (math.abs(obj[kek[i]].x - en[j].x)<enScale*k+objScale*k and math.abs(obj[kek[i]].y - en[j].y)<objScale*k2+enScale*k2 and (math.pow((obj[kek[i]].x - en[j].x),2) + math.pow((obj[kek[i]].y - en[j].y),2))<=math.pow((objScale*k+enScale*k),2)) then
                        local angleD = math.atan2(en[j].x-obj[kek[i]].x,en[j].y-obj[kek[i]].y)
                        obj[kek[i]].ax= obj[kek[i]].ax -800000*dt*k*math.sin(angleD)/obj[kek[i]].scale
                        obj[kek[i]].ay= obj[kek[i]].ay -800000*dt*k*math.cos(angleD)/obj[kek[i]].scale
                        obj[kek[i]].health = obj[kek[i]].health - 10000
                    end
                end
            end
        end
    end
end

function enFire(x,y,x2,y2,angleEn,damage)
    local ugol = math.atan2(x-x2,y-y2)
    bullet = {
        x = x2 + 10*k*math.sin(angleEn),
        y = y2 + 10*k2*math.cos(angleEn),
        ax = 22*k*math.sin(ugol),
        ay = 22*k2*math.cos(ugol),
        damage = damage
    }
    table.insert(enemyBullets,bullet)
end
function enBoomAfterDieDraw(dt)
    for i = #enBoomAnimat, 1, -1 do
      enBoomAnimat[i].timer =  enBoomAnimat[i].timer -80*dt
      if (enBoomAnimat[i].timer < 0) then
          enBoomAnimat[i].timer = 1
          enBoomAnimat[i].an = enBoomAnimat[i].an+1
      end
      if (  enBoomAnimat[i].an> 10 ) then
          table.remove(enBoomAnimat,i)
      end
      if ( enBoomAnimat[i] and enBoomAnimat[i].an <=10) then  
          boomBatch:setColor(1,1,1,1)
          boomBatch:add(boomQuads[enBoomAnimat[i].an],enBoomAnimat[i].x,enBoomAnimat[i].y,enBoomAnimat[i].r,k/2.2,k2/2.2,160, 160)
      end
  end
end

function enAfterDieDraw(dt)
    for i = #enAfterDieTex, 1, -1 do
        if ( enAfterDieTex[i].timer> 0) then
            enBatchAfterDie:setColor(1,1,1,enAfterDieTex[i].timer/5)
            enBatchAfterDie:add(enAfterDieTex[i].quad,enAfterDieTex[i].x,enAfterDieTex[i].y,enAfterDieTex[i].r,enAfterDieTex[i].koff,enAfterDieTex[i].koff2,enAfterDieTex[i].ox, enAfterDieTex[i].oy)
            enAfterDieTex[i].r =  enAfterDieTex[i].r + enAfterDieTex[i].ra*dt*1
            enAfterDieTex[i].x =enAfterDieTex[i].x-enAfterDieTex[i].ax*dt*3
            enAfterDieTex[i].y =enAfterDieTex[i].y-enAfterDieTex[i].ay*dt*3
            enAfterDieTex[i].timer = enAfterDieTex[i].timer - dt*3
        else
            table.remove(enAfterDieTex,i)
        end
    end
end

return enFunction