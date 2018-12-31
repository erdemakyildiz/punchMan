Player = Object:extend()

function Player:new()
    self.tileW = 85
    self.tileH = 170
    
    local image = love.graphics.newImage( 'assets/atlas.png' )
    local one = love.graphics.newQuad( 0, 0, self.tileW, self.tileH, image:getWidth(), image:getHeight() )
    local two = love.graphics.newQuad( self.tileW, 0, self.tileW, self.tileH, image:getWidth(), image:getHeight() )
    local three = love.graphics.newQuad( self.tileW * 2, 0, self.tileW, self.tileH, image:getWidth(), image:getHeight() )
    local four = love.graphics.newQuad( self.tileW * 3, 0, self.tileW, self.tileH, image:getWidth(), image:getHeight() )
    local five = love.graphics.newQuad( self.tileW * 4, 0, self.tileW, self.tileH, image:getWidth(), image:getHeight() )
    local six = love.graphics.newQuad( self.tileW * 5, 0, self.tileW, self.tileH, image:getWidth(), image:getHeight() )
    
    self.anim = Animator.newAnimation( { two, two, three, four, five, six }, 0.05, image )

    self.anim:setLooping()
end

function Player:update(dt)
    self.anim:update(dt)
end

function Player:render()
    self.anim:draw()
end