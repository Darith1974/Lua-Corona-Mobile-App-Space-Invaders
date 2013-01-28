
display.setStatusBar(display.HiddenStatusBar)
require "physics"
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
physics.setDrawMode("hybrid")
function StartGame(event)
	storyboard.gotoScene( "scene1a", {effect = "fade", time = 400 })
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	group = self.view
	media.playEventSound("gameoversound.wav")
	
	GameMsg= display.newText("     Click Here    \n to Start Game",0,0,nil,30)
	GameMsg.x=display.contentWidth*0.5
	GameMsg.y=display.contentHeight*0.35
	group:insert(GameMsg)
	
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	GameMsg:addEventListener("tap",StartGame)
end

-- Called when scene is about to move offscreen:
function scene:exitScene()
	GameMsg:removeEventListener("tap",StartGame)
end


function scene:didExitScene( event )
	storyboard.purgeScene( "intro1" )
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