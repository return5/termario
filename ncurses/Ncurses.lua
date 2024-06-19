require("libs.ncurses.sluacurses")

local init <const> = init
local endWin <const> = endwin
local getTime <const> = getTime
local getMaxYX <const> = getMaxYX
local initBorder <const> = initBorder
local initwindow <const> = initwindow

local Ncurses <const> = {}
Ncurses.__index = Ncurses

_ENv = Ncurses

function Ncurses.tearDown()
	endWin()
end

function Ncurses.getTime()
	return getTime()
end

function Ncurses.init()
	init()
end

function Ncurses.getMaxYX()
	return getMaxYX()
end

return Ncurses
