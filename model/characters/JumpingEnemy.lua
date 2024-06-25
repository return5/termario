local JumpingCharacter <const> = require('model.characters.JumpingCharacter')
local setmetatable <const> = setmetatable

local JumpingEnemy <const> = {}
JumpingEnemy.__index = JumpingEnemy

setmetatable(JumpingEnemy,JumpingCharacter)

_ENV = JumpingEnemy

function JumpingEnemy:jump(dt)
	if self.acc ~= 0 then return self end
	self.dt = self.dt + dt
	if self.dt >= self.interval then
		JumpingCharacter.jump(self,dt)
		self.dt = 0
	end
	return self
end

function JumpingEnemy:update(dt,world,gravity)
	gravity:applyGravity(self)
	self:jump(dt)
	return JumpingCharacter.update(self,dt,world)
end

function JumpingEnemy:new(x,y,char,speed,xDir,jumpAcc,interval)
	local jumpingEnemy <const> = setmetatable(JumpingCharacter:new(x,y,char,speed,xDir,jumpAcc,interval),self)
	jumpingEnemy.dt = interval
	return jumpingEnemy
end

return JumpingEnemy
