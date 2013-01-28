-------------------------------------------------
--		DECLARE TABLE AND METATABLE
-------------------------------------------------

local bullet = {}
local bullet_mt = { __index = bullet } -- metatable

function bullet.new( posx, posy,c,d) -- constructor
	--This constructor creates a image with physics and velocity upwards. 
	local newbullet = {}
	--[[newbullet.image =display.newCircle( posx + 22.05, posy, 5 )
	newbullet.image:setFillColor(255,0,0)
	--newbullet.image =display.newImage("bullet.png", posx + 22.05, posy,  )
	physics.addBody(newbullet.image, "dynamic", {friction=0.3, bounce = 0,density = 1})]]--
	if c > 0 then
		newbullet.image =display.newCircle( posx + 22.05, posy, 5 )
		physics.addBody(newbullet.image, "dynamic", {friction=0.3, bounce = 0,density = 1})
		newbullet.image:setLinearVelocity(1850, 0)
	elseif c < 0 then
		newbullet.image =display.newCircle( posx - 22.05, posy, 5 )
		physics.addBody(newbullet.image, "dynamic", {friction=0.3, bounce = 0,density = 1})
		newbullet.image:setLinearVelocity(-1850, 0)
	elseif c == 0 then
	 if d == 1 then
		newbullet.image =display.newCircle( posx - 22.05, posy, 5 )
		physics.addBody(newbullet.image, "dynamic", {friction=0.3, bounce = 0,density = 1})
		newbullet.image:setLinearVelocity(-1850, 0)
	 end
	 if d == 2 then
		newbullet.image =display.newCircle( posx + 22.05, posy, 5 )
		physics.addBody(newbullet.image, "dynamic", {friction=0.3, bounce = 0,density = 1})
		newbullet.image:setLinearVelocity(1850, 0)
	 end
	end
	
	newbullet.image:setFillColor(255,0,0)
	newbullet.myName = "Bullet"
	media.playEventSound("shot.mp3")
	--newbullet:addEventListener("collision",bullet)
	return setmetatable( newbullet, bullet_mt )
end

function bullet:collision(event)
	-- When a missile object collides with another physics object,i use its own collision fn to remove itself and make the object visible plus is Sensor true.
	--I also change the value of the other object's boolean.
	print("collision")
	if(event.phase == "began") then
			if(event.other.type == "alien") then
				media.playEventSound("explo.mp3")
				event.other.isVisible = false
				event.other.isSensor= true
				--event.other.d = false
				event.target:removeSelf()
				print("bullet destroyed")
				print("Alien destroyed")
				print(event.other.isVisible)
			else 
				event.target:removeSelf()
			end
	end
end

-------------------------------------------------


return bullet
