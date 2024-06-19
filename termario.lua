local Timer <const> = require('model.Timer')
local Gravity <const> = require('model.Gravity')
local Body <const> = require('model.Body')
local NcursesIO <const> = require('ncurses.NcurseIO')

local continue = true

local function draw(player,world,enemies)
	player:print()
	world:print(player)
	enemies:print()
end

local function input(player)
	local userInput <const> = NcursesIO.getCh()
	if userInput then player:move(userInput) end
end

local function loop(timer,gravity,player)
	while continue do
		player:update(timer:getDt())
		input(player)
	--	gravity:applyGravity(player)
		player:print()
	end
end

local function main()
	local timer <const> = Timer:new()
	local gravity <const> = Gravity:new(0.05,9.8)
	local player <const> = Body:new(50,60,"@",5,0)
	loop(timer,gravity,player)
end


main()
