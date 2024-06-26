local Object <const> = require('model.characters.Object')
local Dirs <const> = require('constant.Dirs')
local setmetatable <const> = setmetatable
local floor <const> = math.floor

local Body <const> = {}
Body.__index = Body
setmetatable(Body,Object)

_ENV = Body

function Body:applyGravity()
	return self
end

local xOppositeDirs <const> = {
	[Dirs.LEFT] = Dirs.RIGHT,
	[Dirs.RIGHT] = Dirs.LEFT
}

function Body:moveOppositeX()
	self.xDir = xOppositeDirs[self.xDir]
	return self
end

function Body:checkIfCollideSolidObj(world)
	if (self.printX < 1 and self.xDir == Dirs.LEFT) or (self.printX == world.length + 1 and self.xDir == Dirs.RIGHT) or world:getCharAt(self.printX,self.printY) == 2 then
		self:moveOppositeX()
		self.printX = self.prevPrintX
		self.x = self.prevX
		return true
	end
	return false
end

function Body:checkBoundaries()
	--TODO
	return true
end

local xMoveTranslate <const> = {
	[Dirs.LEFT] = {[Dirs.LEFT] = Dirs.LEFT,[Dirs.RIGHT] = Dirs.STOP},
	[Dirs.RIGHT] = {[Dirs.LEFT] = Dirs.STOP,[Dirs.RIGHT] = Dirs.RIGHT},
	[Dirs.STOP] = {[Dirs.LEFT] = Dirs.LEFT,[Dirs.RIGHT] = Dirs.RIGHT}
}

function Body:moveX(dir)
	local dirTbl = xMoveTranslate[self.xDir]
	self.xDir = dirTbl[dir]
	return self
end

local moveFunctions <const> = {
	[Dirs.LEFT] = Body.moveX,
	[Dirs.RIGHT] = Body.moveX,
}

function Body:move(dir)
	if moveFunctions[dir] then return moveFunctions[dir](self,dir) end
	return self
end

function Body:update(dt,world)
	self.prevX = self.x
	self.x = self.x + self.xDir * self.speed * dt
	self.prevPrintX = self.printX
	self.printX = floor(self.x)
	return self:checkIfCollideSolidObj(world)
end

function Body:checkSideCollision(body1)
	return body1.printY == self.printY and body1.printX == self.printX
end

function Body:checkTopCollision(body1)
	return body1.prevPrintY < self.printY and body1.printY == self.printY and body1.printX == self.printX and body1.prevPrintX == self.printX
end

function Body:new(x,y,char,speed,xDir)
	local body <const> = setmetatable(Object:new(x,y, char),self)
	body.speed = speed
	body.xDir = xDir
	return body
end

return Body
