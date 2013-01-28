display.setStatusBar( display.HiddenStatusBar )
require "physics"
physics.start()
local storyboard = require "storyboard"

storyboard.gotoScene( "intro" )
--DamageFleetCounter counts the number alien ships destroyed.
DamageFleetCounter = 0
-- these three variables are used in the timeScore fn in each scene
local minsText = 0 
local secsText = 0
local timeText = 0