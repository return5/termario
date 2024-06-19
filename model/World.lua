local Config <const> = require('constant.Config')
local NcurseIO <const> = require('ncurses.NcurseIO')
local floor <const> = math.floor
local setmetatable <const> = setmetatable

local World <const> = {}
World.__index = World

_ENV = World

local printWidth_half <const> = floor(Config.printWidth / 2)

local function printWorld(level,start,stop)
	local printStop <const> = stop <= #level[1] and stop or #level[1]
	for x=start,printStop,1 do
		for y=1,#level,1 do
			NcurseIO.print(x,y,level[y][x])
		end
	end
end

function World:print(center)
	if center.printX <= printWidth_half then
		return printWorld(self.level,1,Config.printWidth)
	end
	if center.printX >= #self.level[1] - Config.printWidth_half then
		return printWorld(self.level,#self.level[1] - Config.printWidth,#self.level[1])
	end
	return printWorld(self.level,center.printX - printWidth_half,center.printX + printWidth_half)
end

function World:new(level)
	return setmetatable({level = level},self)
end

return World
