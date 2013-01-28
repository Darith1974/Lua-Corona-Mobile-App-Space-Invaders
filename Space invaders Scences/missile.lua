-------------------------------------------------
--		DECLARE TABLE AND METATABLE
-------------------------------------------------

local missile = {}
local missile_mt = { __index = missile } -- metatable
require "physics"
function missile.new( posx, posy) -- constructor
	--This constructor creates a image with physics and velocity upwards. 
	local newmissile = {}
	--newmissile.image =display.newCircle( posx, posy-22.05, 5 )
	newmissile.image =display.newImage("bullet.png", posx, posy-22.05 )
	physics.addBody(newmissile.image, "dynamic", {friction=0.3, bounce = 0,density = 1})
	newmissile.image:setLinearVelocity(0, -650)
	--newmissile.myName = "Missile"
	media.playEventSound("shot.mp3")
	return setmetatable( newmissile, missile_mt )
end

function missile:collision(event)
	-- When a missile object collides with another physics object,i use its own collision fn to remove itself and make the object visible plus is Sensor true.
	--I also change the value of the other object's boolean if one exists.
	print("collision")
	if(event.phase == "began") then
			if(event.other.type == "destructible") then
				media.playEventSound("explo.mp3")
				event.other.isVisible = false
				event.other.isSensor= true
				event.other.d = false
				event.target:removeSelf()
				--event.contact.isEnabled = false
				--physics.removeBody(event.other)
				display.remove(event.other)
				DamageFleetCounter = DamageFleetCounter + 1
				print("missile destroyed")
				print("Alien ship destroyed")
				print(event.other.isVisible)
			end
			if event.other.myName == "Wall" then
				event.target:removeSelf()
			end
						
	end
end

-------------------------------------------------


return missile
