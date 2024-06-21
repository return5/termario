local Body <const> = require('model.Body')
local Dirs <const> = require('constant.Dirs')
local setmetatable <const> = setmetatable
local floor <const> = math.floor


local Player <const> = {}
Player.__index = Player
setmetatable(Player,Body)

_ENV = Player

function Player:applyAcceleration(newAcc,dt)
	self.acc = self.acc + newAcc
	self.prevY = self.y
	self.y = self.y + self.acc * dt
	self.prevPrintY = self.printY
	self.printY = floor(self.y)
	return self
end

function Player:checkIfCollideSolidObj(world)
	local xVal <const> = floor(self.x)
	if world:getCharAt(xVal,self.printY) == 2 then
		self.acc = 0
		self.printY = self.prevPrintY
		self.y = self.prevY
	end
	if world:getCharAt(xVal + self.xDir,self.printY) == 2 then
		self.xDir = Dirs.STOP
	end
	return self
end

function Player:update(dt,world)
	Body.update(self,dt)
	self:checkIfCollideSolidObj(world)
	return self
end

function Player:new(x,y,char,speed,xDir)
	local player <const> = setmetatable(Body:new(x,y, char,speed,xDir),self)
	player.acc = 0
	return player
end

return Player
