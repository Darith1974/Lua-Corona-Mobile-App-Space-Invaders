
display.setStatusBar(display.HiddenStatusBar)
--physics.setDrawMode("hybrid")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local function ReStartGame(event)
	storyboard.gotoScene( "intro", {effect = "fade", time = 400 })
end
-- Called when the scene's view does not exist:
function scene:createScene( event )
	group = self.view
	
	background1= display.newImage("space12bg.jpg",0,0)
	--background1:setFillColor(255,0,0)
	background1.xScale = 2
	background1.yScale = 2
	group:insert(background1)
	
	media.playEventSound("gameoversound.wav")
	GameOverMsg = display.newImage("game-over1.png",display.contentWidth*(0.0),display.contentHeight*0.2)
	GameOverMsg.xScale= 0.4
	GameOverMsg.yScale= 0.4
	GameOverMsg.x=display.contentWidth*0.5
	GameOverMsg.y = display.contentHeight*0.1
	group:insert(GameOverMsg)
	GameMsg= display.newText("Your time was: ",0,0,nil,30)
	GameMsg.x=display.contentWidth*0.5
	GameMsg.y=display.contentHeight*0.35
	group:insert(GameMsg)
	GameMsg1= display.newText(timeText.text,0,0,nil,30)
	GameMsg1.x=display.contentWidth*0.6
	GameMsg1.y=display.contentHeight*0.6
	group:insert(GameMsg1)
	StartAgain = display.newImage("startagain1.png",display.contentWidth*(0.0),display.contentHeight*0.9)
	StartAgain.xScale= 0.4
	StartAgain.yScale= 0.4
	StartAgain.x=display.contentWidth*0.5
	StartAgain.y = display.contentHeight*0.8
	group:insert(StartAgain)
	
	print("game over")
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	StartAgain:addEventListener("tap",ReStartGame)
end

-- Called when scene is about to move offscreen:
function scene:exitScene()
	StartAgain:removeEventListener("tap",ReStartGame)
end


function scene:didExitScene( event )
	storyboard.purgeScene( "GameEnd" )
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