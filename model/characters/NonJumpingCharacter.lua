local Body <const> = require('model.characters.Body')
local setmetatable <const> = setmetatable

local NonJumpingCharacter <const> = {}
NonJumpingCharacter.__index = NonJumpingCharacter
setmetatable(NonJumpingCharacter,Body)

_ENV = NonJumpingCharacter

function NonJumpingCharacter:checkIfNotOverSolidGround(world)
	if world:getCharAt(self.printX,self.printY + 1) ~= 2 then
		self:moveOppositeX()
		self.x = self.prevX
		self.printX = self.prevPrintX
	end
	return self
end

function NonJumpingCharacter:update(dt,world)
	if Body.update(self,dt,world) then
		self:checkIfNotOverSolidGround(world)
	end
	return true
end

function NonJumpingCharacter:new(x,y,char,speed,xDir,color)
	return setmetatable(Body:new(x,y,char,speed,xDir,color),self)
end

return NonJumpingCharacter
