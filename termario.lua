local Timer <const> = require('model.Timer')
local Gravity <const> = require('model.Gravity')
local Body <const> = require('model.Body')
local continue = true

local function loop(timer,gravity,body)
	while continue do
		body:update(timer:getDt())
		gravity:applyGravity(body)
		body:print()
	end
end

local function main()
	local timer <const> = Timer:new()
	local gravity <const> = Gravity:new(0.05,9.8)
	local body <const> = Body:new(50,60,"a",5,0)
	loop(timer,gravity,body)
end


main()
