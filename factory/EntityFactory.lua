local Dirs <const> = require('constant.Dirs')
local RegularEnemy <const> = require('model.characters.NonJumpingCharacter')
local JumpingEnemy <const> = require('model.characters.JumpingEnemy')
local NcursesColors <const> = require('ncurses.NcursesColors')
local Body <const> = require('model.characters.Body')
local FlyingEnemy <const> = require('model.characters.FlyingEnemy')

local EntityFactory <const> = {}
EntityFactory.__index = EntityFactory

_ENV = EntityFactory

local function makeRegularEnemyLeft(x,y)
	return RegularEnemy:new(x,y,"#",2,Dirs.LEFT,NcursesColors.Green,10)
end

local function makeRegularEnemyRight(x,y)
	return RegularEnemy:new(x,y,"#",2,Dirs.RIGHT,NcursesColors.Green,10)
end

local function makeJumpingEnemyLeft(x,y)
	return JumpingEnemy:new(x,y,"&",1,Dirs.LEFT,-3,1,NcursesColors.Magenta,20)
end

local function makeJumpingEnemyRight(x,y)
	return JumpingEnemy:new(x,y,"&",1,Dirs.RIGHT,-3,1,NcursesColors.Magenta,20)
end

local function makeJumpingEnemyNoMove(x,y)
	return JumpingEnemy:new(x,y,"&",1,Dirs.STOP,-3,1,NcursesColors.Magenta,20)
end

local function makeCoin(x,y)
	return Body:new(x,y,"o",0,Dirs.STOP,NcursesColors.Yellow,25)
end

local function makeFlyingEnemyLeft(x,y)
	return FlyingEnemy:new(x,y,"<",1,Dirs.LEFT,NcursesColors.Red,15)
end

local function makeFlyingEnemyRight(x,y)
	return FlyingEnemy:new(x,y,">",1,Dirs.RIGHT,NcursesColors.Red,15)
end

local createEnemiesMap <const> = {
	[4] = makeRegularEnemyLeft,
	[5] = makeRegularEnemyRight,
	[6] = makeJumpingEnemyLeft,
	[7] = makeJumpingEnemyRight,
	[8] = makeJumpingEnemyNoMove,
	[10] = makeFlyingEnemyRight,
	[11] = makeFlyingEnemyLeft
}

local createCoinsMap <const> = {
	[0] = makeCoin
}

local function loopOverLevel(map, level)
	local tbl <const> = {}
	for y = 1,#level,1 do
		for x = 1,#level[y],1 do
			if map[level[y][x]] then
				tbl[#tbl + 1 ] = map[level[y][x]](x,y)
			end
		end
	end
	return tbl
end


function EntityFactory.generateEnemies(level)
	return loopOverLevel(createEnemiesMap,level)
end

function EntityFactory.generateCoins(level)
	return loopOverLevel(createCoinsMap,level)
end

return EntityFactory
