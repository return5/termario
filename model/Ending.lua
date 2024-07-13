local Object <const> = require('model.characters.Object')
local setmetatable <const> = setmetatable

local Ending <const> = {}
Ending.__index = Ending
setmetatable(Ending,Object)

function Ending:isAtEnd()
	return true
end

function Ending:new(x,y,char,color)
	return setmetatable(Object:new(x,y,char,color),self)
end

return Ending
