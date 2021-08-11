local chartReader = require("libs.chartreader")
local lerp = require("libs.lerp")
local animation = require("modules.animation")
local glitch = require("modules.glitchflash")

local chart = chartReader:load("C:\\Users\\asus\\Desktop\\Phigros\\KUN_RETURNS\\projects\\ChartFile\\Chart_HD.json")

-- Load plugin
chart:loadModule(glitch)
chart:loadModule(animation)
chart:autoMarkVanity()

local act = -1
local finalPos = 0.5
chart:addAnim(9, "alpha", 12416, 12672, 1, 1, 13, 4)
chart:addAnim(9, "rotate", 12416, 12672, 90, 90, 13)
for t = 12416, 12543, 4 do
    act = act + 1
    if act % 2 == 1 then
        finalPos = 0.5 + 0.025 * math.floor(act / 2)
        chart:addNode(9, "move", t, {finalPos, 0.5}, "zero")
    else
        finalPos = 0.5 - 0.025 * math.floor(act / 2)
        chart:addNode(9, "move", t, {finalPos, 0.5}, "zero")
    end
end

for t = 12544, 12607, 4 do
    finalPos = finalPos - 0.05
    chart:addNode(9, "move", t, {finalPos, 0.5}, "zero")
end

for t = 12608, 12672, 4 do
    finalPos = finalPos + 0.05
    chart:addNode(9, "move", t, {finalPos, 0.5}, "zero")
end

-- for j = 16, 23 do chart:removeNodes(j, "alpha", 9472, 9600) end
-- for t = 9472,9600,8 do
--     if t ~= 9544 and t ~= 9576 then
--         for j = 16, 23 do
--             chart:flashOnce(j, t, t+7, 1, 0.3, "outSine")
--         end
--     end
-- end

