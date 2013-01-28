
display.setStatusBar(display.HiddenStatusBar)
--require "physics"
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
--physics.setDrawMode("hybrid")
--secsText = 00
--minsText = 0

function StartGame(event)
	storyboard.gotoScene( "scene5", {effect = "fade", time = 400 })
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	--media.playEventSound("gameoversound.wav")
	background1= display.newImage("soldier_bg.jpg",0,0)
	--background1:setFillColor(255,0,0)
	background1.xScale = 1
	background1.yScale = 1
	group:insert(background1)
	
	local function timeScore()
		 
	-- a timer constanly calls a local fn to update the timer ibject displayed on the screen.
		 timeText = display.newText(minsText.. ":0" ..secsText, 10, 100, "Helvetica", 24)
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
	
	GameMsg= display.newText("   You have landed on Sirus 3   \nNegoiate the various platforms by \nreaching the door at each level\nand eliminate as many aliens\nas possible\nTap the soldier to fire. Each arrow\nrepresents move left,right, jump\nright, jump left and stop. Pressing\nstop will also fire.\nWhen ready, tap to proceed",0,0,nil,30)
	GameMsg.x=display.contentWidth*0.5
	GameMsg.y=display.contentHeight*0.65
	group:insert(GameMsg)
	--timeScore()
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
	storyboard.purgeScene( "scene4i" )
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