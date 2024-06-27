local Body <const> = require('model.characters.Body')
local Dirs <const> = require('constant.Dirs')
local setmetatable <const> = setmetatable
local floor <const> = math.floor

local JumpingCharacter <const> = {}
JumpingCharacter.__index = JumpingCharacter
setmetatable(JumpingCharacter,Body)

_ENV = JumpingCharacter

function JumpingCharacter:checkIfCollideSolidFloor(world)
	local xVal <const> = floor(self.x)
	if world:getCharAt(xVal,self.printY) == 2 then
		self.acc = 0
		self.printY = self.prevPrintY
		self.y = self.prevY
		return true
	end
	return false
end

function JumpingCharacter:applyAcceleration(newAcc,dt)
	self.acc = self.acc + newAcc
	self.prevY = self.y
	self.y = self.y + self.acc * dt
	self.prevPrintY = self.printY
	self.printY = floor(self.y)
	return self
end

function JumpingCharacter:jump(dt)
	return self:applyAcceleration(self.jumpAcc,dt)
end

function JumpingCharacter:applyGravity(gravity,dt)
	return self:applyAcceleration(gravity,dt)
end

function JumpingCharacter:update(dt,world)
	self:checkIfCollideSolidFloor(world)
	if self.printY >= world.height then return false end
	return Body.update(self,dt,world)
end

local moveFunctions <const> = {
	[Dirs.UP] = JumpingCharacter.jump
}

function JumpingCharacter:move(dir,dt)
	if moveFunctions[dir] then return moveFunctions[dir](self,dt) end
	return Body.move(self,dir)
end


function JumpingCharacter:new(x,y,char,speed,xDir,jumpAcc,interval,color)
	local jumpCharacter <const> = setmetatable(Body:new(x,y,char,speed,xDir,color),self)
	jumpCharacter.jumpAcc = jumpAcc
	jumpCharacter.interval = interval
	jumpCharacter.acc = 0
	return jumpCharacter
end

return JumpingCharacter
