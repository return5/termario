local setmetatable <const> = setmetatable

local Object <const> = {}
Object.__index = Object

_ENV = Object

function Object:print()
	--TODO
	return self
end

function Object:new(x,y,char)
	return setmetatable({x = x,y = y, char = char},self)

end

return Object
