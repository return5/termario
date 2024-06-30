local Collection <const> = require('model.collections.Collection')
local setmetatable <const> = setmetatable
local remove <const> = table.remove

local Coins <const> = {}
Coins.__index = Coins
setmetatable(Coins,Collection)

_ENV = Coins

function Coins:checkCollisions(player,items)
	return function(item,i)
		if item:checkSideCollision(player) then
			player.score = player.score + item.score
			remove(items,i)
		end
		return true
	end
end

function Coins:update()
	return true
end

function Coins:new()
	return setmetatable(Collection:new(),self)
end

return Coins
