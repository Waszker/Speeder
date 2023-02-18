import "consts"
import "Player/player"
import "Obstacle/obstacle"

local gfx <const> = playdate.graphics
local tmr <const> = playdate.timer

class("GameScene").extends(gfx.sprite)

function GameScene:init()
    GameScene.super.init(self)

    -- Initialize some internal values
    self.gameSpeedAnimator = gfx.animator.new(5 * 60 * 1000, minWorldSpeed, maxWorldSpeed)  -- max speed after 5 minutes
    self.obstacleCreationDelayAnimator = tmr.new(1500, function()
        Obstacle("Images/rock", self.gameSpeedAnimator)
    end)
    self.obstacleCreationDelayAnimator.repeats = true

    -- Load background image
    local backgroundImage = gfx.image.new("Images/backgroundDesert")
    assert(backgroundImage, "Cannot load background!")
    self.background = gfx.sprite.new(backgroundImage)
    self.background:moveTo(400, 120)
    self.background:add()

    -- Load player sprite
    self.player = Player(40, 170, "Images/cat", self.gameSpeedAnimator)
end

function GameScene:update()
    self:drawBackground()
    self:checkCollisions()
end

function GameScene:drawBackground()
    local newBackgroundSpeed = self.gameSpeedAnimator:currentValue() / 100
    local newXPosition = (self.background.x - newBackgroundSpeed) % 400
    self.background:moveTo(newXPosition, 120)
end

function GameScene:checkCollisions()
    local collisions = gfx.sprite.allOverlappingSprites()
    if #collisions > 0 then
        print("Collision detected!!!!")
    end
end
