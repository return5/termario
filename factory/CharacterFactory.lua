local Dirs <const> = require('constant.Dirs')
local RegularEnemy <const> = require('model.RegularEnemy')

local CharacterFactory <const> = {}
CharacterFactory.__index = CharacterFactory

_ENV = CharacterFactory



local function makeRegularEnemy(x,y)
	return RegularEnemy:new(x,y,"#",0,Dirs.LEFT)
end


--TODO
local createEnemiesMap <const> = {
	[3] = makeRegularEnemy
}

function CharacterFactory.generateEnemies(level)
	local enemies <const> = {}
	for y = 1,#level,1 do
		for x = 1,#level[y],1 do
			if createEnemiesMap[level[y][x]] then
				enemies[#enemies + 1] = createEnemiesMap[level[y][x]](x,y)
				level[y][x] = 1
			end
		end
	end
	return enemies
end

return CharacterFactory
