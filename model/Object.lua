local setmetatable <const> = setmetatable
local NcurseIO <const> = require('ncurses.NcurseIO')

local Object <const> = {}
Object.__index = Object

_ENV = Object

function Object:print()
	NcurseIO.print(self.prevPrintX,self.prevPrintY," ")
	NcurseIO.print(self.printX,self.printY,self.char)
	return self
end

function Object:checkWithinBounds(startX,stopX)
	return self.printX >= startX and self.printX <= stopX
end

function Object:new(x,y,char)
	return setmetatable({x = x,y = y, char = char,printX = x, printY = y,prevPrintX = x,prevPrintY = y},self)

end

return Object