-- local l1, l2, l3, l4 = 15,14,13,12
-- -- 5504: Light the left two lines
-- chart:addAnim(l1, "alpha", 5504, 5504+8, 0, 1, "outSine")
-- chart:addAnim(l1, "move", 5504, 5504 + 8, {0.4, 0.5}, {0.2, 0.5}, "outCubic")
-- chart:addAnim(l1, "rotate", 5504, 5648, 90, 90, "zero")
-- chart:addAnim(l2, "alpha", 5504, 5504+8, 0, 1, "outSine")
-- chart:addAnim(l2, "move", 5504, 5504 + 8, {0.5, 0.5}, {0.4, 0.5}, "outCubic")
-- chart:addAnim(l2, "rotate", 5504, 5648, 90, 90, "zero")
-- -- 5552: Light the right two lines
-- chart:addAnim(l3, "alpha", 5552, 5552+8, 0, 1, "outSine")
-- chart:addAnim(l3, "move", 5552, 5552 + 8, {0.5, 0.5}, {0.6, 0.5}, "outCubic")
-- chart:addAnim(l3, "rotate", 5552, 5648, 90, 90, "zero")
-- chart:addAnim(l4, "alpha", 5552, 5552+8, 0, 1, "outSine")
-- chart:addAnim(l4, "move", 5552, 5552 + 8, {0.6, 0.5}, {0.8, 0.5}, "outCubic")
-- chart:addAnim(l4, "rotate", 5552, 5648, 90, 90, "zero")
-- -- 5584 ~+32 Line 1 goes to middle
-- chart:addAnim(l1, "move", 5584, 5584 + 32, {0.2, 0.5}, {0.5, 0.5}, "outCubic")
-- -- 5592 ~+32 Line 4 goes to middle
-- chart:addAnim(l4, "move", 5592, 5592 + 32, {0.8, 0.5}, {0.5, 0.5}, "outCubic")
-- -- 5584 ~+32 Line 2 goes to middle
-- chart:addAnim(l2, "move", 5584, 5584 + 32, {0.4, 0.5}, {0.5, 0.5}, "outCubic")
-- -- 5616 ~+32 Line 3 goes to middle
-- chart:addAnim(l3, "move", 5616, 5616 + 32, {0.6, 0.5}, {0.5, 0.5}, "outCubic")
-- -- 5648 ~+16 Line 1 goes to left bottom and tilt
-- chart:addAnim(l1, "move", 5648, 5648 + 16, {0.5, 0.5}, {0.3, 0.75}, "outCubic")
-- chart:addAnim(l1, "rotate", 5648, 5648 + 16, 90, 110, "outCubic")
-- -- 5656 ~+16 Line 4 goes to right top and tilt
-- chart:addAnim(l4, "move", 5656, 5656 + 16, {0.5, 0.5}, {0.7, 0.25}, "outCubic")
-- chart:addAnim(l4, "rotate", 5656, 5656 + 16, 90, 110, "outCubic")
-- -- 5680 ~+12 Line 2 3 separate
-- chart:addAnim(l2, "move", 5680, 5680 + 12, {0.5, 0.5}, {0.4, 0.625}, "outCubic")
-- chart:addAnim(l2, "rotate", 5680, 5680 + 12, 90, 110, "outCubic")
-- chart:addAnim(l3, "move", 5680, 5680 + 12, {0.5, 0.5}, {0.6, 0.375}, "outCubic")
-- chart:addAnim(l3, "rotate", 5680, 5680 + 12, 90, 110, "outCubic")
-- -- 5704 ~+16 Line 1 move further towards bottom left
-- chart:addAnim(l1, "move", 5704, 5704 + 16, {0.3, 0.75}, {0.3, 0.25}, "outSine")
-- -- 5712 ~+16 Line 4 move further towards top right
-- chart:addAnim(l4, "move", 5712, 5712 + 16, {0.7, 0.25}, {0.7, 0.75}, "outSine")
-- -- 5720 ~+16 Line 2 move further towards bottom left
-- chart:addAnim(l2, "move", 5720, 5720 + 16, {0.4, 0.625}, {0.4, 0.375}, "outSine")
-- -- 5728 ~+16 Line 3 move further towards top right
-- chart:addAnim(l3, "move", 5728, 5728 + 16, {0.6, 0.375}, {0.6, 0.625}, "outSine")
-- -- 5744 ~+16 Lines flash from black, during which time they rotate 90 deg
-- chart:flashOnce(l1, 5744, 5744+15, 0, 1, "outSine")
-- chart:addAnim(l1, "rotate", 5744, 5744 + 15, 20, 20, 13)
-- chart:flashOnce(l2, 5744, 5744+15, 0, 1, "outSine")
-- chart:addAnim(l2, "rotate", 5744, 5744 + 15, 20, 20, 13)
-- chart:flashOnce(l3, 5744, 5744+15, 0, 1, "outSine")
-- chart:addAnim(l3, "rotate", 5744, 5744 + 15, 20, 20, 13)
-- chart:flashOnce(l4, 5744, 5744+15, 0, 1, "outSine")
-- chart:addAnim(l4, "rotate", 5744, 5744 + 15, 20, 20, 13)
-- -- 5760 ~+16 Lines flash again but with 110 rotation
-- chart:flashOnce(l1, 5760, 5760+16, 0, 1, "outSine")
-- chart:addAnim(l1, "rotate", 5760, 5760 + 16, 110, 110, 13)
-- chart:flashOnce(l2, 5760, 5760+16, 0, 1, "outSine")
-- chart:addAnim(l2, "rotate", 5760, 5760 + 16, 110, 110, 13)
-- chart:flashOnce(l3, 5760, 5760+16, 0, 1, "outSine")
-- chart:addAnim(l3, "rotate", 5760, 5760 + 16, 110, 110, 13)
-- chart:flashOnce(l4, 5760, 5760+16, 0, 1, "outSine")
-- chart:addAnim(l4, "rotate", 5760, 5760 + 16, 110, 110, 13)
-- -- 5776 ~+16: Line 1 <-> 3, Line 2 <-> 4
-- chart:addAnim(l1, "move", 5776, 5776 + 16, {0.3, 0.25}, {0.6, 0.625}, "outCubic")
-- chart:addAnim(l3, "move", 5776, 5776 + 16, {0.6, 0.625}, {0.3, 0.25}, "outCubic")
-- chart:addAnim(l4, "move", 5776, 5776 + 16, {0.7, 0.75}, {0.4, 0.375}, "outCubic")
-- chart:addAnim(l2, "move", 5776, 5776 + 16, {0.4, 0.375}, {0.7, 0.75}, "outCubic")
-- -- 5800 period 8 ~+8 flash 4 lines
-- chart:flashOnce(l1, 5800, 5800+16, 0, 1, "inSine")
-- chart:flashOnce(l2, 5808, 5808+16, 0, 1, "inSine")
-- chart:flashOnce(l3, 5816, 5816+16, 0, 1, "inSine")
-- chart:flashOnce(l4, 5824, 5824+16, 0, 1, "inSine")
-- -- 5840 ~ 5888 period 8 change rotate value
-- local a, b
-- math.randomseed(1)
-- for t = 5840, 5888, 8 do
--     a = math.random(0, 179)
--     b = math.random(0, 179)
--     chart:addNode(l1, "rotate", t, a, 13)
--     chart:addNode(l2, "rotate", t, b, 13)
--     chart:addNode(l3, "rotate", t, b, 13)
--     chart:addNode(l4, "rotate", t, a, 13)
-- end
-- -- 5912 ~ 5952 Line 1 towards {0.5, 0.5}, 0
-- local a0 = a + math.random(240, 300)
-- chart:addAnim(l1, "rotate", 5912, 5952, a, a0, "inOutCubic")
-- chart:addAnim(l1, "move", 5912, 5952, {0.6, 0.625}, {0.5, 0.5}, "inOutCubic")
-- -- 5920 ~ 5952 Line 2
-- local b0 = b + math.random(240, 300)
-- chart:addAnim(l2, "rotate", 5920, 5952, b, b0, "inOutCubic")
-- chart:addAnim(l2, "move", 5920, 5952, {0.7, 0.75}, {0.5, 0.5}, "inOutCubic")
-- -- 5928 ~ 5952 Line 3
-- chart:addAnim(l3, "rotate", 5928, 5952, b, b0 + 20, "inOutCubic")
-- chart:addAnim(l3, "move", 5928, 5952, {0.3, 0.25}, {0.5, 0.5}, "inOutCubic")
-- -- 5936 ~ 5952 Line 4 
-- chart:addAnim(l4, "rotate", 5936, 5952, a, a0 + 20, "inOutCubic")
-- chart:addAnim(l4, "move", 5936, 5952, {0.4, 0.375}, {0.5, 0.5}, "inOutCubic")
-- -- 5976 ~ 6000 Line 1 and 3 dim, 6000 ~ 6016 bright, 6016 then dim
-- chart:addAnim(l1, "alpha", 5976, 6000, 0.3, 1, "zero")
-- chart:addAnim(l1, "alpha", 6000, 6016, 1, 0.3, "zero")
-- chart:addAnim(l3, "alpha", 5976, 6000, 0.3, 1, "zero")
-- chart:addAnim(l3, "alpha", 6000, 6016, 1, 0.3, "zero")

