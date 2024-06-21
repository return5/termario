

local levelsArr <const> = {require('levels.Level1')}

local function getLevel()
	local i = 0
	return function()
		i = i + 1
		return levelsArr[i]
	end
end

return { getLevel = getLevel(), reset = function(self) self.getLevel = getLevel(); return self end }
