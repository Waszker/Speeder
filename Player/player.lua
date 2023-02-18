import "consts"

local gfx <const> = playdate.graphics

class('Player').extends(gfx.sprite)

function Player:init(xPosition, yPosition, imageTablePath, gameSpeedAnimator)
    Player.super.init(self)

    self.gameSpeedAnimator = gameSpeedAnimator
    self.frameAnimator = gfx.animator.new(minPlayerAnimationSpeed, 1, 10)
    self.frameAnimator.repeatCount = -1
    self.playerSpriteTable = gfx.imagetable.new(imageTablePath)
    assert(self.playerSpriteTable, "Cannot load player image table: " .. imageTablePath)

    self:setScale(2)
    self:setImage(self.playerSpriteTable:getImage(1, 5))
    self:moveTo(xPosition, yPosition)
    self:add()
end

function Player:update()
    local currentFrame = self.frameAnimator:currentValue() // 1

    if currentFrame == 9 then
        local gameAnimationSpeed = self.gameSpeedAnimator:currentValue()
        local newAnimationSpeed = maxPlayerAnimationSpeed + (minPlayerAnimationSpeed - maxPlayerAnimationSpeed) * ((maxWorldSpeed - gameAnimationSpeed) / (maxWorldSpeed - minWorldSpeed))
        self.frameAnimator:reset(newAnimationSpeed)
    else
        self:setImage(self.playerSpriteTable:getImage(currentFrame, 5))
    end
end
