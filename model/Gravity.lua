local Timer <const> = require('model.Timer')
local setmetatable <const> = setmetatable

local Gravity <const> = {}
Gravity.__index = Gravity

_ENV = Gravity

function Gravity:applyGravity(body)
	if self:hasTimeElapsed() then
		body:applyAcceleration(-self.gravityAcc * self.elapsedTimer,self.elapsedTimer)
	end
	return self
end

function Gravity:hasTimeElapsed()
	self.elapsed = self.elapsed + self.timer:getDt()
	if self.elapsed >= self.elapsedTimer then
		self.elapsed = 0
		return true
	end
	return false
end

function Gravity:new(elapsedTimer,gravityAcc)
	return setmetatable({timer = Timer:new(),elapsedTimer = elapsedTimer,elapsed = 0,gravityAcc = gravityAcc},self)
end


return Gravity
