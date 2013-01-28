local defaultField, numberField -- forward reference (needed for Lua closure)
 
-- TextField Listener
local function fieldHandler( getObj )
        
-- Use Lua closure in order to access the TextField object
 
        return function( event )
 
                print( "TextField Object is: " .. tostring( getObj() ) )
                
                if ( "began" == event.phase ) then
                        -- This is the "keyboard has appeared" event
                
                elseif ( "ended" == event.phase ) then
                        -- This event is called when the user stops editing a field:
                        -- for example, when they touch a different field or keyboard focus goes away
                
                        print( "Text entered = " .. tostring( getObj().text ) )         -- display the text entered
                        
                elseif ( "submitted" == event.phase ) then
                        -- This event occurs when the user presses the "return" key
                        -- (if available) on the onscreen keyboard
                        
                        -- Hide keyboard
                        native.setKeyboardFocus( nil )
                end
                
        end     -- "return function()"
 
end
 
-- Create our Text Field
defaultField = native.newTextField( 10, 30, 180, 30,
        fieldHandler( function() return defaultField end ) )    -- passes the text field object
        
numberField = native.newTextField( 10, 70, 180, 30,
        fieldHandler( function() return numberField end ) )