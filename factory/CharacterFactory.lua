local Dirs <const> = require('constant.Dirs')
local RegularEnemy <const> = require('model.RegularEnemy')

local CharacterFactory <const> = {}
CharacterFactory.__index = CharacterFactory

_ENV = CharacterFactory



local function makeRegularEnemy(x,y)
	return RegularEnemy:new(x,y,"#",2,Dirs.LEFT)
end

local function makeRegularEnemyRight(x,y)
	return RegularEnemy:new(x,y,"#",2,Dirs.RIGHT)
end

local function makeJumpingEnemy(x,y)

end


--TODO
local createEnemiesMap <const> = {
	[4] = makeRegularEnemy,
	[5] = makeRegularEnemyRight,
	[6] = makeJumpingEnemy,
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
