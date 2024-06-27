local Timer <const> = require('model.Timer')
local Gravity <const> = require('model.Gravity')
local Player <const> = require('model.characters.Player')
local NcursesIO <const> = require('ncurses.NcurseIO')
local Ncurses <const> = require('ncurses.Ncurses')
local Levels <const> = require('levels.Levels')
local World <const> = require('model.World')
local Enemies <const> = require('model.Enemies')
local CharacterFactory <const> = require('factory.CharacterFactory')
local NcursesColors <const> = require('ncurses.NcursesColors')

local continue = true

local function draw(player,world,enemies)
	world:print(player)
	player:print(world.offset)
	enemies:print(world,player)
end

local function input(player,dt)
	local userInput <const> = NcursesIO.getCh()
	if userInput ~= nil then player:move(userInput,dt) end
end

local function update(player,world,enemies,dt,gravity)
	input(player,dt)
	gravity:setElapsed()
	player:update(dt,world,gravity)
	enemies:update(dt,world,player,gravity)
	gravity:resetElapsed()
end

local function loop(timer,gravity,player,world,enemies)
	while continue do
		update(player,world,enemies,timer:getDt(),gravity)
		draw(player,world,enemies)
		continue = enemies:checkCollision(player,world)
	end
end

local function startLevel(world,player,enemies,level)
	world:reset(level)
	player:reset(level)
	enemies:reset(CharacterFactory.generateEnemies(level))
	continue = true
end

local function loopOverLevels(timer,gravity,player,world,enemies)
	while true do
		local level <const> = Levels.getLevel()
		if level == nil then
			Levels:reset()
			return loopOverLevels(timer,gravity,player,world,enemies)
		end
		startLevel(world,player,enemies,level)
		loop(timer,gravity,player,world,enemies)
	end
end


local function main()
	Ncurses.init()
	local timer <const> = Timer:new()
	local gravity <const> = Gravity:new(0.05,3)
	local player <const> = Player:new(0,0,"@",4,1,NcursesColors.Cyan)
	local world <const> = World:new()
	local enemies <const> = Enemies:new()
	loopOverLevels(timer,gravity,player,world,enemies)
	Ncurses.tearDown()
end


main()
