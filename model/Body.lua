local Object <const> = setmetatable('model.Object')
local setmetatable <const> = setmetatable

local Body <const> = {}
Body.__index = Body
setmetatable(Body,Object)

_ENV = Body

function Body:checkBoundaries()
	--TODO
	return true
end

function Body:update(dt,gravity)
	self.x = self.x + self.xDir * self.speed * dt
	self.acc = self.acc - gravity * dt
	self.y = self.y + self.acc
	return self
end

function Body:new(x,y,char,speed,xDir)
	local body <const> = setmetatable(Object:new(x,y, char),self)
	body.speed = speed
	body.acc = 0
	body.xDir = xDir
	return body
end

return Body
