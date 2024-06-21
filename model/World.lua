local Config <const> = require('constant.Config')
local NcurseIO <const> = require('ncurses.NcurseIO')
local Ncurses <const> = require('ncurses.Ncurses')
local floor <const> = math.floor
local setmetatable <const> = setmetatable

local World <const> = {}
World.__index = World

_ENV = World


local convertNumToChar <const> = {" ","=","|"}

local function printWorld(level,start,stop,offset)
	local printStop <const> = stop <= #level[1] and stop or #level[1]
	for y=1,#level,1 do
		for x=start,printStop,1 do
			NcurseIO.print(x - offset,y,convertNumToChar[level[y][x]])
		end
	end
end

function World:getLimits(player)
	if player.printX <= self.printWidth_half then
		return 1,self.maxWidth
	end
	if player.printX >= #self.level[1] - self.printWidth_half then
		return #self.level[1] - self.maxWidth,#self.level[1]
	end
	return  player.printX - self.printWidth_half, player.printX + self.printWidth_half

end

function World:print(player)
	local start <const>,stop <const> = self:getLimits(player)
	self.offset = start - 1
	printWorld(self.level,start,stop,self.offset)
end

function World:getCharAt(x,y)
	return self.level[y][x]
end

function World:reset(level)
	local maxY <const> = Ncurses.getMaxYX()
	local printWidth_half <const> = floor(maxY/ 2)
	self.printWidth_half = printWidth_half
	self.maxWidth = maxY
	self.level = level
	return self
end

function World:new()
	return setmetatable({level = {},printWidth_half = 0,maxWidth = 0,offset = 0},self)
end

return World
