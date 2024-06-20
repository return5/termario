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

function Body:print(offset)
	self.printX = self.printX - offset
	Object.print(self)
	return self
end

function Body:applyAcceleration(newAcc,dt)
	self.acc = self.acc + newAcc
	self.y = self.y + self.acc * dt
	self.prevPrintY = self.printY
	self.printY = floor(self.y)
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
	self.x = self.x + self.xDir * self.speed * dt
	self.prevPrintX = self.printX
	self.printX = floor(self.x)
	return self
end

function Body:new(x,y,char,speed,xDir,dt)
	local body <const> = setmetatable(Object:new(x,y, char),self)
	body.speed = speed
	body.acc = 0
	body.xDir = xDir
	body.dt = dt
	return body
end

return Body
