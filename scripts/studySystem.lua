local studySystem = {}

local Text = {
    string ="",
    outputText ="",
    maxLineLength = 13,
    lineLength =0,
    lengthIndex = 0,
}


local Move = {}
local Atack = {}
local Resource = {}
local BuyUpgrades = {}
local text1 = "5111 23123 131 2313125"

StudySystem = {
    isEnabled = true,
    number = 1,
    States ={},
}

function StudySystem:load()
    Text:setText(text1)
    Text:setLineSize(15)
end

function StudySystem:update(dt)
    bodyTextPanel(130*k,screenHeight/2,1/2.3)
    Text:update(dt) 
end

function StudySystem:draw()
    UIBatch:clear()
    Text:print(150,screenHeight/2,0.6)
end

function Text:setText(text)
    self.string =text
    self.outputText =""
    self.maxLineLength = 13
    self.lineLength =0
    self.lengthIndex = 0
end

function Text:setLineSize(size)
    self.maxLineLength = size
end
function Text:update(dt) 
    if (self.lengthIndex<=#self.string) then 
        self.lengthIndex = self.lengthIndex+1
        self.lineLength = self.lineLength+1
        local textLine ="" 
        if (self.outputText:sub(#self.outputText,#self.outputText)=="_") then
            self.outputText = self.outputText:sub(0,#self.outputText-1)
        end
        textLine = self.string:sub(self.lengthIndex,self.lengthIndex)
        if ( self.lineLength>13 and self.string:sub(self.lengthIndex,self.lengthIndex) == " ") then
            self.lineLength = 0 
            textLine =textLine.."\n"
        end
        self.outputText = self.outputText..textLine.."_"
    end
end

function Text:print(x,y,scale)
    love.graphics.setColor(1,1,1,1)
    love.graphics.print(self.outputText,x,y,-3.14/2,scale*k,scale*k)
end


function Move:update()
end

return studySystem