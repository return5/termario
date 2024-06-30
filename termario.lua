local Timer <const> = require('model.utils.Timer')
local Gravity <const> = require('model.utils.Gravity')
local Player <const> = require('model.characters.Player')
local NcursesIO <const> = require('ncurses.NcurseIO')
local Ncurses <const> = require('ncurses.Ncurses')
local Levels <const> = require('levels.Levels')
local World <const> = require('model.World')
local Enemies <const> = require('model.collections.Collection')
local EntityFactory <const> = require('factory.EntityFactory')
local NcursesColors <const> = require('ncurses.NcursesColors')
local Coins <const> = require('model.collections.Coins')
local InfoPrinter <const> = require('model.utils.InfoPrinter')

local continue = true
local levelCounter = 0

local function draw(player,world,enemies,coins,infoPrinter)
	world:print(player)
	coins:print(world,player)
	player:print(world.offset)
	enemies:print(world,player)
	infoPrinter:print(player,levelCounter)
end

local function input(player,dt)
	local userInput <const> = NcursesIO.getInput()
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

local function resetLevel(world,player,enemies,infoPrinter)
	local level <const> = Levels.getCurrentLevel()
	local enemyList <const> = EntityFactory.generateEnemies(level)
	player:reset(level)
	enemies:reset(enemyList)
	infoPrinter:reset(world)
	continue = true
end

local function resetCoinsAndWorld(coins,world)
	local level <const> = Levels.getCurrentLevel()
	local coinList <const> = EntityFactory.generateCoins(level)
	local levelMap <const> = EntityFactory.generateLevel(level)
	world:reset(levelMap)
	coins:reset(coinList)
end

local function getNewLevel(world,player,enemies,coins,infoPrinter)
	local level <const> = Levels.getNextLevel()
	levelCounter = levelCounter + 1
	if level == nil then
		Levels:reset()
		return getNewLevel(world,player,enemies,coins,infoPrinter)
	end
	resetCoinsAndWorld(coins,world)
	resetLevel(world,player,enemies,infoPrinter)
end

local function checkIfAtEnd(world,player,enemies,coins,infoPrinter)
	if world:isPlayerAtEnd(player) then
		player.score = player.score + 50
		getNewLevel(world,player,enemies,coins,infoPrinter)
	end
end

local function loop(timer,gravity,player,world,enemies,coins,infoPrinter)
	while continue do
		update(player,world,enemies,timer:getDt(),gravity,coins)
		draw(player,world,enemies,coins,infoPrinter)
		continue = player:checkIfContinue(enemies,world)
		checkIfAtEnd(world,player,enemies,coins,infoPrinter)
	end
	resetLevel(world,player,enemies,infoPrinter)
end

local function loopOverLevels(timer,gravity,player,world,enemies,coins,infoPrinter)
	while player.lives >= 0 do
		NcursesIO.clear()
		loop(timer,gravity,player,world,enemies,coins,infoPrinter)
	end
end

local function displayGameOver(player)
	local maxY, maxX <const> = Ncurses.getMaxYX()
	local middleX <const> = math.floor(maxX / 2)
	local middleY <const> = math.floor(maxY / 2)
	local scoreStr <const> = "Score " .. player.score
	local scoreX <const> = math.floor(middleX - scoreStr:len() / 2)
	NcursesIO.turnOnStandOut()
			.print(middleX,middleY,"Game Over.")
			.print(scoreX,middleY + 2,scoreStr)
			.print(scoreX,middleY + 3,"Level Reached: " .. levelCounter)
	Ncurses.blockingInput()
	NcursesIO.getCh()
end

local function main()
	Ncurses.init()
	local timer <const> = Timer:new()
	local gravity <const> = Gravity:new(0.05,3)
	local player <const> = Player:new(0,0,"@",4,1,NcursesColors.Cyan)
	local world <const> = World:new()
	local enemies <const> = Enemies:new()
	local coins <const> = Coins:new()
	local infoPrinter <const> = InfoPrinter:new()
	getNewLevel(world,player,enemies,coins,infoPrinter)
	loopOverLevels(timer,gravity,player,world,enemies,coins,infoPrinter)
	displayGameOver(player)
	Ncurses.tearDown()
end


main()
