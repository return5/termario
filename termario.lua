local Timer <const> = require('model.Timer')
local Gravity <const> = require('model.Gravity')
local Player <const> = require('model.Player')
local NcursesIO <const> = require('ncurses.NcurseIO')
local Ncurses <const> = require('ncurses.Ncurses')
local level1 <const> = require('levels.Level1')
local World <const> = require('model.World')

local continue = true

local function draw(player,world,enemies)
--	NcursesIO.clear()
	world:print(player)
	player:print(world.offset)
--	NcursesIO.refresh()
--	enemies:print()
end

local function input(player)
	local userInput <const> = NcursesIO.getCh()
	if userInput then player:move(userInput) end
end

local function loop(timer,gravity,player,world,enemies)
	while continue do
		gravity:applyGravity(player)
		input(player)
		player:update(timer:getDt(),world)
		draw(player,world,enemies)
	end
end

local function main()
	Ncurses.init()
	local timer <const> = Timer:new()
	local gravity <const> = Gravity:new(0.05,3)
	local player <const> = Player:new(23,#level1 - 1,"@",4,-1)
--	player.acc = -4
	local world <const> = World:new(level1)
	loop(timer,gravity,player,world)
	Ncurses.tearDown()
end


main()
