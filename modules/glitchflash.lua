local animation = require("modules.animation")
assert(animation, "This module depends on module 'animation' which cannot be loaded")

local GlitchFlash = {
    __kunedit = {
        version = 1,
        author = "Kunologist",
        description = "Glitch Flash Effect by toggling alpha. Supports chance easing."
    },
    functions = {}
}

GlitchFlash.functions.flashToggle = function(chart, lineId, startTime, endTime, period, alphaOn, alphaOff, isFirstNodeOn)
    local isLineExist, hasNode = pcall(function()
        return animation.functions.nodeExist(chart, lineId, 1, startTime, endTime)
    end)
    if not(isLineExist) then
        error("The line does not exist")
    end
    if hasNode then
        error("Cannot add animation because other nodes exist")
    end
    local currentTime = startTime
    local nodeCount = 0
    while currentTime < endTime do
        if isFirstNodeOn then
            if nodeCount % 2 == 0 then
                animation.functions.addNode(chart, lineId, 1, math.floor(currentTime), alphaOn or 1, 13)
            else
                animation.functions.addNode(chart, lineId, 1, math.floor(currentTime), alphaOff or 0, 13)
            end
        else
            if nodeCount % 2 == 0 then
                animation.functions.addNode(chart, lineId, 1, math.floor(currentTime), alphaOff or 0, 13)
            else
                animation.functions.addNode(chart, lineId, 1, math.floor(currentTime), alphaOn or 1, 13)
            end
        end
        nodeCount = nodeCount + 1
        if type(period) == "number" then
            assert(period > 0, "Argument 'period' must be a positive number")
            currentTime = period + currentTime
        elseif type(period) == "function" then
            local p = period(nodeCount)
            assert(p > 0, "Argument 'period' must be a positive number")
            currentTime = period + currentTime
        elseif type(period) == "table" then
            local p = period[nodeCount]
            assert(p > 0, "Argument 'period' must be a positive number")
            currentTime = period + currentTime
        else
            error("Cannot determine period at node "..nodeCount)
        end
    end
end

GlitchFlash.functions.flashRandom = function(chart, lineId, startTime, endTime, period, chanceOn, alphaOn, alphaOff)
    local isLineExist, hasNode = pcall(function()
        return animation.functions.nodeExist(chart, lineId, 1, startTime, endTime)
    end)
    if not(isLineExist) then
        error("The line does not exist")
    end
    if hasNode then
        error("Cannot add animation because other nodes exist")
    end
    assert(type(period) == "number" and period > 0 and math.floor(period) == period, "Argument 'period' must be a positive number")
    for t = startTime, endTime, period do
        local chance = nil
        if type(chanceOn) == "function" then
            chance = chanceOn(t, 0, 1, endTime - startTime)
        elseif type(chanceOn) == "number" then
            chance = chanceOn
        end
        assert(chance, "Cannot determine chance at time "..t)
        if math.random() < chance then
            animation.functions.addNode(chart, lineId, 1, t, alphaOn or 1, 13)
        else
            animation.functions.addNode(chart, lineId, 1, t, alphaOff or 0, 13)
        end
    end
end

function GlitchFlash.functions.flashOnce(chart, lineId, startTime, endTime, alphaOn, alphaOff, easeType, resetDelay, resetSwitch)
    local isLineExist, hasNode = pcall(function()
        return animation.functions.nodeExist(chart, lineId, 1, startTime, endTime)
    end)
    if not(isLineExist) then
        error("Error: "..hasNode)
    end
    if hasNode then
        error("Cannot add animation because other nodes exist")
    end
    animation.functions.addAnim(chart, lineId, 1, startTime, endTime, alphaOn, alphaOff, easeType, resetDelay, resetSwitch)
end

return GlitchFlash
