display.setStatusBar(display.HiddenStatusBar)
require "physics"
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
--physics.setDrawMode("hybrid")
physics.start()
local a = (display.contentWidth - 20)/3
local b = (display.contentHeight -20)/4
local c =10
require "sprite"
local Platforms = {}
local wall = {}
local background1 = 0
local bulletClass = require( "bullet" )
local stance = 2

local function Universe()
	--Here i create four walls with physics within which all other objects interact. Refer back to createScene.
	
	local wallThickness = 10
	
	local a = (display.contentWidth - 20)/3
	local b = (display.contentHeight -20)/4
	local c =10
	-- Top blocks
	wall[1] = display.newRect( 0, 0, wallThickness, wallThickness )
	physics.addBody(wall[1], "static", {friction=0, bounce = 0})
	wall[1].myName = "Wall1"
	group:insert(wall[1])
	wall[2] = display.newRect( 10, 0,a, wallThickness )
	physics.addBody(wall[2], "static", {friction=0, bounce = 0})
	wall[2].myName = "Wall2"
	group:insert(wall[2])
	
	wall[3] = display.newRect( a+10, 0, a, wallThickness )
	physics.addBody(wall[3], "static", {friction=0, bounce = 0})
	wall[3].myName = "Wall3"
	group:insert(wall[3])
	
	wall[4] = display.newRect( (2*a)+10, 0, a, wallThickness )
	physics.addBody(wall[4], "static", {friction=0, bounce = 0})
	wall[4].myName = "Wall4"
	group:insert(wall[4])
	
	wall[5] = display.newRect( (3*a)+10, 0, 10, wallThickness )
	physics.addBody(wall[5], "static", {friction=0, bounce = 0})
	wall[5].myName = "Wall5"
	group:insert(wall[5])
	-- Right wall
	wall[6] = display.newRect( (3*a)+10, 10,wallThickness, b )
	physics.addBody(wall[6], "static", {friction=0, bounce = 0})
	wall[6].myName = "Wall6"
	group:insert(wall[6])
	
	wall[7] = display.newRect( (3*a)+10, b + 10,wallThickness,b )
	physics.addBody(wall[7], "static", {friction=0, bounce = 0})
	wall[7].myName = "Wall7"
	group:insert(wall[7])
	
	wall[8] = display.newRect( (3*a)+10, (2*b) + 10,wallThickness,b )
	physics.addBody(wall[8], "static", {friction=0, bounce = 0})
	wall[8].myName = "Wall8"
	group:insert(wall[8])
	
	wall[9] = display.newRect( (3*a)+10, (3*b) + 10, wallThickness,b )
	physics.addBody(wall[9], "static", {friction=0, bounce = 0})
	wall[9].myName = "Wall9"
	group:insert(wall[9])
	
	
	wall[10] = display.newRect( (3*a)+10, (4*b)+10,  wallThickness,10 )
	physics.addBody(wall[10], "static", {friction=0, bounce = 0})
	wall[10].myName = "Wall1"
	group:insert(wall[10])
	
	wall[11] = display.newRect( (2*a)+10, (4*b)-110,a,10 )
	physics.addBody(wall[11], "static", {friction=0, bounce = 0})
	wall[11].myName = "Wall11"
	group:insert(wall[11])
	
	wall[12] = display.newRect( a+10, (4*b)-110, a, wallThickness )
	physics.addBody(wall[12], "static", {friction=0, bounce = 0})
	wall[12].myName = "Wall12"
	group:insert(wall[12])
	
	wall[13] = display.newRect( 10, (4*b)-110, a, wallThickness )
	physics.addBody(wall[13], "static", {friction=0, bounce = 0})
	wall[13].myName = "Wall13"
	group:insert(wall[13])
	
	wall[14] = display.newRect( 0, (4*b)+10, 10, wallThickness )
	physics.addBody(wall[14], "static", {friction=0, bounce = 0})
	wall[14].myName = "Wall14"
	group:insert(wall[14])
	
	wall[15] = display.newRect( 0, (3*b)+10, wallThickness, b )
	physics.addBody(wall[15], "static", {friction=0, bounce = 0})
	wall[15].myName = "Wall15"
	group:insert(wall[15])
	
	wall[16] = display.newRect( 0, (2*b)+10, wallThickness, b )
	physics.addBody(wall[16], "static", {friction=0, bounce = 0})
	wall[16].myName = "Wall16"
	group:insert(wall[16])
	
	wall[17] = display.newRect(0,b+10,wallThickness,b)
	physics.addBody(wall[17], "static", {friction=0, bounce = 0})
	group:insert(wall[17])
	wall[17].myName = "Wall7"
	-- Right wall
	wall[18] = display.newRect(0, 10, 10,b)
	physics.addBody(wall[18], "static", {friction=0, bounce = 0})
	group:insert(wall[18])
	wall[18].myName = "Wall18"
	
