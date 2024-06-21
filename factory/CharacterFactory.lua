local Dirs <const> = require('constant.Dirs')

local CharacterFactory <const> = {}
CharacterFactory.__index = CharacterFactory

_ENV = CharacterFactory

--TODO
local createEnemiesMap <const> = {

}

function CharacterFactory.generateEnemies(level)
	local enemies <const> = {}
	for y = 1,#level,1 do
		for x = 1,#level[y],1 do
			if createEnemiesMap[level[y][x]] then
				enemies[#enemies + 1] = createEnemiesMap[level[y][x]]()
				level[y][x] = 1
			end
		end
	end
end

return CharacterFactory
