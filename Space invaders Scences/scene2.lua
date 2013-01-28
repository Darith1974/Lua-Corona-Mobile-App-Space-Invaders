
display.setStatusBar(display.HiddenStatusBar)
require "physics"
require "sprite" 
local missileClass = require( "missile" )
local shipClass = require( "ship" )
physics.start()
physics.setGravity(0,0)
physics.setDrawMode("hybrid")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
NoOfAliens=10

function DamageFleet()
	print("waypoint 4")
	count = 0
	for i = 1,NoOfAliens do
		print("waypoint 5")
		print(fleet[i].isVisible)
		if fleet[i].isVisible == false then
			print("waypoint 6")
			count = count + 1
			print("count incremented")
		end
	end
	print("waypoint 7")
	if count == NoOfAliens then
	print("alien fleet destroyed")
		local options = {effect = "fade", time = 400 }
		storyboard.gotoScene( "scene3", options)
	end
	
end

function Aliens(z)
	fleet={}
	--group:insert(fleet[])
	aliensheet = sprite.newSpriteSheet( "samplespaceships3.png", 44.1,44.1) -- ( image.png, spriteWidth, spriteHeight)
	alienspriteSet = sprite.newSpriteSet(aliensheet, 1, 100)
	sprite.add( alienspriteSet, "alien", 1, 6, 10000, 0 ) 
	for i =1,NoOfAliens do
		fleet[i] = sprite.newSprite( alienspriteSet)
		--fleet[i].d = true
		fleet[i].x= i*44.1
		fleet[i].y= 100*z
		--fleet[i].xScale=0.5
		--fleet[i].yScale=0.5
		fleet[i]:prepare("alien")
		fleet[i]:play()
		physics.addBody(fleet[i], "static", {friction=0.3, bounce = 0,density = 0})
		fleet[i].type="destructible"
		group:insert(fleet[i])
	end
end

function Missile(event)
	DamageFleet()
	print("Launch Missile")
	a = Viper.image.x 
	b = Viper.image.y 
	missile1 = missileClass.new(a,b)
	--group:insert(missile1.image)
	missile1.image:addEventListener("collision", missile1)
	
	
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
	Aliens(2)
	Viper = shipClass.new()
	group:insert(Viper.image)
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	Viper.image:addEventListener("tap", Missile)
	Runtime:addEventListener("tap",Viper)
end

-- Called when scene is about to move offscreen:
function scene:exitScene()
	Viper.image:removeEventListener("tap", Missile)
	Runtime:removeEventListener("tap",Viper)
end


function scene:didExitScene( event )
	storyboard.purgeScene( "scene2" )
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