local Ncurses <const> = require('ncurses.Ncurses')
local Config <const> = require('constant.Config')
local floor <const> = math.floor
local setmetatable <const> = setmetatable

local World <const> = {}
World.__index = World

_ENV = World


local function printWorld(level,start,stop,offset)
	for y=1,#level,1 do
		local printStop <const> = stop <= #level[1] and stop or #level[1]
		for x=start,printStop,1 do
			level[y][x]:print(offset)
		end
	end
end

function World:isPlayerAtEnd(player)
	local yArr <const> = self.level[player.printY + 1]
	if not yArr then return false end
	return yArr[player.printX]:isAtEnd()
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
	if not self.level[y] or not self.level[y][x] then return "" end
	return self.level[y][x].char
end

function World:reset(level)
	local _ <const>, maxX <const> = Ncurses.getMaxYX()
	self.maxWidth = maxX <= Config.printWidth and maxX or Config.printWidth
	local printWidth_half <const> = floor(self.maxWidth/ 2)
	self.printWidth_half = printWidth_half
	self.level = level
	self.length = level and level[1] and #level[1] or 0
	self.height = #level
	return self
end

function World:new()
	return setmetatable({level = {},printWidth_half = 0,maxWidth = 0,offset = 0,length = 0, height = 0},self)
end

return World
