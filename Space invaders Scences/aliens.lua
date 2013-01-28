-------------------------------------------------
--		DECLARE TABLE AND METATABLE
-------------------------------------------------

local aliens = {}
local aliens_mt = { __index = aliens } -- metatable
require "sprite"

function aliens.new(NoOfAliensX,NoOfAliensY) -- constructor
	local t =s
	newaliens = {}
	FleetStatus = "active"
	newaliens[FleetStatus]= "active"
	aliensheet = sprite.newSpriteSheet( "samplespaceships3.png", 44.1,44.1) -- ( image.png, spriteWidth, spriteHeight)
	alienspriteSet = sprite.newSpriteSet(aliensheet, 1, 100)
	sprite.add( alienspriteSet, "alien", 1, 6, 10000, 0 )
	for i =1,NoOfAliensX do
		newaliens[i] = {}
			for j= 1,NoOfAliensY do
				newaliens[i][j] = sprite.newSprite( alienspriteSet)
				newaliens[i][j].x= i*44.1
				newaliens[i][j].y= 44.1*j
				newaliens[i][j]:prepare("alien")
				newaliens[i][j]:play()
				physics.addBody(newaliens[i][j], "static", {friction=0.3, bounce = 0,density = 0})
				newaliens[i][j].type="destructible"
				group:insert(newaliens[i][j])
				newaliens[i][j].d = true
			end
		
		--newaliens[i] = sprite.newSprite( alienspriteSet)
		--newaliens[i].x= i*44.1
		--newaliens[i].y= 44.1*t
		--newaliens[i]:prepare("alien")
		--newaliens[i]:play()
		--physics.addBody(newaliens[i], "static", {friction=0.3, bounce = 0,density = 0})
		--newaliens[i].type="destructible"
	end
	return setmetatable( newaliens, aliens_mt )
end

function aliens:DamageFleet(NoOfAliensX,NoOfAliensY)
	local count = 0
	--for i =1,NoOfAliensX do
		--newaliens[i] = {}
		--for j =1,NoOfAliensY do
			--[[if self[10][1].d == false then
				--newaliens[i].d = false
				count = count + 1
				print("waypoint 11")
			end--]]
			--[[if count == (NoOfAliensx * NoOfAliensY) then
				self[FleetStatus]="destroyed"
				print("waypoint 12")
				print("Fleet destroyed")
				for i= 1,NoOfAliens do
					newaliens[i]:removeSelf()
				end
			end--]]
		--end
	--end
end


-------------------------------------------------


return aliens
