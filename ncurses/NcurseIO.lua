require('libs.ncurses.sluacurses')

local Dirs <const> = require('constant.Dirs')
local NcursesColorPairs <const> = require('ncurses.Ncurses').ColorPairs
local mvprintw <const> = mvprintw
local clear <const> = clear
local refresh <const> = refresh
local getch <const> = getch
local attron <const> = attron
local attroff <const> = attroff
local colorPair <const> = COLOR_PAIR

local NcursesIO <const> = {}
NcursesIO.__index = NcursesIO

_ENV = NcursesIO

function NcursesIO.refresh()
	refresh()
	return NcursesIO
end

function NcursesIO.clear()
	clear()
	return NcursesIO
end

function NcursesIO.print(x,y,char)
	mvprintw(y,x,char)
	return NcursesIO

end

local keysToDirsMap <const> = {
	a = Dirs.LEFT,
	d = Dirs.RIGHT,
	[' '] = Dirs.UP
}

function NcursesIO.getCh()
	local ch <const> = getch()
	return keysToDirsMap[ch]
end

function NcursesIO.turnOnColor(color)
	attron(colorPair(NcursesColorPairs[color]))
	return NcursesIO
end

function NcursesIO.turnOffColor(color)
	attroff(colorPair(NcursesColorPairs[color]))
	return NcursesIO
end

return NcursesIO