end
local function SpaceDoor(event)
	local function GameEnd()
			local options = {effect = "fade", time = 400 }					
			storyboard.gotoScene( "Scene8" )
		end
	local s = timer.performWithDelay(1000,GameEnd,1)
end

local function Platform()

		local wallThickness = 20
		local a = (display.contentWidth - 20)/3
		local b = (display.contentHeight -20)/4
		local c =10
		local d = 38.25
		local e = (4*b) -60
		Swarm = {}
		--fleet[i] = sprite.newSprite( alienspriteSet)
		aliensheetR = sprite.newSpriteSheet( "alien-3.jpg", 60,39) -- ( image.png, spriteWidth, spriteHeight)
		aliensheetS = sprite.newSpriteSheet( "alienS12.png", 64.875,54) -- ( image.png, spriteWidth, spriteHeight)
		alienspriteSetR = sprite.newSpriteSet(aliensheetR, 1, 7)
		alienspriteSetS = sprite.newSpriteSet(aliensheetS, 1, 8)
		sprite.add(alienspriteSetR, "alienR", 1, 7, 1000, 0 )
		sprite.add(alienspriteSetS, "alienS", 1, 4, 1000, 0 )
		
		Platforms[1] = display.newRect( 10, e-3*d, a+10, c )
		physics.addBody(Platforms[1], "static", {friction=1, bounce = 0})
		Platforms[1]:setFillColor( 150, 180, 200)
		group:insert(Platforms[1])
		Swarm[1] = sprite.newSprite(alienspriteSetS)
		physics.addBody(Swarm[1], "dynamic", {friction=0, bounce = 0})
		Swarm[1].x = a +10
		Swarm[1].y = e-3*d
		Swarm[1]:prepare("alienS")
		Swarm[1]:play()
		Swarm[1].type="alien"
		group:insert(Swarm[1])
		Platforms[2] = display.newRect( a+10,e-6*d, a+10, c )
		physics.addBody(Platforms[2], "static", {friction=1, bounce = 0})
		Platforms[2]:setFillColor( 150, 180, 200 )
		group:insert(Platforms[2])
		Swarm[2] = sprite.newSprite(alienspriteSetS)
		physics.addBody(Swarm[2], "dynamic", {friction=0, bounce = 0})
		Swarm[2].x = 2*a 
		Swarm[2].y = e-(6*d)
		Swarm[2]:prepare("alienS")
		Swarm[2]:play()
		Swarm[2].type="alien"
		group:insert(Swarm[2])
		Platforms[3] = display.newRect( 2*a+10,e-(9*d), a+10, c )
		physics.addBody(Platforms[3], "static", {friction=1, bounce = 0})
		Platforms[3]:setFillColor( 150, 180, 200)
		group:insert(Platforms[3])
		Swarm[3] = sprite.newSprite(alienspriteSetS)
		physics.addBody(Swarm[3], "dynamic", {friction=0, bounce = 0})
		Swarm[3].x = 3*a
		Swarm[3].y = e-(9*d)
		Swarm[3]:prepare("alienS")
		Swarm[3]:play()
		Swarm[3].type="alien"
		group:insert(Swarm[3])
		Platforms[4] = display.newRect( a+10,e-(12*d), a+10, c )
		physics.addBody(Platforms[4], "static", {friction=1, bounce = 0})
		Platforms[4]:setFillColor( 150, 180, 200)
		group:insert(Platforms[4])
		Swarm[4] = sprite.newSprite(alienspriteSetS)
		physics.addBody(Swarm[4], "dynamic", {friction=0, bounce = 0})
		Swarm[4].x = a + 25
		Swarm[4].y = e-(12*d)
		Swarm[4]:prepare("alienS")
		Swarm[4]:play()
		Swarm[4].type="alien"
		group:insert(Swarm[4])
		Platforms[5] = display.newRect( 10,e-(15*d), a+10, c )
		physics.addBody(Platforms[5], "static", {friction=1, bounce = 0})
		Platforms[5]:setFillColor( 150, 180, 200)
		group:insert(Platforms[5])
		--[[
		Platforms[6] = display.newRect( a+ 10,e-(18*d), a+10, c )
		physics.addBody(Platforms[6], "static", {friction=1, bounce = 0})
		Platforms[6]:setFillColor( 255, 0, 0 )
		group:insert(Platforms[6])
		]]--
		Platforms[7] = display.newRect(a+10,e-(18*d), a+10, c )
		physics.addBody(Platforms[7], "static", {friction=1, bounce = 0})
		Platforms[7]:setFillColor(150, 180, 200)
		group:insert(Platforms[7])
		
		Platforms[8] = display.newImage("spacedoor.jpg",a+30,10 )
		--Platforms[8].xScale = 0.66
		--Platforms[8].yScale = 0.66
		physics.addBody(Platforms[8], "static", {friction=1, bounce = 0})
		Platforms[8]:setFillColor(150, 180, 200 )
		group:insert(Platforms[8])
		
