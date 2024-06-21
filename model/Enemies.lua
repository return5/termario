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

function Enemies:reset(enemies)
	self.enemies = enemies
end

function Enemies:new()
	return setmetatable({enemies = {}},self)
end

return Enemies
