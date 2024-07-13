
local levels <const> = require('levels.LevelsArray')

local Levels <const> = {}
Levels.__index = Levels

_ENV = Levels

local levelsArr <const> = levels
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
