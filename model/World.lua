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

function World:getLimits(player)
	if player.printX <= printWidth_half then
		return 1,Config.printWidth
	end
	if player.printX >= #self.level[1] - Config.printWidth_half then
		return #self.level[1] - Config.printWidth,#self.level[1]
	end
	return  player.printX - printWidth_half, player.printX + printWidth_half

end

function World:print(player)
	local start <const>,stop <const> = self:getLimits(player)
	printWorld(self.level,start,stop)
end

function World:new(level)
	return setmetatable({level = level},self)
end

return World
