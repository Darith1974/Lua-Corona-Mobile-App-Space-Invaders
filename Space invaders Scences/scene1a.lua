
display.setStatusBar(display.HiddenStatusBar)
require "physics"
require "sprite" 
local missileClass = require( "missile" )
local shipClass = require( "ship" )
physics.start()
physics.setGravity(0,0)
--physics.setDrawMode("hybrid")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local NoOfAliensX=10
local NoOfAliensY=1
local Viper
local fleet = {}
local wall1,wall2,wall3,wall4
local FleetCheck
DamageFleetCounter = 0
--[[ This is the second scene . Preceding this comment line , i include physics, sprite & storyboard. I also include
two classes: missile & ship. The gravity is started. The No. of alien ships is determined by NoOfAliensX & NoOfAliensY. Please skip to createScene
to follow execution and further comments. You will also notice there are various print ststements interpersed printing out various values of functions
or just waypoints. These are used for debug purposes. ]]--  

local function GameOver()
	--[[ This fn is called when the table of alien sprites reach the bottom of the screeen without been eleminated beforehand. Then the fleet is still active
	and the player has lost the game whereby they transition to the end screen.]]--
	
	
		if fleet[FleetStatus] == "active" then
			print("waypoint 9-1a")
			local options = {effect = "fade", time = 400 }
			storyboard.gotoScene( "GameEnd", options)
		end
	
end

local function Damagefleet()
	--I use a for loop to check the status of each element of the fleet table. If the boolean is false, increase the counter. When the counter is the same 
	--as the total content of the fleet table then the fleet[FleetStatus] key is set to destroyed. I then jump to scene 2a.
		local count = 0
		print("accessing fleet")
		--[[for i =1,NoOfAliensX do
		--fleet[i]= {}
			--for j = 1, NoOfAliensY do
				if fleet[i] == nil then
					count  = count +1
					print("alien ship invisible, count incremented")
				end
				if count == (NoOfAliensX) then
					fleet[FleetStatus]="destroyed"
					print("alien fleet destroyed")
					storyboard.gotoScene( "scene2a", options)
				end
			--end
		end--]]
	if DamageFleetCounter == 10 then
		fleet[FleetStatus]="destroyed"
		DamageFleetCounter = 0
		local options = {effect = "fade", time = 400 }
		storyboard.gotoScene( "scene2a", options)
	end
end


local function Missile(event)
	 --[[When the viper is tapped i take its position and place in a&b. Then i create a missile object from my missile class. Please refer to missile class
		for info. A listener is added for collision which is handled in its own class. 
	]]--
	print("Launch Missile")
	local a = Viper.x 
	local b = Viper.y 
	local missile1 = missileClass.new(a,b)
	--group:insert(missile1.image)
	missile1.image:addEventListener("collision", missile1)
	--[[if fleet[FleetStatus]=="active" then
		print("Accessing damage to fleet")
		Damagefleet()
	end
	print("fleet[FleetStatus] = " ..fleet[FleetStatus])
	local options = {effect = "fade", time = 400 }
	if fleet[FleetStatus]=="destroyed" then
		print(fleet[FleetStatus])
		print("waypoint 14")
		storyboard.gotoScene( "scene2a", options)
	end]]--
end

-- Called when the scene's view does not exist:

local function MoveShip(event)
	Viper.x = event.x
