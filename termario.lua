local Timer <const> = require('model.Timer')
local Gravity <const> = require('model.Gravity')
local Body <const> = require('model.Body')
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
		player:update(timer:getDt())
		input(player)
	--	gravity:applyGravity(player)
		draw(player,world,enemies)
	end
end

local function main()
	Ncurses.init()
	local timer <const> = Timer:new()
	local gravity <const> = Gravity:new(0.05,3)
	local player <const> = Body:new(1,0,"@",5,1)
	local world <const> = World:new(level1)
	loop(timer,gravity,player,world)
	Ncurses.tearDown()
end


main()
