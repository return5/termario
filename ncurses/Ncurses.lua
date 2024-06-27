require("libs.ncurses.sluacurses")
local NcursesColors <const> = require('ncurses.NcursesColors')

local init <const> = init
local endWin <const> = endwin
local getTime <const> = getTime
local getMaxYX <const> = getMaxYX
local init_pair <const> = init_pair
local pairs <const> = pairs

local Ncurses <const> = {}
Ncurses.__index = Ncurses

_ENV = Ncurses

Ncurses.ColorPairs = {}

function Ncurses.tearDown()
	endWin()
end

function Ncurses.getTime()
	return getTime()
end

function Ncurses.init()
	init()
	local counter = 1
	for _, color in pairs(NcursesColors) do
		Ncurses.ColorPairs[color] = counter
		init_pair(counter,color,NcursesColors.Black)
		counter = counter + 1
	end
end

function Ncurses.getMaxYX()
	return getMaxYX()
end

return Ncurses
