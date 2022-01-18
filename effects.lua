local effects = {}


function light(x1,y1,x2,y2,i)
    local length = math.sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1))
    local m = {x1,y1}
    local masKof = {}
    local x =0
    local y = 0
    local aye = 5 -- ширина разброса 
    local ran =math.random(-length/aye,length/aye)
    table.insert(masKof,ran)
    local angle =3.14-math.atan2((x2-x1),(y2-y1))
    x =x1+(x2-x1)/2+math.cos(angle)*ran
    y =y1+(y2-y1)/2+math.sin(angle)*ran
    local m1,m2 = pol(x1,y1,x,y,i)
    for  i=1,#m1 do
        table.insert(m,m1[i])
    end
    for  i=1,#m2 do
        table.insert(masKof,m2[i])
    end
    table.insert(m,x)
    table.insert(m,y)
    m1,m2 = pol(x,y,x2,y2,i)
    for  i=1,#m1 do
        table.insert(m,m1[i])
    end
    for  i=1,#m2 do
        table.insert(masKof,m2[i])
    end
    table.insert(m,x2)
    table.insert(m,y2)
    return masKof
end
function pol(x1,y1,x2,y2,i) 
    local aye = 5 -- ширина разброса 
    local masKofPol = {}
    local length = math.sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1))
    local ran =math.random(-length/aye,length/aye)
    table.insert(masKofPol,ran)
    local angle =3.14-math.atan2((x2-x1),(y2-y1))
    local x =x1+(x2-x1)/2+math.cos(angle)*ran
    local y =y1+(y2-y1)/2+math.sin(angle)*ran
    local m1 = {}
    if ( i>0 and i~=0 ) then
        local m2,m3 = pol(x1,y1,x,y,i-1)
        for  i=1,#m2 do
            table.insert(m1,m2[i])
        end
        for  i=1,#m3 do
            table.insert(masKofPol,m3[i])
        end
    end
 
    table.insert(m1,x)
    table.insert(m1,y)
    if ( i>0) then
        local m2,m3 = pol(x,y,x2,y2,i-1)
        for  i=1,#m2 do
            table.insert(m1,m2[i])
        end
        for  i=1,#m3 do
            table.insert(masKofPol,m3[i])
        end
    end
    return m1,masKofPol
end

function light2(x1,y1,x2,y2,i)
    local length = math.sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1))
    local m = {x1,y1}
    local x =0
    local y = 0
    local aye = 4 -- ширина разброса 
    local ran =math.random(-length/aye,length/aye)
    local angle =3.14-math.atan2((x2-x1),(y2-y1))
    x =x1+(x2-x1)/2+math.cos(angle)*ran
    y =y1+(y2-y1)/2+math.sin(angle)*ran
    local m1 = pol2(x1,y1,x,y,i)
    for  i=1,#m1 do
        table.insert(m,m1[i])
    end
    table.insert(m,x)
    table.insert(m,y)
    m1 = pol2(x,y,x2,y2,i)
    for  i=1,#m1 do
        table.insert(m,m1[i])
    end
    table.insert(m,x2)
    table.insert(m,y2)
    return m
end

function pol2(x1,y1,x2,y2,i) 
    local aye = 5 -- ширина разброса 
    local length = math.sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1))
    local ran =math.random(-length/aye,length/aye)
    local angle =3.14-math.atan2((x2-x1),(y2-y1))
    local x =x1+(x2-x1)/2+math.cos(angle)*ran
    local y =y1+(y2-y1)/2+math.sin(angle)*ran
    local m1 = {}
    table.insert(m1,x)
    table.insert(m1,y)
    return m1
end

