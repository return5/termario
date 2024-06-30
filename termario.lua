local Timer <const> = require('model.utils.Timer')
local Gravity <const> = require('model.utils.Gravity')
local Player <const> = require('model.characters.Player')
local NcursesIO <const> = require('ncurses.NcurseIO')
local Ncurses <const> = require('ncurses.Ncurses')
local Levels <const> = require('levels.Levels')
local World <const> = require('model.World')
local Enemies <const> = require('model.collections.Collection')
local CharacterFactory <const> = require('factory.EntityFactory')
local NcursesColors <const> = require('ncurses.NcursesColors')
local Coins <const> = require('model.collections.Coins')
local InfoPrinter <const> = require('model.utils.InfoPrinter')

local continue = true
local levelCounter = 0

local function draw(player,world,enemies,coins,infoPrinter)
	world:print(player)
	player:print(world.offset)
	enemies:print(world,player)
	coins:print(world,player)
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

local function loop(timer,gravity,player,world,enemies,coins,infoPrinter)
	while continue do
		update(player,world,enemies,timer:getDt(),gravity,coins)
		draw(player,world,enemies,coins,infoPrinter)
		continue = player:checkIfContinue(enemies,world)
	end
	player:removeLife()
end

local function startLevel(world,player,enemies,coins,level,infoPrinter)
	local enemyList <const>, coinList <const> = CharacterFactory.generateEnemies(level)
	world:reset(level)
	player:reset(level)
	enemies:reset(enemyList)
	coins:reset(coinList)
	infoPrinter:reset(world)
	continue = true
end

local function loopOverLevels(timer,gravity,player,world,enemies,coins,infoPrinter)
	while player.lives >= 0 do
		local level <const> = Levels.getLevel()
		levelCounter = levelCounter + 1
		if level == nil then
			Levels:reset()
			levelCounter = 0
			return loopOverLevels(timer,gravity,player,world,enemies,coins,infoPrinter)
		end
		NcursesIO.clear()
		startLevel(world,player,enemies,coins,level,infoPrinter)
		loop(timer,gravity,player,world,enemies,coins,infoPrinter)
	end
end

local function displayGameOver(player)
	local maxY, maxX <const> = Ncurses.getMaxYX()
	local middleX <const> = math.floor(maxX / 2)
	local middleY <const> = math.floor(maxY / 2)
	NcursesIO.turnOnStandOut()
	local scoreStr <const> = "Score " .. player.score
	local scoreX <const> = math.floor(middleX - scoreStr:len() / 2)
	NcursesIO.print(middleX,middleY,"Game Over.")
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
	loopOverLevels(timer,gravity,player,world,enemies,coins,infoPrinter)
	displayGameOver(player)
	Ncurses.tearDown()
end


main()
