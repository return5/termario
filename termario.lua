local Timer <const> = require('model.Timer')
local Gravity <const> = require('model.Gravity')
local Player <const> = require('model.characters.Player')
local NcursesIO <const> = require('ncurses.NcurseIO')
local Ncurses <const> = require('ncurses.Ncurses')
local Levels <const> = require('levels.Levels')
local World <const> = require('model.World')
local Enemies <const> = require('model.Collection')
local CharacterFactory <const> = require('factory.EntityFactory')
local NcursesColors <const> = require('ncurses.NcursesColors')
local Coins <const> = require('model.Coins')

local continue = true

local function draw(player,world,enemies,coins)
	world:print(player)
	player:print(world.offset)
	enemies:print(world,player)
	coins:print(world,player)
end

local function input(player,dt)
	local userInput <const> = NcursesIO.getCh()
	if userInput ~= nil then player:move(userInput,dt) end
end

local function update(player,world,enemies,dt,gravity,coins)
	input(player,dt)
	gravity:setElapsed()
	player:update(dt,world,gravity)
	enemies:update(dt,world,player,gravity)
	coins:checkCollision(player,world)
	gravity:resetElapsed()
end

local function loop(timer,gravity,player,world,enemies,coins)
	while continue do
		update(player,world,enemies,timer:getDt(),gravity,coins)
		draw(player,world,enemies,coins)
		continue = player:checkIfContinue(enemies,world)
	end
	player:removeLife()
end

local function startLevel(world,player,enemies,coins,level)
	local enemyList <const>, coinList <const> = CharacterFactory.generateEnemies(level)
	world:reset(level)
	player:reset(level)
	enemies:reset(enemyList)
	coins:reset(coinList)
	continue = true
end

local function loopOverLevels(timer,gravity,player,world,enemies,coins)
	while player.lives > 0 do
		local level <const> = Levels.getLevel()
		if level == nil then
			Levels:reset()
			return loopOverLevels(timer,gravity,player,world,enemies,coins)
		end
		NcursesIO.clear()
		startLevel(world,player,enemies,coins,level)
		loop(timer,gravity,player,world,enemies,coins)
	end
end


local function main()
	Ncurses.init()
	local timer <const> = Timer:new()
	local gravity <const> = Gravity:new(0.05,3)
	local player <const> = Player:new(0,0,"@",4,1,NcursesColors.Cyan)
	local world <const> = World:new()
	local enemies <const> = Enemies:new()
	local coins <const> = Coins:new()
	loopOverLevels(timer,gravity,player,world,enemies,coins)
	Ncurses.tearDown()
end


main()
