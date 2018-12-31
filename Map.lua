Map = Object:extend()

function Map:new()
    self.landscape = love.graphics.newImage("world/landscape.png")
end

function Map:update(dt)
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
        camera.scale = camera.scale + 0.01
    end
    
    if love.keyboard.isDown("c") then
        if (camera.scale > 0.1) then
            camera.scale = camera.scale - 0.01
        end
    end
end


function Map:render()
    for x = 0, 50 do
        for y = 0, 50 do
            love.graphics.draw(self.landscape, x + self.landscape:getWidth()/2, y + self.landscape:getHeight()/4 - self.landscape:getHeight()/2 )
        end
    end
end