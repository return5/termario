local JumpingCharacter <const> = require('model.characters.JumpingCharacter')
local Dirs <const> = require('constant.Dirs')
local setmetatable <const> = setmetatable
local floor <const> = math.floor

local Player <const> = {}
Player.__index = Player
setmetatable(Player,JumpingCharacter)

_ENV = Player

function Player:checkIfCollideSolidObj(world)
	local xVal <const> = floor(self.x)
	if world:getCharAt(xVal,self.printY) == 2 then
		self.acc = 0
		self.printY = self.prevPrintY
		self.y = self.prevY
	end
	if (self.printX == 1 and self.dir == Dirs.LEFT) or world:getCharAt(xVal + self.xDir,self.printY) == 2 then
		self.xDir = Dirs.STOP
	end
	return self
end

function Player:update(dt,world)
	JumpingCharacter.update(self,dt)
	self:checkIfCollideSolidObj(world)
	return self
end

function Player:reset(level)
	self.x = 1
	self.printX = 1
	self.y = #level - 1
	self.printY = self.y
	return self
end

function Player:new(x,y,char,speed,xDir)
	local player <const> = setmetatable(JumpingCharacter:new(x,y, char,speed,xDir,3),self)
	player.acc = 0
	player.score = 0
	return player
end

return Player