end

local function Attack(event)
	local a = x.x
	local b = x.y
	local c = x:getLinearVelocity()
	bullet1= bulletClass.new(a,b,c,stance)
	bullet1.image:addEventListener("collision",bullet1)
end

function TapEvent(event)
	
	
	if  event.target == GameMsg1 then
		--physics.setGravity(0,-2.8)
		--print("Gravity up")
		x:setLinearVelocity(0,0)
		x:prepare("soldierR")
		x:play()
		x:applyLinearImpulse(0.03,-0.1,0,0)
		stance  = 2
	end
	if  event.target ==  GameMsg2 then
		--physics.setGravity(2.8,0)
		--print("Gravity left")
		x:setLinearVelocity(0,0)
		x:prepare("soldierl")
		x:play()
		x:setLinearVelocity(-10,0)
		stance  = 1
	end
	if  event.target == GameMsg3 then
		--physics.setGravity(-2.8,0)
		--print("Gravity right")
		x:setLinearVelocity(0,0)
		x:prepare("soldierR")
		x:play()
		x:setLinearVelocity(10,0)
		stance = 2
	end
	if  event.target == GameMsg4 then
		--physics.setGravity(0,2.8)
		--print("Gravity down")
		x:setLinearVelocity(0,0)
		x:prepare("soldierl")
		x:play()
		x:applyLinearImpulse(-0.03,-0.1,0,0)
		stance  = 1
	end
	if event.target == GameMsg5 then
		--physics.setGravity(0,0)
		--print("Gravity off")
		x:setLinearVelocity(0,0)
		Attack()
	end
end

local function Death(event)
	if event.other.type == "alien" then
		local function GameEnd()
			local options = {effect = "fade", time = 400 }					
			storyboard.gotoScene( "GameEnd" )
		end
		local s = timer.performWithDelay(1000,GameEnd,1)
	end

end

