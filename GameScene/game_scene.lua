local gfx <const> = playdate.graphics
local backgroundAnimationSpeed = 5000 -- 5 seconds to get through whole background

class('GameScene').extends(gfx.sprite)

function GameScene:init()
    GameScene.super.init(self)

    -- Initialize some internal values
    self.gameSpeedAnimator = gfx.animator.new(60 * 1000, 100, 500)  -- game at max speed after 1 minute

    -- Load background image
    local backgroundImage = gfx.image.new("Images/backgroundDesert")
    assert(backgroundImage, "Cannot load background!")
    self.background = gfx.sprite.new(backgroundImage)
    self.background:moveTo(400, 120)
    self.background:add()
end

function GameScene:update()
    self:drawBackground()
end

function GameScene:drawBackground()
    local newBackgroundSpeed = self.gameSpeedAnimator:currentValue() / 100
    local newXPosition = (self.background.x - newBackgroundSpeed) % 400
    self.background:moveTo(newXPosition, 120)
end
