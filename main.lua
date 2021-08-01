local chartReader = require("chartreader")
local animation = require("animation")

local chart = chartReader:load("Chart_EZ.json")

-- Load plugin
chart:loadModule(animation)

-- Auto mark vanity
chart:autoMarkVanity()
-- Begin to operate


print(chart)
