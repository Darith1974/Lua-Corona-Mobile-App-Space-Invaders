
display.setStatusBar(display.HiddenStatusBar)
--require "physics"
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
--physics.setDrawMode("hybrid")
secsText = 0
minsText = 0

--[[ This is the first scene of the game. I put up a nice sci fi background image and then some introductory text. A event listener toggles to the scene. 
]]--
function StartGame(event)
	storyboard.gotoScene( "scene1a", {effect = "fade", time = 400 })
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	media.playEventSound("gameoversound.wav")
	
	background1= display.newImage("space12bg.jpg",0,0)
	--background1:setFillColor(255,0,0)
	background1.xScale = 2
	background1.yScale = 2
	group:insert(background1)
	
	GameMsg= display.newText("     In 2014 the Space Treaty\nOrganisation was setup via the\nUnited Nations for the specific\npurpose of mutual defence\nof offworld colonies of \nvarious nations and some\ncorporate intertests. The Sirius\n system has three\nColonies: Sirius 1, 2 & 3.\nTwo Australian and one Chinese.\nYou are a member of the United\nStates Marine Core assigned\nto STO forces in this area.\nYou have been ordered to take\ncommand of a viper and proceed\n to Sirus 3 for further orders.\n Eliminate as many hostiles on\nroute. Where you tap;your ship\n will move. Tap ship to fire.\nTap screen to begin Game.",0,0,nil,30)
	GameMsg.x=display.contentWidth*0.5
	GameMsg.y=display.contentHeight*0.45
	group:insert(GameMsg)
	
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	Runtime:addEventListener("tap",StartGame)
end

-- Called when scene is about to move offscreen:
function scene:exitScene()
	Runtime:removeEventListener("tap",StartGame)
end


function scene:didExitScene( event )
	storyboard.purgeScene( "intro" )
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