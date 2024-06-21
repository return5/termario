local setmetatable <const> = setmetatable

local Enemies <const> = {}
Enemies.__index = Enemies

_ENV = Enemies


function Enemies:loop(func,startX,stopX)
	for i=#self.enemies,1,-1 do
		if self.enemies[i]:checkWithinBounds(startX,stopX) then
			func(self.enemies[i],i)
		end
	end
end


function Enemies:checkCollision(player,world)

end

local function printEnemy(enemy,world)
	enemy:print()
end

function Enemies:print()
	self:loop(printEnemy)
end

local createEnemiesMap <const> = {

}

function Enemies:reset(level)
	local enemies <const> = {}
	for y = 1,#level,1 do
		for x = 1,#level[y],1 do
			if createEnemiesMap[level[y][x]] then
				enemies[#enemies + 1] = createEnemiesMap[level[y][x]]()
			end
		end
	end
	self.enemies = enemies
end

function Enemies:new()
	return setmetatable({enemies = {}},self)
end

return Enemies
