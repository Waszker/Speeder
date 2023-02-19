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
    self.obstacleCreationDisabled = true  -- initially do not allow for obstacle creation
    self.obstacleCreationDelayAnimator = tmr.new(100, function()
        if self.obstacleCreationDisabled == false then
            if math.random(1, 2) == 1 then
                Obstacle("Images/cactus", self.gameSpeedAnimator)
            else
                Obstacle("Images/rock", self.gameSpeedAnimator)
            end
            self.obstacleCreationDisabled = true
            local obstacleCreationEnableTimeout = math.random(1000, 5000)
            tmr.new(obstacleCreationEnableTimeout, function() self.obstacleCreationDisabled = false end)
        end
    end)
    self.obstacleCreationDelayAnimator.repeats = true
    tmr.new(1500, function() self.obstacleCreationDisabled = false end)  -- start spawning obstacles after 1.5sec

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
        restartGame()
    end
end