-- chart:addAnim(l2, "alpha", 5976, 6000, 1, 0.3, "zero")
-- chart:addAnim(l4, "alpha", 5976, 6000, 1, 0.3, "zero")
-- -- 6016 ~ 6048 4 lines go to bottom
-- chart:addAnim(l1, "rotate", 6016, 6048, a0, 0,      "outSine")
-- chart:addAnim(l2, "rotate", 6016, 6048, b0, 0,      "outSine")
-- chart:addAnim(l3, "rotate", 6016, 6048, b0 + 20, 0, "outSine")
-- chart:addAnim(l4, "rotate", 6016, 6048, a0 + 20, 0, "outSine")
-- chart:addAnim(l1, "move",   6016, 6048, {0.5, 0.5}, {0.5, 0.15}, "outSine")
-- chart:addAnim(l2, "move",   6016, 6048, {0.5, 0.5}, {0.5, 0.15}, "outSine")
-- chart:addAnim(l3, "move",   6016, 6048, {0.5, 0.5}, {0.5, 0.15}, "outSine")
-- chart:addAnim(l4, "move",   6016, 6048, {0.5, 0.5}, {0.5, 0.15}, "outSine")
-- -- 6048 ~ 6080 4 lines go up respectively, and flash
-- chart:addAnim(l1, "move", 6048, 6080, {0.5, 0.15}, {0.5, 0.8}, "outCubic")
-- chart:addAnim(l2, "move", 6048, 6080, {0.5, 0.15}, {0.5, 0.6}, "outCubic")
-- chart:addAnim(l3, "move", 6048, 6080, {0.5, 0.15}, {0.5, 0.4}, "outCubic")
-- chart:addAnim(l4, "move", 6048, 6080, {0.5, 0.15}, {0.5, 0.2}, "outCubic")
-- chart:addAnim(l1, "alpha", 6048, 6079, 1, 0.2, "inSine")
-- chart:addAnim(l2, "alpha", 6048, 6079, 1, 0.2, "inSine")
-- chart:addAnim(l3, "alpha", 6048, 6079, 1, 0.2, "inSine")
-- chart:addAnim(l4, "alpha", 6048, 6079, 1, 0.2, "inSine")

