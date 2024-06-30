
local level1 <const> = require('levels.Level1')

local Levels <const> = {}
Levels.__index = Levels

_ENV = Levels

local levelsArr <const> = {level1}
local currentLevel = 0

function Levels.getCurrentLevel()
	return levelsArr[currentLevel]
end

function Levels.getNextLevel()
	currentLevel = currentLevel + 1
	return Levels.getCurrentLevel()
end

function Levels.reset()
	currentLevel = 0
	return Levels
end

return Levels
