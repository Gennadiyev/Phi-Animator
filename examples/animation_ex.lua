local chartReader = require("libs.chartreader")
local animation = require("modules.animation")

local chart = chartReader:load("C:\\Users\\asus\\Desktop\\Phigros\\KUN_RETURNS\\projects\\ChartFile\\Chart_HD.json")
print(chart)

chart:autoMarkVanity()

local t = 1312
local action = 9
while t <= 5536 do
    action = action - 1
    chart:addAnim(15 + action, "alpha", t, t + 256, 0.3, 0.3, 13, 0)
    local function randomPos()
        local x = math.random(3, 7) * 0.1
        return {x, 2}, {x, -2}
    end
    local sp, ep = randomPos()
    chart:addAnim(15 + action, "move", t, t + 256, sp, ep, 0, 0)
    local ang = math.random(-50, 50)
    chart:addAnim(15 + action, "rotate", t, t + 256, ang, ang, 13, 0)
    if action == 1 then
        t = t + 33
        action = 9
    else
        t = t + 32 
    end
end

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

chart:save("C:\\Users\\asus\\Desktop\\Phigros\\KUN_RETURNS\\projects\\ChartFile\\Chart_EZ.json")