end


	
function scene:createScene( event )
	local group = self.view
	
	background1= display.newImage("BG1.jpg",0,0)
	--background1:setFillColor(255,0,0)
	background1.xScale = 6
	background1.yScale = 14
	group:insert(background1)
	
	local function timeScore()
		 secsText = 00
		 minsText = 0
	-- a timer constanly calls a local fn to update the timer ibject displayed on the screen.
		 timeText = display.newText(minsText.. ":0" ..secsText, 10, 200, "Helvetica", 24)
		timeText:setTextColor(255,0,0)
		group:insert(timeText)

		local function updateTime (event)
			secsText = secsText + 1

			if secsText < 10 then 
				secsText = "0" ..secsText
			elseif secsText > 59 then
				secsText = 00
				minsText = minsText+1
			end
			timeText.text = minsText .. ":" ..secsText
		end
		timer.performWithDelay(1000, updateTime, 0)
	end
	
	local function Universe()
		--Here i create four walls with physics within which all other objects interact. Refer back to createScene.
		local wallThickness = 10
	
		-- Left wall
		wall1 = display.newRect( 0, 0, wallThickness, display.contentHeight )
		physics.addBody(wall1, "static", {friction=0, bounce = 1})
		group:insert(wall1)
		wall1.myName = "Wall"
		-- Top wall
		wall2 = display.newRect(0,0, display.contentWidth, wallThickness)
		physics.addBody(wall2, "static", {friction=0, bounce = 1})
		group:insert(wall2)
		wall2.myName = "Wall"
		-- Right wall
		wall3 = display.newRect(display.contentWidth - wallThickness, 0, wallThickness, display.contentHeight)
		physics.addBody(wall3, "static", {friction=0, bounce = 1})
		group:insert(wall3)
		wall3.myName = "Wall"
		-- Bottom wall
		wall4 = display.newRect(0, display.contentHeight - 50, display.contentWidth, wallThickness)
		physics.addBody(wall4, "static", {friction=0, bounce = 1})
		group:insert(wall4)
		wall4.myName = "Wall"
	--wall.type = "bottomWall"
	end
	local function Aliens()
		--[[ I create a table of sprites which have physics and transition the whole table towards the bottom of the screen. Refer to GameOver 
		to clarify what happens for this fn.
		]]--
		--local fleet = {}
		aliensheet = sprite.newSpriteSheet( "samplespaceships4.png", 44.1,44.1) -- ( image.png, spriteWidth, spriteHeight)
		alienspriteSet = sprite.newSpriteSet(aliensheet, 1, 100)
		sprite.add( alienspriteSet, "alien", 1, 6, 10000, 0 )
		FleetStatus = "active"
		fleet[FleetStatus]= "active"
		for i = 1,NoOfAliensX do
			--fleet[i]= {}
			--for j =1,NoOfAliensY do
				fleet[i] = sprite.newSprite( alienspriteSet)
				fleet[i].x= i*44.1
				fleet[i].y= 44.1
				fleet[i]:prepare("alien")
				fleet[i]:play()
				physics.addBody(fleet[i], "static", {friction=0.3, bounce = 0,density = 0})
				fleet[i].type="destructible"
				group:insert(fleet[i])
				--fleet[i].d = true
				transition.to( fleet[i], { y = display.contentHeight-120, time = 80000, onComplete = GameOver })
			--end
		end
	end
	-- A group in which all objects are inserted so they can be collectively removed at end of scene.
	Universe()
	-- This function creates the universe or environment boundaries for the various objects. Please goto this fn now to follow execution.
	Aliens()
	--Jump to aliens now to show i create the enemy objects
	--Viper = shipClass.new()
	timeScore()
	SpaceShip= sprite.newSpriteSheet("shipsprite1_0.png",31.34,31.25)
	SpaceshipSet = sprite.newSpriteSet(SpaceShip,1, 24)
	sprite.add(SpaceshipSet, "ship",1, 3, 1000, 0 )
	Viper= sprite.newSprite(SpaceshipSet)
	physics.addBody(Viper, "static", {friction=0, bounce = 0})
	Viper.x = 100
	Viper.y = display.contentHeight-90
	Viper.xScale = 3
	Viper.yScale = 4
	Viper:prepare("ship")
	Viper:play()
	-- Viper is a object of the ship class which is what the player controls. Please refer to ship class for further details. 
	group:insert(Viper)
	--The Viper is inserted into the group. Now refer to the listeners in enterScene to follow execution
	--group:insert(FleetCheck)
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	Viper:addEventListener("tap", Missile)
	--When a tap is performed on the Viper it invokes the missile fn. Please refer to missile fn to follow execution
	Runtime:addEventListener("tap",MoveShip)
	--This Listener will call the tap fn of the Viper class.
	FleetCheck = timer.performWithDelay(1000,Damagefleet,0)
	--This timer checks the status of the alien fleet every 1000ms
	
end

-- Called when scene is about to move offscreen:
function scene:exitScene()
	Viper:removeEventListener("tap", Missile)
	--missile1.image:removeEventListener("collision", missile1)
	--fleet:removeEventListener("collision", GameOver)
	Runtime:removeEventListener("tap",MoveShip)
	timer.cancel(FleetCheck)
end


function scene:didExitScene( event )
	storyboard.purgeScene( "scene1a" )
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