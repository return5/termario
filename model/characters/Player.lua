local JumpingCharacter <const> = require('model.characters.JumpingCharacter')
local Dirs <const> = require('constant.Dirs')
local setmetatable <const> = setmetatable

local Player <const> = {}
Player.__index = Player
setmetatable(Player,JumpingCharacter)

_ENV = Player

function Player:update(dt,world,gravity)
	gravity:applyGravity(self)
	if JumpingCharacter.update(self,dt,world) then
		self.xDir = Dirs.STOP
	end
	return self
end

function Player:reset(level)
	self.x = 1
	self.prevX = 1
	self.printX = 1
	self.prevPrintX = 1
	self.y = #level - 1
	self.printY = self.y
	self.prevPrintY = self.printY
	self.prevY = self.y
	self.acc = 0
	self.xDir = 0
	return self
end

function Player:new(x,y,char,speed,xDir,color)
	local player <const> = setmetatable(JumpingCharacter:new(x,y, char,speed,xDir,-4,0,color),self)
	player.acc = 0
	player.score = 0
	return player
end

return Player