-- -- 6080 ~ 6104 Line 1, 2 merge together, and flashes
-- chart:flashOnce(l1, 6080, 6104, 1, 0.9, "linear")
-- chart:flashOnce(l2, 6080, 6104, 1, 0.9, "linear")
-- chart:addAnim(l1, "move", 6080, 6104, {0.5, 0.8}, {0.5, 0.7}, "outCubic")
-- chart:addAnim(l2, "move", 6080, 6104, {0.5, 0.6}, {0.5, 0.7}, "outCubic")
-- -- 6088 ~ 6104 Line 1, 2 merge together
-- chart:flashOnce(l3, 6088, 6104, 1, 0.9, "linear")
-- chart:flashOnce(l4, 6088, 6104, 1, 0.9, "linear")
-- chart:addAnim(l3, "move", 6088, 6104, {0.5, 0.4}, {0.5, 0.3}, "outCubic")
-- chart:addAnim(l4, "move", 6088, 6104, {0.5, 0.2}, {0.5, 0.3}, "outCubic")
-- -- 6104 ~ 6128 Line 2, 3 centered and dimmed
-- chart:addAnim(l2, "move", 6104, 6128, {0.5, 0.7}, {0.5, 0.5}, "outCubic")
-- chart:addAnim(l3, "move", 6104, 6128, {0.5, 0.3}, {0.5, 0.5}, "outCubic")
-- chart:addAnim(l2, "alpha", 6104, 6128, 0.9, 0.2, "inSine")
-- chart:addAnim(l3, "alpha", 6104, 6128, 0.9, 0.2, "inSine")
-- -- 6128 ~ 6144 Line 1, 4 centered and dimmed
-- chart:addAnim(l1, "move",  6128, 6144, {0.5, 0.7}, {0.5, 0.5}, "outCubic")
-- chart:addAnim(l4, "move",  6128, 6144, {0.5, 0.3}, {0.5, 0.5}, "outCubic")
-- chart:addAnim(l1, "alpha", 6128, 6144, 0.9, 0.2, "inSine")
-- chart:addAnim(l4, "alpha", 6128, 6144, 0.9, 0.2, "inSine")
-- -- 6144 ~ 6272 rotate!
-- chart:addAnim(l1, "rotate", 6144, 6272, -360, 0, "outCubic")
-- chart:addAnim(l2, "rotate", 6144, 6272, -360, 0, "outSine")
-- chart:addAnim(l3, "rotate", 6144, 6272, -360, 0, "inSine")
-- chart:addAnim(l4, "rotate", 6144, 6272, -360, 0, "inCubic")
-- chart:addAnim(l1, "alpha",  6144, 6208, 0.2, 1, "outSine")
-- chart:addAnim(l2, "alpha",  6144, 6208, 0.2, 1, "outSine")
-- chart:addAnim(l3, "alpha",  6144, 6208, 0.2, 1, "outSine")
-- chart:addAnim(l4, "alpha",  6144, 6208, 0.2, 1, "outSine")
-- chart:addAnim(l1, "alpha",  6208, 6272, 1, 0.2, "inSine")
-- chart:addAnim(l2, "alpha",  6208, 6272, 1, 0.2, "inSine")
-- chart:addAnim(l3, "alpha",  6208, 6272, 1, 0.2, "inSine")
-- chart:addAnim(l4, "alpha",  6208, 6272, 1, 0.2, "inSine")
-- -- 6272 ~+16 Line 1 travels to target place
-- chart:addAnim(l1, "alpha", 6272, 6272+16, 0.2, 0.7, "outSine")
-- chart:addAnim(l1, "move", 6272, 6272+16, {0.5, 0.5}, {0.25, 0.5}, "outCubic")
-- chart:addAnim(l1, "rotate", 6272, 6272+16, 0, 80, "outCubic")
-- -- 6296 ~+16 Line 2 travels to target place
-- chart:addAnim(l2, "alpha", 6296, 6296+16, 0.2, 0.7, "outSine")
-- chart:addAnim(l2, "move", 6296, 6296+16, {0.5, 0.5}, {0.25, 0.5}, "outCubic")
-- chart:addAnim(l2, "rotate", 6296, 6296+16, 0, 100, "outCubic")
-- -- 6320 ~+16 Line 3 travels to target place
-- chart:addAnim(l3, "alpha", 6320, 6320+16, 0.2, 0.7, "outSine")
-- chart:addAnim(l3, "move",  6320, 6320+16, {0.5, 0.5}, {0.75, 0.5}, "outCubic")
-- chart:addAnim(l3, "rotate",6320, 6320+16, 0, 80, "outCubic")
-- -- 6336 ~+16 Line 2 travels to target place
-- chart:addAnim(l4, "alpha", 6336, 6336+16, 0.2, 0.7, "outSine")
-- chart:addAnim(l4, "move",  6336, 6336+16, {0.5, 0.5}, {0.75, 0.5}, "outCubic")
-- chart:addAnim(l4, "rotate",6336, 6336+16, 0, 100, "outCubic")
-- -- 6360 Lines off
-- chart:addAnim(l1, "alpha", 6352, 6360, 0.7, 0, "outSine")
-- chart:addAnim(l2, "alpha", 6352, 6360, 0.7, 0, "outSine")
-- chart:addAnim(l3, "alpha", 6352, 6360, 0.7, 0, "outSine")
-- chart:addAnim(l4, "alpha", 6352, 6360, 0.7, 0, "outSine")

