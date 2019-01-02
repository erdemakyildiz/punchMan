local Animation = require("Animation")
local Sprite = require("Sprite")
local Key = require("Keyboard")
local Evt = require("Events")

local heroAtlas
local heroSprite

local spr
local idle = Animation(16, 16, 16, 16, 4, 4, 6)
local walk = Animation(16, 32, 16, 16, 6, 6, 12)
local swim = Animation(16, 64, 16, 16, 6, 6, 12)
local punch = Animation(16, 80, 16, 16, 3, 3, 16, false)

local punchSound = love.audio.newSource("hit01.wav", "static")
    
function love.load()
    Key:hookLoveEvents()
    love.graphics.setDefaultFilter("nearest", "nearest")
    heroAtlas = love.graphics.newImage("hero.png")
    heroSprite = love.graphics.newQuad(16, 32, 16, 16, heroAtlas:getDimensions())

    spr = Sprite(heroAtlas, 16, 16, 100, 100, 10, 10)
    spr:addAnimation("walk", walk)
    spr:addAnimation("swim", swim)
    spr:addAnimation("punch", punch)
    spr:addAnimation("idle", idle)

    spr:animate("walk")

    e = Evt(true)
    e:add("on_space")
    e:hook("on_space", on_space)

end

function on_space( ... )
    love.window.setTitle("bok")
end

function love.update(dt)
    if dt > 0.035 then
        return
    end

    if Key:keyDown("space") and spr.currentAnimation ~= "punch" then
        spr:animate("punch")
        love.audio.stop(punchSound)
        love.audio.play(punchSound)
        e:invoke("on_space")
    elseif Key:keyDown("u") then
        e:unhook("on_space", on_space)
    elseif Key:keyDown("escape") then
        love.event.quit()
    end

    if spr.currentAnimation == "punch" and spr:animationIsFinished() then
        spr:animate("idle")
        love.window.setTitle("123")
    end

    Key:update(dt)
    spr:update(dt)
end

function love.draw()
    love.graphics.clear(80 / 255, 64 / 255, 1)
    spr:draw()
end
