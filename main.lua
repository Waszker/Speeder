import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "GameScene/game_scene"

local gfx <const> = playdate.graphics
local gameScene = GameScene()
gameScene:add()

function playdate.update()
    playdate.timer.updateTimers()
    gfx.sprite.update()
end
