local class = require("class")
local Sprite = class:derive("Sprite")
local Animation = require("Animation")
local Vector2 = require("Vector2")

function Sprite:new(atlas, w, h, x, y, sx, sy, angle)
    self.w = w
    self.h = h
    self.flip = Vector2(1,1)
    self.position = Vector2(x,y)
    self.scale = Vector2(sx or 1, sy or 1)
    self.atlas = atlas
    self.animations = {}
    self.currentAnimation = ""
    self.angle = angle or 0
    self.quad = love.graphics.newQuad(0, 0, w, h, atlas:getDimensions())
end

function Sprite:animate(animationName)
    if self.currentAnimation ~= animationName and self.animations[animationName] ~= nil then
        self.animations[animationName]:reset()
        self.animations[animationName]:set(self.quad)
        self.currentAnimation = animationName
    end
end

function Sprite:flipHorizontal(flip)
    if flip then
        self.flip.x = -1
    else
        self.flip.x = 1
    end
end

function Sprite:flipVertical(flip)
    if flip then
        self.flip.y = -1
    else
        self.flip.y = 1
    end
end

function Sprite:animationIsFinished()
    if self.animations[self.currentAnimation] ~= animationName then
        return self.animations[self.currentAnimation].done
    end

    return false
end

function Sprite:addAnimation(name, anim)
    self.animations[name] = anim
end

function Sprite:update(dt)
    if self.animations[self.currentAnimation] ~= nil then
        self.animations[self.currentAnimation]:update(dt, self.quad)
    end
end

function Sprite:draw()
    love.graphics.draw(self.atlas, self.quad, self.position.x, self.position.y, self.angle, 
                        self.scale.x * self.flip.x, self.scale.y * self.flip.y, self.w / 2, self.h / 2)
end

return Sprite
