-------------------------------------------------
--		DECLARE TABLE AND METATABLE
-------------------------------------------------

local ship = {}
local ship_mt = { __index = ship } -- metatable

function ship.new( posx, posy) -- constructor
	
	local newship = {}
	newship.image =display.newImage( "spaceship4.jpg" )
	physics.addBody(newship.image, "static", {friction=0, bounce = 0})
	newship.image.x = 100
	newship.image.y = display.contentHeight-90
	newship.e= true
	newship.type="Ship"
	return setmetatable( newship, ship_mt )
	--The player's ship is a image with physics and a boolean attached also.
end

function ship:tap(event)
	-- The ship is moved by a event from main
	print("ship moved")
	self.image.x= event.x
end

-------------------------------------------------


return ship