local setmetatable <const> = setmetatable
local write <const> = io.write

local Object <const> = {}
Object.__index = Object

_ENV = Object

function Object:print()
	write(self.printX," : ",self.printY,"\n")
	return self
end

function Object:new(x,y,char)
	return setmetatable({x = x,y = y, char = char,printX = x, printY = y},self)

end

return Object
