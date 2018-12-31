-- global
Object = require("library/Classic")
Camera = require("library/Camera")
Animator = require("library/Animator")
Push = require("library/Push")

-- props
cameraSpeed = 1000

virtualWidth = 1280
virtualHeight = 720

windowWidth = 1280
windowHeight = 720

function love.load()
   camera = Camera()

   require("Map")
   Map = Map()

   --require("Player")
  -- Player = Player()

   Push:setupScreen(virtualWidth, virtualHeight, windowWidth, windowHeight, {
      fullscreen = false,
      resizable = true
    })
end

function love.update(dt)
    camera:update(dt)
    Map:update(dt)
    --Player:update(dt)
end

function love.draw()
   camera:attach()
 
   love.graphics.setColor(1,1,1,1)

   Map:render()
   -- Player:render()
   
   camera:detach()
   camera:draw() 
end
