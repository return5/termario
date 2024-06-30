local JumpingCharacter <const> = require('model.characters.JumpingCharacter')
local Dirs <const> = require('constant.Dirs')
local setmetatable <const> = setmetatable

local Player <const> = {}
Player.__index = Player
setmetatable(Player,JumpingCharacter)

_ENV = Player

function Player:update(dt,world,gravity)
	gravity:applyGravity(self)
	if not JumpingCharacter.update(self,dt,world) then
		self.xDir = Dirs.STOP
	end
	return self
end

function Player:jump(dt)
	if self.acc ~= 0 then return self end
	return JumpingCharacter.jump(self,dt)
end

function Player:removeLife()
	self.lives = self.lives - 1
end

function Player:checkIfContinue(enemies,world)
	if self.printY > world.height then
		self:removeLife()
		return false
	end
	if not enemies:checkCollision(self,world) then
		self:removeLife()
		return false
	end
	return true
end

function Player:reset(level)
	self.x = 1
	self.printX = 1
	self.y = #level - 1
	self.printY = self.y
	self.acc = 0
	self.xDir = 0
	return self
end

function Player:new(x,y,char,speed,xDir,color)
	local player <const> = setmetatable(JumpingCharacter:new(x,y, char,speed,xDir,-4,0,color,0),self)
	player.acc = 0
	player.lives = 2
	return player
end

return Player
