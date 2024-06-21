local Object <const> = require('model.Object')
local Dirs <const> = require('constant.Dirs')
local setmetatable <const> = setmetatable
local floor <const> = math.floor

local Body <const> = {}
Body.__index = Body
setmetatable(Body,Object)

_ENV = Body

function Body:checkBoundaries()
	--TODO
	return true
end

function Body:print(xOffset)
	Object.print(self,xOffset)
	return self
end

local moveTranslate <const> = {
	[Dirs.LEFT] = {[Dirs.LEFT] = Dirs.LEFT,[Dirs.RIGHT] = Dirs.STOP},
	[Dirs.RIGHT] = {[Dirs.LEFT] = Dirs.STOP,[Dirs.RIGHT] = Dirs.RIGHT},
	[Dirs.STOP] = {[Dirs.LEFT] = Dirs.LEFT,[Dirs.RIGHT] = Dirs.RIGHT}
}

function Body:move(dir)
	local dirTbl = moveTranslate[self.xDir]
	self.xDir = dirTbl[dir]
	return self
end

function Body:update(dt)
	self.prevX = self.x
	self.x = self.x + self.xDir * self.speed * dt
	self.prevPrintX = self.printX
	self.printX = floor(self.x)
	return self
end

function Body:new(x,y,char,speed,xDir)
	local body <const> = setmetatable(Object:new(x,y, char),self)
	body.speed = speed
	body.xDir = xDir
	return body
end

return Body
