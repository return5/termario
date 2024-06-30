local setmetatable <const> = setmetatable
local remove <const> = table.remove

local Collection <const> = {}
Collection.__index = Collection

_ENV = Collection


function Collection:loop(func,startX,stopX)
	local xOffset <const> = startX - 1
	for i=#self.items,1,-1 do
		if self.items[i]:checkWithinBounds(startX,stopX) then
			if func(self.items[i],i,xOffset) == false then return false end
		end
	end
	return true
end

function Collection:checkCollisions(player,items)
	return function(item,i)
		if item:checkTopCollision(player) then
			player.score = player.score + item.score
			remove(items,i)
		elseif item:checkSideCollision(player) then
			return false
		end
		return true
	end
end

function Collection:checkCollision(player,world)
	local leftLimit <const>, rightLimit <const> = world:getLimits(player)
	return self:loop(self:checkCollisions(player,self.items),leftLimit,rightLimit)
end

local function printEnemy(item,_,xOffset)
	return item:print(xOffset)
end

function Collection:print(world,player)
	local leftLimit <const>, rightLimit <const> = world:getLimits(player)
	return self:loop(printEnemy,leftLimit,rightLimit)
end

local function updateEnemy(dt,world,gravity,items)
	return function(item,i)
		if not item:update(dt,world,gravity) then
			remove(items,i)
		end
		return true
	end
end

function Collection:update(dt,world,player,gravity)
	local leftLimit <const>, rightLimit <const> = world:getLimits(player)
	return self:loop(updateEnemy(dt,world,gravity,self.items),leftLimit,rightLimit)
end


function Collection:reset(items)
	self.items = items
	return self
end

function Collection:new()
	return setmetatable({items = {}},self)
end

return Collection
