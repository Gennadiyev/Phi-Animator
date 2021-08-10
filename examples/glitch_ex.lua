local chartReader = require("libs.chartreader")
local animation = require("modules.animation")

local chart = chartReader:load("C:\\Users\\asus\\Desktop\\Phigros\\KUN_RETURNS\\projects\\ChartFile\\Chart_HD.json")
print(chart)

chart:flashToggle(1, 2304, 2336, 4, 1, 0, 1)
chart:flashToggle(1, 2368, 2400, 4, 1, 0, 1)

chart:save("C:\\Users\\asus\\Desktop\\Phigros\\KUN_RETURNS\\projects\\ChartFile\\Chart_EZ.json")