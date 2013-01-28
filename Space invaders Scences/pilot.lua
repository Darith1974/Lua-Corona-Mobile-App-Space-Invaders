-------------------------------------------------
--		DECLARE TABLE AND METATABLE
-------------------------------------------------

local pilot = {}
local pilot_mt = { __index = pilot } -- metatable
require "sprite"
local a = (display.contentWidth - 20)/3
local b = (display.contentHeight -20)/4
local c =10
function pilot.new() -- constructor
	SoldierRunning= sprite.newSpriteSheet("soldier11.png",25.25,38.25)
	SoldierRunningSet = sprite.newSpriteSet(SoldierRunning,1, 16)
	sprite.add( SoldierRunningSet, "soldierR",9, 4, 1000, 0 )
	sprite.add( SoldierRunningSet, "soldierl",5, 4, 1000, 0 )
	sprite.add( SoldierRunningSet, "soldierS",1, 4, 1000, 0 )
	local newpilot = {}
	newpilot= sprite.newSprite( SoldierRunningSet)
	physics.addBody(newpilot, "dynamic", {friction=0, bounce = 0})
	--newpilot:setReferencePoint()
	newpilot.x = 20
	newpilot.y = (4*b) -220
	newpilot.xScale=2
	newpilot.yScale =2
	--[[newpliot.sprite:prepare("soldierR")
	newpilot.sprite:play()
	newpilot.sprite:setLinearVelocity(10,0)]]--
	--newpilot.image.isFixedRotation =true
	--local newpilot = {}
	--newpilot.image =display.newImage( "spaceship4.jpg" )
	--physics.addBody(newpilot.image, "static", {friction=0, bounce = 0})
	--[[newpilot.image.x = 100
	newpilot.image.y = display.contentHeight-90
	newpilot.e= true
	newpilot.type="Ship"]]--
	return setmetatable( newpilot, pilot_mt )
	--The player's ship is a image with physics and a boolean attached also.
end

function pilot:tap(event)
	-- The ship is moved by a event from main
	print("ship moved")
	self.image.x= event.x
end

function pilot:Right(event)
	newpilot:setLinearVelocity(0,0)
	newpliot:prepare("soldierR")
	newpilot:play()
	newpilot:setLinearVelocity(10,0)
	newpilot.isFixedRotation =true
end

function pilot:RightandUp(event)
	newpilot:setLinearVelocity(0,0)
	newpliot:prepare("soldierR")
	newpilot:play()
	newpilot:applyLinearImpulse(0.03,-0.1,0,0)
	newpilot.isFixedRotation =true
end

function pilot:Left(event)
	newpilot:setLinearVelocity(0,0)
	newpliot:prepare("soldierl")
	newpilot:play()
	newpilot:setLinearVelocity(-10,0)
	newpilot.isFixedRotation =true
end

function pilot:LeftAndUp(event)
	newpilot:setLinearVelocity(0,0)
	newpliot:prepare("soldierl")
	newpilot:play()
	newpilot:applyLinearImpulse(-0.03,-0.1,0,0)
	newpilot.isFixedRotation =true
end

function pilot:Stop(event)
	newpilot:setLinearVelocity(0,0)
	
end
-------------------------------------------------


return pilot