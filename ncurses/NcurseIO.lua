require('libs.ncurses.sluacurses')

local Dirs <const> = require('constant.Dirs')
local NcursesColors <const> = require('ncurses.NcursesColors')
local mvprintw <const> = mvprintw
local clear <const> = clear
local refresh <const> = refresh
local getch <const> = getch
local attron <const> = attron
local attroff <const> = attroff
local initPair <const> = init_pair
local colorPair <const> = COLOR_PAIR
local pairs <const> = pairs

local NcursesIO <const> = {}
NcursesIO.__index = NcursesIO

_ENV = NcursesIO

local colorPairsTbl <const> = {}

local counter = 1
for colorName, color in pairs(NcursesColors) do
	colorPairsTbl[colorName] = counter
	initPair(counter,color,NcursesColors.Black)
	counter = counter + 1
end

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
	attron(colorPair(colorPairsTbl[color]))
	return NcursesIO
end

function NcursesIO.turnOffColor(color)
	attroff(colorPair(colorPairsTbl[color]))
	return NcursesIO
end

return NcursesIO
