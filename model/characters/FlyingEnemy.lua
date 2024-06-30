local Body <const> = require('model.characters.Body')
local setmetatable <const> = setmetatable

local FlyingEnemy <const> = {}
FlyingEnemy.__index = FlyingEnemy
setmetatable(FlyingEnemy, Body)

_ENV = FlyingEnemy


local oppositeChar <const> = {
	["<"] = ">",
	[">"] = "<"
}

function FlyingEnemy:update(dt,world)
	Body.update(self,dt,world)
	return true
end

function FlyingEnemy:moveOppositeX()
	Body.moveOppositeX(self)
	self.char = oppositeChar[self.char]
	return self
end

function FlyingEnemy:new(x,y,char,speed,xDir,color,score)
	return setmetatable(Body:new(x,y,char,speed,xDir,color,score),self)
end

return FlyingEnemy
