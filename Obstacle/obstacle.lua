local gfx <const> = playdate.graphics

class("Obstacle").extends(gfx.sprite)

function Obstacle:init(imagePath, gameSpeedAnimator)
    Obstacle.super.init(self)

    self.gameSpeedAnimator = gameSpeedAnimator

    local image = gfx.image.new(imagePath)
    assert(image, "Cannot load image: " .. imagePath)

    self:setImage(image)
    self:moveTo(420, 190)
    self:setCollideRect(0, 0, 32, 32)
    self:add()
end

function Obstacle:update()
    local obstacleOffset = self.gameSpeedAnimator:currentValue() / 100
    self:moveBy(-1 * obstacleOffset, 0)

    if self.x < -50 then
        self:remove()
    end
end