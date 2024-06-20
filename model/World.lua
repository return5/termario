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

function World:new(level)
	local maxY <const> = Ncurses.getMaxYX()
	local maxWidth <const> = maxY >= Config.printWidth and Config.printWidth or maxY
	local printWidth_half <const> = floor(maxWidth/ 2)
	return setmetatable({level = level,printWidth_half = printWidth_half,maxWidth = maxWidth,offset = 0},self)
end

return World
