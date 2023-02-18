import "consts"

local gfx <const> = playdate.graphics

PlayerState = {
    WALKING = 1,
    JUMPING = 2,
}

PlayerJumpingDirection = {
    NONE = 1,  -- means player is "on the ground"
    ASCENDING = 2,
    DESCENDING = 3,
}

class('Player').extends(gfx.sprite)

function Player:init(xPosition, yPosition, imageTablePath, gameSpeedAnimator)
    Player.super.init(self)

    self.gameSpeedAnimator = gameSpeedAnimator
    self.frameAnimator = gfx.animator.new(minPlayerAnimationSpeed, 1, 10)
    self.frameAnimator.repeatCount = -1
    self.state = PlayerState.WALKING
    self.jumpingDirection = PlayerJumpingDirection.NONE
    self.velocity = 0
    self.playerSpriteTable = gfx.imagetable.new(imageTablePath)
    assert(self.playerSpriteTable, "Cannot load player image table: " .. imageTablePath)

    self:setScale(2)
    self:setImage(self.playerSpriteTable:getImage(1, 5))
    self:moveTo(xPosition, yPosition)
    self:add()
end

function Player:update()
    if self.state == PlayerState.WALKING then
        self:renderWalkingImage()
    else
        self:renderJumpingImage()
    end

    if playdate.buttonIsPressed(playdate.kButtonA) and self.state == PlayerState.WALKING then
        self.state = PlayerState.JUMPING
        self.jumpingDirection = PlayerJumpingDirection.ASCENDING
        self.velocity = maxPlayerVelocity
        self.currentFrame = 1
    end
end

function Player:renderWalkingImage()
    local currentFrame = self.frameAnimator:currentValue() // 1

    if currentFrame == 9 then
        local gameAnimationSpeed = self.gameSpeedAnimator:currentValue()
        local newAnimationSpeed = (
                maxPlayerAnimationSpeed +
                        (minPlayerAnimationSpeed - maxPlayerAnimationSpeed) *
                                ((maxWorldSpeed - gameAnimationSpeed) / (maxWorldSpeed - minWorldSpeed))
        )
        self.frameAnimator:reset(newAnimationSpeed)
    else
        self:setImage(self.playerSpriteTable:getImage(currentFrame, 5))
    end
end

function Player:renderJumpingImage()
    self:moveBy(0, self.velocity * (self.jumpingDirection == PlayerJumpingDirection.ASCENDING and -1 or 1))
    self:setImage(
            self.playerSpriteTable:getImage(self.jumpingDirection == PlayerJumpingDirection.ASCENDING and 3 or 4, 9)
    )

    self.velocity = self.velocity + (self.jumpingDirection == PlayerJumpingDirection.ASCENDING and -1 or 1)

    if self.velocity == 0 and self.jumpingDirection == PlayerJumpingDirection.ASCENDING then
        self.jumpingDirection = PlayerJumpingDirection.DESCENDING
    elseif self.velocity > maxPlayerVelocity and self.jumpingDirection == PlayerJumpingDirection.DESCENDING then
        self.state = PlayerState.WALKING
        self.jumpingDirection = PlayerJumpingDirection.NONE
    end
end
