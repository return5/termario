local Dirs <const> = require('constant.Dirs')
local RegularEnemy <const> = require('model.characters.NonJumpingCharacter')
local JumpingEnemy <const> = require('model.characters.JumpingEnemy')
local NcursesColors <const> = require('ncurses.NcursesColors')

local CharacterFactory <const> = {}
CharacterFactory.__index = CharacterFactory

_ENV = CharacterFactory



local function makeRegularEnemyLeft(x,y)
	return RegularEnemy:new(x,y,"#",2,Dirs.LEFT,NcursesColors.Green)
end

local function makeRegularEnemyRight(x,y)
	return RegularEnemy:new(x,y,"#",2,Dirs.RIGHT,NcursesColors.Green)
end

local function makeJumpingEnemyLeft(x,y)
	return JumpingEnemy:new(x,y,"&",1,Dirs.LEFT,-3,1,NcursesColors.Yellow)
end

local function makeJumpingEnemyRight(x,y)
	return JumpingEnemy:new(x,y,"&",1,Dirs.RIGHT,-3,1,NcursesColors.Yellow)

end

local function makeJumpingEnemyNoMove(x,y)
	return JumpingEnemy:new(x,y,"&",1,Dirs.STOP,-3,1,NcursesColors.Yellow)

end

local createEnemiesMap <const> = {
	[4] = makeRegularEnemyLeft,
	[5] = makeRegularEnemyRight,
	[6] = makeJumpingEnemyLeft,
	[7] = makeJumpingEnemyRight,
	[8] = makeJumpingEnemyNoMove,
}

function CharacterFactory.generateEnemies(level)
	local enemies <const> = {}
	for y = 1,#level,1 do
		for x = 1,#level[y],1 do
			if createEnemiesMap[level[y][x]] then
				enemies[#enemies + 1] = createEnemiesMap[level[y][x]](x,y)
			end
		end
	end
	return enemies
end

return CharacterFactory
