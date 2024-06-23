local Body <const> = require('model.characters.Body')
local setmetatable <const> = setmetatable

local RegularCharacter <const> = {}
RegularCharacter.__index = RegularCharacter
setmetatable(RegularCharacter,Body)


_ENV = RegularCharacter

function RegularCharacter:checkSideCollision(player)
	return player.printY == self.printY and player.printX == self.printX
end

function RegularCharacter:checkTopCollision(player)
	return player.prevPrintY < self.printY and player.printY == self.printY and player.printX == self.printX and player.prevPrintX == self.printX
end

function RegularCharacter:new(x,y,char,speed,xDir)
	return setmetatable(Body:new(x,y,char,speed,xDir),self)
end

return RegularCharacter