-- local left = {{16, 17}, {18, 19}, {l1, l2}}
-- local right = {{20, 21}, {22, 23}, {l3, l4}}
-- local t = 6368
-- local ptr = 0

-- while t < 6496 do
--     ptr = ptr + 1
--     if ptr > #left then ptr = 1 end
--     chart:addAnim(left[ptr][1], "alpha",   t, t + 47, 0, 1, "linear")
--     chart:addAnim(left[ptr][2], "alpha",   t, t + 47, 0, 1, "linear")
--     chart:addAnim(left[ptr][1], "move",    t, t + 47, {0.4, 0.5}, {-0.1, 0.5}, "inSine")
--     chart:addAnim(left[ptr][2], "move",    t, t + 47, {0.4, 0.5}, {-0.1, 0.5}, "inSine")
--     chart:addAnim(left[ptr][1], "rotate",  t, t + 47, 80, 80, "zero")
--     chart:addAnim(left[ptr][2], "rotate",  t, t + 47, 100, 100, "zero")
--     chart:addAnim(right[ptr][1], "alpha",  t, t + 47, 0, 1, "linear")
--     chart:addAnim(right[ptr][2], "alpha",  t, t + 47, 0, 1, "linear")
--     chart:addAnim(right[ptr][1], "move",   t, t + 47, {0.6, 0.5}, {1.1, 0.5}, "inSine")
--     chart:addAnim(right[ptr][2], "move",   t, t + 47, {0.6, 0.5}, {1.1, 0.5}, "inSine")
--     chart:addAnim(right[ptr][1], "rotate", t, t + 47, 80, 80, "zero")
--     chart:addAnim(right[ptr][2], "rotate", t, t + 47, 100, 100, "zero")
--     t = t + 16
-- end

-- t = 6544

-- while t < 7488 do
--     ptr = ptr + 1
--     if ptr > #left then ptr = 1 end
--     chart:addAnim(left[ptr][1], "alpha",   t, t + 62, 0, 0.7, "linear")
--     chart:addAnim(left[ptr][2], "alpha",   t, t + 62, 0, 0.7, "linear")
--     chart:addAnim(left[ptr][1], "move",    t, t + 62, {0.3, 0.5}, {-0.1, 0.5}, "inSine")
--     chart:addAnim(left[ptr][2], "move",    t, t + 62, {0.3, 0.5}, {-0.1, 0.5}, "inSine")
--     chart:addAnim(left[ptr][1], "rotate",  t, t + 62, 80, 80, "zero")
--     chart:addAnim(left[ptr][2], "rotate",  t, t + 62, 100, 100, "zero")
--     chart:addAnim(right[ptr][1], "alpha",  t, t + 62, 0, 0.7, "linear")
--     chart:addAnim(right[ptr][2], "alpha",  t, t + 62, 0, 0.7, "linear")
--     chart:addAnim(right[ptr][1], "move",   t, t + 62, {0.7, 0.5}, {1.1, 0.5}, "inSine")
--     chart:addAnim(right[ptr][2], "move",   t, t + 62, {0.7, 0.5}, {1.1, 0.5}, "inSine")
--     chart:addAnim(right[ptr][1], "rotate", t, t + 62, 80, 80, "zero")
--     chart:addAnim(right[ptr][2], "rotate", t, t + 62, 100, 100, "zero")
--     t = t + 21
-- end

