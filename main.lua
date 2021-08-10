local chartReader = require("libs.chartreader")
local lerp = require("libs.lerp")
local animation = require("modules.animation")
local glitch = require("modules.glitchflash")

local chart = chartReader:load("C:\\Users\\asus\\Desktop\\Phigros\\KUN_RETURNS\\projects\\ChartFile\\Chart_HD.json")

-- Load plugin
chart:loadModule(glitch)
chart:loadModule(animation)
print(chart)

chart:autoMarkVanity()

for i = 16, 23 do
    chart:removeNodes(i, 5376, 5376+64, "alpha")
    chart:addAnim(i, "alpha", 5376, 5376 + 15, 0, 0, 1)
    chart:addAnim(i, "alpha", 5376 + 16, 5376 + 31, 0, 0, 1)
    chart:addAnim(i, "alpha", 5376 + 32, 5376 + 47, 0, 0, 1)
    chart:addAnim(i, "alpha", 5376 + 48, 5376 + 63, 0, 0, 1)

    chart:removeNodes(i, 2304, 2432, "alpha")
    chart:addAnim(i, "alpha", 2304, 2432, 0, 0, 13)

    chart:removeNodes(i, 1824, 1856, "alpha")
    chart:flashOnce(i, 1824, 1824+8, 1, 0, 3)
    chart:flashOnce(i, 1840, 1840+7, 1, 0, 3)
    chart:flashOnce(i, 1848, 1848+8, 1, 0, 3)
end

-- local t = 1312
-- local action = 9
-- chart:autoMarkVanity()
-- while t <= 5536 do
--     action = action - 1
--     chart:addAnim(15 + action, "alpha", t, t + 256, 0.3, 0.3, 13, 0)
--     local function randomPos()
--         local x = math.random(3, 7) * 0.1
--         return {x, 2}, {x, -2}
--     end
--     local sp, ep = randomPos()
--     chart:addAnim(15 + action, "move", t, t + 256, sp, ep, 0, 0)
--     local ang = math.random(-50, 50)
--     chart:addAnim(15 + action, "rotate", t, t + 256, ang, ang, 13, 0)
--     if action == 1 then
--         t = t + 33
--         action = 9
--     else
--         t = t + 32 
--     end
-- end

-- chart:autoMarkVanity()
-- chart:addAnim(2, "alpha", 1920, 1952, 0.5, 0, 2, 2, {true, false})
-- local pos1 = randomPos()
-- chart:addAnim(2, "move", 1920, 1952, pos1, pos1, 13, 2)
-- chart:addAnim(2, "rotate", 1920, 1952, 60, 60, 13, 2)
-- chart:addAnim(3, "alpha", 1920, 1952, 0.5, 0, 2, 2, {true, false})
-- chart:addAnim(3, "move", 1920, 1952, pos2, pos2, 13, 2)
-- chart:addAnim(3, "rotate", 1920, 1952, -25, -25, 13, 2)
-- chart:addAnim(4, "alpha", 1920, 1952, 0.5, 0, 2, 2, {true, false})
-- chart:addAnim(4, "move", 1920, 1952, pos3, pos3, 13, 2)
-- chart:addAnim(4, "rotate", 1920, 1952, -75, -75, 13, 2)
-- chart:addAnim(5, "alpha", 1920, 1952, 0.5, 0, 2, 2, {true, false})
-- chart:addAnim(5, "move", 1920, 1952, pos4, pos4, 13, 2)
-- chart:addAnim(5, "rotate", 1920, 1952, 20, 20, 13, 2)

-- glitch.functions.flashToggle(chart, 1, 2304, 2336, 4, 1, 0, 1)
-- glitch.functions.flashToggle(chart, 1, 2368, 2400, 4, 1, 0, 1    )

-- animation.functions.autoAddAnim(chart, "alpha", 1408, 1440, 1, 0, 2, 1)
-- animation.functions.autoAddAnim(chart, "move", 1408, 1440, {0.5, 0.5}, {0.7, 0.5}, 5, 1)
-- -- Auto mark vanity
-- chart:autoMarkVanity()
-- -- Add animations
-- chart:addAnim(10, 1, 1472, 1504, 1, 0, 3, 8)
-- chart:addAnim(10, 2, 1472, 1504, {0.5, 0.14}, {0.5, 0.5}, 3, 8)
-- chart:addAnim(11, 1, 1496, 1528, 1, 0, 3, 8)
-- chart:addAnim(11, 2, 1496, 1528, {0.5, 0.14}, {0.5, 0.5}, 3, 8)
 
chart:save("C:\\Users\\asus\\Desktop\\Phigros\\KUN_RETURNS\\projects\\ChartFile\\Chart_EZ.json")