function lightDesh(x1,y1,x2,y2,i,mas)
    local length = math.sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1))
    local m = {x1,y1}
    local aye = 4 -- ширина разброса 
    local ran =mas[1]
    local angle =3.14-math.atan2((x2-x1),(y2-y1))
    local x =x1+(x2-x1)/2+math.cos(angle)*ran
    local y =y1+(y2-y1)/2+math.sin(angle)*ran
    local m1= polDesh(x1,y1,x,y,i,2,mas)
    for  i=1,#m1 do
        table.insert(m,m1[i])
    end
    table.insert(m,x)
    table.insert(m,y)
    m1 = polDesh(x,y,x2,y2,i,2+#m1/2,mas)
    for  i=1,#m1 do
        table.insert(m,m1[i])
    end
    table.insert(m,x2)
    table.insert(m,y2)
    return m
end

function polDesh(x1,y1,x2,y2,i,masI,mas) 
    local aye = 5 -- ширина разброса 
    local length = math.sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1))
    local ran =mas[masI]
    local angle =3.14-math.atan2((x2-x1),(y2-y1))
    local x =x1+(x2-x1)/2+math.cos(angle)*ran
    local y =y1+(y2-y1)/2+math.sin(angle)*ran
    local m1 = {}
    local m2 = {}
    local m3 = {}
    if ( i>0 and i~=0 ) then
        m2 = polDesh(x1,y1,x,y,i-1,masI+1,mas)
        for  i=1,#m2 do
            table.insert(m1,m2[i])
        end
    end
    table.insert(m1,x)
    table.insert(m1,y)
    if ( i>0) then
        m3 = polDesh(x,y,x2,y2,i-1,masI+1+#m2/2,mas)
        for  i=1,#m2 do
            table.insert(m1,m3[i])
        end
    end
    return m1
end

function explUpdate2(dt)
    for i =1, #exp do
        if( exp[i]) then
            exp[i].x= exp[i].x+exp[i].ax*dt*k
            exp[i].y= exp[i].y+exp[i].ay*dt*k2
            if (  exp[i].flag ==false) then 
                if ( exp[i].ax > 0 ) then
                    exp[i].ax  = exp[i].ax -70*dt*k
                else
                    exp[i].ax  = exp[i].ax + 70*dt*k
                end
                if ( exp[i].ay > 0 ) then
                    exp[i].ay  = exp[i].ay -70*dt*k2
                else
                    exp[i].ay  = exp[i].ay + 70*dt*k2
                end
            end
            if ( (exp[i].ay<3*k2 and  exp[i].ay>-3*k2) or (exp[i].ax<3*k and  exp[i].ax>-3*k)) then
                table.remove(exp,i)
            end
        end
    end
end

function explUpdate(dt)
    for i =1, #exp do
        if( exp[i]) then
            exp[i].x= exp[i].x+exp[i].ax*dt*2*k
            exp[i].y= exp[i].y+exp[i].ay*dt*2*k2
            if (  exp[i].flag ==false) then 
                if ( exp[i].ax > 0 ) then
                    exp[i].ax  = exp[i].ax - 50*dt*k
                else
                    exp[i].ax  = exp[i].ax + 50*dt*k
                end
                if ( exp[i].ay > 0 ) then
                    exp[i].ay  = exp[i].ay - 50*dt*k2
                else
                    exp[i].ay  = exp[i].ay + 50*dt*k2
                end
            end
            if ( (exp[i].ay<10*k2 and  exp[i].ay>-10*k2) or (exp[i].ax<10*k and  exp[i].ax>-10*k)) then
                exp[i].flag =true
            end
            if ( exp[i].flag == true) then
                local x1 = exp[i].x - exp[i].xx
                local y1 = exp[i].y - exp[i].yy
                local ugol = math.atan2(x1,y1)
                exp[i].ax=90*k*math.sin(ugol+2)
                exp[i].ay=90*k2*math.cos(ugol+2)
            end
            if ( ((exp[i].y<exp[i].yy+200*k2*dt and  exp[i].y>exp[i].yy-200*k2*dt) and (exp[i].x<exp[i].xx+200*k*dt and  exp[i].x>exp[i].xx-200*k*dt)) and exp[i].flag == true ) then
                table.remove(exp,i)
            end
        end
    end
end

function expl(x,y,kol)
    for kek =0, kol do
        local Color1,Color2,Color3  = particlColor()
        local e = {
        flag  =false,-----new but old
        tip = 1,
        r = 0 ,
        color1 = Color1,--- old 
        color2= Color2,--- old 
        color3 =Color3,--- old 
        f = false,
        x  = x, 
        y =  y,  
        xx  = x, 
        yy =  y,
        ax  =math.random(-1.72*k*30,1.73*k*30), 
        ay = math.random(-1.73*k*30,1.73*k*30), 
        scale =0.15
        }
    table.insert(exp,e)
    end
end
function gradient(dt)
    if (gradientI == 1 ) then
        gradientOp1(dt)
    end
    if (gradientI  == 2 ) then 
        gradientOp2(dt)
    end
    if (gradientI  == 3 ) then 
        gradientOp3(dt)
    end
    return gradientR+0.8,gradientG+0.8,gradientB+0.8
end
function gradientOp1(dt)
    if ( gradientR>0) then
        gradientR = gradientR - 0.4*dt
        gradientG = gradientG + 0.4*dt
    else
        gradientR = 0
        gradientG = 1
        gradientI = 2
    end
end
function gradientOp2(dt)
    if ( gradientG>0) then
        gradientG = gradientG - 0.4*dt
        gradientB = gradientB + 0.4*dt
    else
        gradientG = 0
        gradientB = 1
        gradientI = 3
    end
end
function gradientOp3(dt)
    if ( gradientB>0) then
        gradientB = gradientB - 0.4*dt
        gradientR = gradientR + 0.4*dt
    else
        gradientB = 0
        gradientR = 1
        gradientI = 1
    end
end












return effects
