local setmetatable <const> = setmetatable
local remove <const> = table.remove

local Enemies <const> = {}
Enemies.__index = Enemies

_ENV = Enemies


function Enemies:loop(func,startX,stopX)
	local xOffset <const> = startX - 1
	for i=#self.enemies,1,-1 do
		if self.enemies[i]:checkWithinBounds(startX,stopX) then
			if not func(self.enemies[i],i,xOffset) then return false end
		end
	end
	return true
end

local function checkCollisions(player,enemies)
	return function(enemy,i)
		if enemy:checkTopCollision(player) then
			remove(enemies,i)
		elseif enemy:checkSideCollision(player) then
			return false
		end
		return true
	end
end

function Enemies:checkCollision(player,world)
	local leftLimit <const>, rightLimit <const> = world:getLimits(player)
	return self:loop(checkCollisions(player,self.enemies),leftLimit,rightLimit)
end

local function printEnemy(enemy,_,xOffset)
	enemy:print(xOffset)
	return self
end

function Enemies:print(world,player)
	local leftLimit <const>, rightLimit <const> = world:getLimits(player)
	self:loop(printEnemy,leftLimit,rightLimit)
end

function Enemies:reset(enemies)
	self.enemies = enemies
end

function Enemies:new()
	return setmetatable({enemies = {}},self)
end

return Enemies
