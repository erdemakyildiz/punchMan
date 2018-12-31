Camera = require 'Camera'
local animator = require 'animator'

local cameraSpeed = 1000

function love.load()
  grass = love.graphics.newImage("grass.png")
  
  block_width = grass:getWidth()
  block_height = grass:getHeight()
  block_depth = block_height / 2
  
  camera = Camera()
  
  tileW = 85
  tileH = 170
  
  local image = love.graphics.newImage( 'atlas.png' )
  local one = love.graphics.newQuad( 0, 0, tileW, tileH, image:getWidth(), image:getHeight() )
  local two = love.graphics.newQuad( tileW, 0, tileW, tileH, image:getWidth(), image:getHeight() )
  local three = love.graphics.newQuad( tileW * 2, 0, tileW, tileH, image:getWidth(), image:getHeight() )
  local four = love.graphics.newQuad( tileW * 3, 0, tileW, tileH, image:getWidth(), image:getHeight() )
  local five = love.graphics.newQuad( tileW * 4, 0, tileW, tileH, image:getWidth(), image:getHeight() )
  local six = love.graphics.newQuad( tileW * 5, 0, tileW, tileH, image:getWidth(), image:getHeight() )
  
	anim = animator.newAnimation( { two, two, three, four, five, six }, 0.05, image )
  anim:setLooping()
end

function love.update(dt)
    anim:update( dt )
    camera:update(dt)
  
    if love.keyboard.isDown("a") then
       camera.x = camera.x - cameraSpeed * dt
    end
    
    if love.keyboard.isDown("d") then
       camera.x = camera.x + cameraSpeed * dt
       
    end
    
    if love.keyboard.isDown("w") then
       camera.y = camera.y - cameraSpeed * dt
    end
    
    if love.keyboard.isDown("s") then
       camera.y = camera.y + cameraSpeed * dt
    end
    
    if love.keyboard.isDown("f") then
       camera.scale = camera.scale + 0.05
    end
    
    if love.keyboard.isDown("c") then
       camera.scale = camera.scale - 0.05
    end
      
end

function love.draw()
   camera:attach()
    -- Draw your game here
    
  love.graphics.setColor(1,1,1,1)
  
  
   for x = 1,20 do
     for y = 1,20 do
          love.graphics.draw(grass,
             ((y-x) * (block_width / 2 - 10)),
            ((x+y) * (block_depth / 2 + 10)) - (block_depth))
     end
   end
   
   anim:draw()
   
   camera:detach()
    camera:draw() 
end
