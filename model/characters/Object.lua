local setmetatable <const> = setmetatable
local NcurseIO <const> = require('ncurses.NcurseIO')

local Object <const> = {}
Object.__index = Object

_ENV = Object

function Object:print(xOffset)
	local xOffsetVal <const> = xOffset or 0
	NcurseIO.turnOnColor(self.color)
	NcurseIO.print(self.prevPrintX - xOffsetVal,self.prevPrintY," ")
	NcurseIO.print(self.printX - xOffsetVal,self.printY,self.char)
	NcurseIO.turnOffColor(self.color)
	return self
end

function Object:checkWithinBounds(startX,stopX)
	return self.printX >= startX and self.printX <= stopX
end

function Object:new(x,y,char,color)
	return setmetatable({x = x,y = y, char = char,printX = x, printY = y,prevPrintX = x,prevPrintY = y,prevX = x, prevY = y,color = color},self)

end

return Object
