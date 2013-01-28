
display.setStatusBar(display.HiddenStatusBar)
require "physics"
require "sprite" 
local aliensClass = require("aliens")
local missileClass = require( "missile" )
local shipClass = require( "ship" )
physics.start()
physics.setGravity(0,0)
physics.setDrawMode("hybrid")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
NoOfAliensX=10
NoOfAliensY=2

function GameOver()
	--print("waypoint 8")
	--for i =1, NoOfAliens do
		if fleet[FleetStatus] == "active" then
			print("waypoint 9")
			local options = {effect = "fade", time = 400 }
			storyboard.gotoScene( "GameEnd", options)
		end
	--end
		--[[if fleet1[FleetStatus] == "active" then
			print("waypoint 9")
			local options = {effect = "fade", time = 400 }
			storyboard.gotoScene( "GameEnd", options)
		end--]]
end

function Damagefleet()
	local count = 0
	for i =1,NoOfAliensX do
		--fleet[i]= {}
		for j = 1, NoOfAliensY do
			if fleet[i][j].d == false then
				count  = count +1
			end
			if (count == (NoOfAliensX * NoOfAliensY)) then
				fleet[FleetStatus]="destroyed"
			end
		end
	end
	
end

function Aliens(z)
	local y = 1 
	fleet={}
	fleet = aliensClass.new(NoOfAliensX,NoOfAliensY)
	for i =1,NoOfAliensX do
		fleet[i]= {}
		for j = 1, NoOfAliensY do
			--group:insert(fleet)
			transition.to( fleet[i][j], { y = display.contentHeight-120, time = 80000, onComplete = GameOver })
		end
	end
	--[[local x = 4 
	fleet1={}
	fleet1 = aliensClass.new(NoOfaliens,x)
	for i =1,NoOfAliens do
		group:insert(fleet1[i])
		transition.to( fleet1[i], { y = display.contentHeight-120, time = 80000, onComplete = GameOver })
	end--]]
end

function Missile(event)
	print("Launch Missile")
	a = Viper.image.x 
	b = Viper.image.y 
	missile1 = missileClass.new(a,b)
	group:insert(missile1.image)
	missile1.image:addEventListener("collision", missile1)
	if fleet[FleetStatus]=="active" then
		print("Accessing damage to fleet")
		--fleet:DamageFleet(NoOfAliensX,NoOfAliensY)
		Damagefleet()
	end
	print("fleet[FleetStatus] = " ..fleet[FleetStatus])
	--[[if fleet1[FleetStatus]=="active" then
		print("Accessing damage to fleet1")
		fleet1:DamageFleet()
		
	end--]]
	--print("fleet1[FleetStatus] = " ..fleet1[FleetStatus])
	local options = {effect = "fade", time = 400 }
	--[[if fleet1[FleetStatus]=="destroyed" then
		print(fleet1[FleetStatus])
		print("waypoint 13")
		--fleet1:removeSelf()--]]
		if fleet[FleetStatus]=="destroyed" then
			print(fleet[FleetStatus])
			print("waypoint 14")
			storyboard.gotoScene( "scene2", options)
		
		end
	--end
end

function Universe()
	
	local wallThickness = 10
	
	-- Left wall
	wall1 = display.newRect( 0, 0, wallThickness, display.contentHeight )
	physics.addBody(wall1, "static", {friction=0, bounce = 1})
	group:insert(wall1)
	
	-- Top wall
	wall2 = display.newRect(0,0, display.contentWidth, wallThickness)
	physics.addBody(wall2, "static", {friction=0, bounce = 1})
	group:insert(wall2)
	-- Right wall
	wall3 = display.newRect(display.contentWidth - wallThickness, 0, wallThickness, display.contentHeight)
	physics.addBody(wall3, "static", {friction=0, bounce = 1})
	group:insert(wall3)
	-- Bottom wall
	wall4 = display.newRect(0, display.contentHeight - 50, display.contentWidth, wallThickness)
	physics.addBody(wall4, "static", {friction=0, bounce = 1})
	group:insert(wall4)
	--wall.type = "bottomWall"
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	group = self.view
	Universe()
	Aliens()
	Viper = shipClass.new()
	group:insert(Viper.image)
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	Viper.image:addEventListener("tap", Missile)
	--fleet:addEventListener("collision", GameOver)
	Runtime:addEventListener("tap",Viper)
end

-- Called when scene is about to move offscreen:
function scene:exitScene()
	Viper.image:removeEventListener("tap", Missile)
	--missile1.image:removeEventListener("collision", missile1)
	--fleet:removeEventListener("collision", GameOver)
	Runtime:removeEventListener("tap",Viper)
end


function scene:didExitScene( event )
	storyboard.purgeScene( "scene1" )
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

scene:addEventListener( "didExitScene", scene)

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene