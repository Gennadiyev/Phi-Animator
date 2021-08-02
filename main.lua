local chartReader = require("chartreader")
local animation = require("animation")

local chart = chartReader:load("C:\\Users\\asus\\Desktop\\Phigros\\KUN_RETURNS\\projects\\ChartFile\\Chart_HD.json")

-- Load plugin
chart:loadModule(animation)

-- Auto mark vanity
chart:autoMarkVanity()
-- Add animations
chart:addAnim(10, 1, 1472, 1504, 1, 0, 3, 8)
chart:addAnim(10, 2, 1472, 1504, {0.5, 0.14}, {0.5, 0.5}, 3, 8)
chart:addAnim(11, 1, 1496, 1528, 1, 0, 3, 8)
chart:addAnim(11, 2, 1496, 1528, {0.5, 0.14}, {0.5, 0.5}, 3, 8)

chart:save("C:\\Users\\asus\\Desktop\\Phigros\\KUN_RETURNS\\projects\\ChartFile\\Chart_EZ.json")

print(chart)
