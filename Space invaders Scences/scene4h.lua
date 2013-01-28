
display.setStatusBar(display.HiddenStatusBar)
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local function ChangeScene(event)
	local options = {effect = "fade", time = 400 }
	storyboard.gotoScene( "scene5", options)
end

function scene:createScene(event)
	local group = self.view
	
	background1= display.newImage("red world.jpg",0,0)
	--background1:setFillColor(255,0,0)
	background1.xScale = 1
	background1.yScale = 1
	group:insert(background1)
	
	
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	Check = timer.performWithDelay(2700,ChangeScene,1)
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
	
	timeScore()
end

-- Called when scene is about to move offscreen:
function scene:exitScene()
	
	timer.cancel(Check)
	
end


function scene:didExitScene( event )
	storyboard.purgeScene( "scene4h" )
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