local function timeScore()
		 
	-- a timer constanly calls a local fn to update the timer ibject displayed on the screen.
		 timeText = display.newText(minsText.. ":0" ..secsText, 10, 10, "Helvetica", 24)
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
function scene:createScene( event )
	group = self.view
	background1= display.newImage("bg12.jpg",0,0)
	--background1:setFillColor(255,0,0)
	group:insert(background1)
	GameMsg1= display.newImage("yellow-street-sign-arrow-up1.png",0,0,nil,30)
	GameMsg1.x=display.contentWidth*0.1
	GameMsg1.y=display.contentHeight-80
	GameMsg1.xScale=0.4
	GameMsg1.yScale=0.4
	GameMsg1:setReferencePoint()
	--GamesMsg1.myName="gamesMsg1"
	group:insert(GameMsg1)
	GameMsg2= display.newImage("arrow-3D-green-left1.png",0,0,nil,30)
	GameMsg2.x=display.contentWidth*0.3
	GameMsg2.y=display.contentHeight-80
	GameMsg2.xScale=0.4
	GameMsg2.yScale=0.4
	GameMsg2:setReferencePoint()
	group:insert(GameMsg2)
	GameMsg3= display.newImage("arrow-3D-green-right1.png",0,0,nil,30)
	GameMsg3.x=display.contentWidth*0.5
	GameMsg3.y=display.contentHeight-80
	GameMsg3.xScale=0.4
	GameMsg3.yScale=0.4
	GameMsg3:setReferencePoint()
	group:insert(GameMsg3)
	GameMsg4= display.newImage("Fire-exit-diagonal-arrow-sign1.png",0,0,nil,30)
	GameMsg4.x=display.contentWidth*0.7
	GameMsg4.y=display.contentHeight-80
	GameMsg4.xScale=0.4
	GameMsg4.yScale=0.4
	GameMsg4:setReferencePoint()
	group:insert(GameMsg4)
	GameMsg5 = display.newImage("stop1.png",0,0,nil,30)
	GameMsg5.x=display.contentWidth*0.9
	GameMsg5.y = display.contentHeight-80
	GameMsg5.xScale=0.2
	GameMsg5.yScale=0.2
	GameMsg5:setReferencePoint()
	group:insert(GameMsg5)
	--SoldierRunning= sprite.newSpriteSheet("soldier2.jpg",59.67,45.714)
	SoldierRunning= sprite.newSpriteSheet("soldier11.png",25.25,38.25)
	SoldierRunningSet = sprite.newSpriteSet(SoldierRunning,1, 16)
	sprite.add( SoldierRunningSet, "soldierR",9, 4, 1000, 0 )
	sprite.add( SoldierRunningSet, "soldierl",5, 4, 1000, 0 )
	sprite.add( SoldierRunningSet, "soldierS",1, 4, 1000, 0 )
	x= sprite.newSprite( SoldierRunningSet)
	physics.addBody(x, "dynamic", {friction=0, bounce = 0})
	x:setReferencePoint()
	x.x = 20
	x.y = (4*b) -220
	x.xScale=2
	x.yScale =2
	x:prepare("soldierR")
	x:play()
	x:setLinearVelocity(10,0)
	x.isFixedRotation =true
	group:insert(x)
	Universe()	
	Platform()
	timeScore()	
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	--Runtime:addEventListener("tap", TapEvent)
	x:addEventListener("tap", Attack)
	x:addEventListener("collision", Death)
	GameMsg1:addEventListener("tap",TapEvent)
	GameMsg2:addEventListener("tap",TapEvent)
	GameMsg3:addEventListener("tap",TapEvent)
	GameMsg4:addEventListener("tap",TapEvent)
	GameMsg5:addEventListener("tap",TapEvent)
	Platforms[8]:addEventListener("collision", SpaceDoor)
end

-- Called when scene is about to move offscreen:
function scene:exitScene()
	GameMsg1:removeEventListener("tap",TapEvent)
	GameMsg2:removeEventListener("tap",TapEvent)
	GameMsg3:removeEventListener("tap",TapEvent)
	GameMsg4:removeEventListener("tap",TapEvent)
	GameMsg5:removeEventListener("tap",TapEvent)
	x:removeEventListener("tap", Attack)
	x:removeEventListener("collision", Death)
	--Runtime:removeEventListener("tap", TapEvent)
	Platforms[8]:removeEventListener("collision", SpaceDoor)
end


function scene:didExitScene( event )
	storyboard.purgeScene( "scene7" )
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