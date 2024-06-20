require('libs.ncurses.sluacurses')

local Dirs <const> = require('constant.Dirs')
local mvprintw <const> = mvprintw
local clear <const> = clear
local refresh <const> = refresh
local getch <const> = getch
local drawBorder <const> = drawBorder


local NcursesIO <const> = {}
NcursesIO.__index = NcursesIO

_ENV = NcursesIO

local keysToDirsMap <const> = {
	w = Dirs.UP,
	s = Dirs.DOWN,
	a = Dirs.LEFT,
	d = Dirs.RIGHT
}

function NcursesIO.refresh()
	refresh()
end

function NcursesIO.clear()
	clear()
end

function NcursesIO.drawBorder(height,width)
	drawBorder(height,width)
end

function NcursesIO.print(x,y,char)
	mvprintw(y,x,char)
end

function NcursesIO.getCh()
	local ch <const> = getch()
	return keysToDirsMap[ch]
end


return NcursesIO
