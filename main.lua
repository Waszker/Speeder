import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "GameScene/game_scene"

local gfx <const> = playdate.graphics
local tmr <const> = playdate.timer

math.randomseed(playdate.getSecondsSinceEpoch())

function restartGame()
    gfx.sprite:removeAll()
    for _, timer in ipairs(tmr.allTimers()) do timer:remove() end
    GameScene():add()
end
restartGame()

function playdate.update()
    playdate.timer.updateTimers()
    gfx.sprite.update()
end
