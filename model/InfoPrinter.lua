local NcursesIO <const> = require('ncurses.NcurseIO')
local setmetatable <const> = setmetatable
local floor <const> = math.floor
local len <const> = string.len

local InfoPrinter <const> = {}
InfoPrinter.__index = InfoPrinter

_ENV = InfoPrinter


function InfoPrinter:printStr(x,y,str)
	NcursesIO.print(x,y,str)
	return self
end

function InfoPrinter:print(player,level)
	self:printStr(self.livesX,self.height,"Lives: " .. player.lives)
	self:printStr(self.levelsX,0,"Level " .. level)
	self:printStr(self.scoreX,self.height,"Score: " .. player.score)
	return self
end

function InfoPrinter:reset(world)
	self.height = world.height + 1
	self.scoreX = world.maxWidth - len("Score: 0000")
	self.levelsX = floor(self.scoreX / 2)
	return self
end

function InfoPrinter:new()
	return setmetatable({height = 0,livesX = 0,levelsX = 0,scoreX = 0},self)
end

return InfoPrinter
