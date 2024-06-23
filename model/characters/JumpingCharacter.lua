local RegularCharacter <const> = require('model.characters.RegularCharacter')
local Dirs <const> = require('constant.Dirs')
local setmetatable <const> = setmetatable
local floor <const> = math.floor

local JumpingCharacter <const> = {}
JumpingCharacter.__index = JumpingCharacter
setmetatable(JumpingCharacter,RegularCharacter)

_ENV = JumpingCharacter


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

function JumpingCharacter:moveY()
	self.acc = -self.jumpAcc
	return self
end

local moveFunctions <const> = {
	[Dirs.UP] = JumpingCharacter.moveY
}

function JumpingCharacter:move(dir)
	if moveFunctions[dir] then return moveFunctions[dir](self,dir) end
	return RegularCharacter.move(self,dir)
end


function JumpingCharacter:new(x,y,char,speed,xDir,jumpAcc,interval)
	local jumpCharacter <const> = setmetatable(RegularCharacter:new(x,y,char,speed,xDir),self)
	jumpCharacter.jumpAcc = jumpAcc
	jumpCharacter.interval = interval
	jumpCharacter.acc = jumpAcc
	return jumpCharacter
end

return JumpingCharacter
