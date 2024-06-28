local Dirs <const> = require('constant.Dirs')
local RegularEnemy <const> = require('model.characters.NonJumpingCharacter')
local JumpingEnemy <const> = require('model.characters.JumpingEnemy')
local NcursesColors <const> = require('ncurses.NcursesColors')
local Body <const> = require('model.characters.Body')


local EntityFactory <const> = {}
EntityFactory.__index = CharacterFactory

_ENV = EntityFactory



local function makeRegularEnemyLeft(x,y,enemies)
	enemies[#enemies + 1] = RegularEnemy:new(x,y,"#",2,Dirs.LEFT,NcursesColors.Green,10)
end

local function makeRegularEnemyRight(x,y,enemies)
	enemies[#enemies + 1] = RegularEnemy:new(x,y,"#",2,Dirs.RIGHT,NcursesColors.Green,10)
end

local function makeJumpingEnemyLeft(x,y,enemies)
	enemies[#enemies + 1] = JumpingEnemy:new(x,y,"&",1,Dirs.LEFT,-3,1,NcursesColors.Magenta,20)
end

local function makeJumpingEnemyRight(x,y,enemies)
	enemies[#enemies + 1] = JumpingEnemy:new(x,y,"&",1,Dirs.RIGHT,-3,1,NcursesColors.Magenta,20)

end

local function makeJumpingEnemyNoMove(x,y,enemies)
	enemies[#enemies + 1] = JumpingEnemy:new(x,y,"&",1,Dirs.STOP,-3,1,NcursesColors.Magenta,20)
end

local function makeCoin(x,y,_,coins)
	coins[#coins + 1] = Body:new(x,y,"o",0,Dirs.STOP,NcursesColors.Yellow,25)
end

local createEnemiesMap <const> = {
	[4] = makeRegularEnemyLeft,
	[5] = makeRegularEnemyRight,
	[6] = makeJumpingEnemyLeft,
	[7] = makeJumpingEnemyRight,
	[8] = makeJumpingEnemyNoMove,
	[0] = makeCoin
}

function EntityFactory.generateEnemies(level)
	local enemies <const> = {}
	local coins <const> = {}
	for y = 1,#level,1 do
		for x = 1,#level[y],1 do
			if createEnemiesMap[level[y][x]] then
				 createEnemiesMap[level[y][x]](x,y,enemies,coins)
			end
		end
	end
	return enemies,coins
end

return EntityFactory