-- chart:addNode(l3, "alpha", 7552, 0, "zero")
-- chart:addNode(l4, "alpha", 7552, 0, "zero")
-- chart:addNode(l1, "rotate", 7552, 0, "zero")
-- chart:addNode(l2, "rotate", 7552, 0, "zero")
-- chart:addNode(l3, "rotate", 7552, 0, "zero")
-- chart:addNode(l4, "rotate", 7552, 0, "zero")
-- chart:addAnim(l1, "move", 7552, 7552+32, {0.5, 0.2}, {0.5, 0.8}, "outSine")
-- chart:addAnim(l2, "move", 7552, 7552+32, {0.5, 0.2}, {0.5, 0.5}, "outSine")
-- chart:addAnim(l1, "alpha", 7552, 8000-32, 1, 0, "outSine")
-- chart:addAnim(l2, "alpha", 7552, 8000-32, 1, 0, "outSine")
-- chart:addAnim(l3, "move",  7808, 7808+32, {0.5, 0.2}, {0.5, 0.6}, "outSine")
-- chart:addAnim(l4, "move",  7808, 7808+32, {0.5, 0.2}, {0.5, 0.4}, "outSine")
-- chart:addAnim(l3, "alpha", 7808, 8000, 1, 0, "outSine")
-- chart:addAnim(l4, "alpha", 7808, 8000, 1, 0, "outSine")

-- local tlist = {8064, 8072, 8080, 8096, 8104, 8120, 8128, 8144, 8152, 8160, 8168, 8176, 8184, 8192}
-- for i = 1, #tlist - 1 do
--     chart:addAnim(l1, "alpha", tlist[i], tlist[i+1] - 1, 1, 0.4, "linear")
--     local function getRandomState() return {math.random(), math.random()}, math.random(0, 179) end
--     local pos, ang = getRandomState()
--     chart:addNode(l1, "move", tlist[i], pos, "zero")
--     chart:addNode(l1, "rotate", tlist[i], ang, "zero")
-- end
-- chart:addNode(l1, "alpha", 8193, 0, "zero")

-- tlist = {10368, 10376, 10384, 10416, 10424, 10432, 10464, 10472, 10480, 10496, 10520, 10544}
-- for i = 16, 23 do
--     chart:removeNodes(i, 10368, 10544, "alpha")
--     for j = 1, #tlist do
--         chart:addAnim(i, "alpha", tlist[j], tlist[j] + 7, 1, 0.3, "linear")
--     end
-- end


-- for i = 16, 23 do
--     chart:removeNodes(i, 5376, 5376+64, "alpha")
--     chart:addAnim(i, "alpha", 5376, 5376 + 15, 0, 0, 1)
--     chart:addAnim(i, "alpha", 5376 + 16, 5376 + 31, 0, 0, 1)
--     chart:addAnim(i, "alpha", 5376 + 32, 5376 + 47, 0, 0, 1)
--     chart:addAnim(i, "alpha", 5376 + 48, 5376 + 63, 0, 0, 1)

--     chart:removeNodes(i, 2304, 2432, "alpha")
--     chart:addAnim(i, "alpha", 2304, 2432, 0, 0, 13)

--     chart:removeNodes(i, 1824, 1856, "alpha")
--     chart:flashOnce(i, 1824, 1824+8, 1, 0, 3)
--     chart:flashOnce(i, 1840, 1840+7, 1, 0, 3)
--     chart:flashOnce(i, 1848, 1848+8, 1, 0, 3)
-- end

-- local t = 8576
-- local action = 9
-- chart:autoMarkVanity()
-- while t < 12680 do
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
--         t = t + 40
--         action = 9
--     else
--         t = t + 39
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
