local owerseerF = {}

function slediFunction()

sledi3:update(dt2)
sledi3:every(0.02, function()  
if ( sled) then
        sled = {
        x = round(player.x + math.cos(sled.y)*3*k+40*k/2),
        y = round(player.y + math.sin(sled.x)*3*k2+40*k2/2)
      }
end  
if ( #sledi2<16) then
  table.insert(sledi2,sled)
end
sledi3:clear()
end)

end

return owerseerF

