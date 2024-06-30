local Timer <const> = require('model.utils.Timer')
local setmetatable <const> = setmetatable

local Gravity <const> = {}
Gravity.__index = Gravity

_ENV = Gravity

function Gravity:applyGravity(body)
	if self:hasTimeElapsed() then
		body:applyAcceleration(self.gravityAcc * self.elapsedTimer,self.elapsedTimer)
	end
	return self
end

function Gravity:setElapsed()
	self.elapsed = self.elapsed + self.timer:getDt()
	return self
end

function Gravity:hasTimeElapsed()
	if self.elapsed >= self.elapsedTimer then
		return true
	end
	return false
end

function Gravity:resetElapsed()
	if self:hasTimeElapsed() then
		self.elapsed = 0
	end
	return self
end

function Gravity:new(elapsedTimer,gravityAcc)
	return setmetatable({timer = Timer:new(),elapsedTimer = elapsedTimer,elapsed = 0,gravityAcc = gravityAcc},self)
end


return Gravity
