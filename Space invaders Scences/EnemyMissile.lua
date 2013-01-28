-------------------------------------------------
--		DECLARE TABLE AND METATABLE
-------------------------------------------------

local EnemyMissile = {}
local EnemyMissile_mt = { __index = EnemyMissile } -- metatable
local shipClass = require( "ship" )

function EnemyMissile.new( posx, posy) -- constructor
	--[[ A image with physics plus type, bullet and sensor specified. I also add a collision event listener which triggers its own collision fn
		set out below.
	]]--
	local newEnemyMissile = {}
	newEnemyMissile.image =display.newCircle(posx,posy,8)
	newEnemyMissile.image:setFillColor(255,0,0)
	physics.addBody(newEnemyMissile.image, "dynamic", {friction=0.3, bounce = 0,density = 1})
	newEnemyMissile.image:setLinearVelocity(0, 200)
	newEnemyMissile.type = "Enemy"
	newEnemyMissile.isBullet= true
	newEnemyMissile.isSensor = true
	--media.playEventSound("boss.mp3")
	newEnemyMissile.image:addEventListener("collision", EnemyMissile)
	return setmetatable( newEnemyMissile, EnemyMissile_mt )
end

function EnemyMissile:collision(event)
	--[[ If the EnemyMissile objects collides it is pointed to its own collision fn. If the other object is not the wall, i.e a ship, set GameStatus
		to false, remove itself and make the other object invisible. If the collision is with a wall of the Universe, then remove itself.
	]]--
	print(" Enemy Missile Collision")
	if(event.phase == "began") then
			media.playEventSound("explo.mp3")
			if(event.other.myName ~= "Wall") then
				GameStatus = false
				event.other.isVisible = false
				print("event.other.e is")
				print(event.other.e )
				event.target:removeSelf()
				print("enemy missile destroyed")
				print(event.other.isVisible)
			end
			if (event.other.myName == "Wall") then
				event.target:removeSelf()
			end
						
	end
end


-------------------------------------------------


return EnemyMissile
