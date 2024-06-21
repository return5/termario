local Body <const> = require('model.Body')
local setmetatable <const> = setmetatable

local RegularEnemy <const> = {}
RegularEnemy.__index = RegularEnemy
setmetatable(RegularEnemy,Body)


_ENV = RegularEnemy

function RegularEnemy:checkSideCollision(player)
	return player.printY == self.printY and player.printX == self.printX
end

function RegularEnemy:checkTopCollision(player)
	return player.prevPrintY < self.printY and player.printY == self.printY and player.printX == self.printX and player.prevPrintX == self.printX
end

function RegularEnemy:new(x,y,char,speed,xDir)
	return setmetatable(Body:new(x,y,char,speed,xDir),self)
end

return RegularEnemy
