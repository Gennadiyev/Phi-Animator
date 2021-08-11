local json = require("libs.json")
local easing = require("libs.lerp")

local Animation = {
    __kunedit = {
        version = 1,
        author = "Kunologist",
        description = "Basic animation utilities."
    },
    functions = {}
}

-- Documented
Animation.functions.addVanityLine = function(chart, bpm)
    assert(type(bpm) == "number", "Argument 'bpm' must be a number")
    local emptyLine = json.decode([[
        {
            "numOfNotes": 0,
            "numOfNotesAbove": 0,
            "numOfNotesBelow": 0,
            "bpm": 0.0,
            "speedEvents": [],
            "notesAbove": [],
            "notesBelow": [],
            "judgeLineDisappearEvents": [],
            "judgeLineMoveEvents": [],
            "judgeLineRotateEvents": []
        }
    ]])
    emptyLine.bpm = bpm
    emptyLine.vanity = true
    chart.data.judgeLineList[#chart.data.judgeLineList+1] = emptyLine
end

-- Documented
function Animation.functions.addNode(chart, lineId, animationType, startTime, startValue, easeType)
    assert(chart.data.judgeLineList[lineId] and chart.data.judgeLineList[lineId].vanity, "Line does not exist or is not a vanity line")
    if type(easeType) == "string" then
        easeType = easing[easeType] or easeType
    end
    assert(type(easeType) == "number", "Undefined ease type "..easeType)
    local l = chart.data.judgeLineList[lineId]
    if animationType == 1 or animationType == "alpha" then
        for j = 1, #l.judgeLineDisappearEvents do
            if l.judgeLineDisappearEvents[j]['startTime'] == startTime then
                error("Cannot add animation because nodes overlap")
            end
        end
        l.judgeLineDisappearEvents[#l.judgeLineDisappearEvents+1] = {
            ['startTime']  = startTime,
            ['endTime']    = 0,
            ['start']      = startValue,
            ['end']        = 0,
            ['start2']     = 0,
            ['end2']       = 0,
            ['easeType']   = easeType,
            ['easeType2']  = 0,
            ['useEndNode'] = false
        }
        table.sort(l.judgeLineDisappearEvents, function(a, b) return a.startTime < b.startTime end)
    elseif animationType == 2 or animationType == "move" then
        for j = 1, #l.judgeLineMoveEvents do
            if l.judgeLineMoveEvents[j]['startTime'] == startTime then
                error("Cannot add animation because nodes overlap")
            end
        end
        l.judgeLineMoveEvents[#l.judgeLineMoveEvents+1] = {
            ['startTime']  = startTime,
            ['endTime']    = 0,
            ['start']      = startValue[1],
            ['end']        = 0.5,
            ['start2']     = startValue[2],
            ['end2']       = 0.5,
            ['easeType']   = easeType,
            ['easeType2']  = easeType,
            ['useEndNode'] = false
        }
        table.sort(l.judgeLineMoveEvents, function(a, b) return a.startTime < b.startTime end)
    elseif animationType == 3 or animationType == "rotate" then
        for j = 1, #l.judgeLineRotateEvents do
            if l.judgeLineRotateEvents[j]['startTime'] == startTime then
                error("Cannot add animation because nodes overlap")
            end
        end
        l.judgeLineRotateEvents[#l.judgeLineRotateEvents+1] = {
            ['startTime']  = startTime,
            ['endTime']    = 0,
            ['start']      = startValue,
            ['end']        = 0,
            ['start2']     = 0,
            ['end2']       = 0,
            ['easeType']   = easeType,
            ['easeType2']  = 0,
            ['useEndNode'] = false
        }
        table.sort(l.judgeLineRotateEvents, function(a, b) return a.startTime < b.startTime end)
    end
end

-- Documented
function Animation.functions.autoMarkVanity(chart)
    for i = 1, #chart.data.judgeLineList do
        local thisLine = chart.data.judgeLineList[i]
        if thisLine.numOfNotes == 0 then
            thisLine.vanity = true
            print("Marked line ".. i .. " as vanity line")
        end
    end
end

-- Documented
function Animation.functions.markVanity(chart, lineId)
    if chart.data.judgeLineList[lineId] then
        if chart.data.judgeLineList[lineId]['vanity'] then
            print("This line is already a vanity line")
        else
            print("Marked line ".. lineId .. " as vanity line")
        end
    end
end

-- Documented
function Animation.functions.addAnim(chart, lineId, animationType, startTime, endTime, startValue, endValue, easeType, resetDelay, resetSwitch)
    if chart.data.judgeLineList[lineId] and chart.data.judgeLineList[lineId].vanity then
        local l = chart.data.judgeLineList[lineId]
        if type(easeType) == "string" then
            easeType = easing[easeType] or easeType
        end
        assert(type(easeType) == "number", "Undefined ease type "..easeType)
        if animationType == 1 or animationType == "alpha" then
            -- Check if the whole place is empty
            local tmin = math.max(0, startTime - (resetDelay or 0))
            local tmax = endTime + (resetDelay or 0)
            local createStartNode, createEndNode = true, true
            for j = 1, #l.judgeLineDisappearEvents do
                if l.judgeLineDisappearEvents[j]['startTime'] >= tmin and l.judgeLineDisappearEvents[j]['startTime'] <= tmax then
                    local startOverlap = (l.judgeLineDisappearEvents[j]['startTime'] == tmin and l.judgeLineDisappearEvents[j]['start'] == startValue)
                    local endOverlap = (l.judgeLineDisappearEvents[j]['endTime'] == tmax and l.judgeLineDisappearEvents[j]['start'] == endValue)
                    if not(startOverlap) and not(endOverlap) then
                        error("Cannot add animation because other nodes exist")
                    else
                        if startOverlap then
                            createStartNode = false
                            if tmin < startTime then
                                l.judgeLineDisappearEvents[j]['easeType'] = 13
                            else
                                l.judgeLineDisappearEvents[j]['easeType'] = easeType
                            end
                        end
                        if endOverlap then
                            createEndNode = false
                            l.judgeLineDisappearEvents[j]['easeType'] = 13
                        end
                    end
                end
            end
            if resetDelay and resetDelay > 0 then
                if not(resetSwitch) then resetSwitch = {1, 1} end
                -- Create invisible node to make the line invisible before
                if resetSwitch[1] then
                    if createStartNode then
                        l.judgeLineDisappearEvents[#l.judgeLineDisappearEvents+1] = {
                            ['startTime']  = tmin,
                            ['endTime']    = 0,
                            ['start']      = 0,
                            ['end']        = 0,
                            ['start2']     = 0,
                            ['end2']       = 0,
                            ['easeType']   = 13,
                            ['easeType2']  = 0,
                            ['useEndNode'] = false
                        }
                    else
                        createStartNode = true
                    end
                end
                if resetSwitch[2] then
                    if createEndNode then
                        -- Hide the line once again after resetDelay
                        l.judgeLineDisappearEvents[#l.judgeLineDisappearEvents+1] = {
                            ['startTime']  = tmax,
                            ['endTime']    = 0,
                            ['start']      = 0,
                            ['end']        = 0,
                            ['start2']     = 0,
                            ['end2']       = 0,
                            ['easeType']   = 13,
                            ['easeType2']  = 0,
                            ['useEndNode'] = false
                        }
                    else
                        createEndNode = true
                    end
                end
            end
            if createStartNode then
                -- Create node 1
                l.judgeLineDisappearEvents[#l.judgeLineDisappearEvents+1] = {
                    ['startTime']  = startTime,
                    ['endTime']    = 0,
                    ['start']      = startValue,
                    ['end']        = 0,
                    ['start2']     = 0,
                    ['end2']       = 0,
                    ['easeType']   = easeType,
                    ['easeType2']  = 0,
                    ['useEndNode'] = false
                }
            end
            if createEndNode then
                -- Create node 2
                l.judgeLineDisappearEvents[#l.judgeLineDisappearEvents+1] = {
                    ['startTime']  = endTime,
                    ['endTime']    = 0,
                    ['start']      = endValue,
                    ['end']        = 0,
                    ['start2']     = 0,
                    ['end2']       = 0,
                    ['easeType']   = 13,
                    ['easeType2']  = 0,
                    ['useEndNode'] = false
                }
            end
            table.sort(l.judgeLineDisappearEvents, function(a, b) return a.startTime < b.startTime end)
        elseif animationType == 2 or animationType == "move" then
            local epseq = function(a, b)
                return math.abs(a-b) < 1e-3
            end
            -- Check if the whole place is empty
            local tmin = math.max(0, startTime - (resetDelay or 0))
            local tmax = endTime + (resetDelay or 0)
            local createStartNode, createEndNode = true, true
            for j = 1, #l.judgeLineMoveEvents do
                if l.judgeLineMoveEvents[j]['startTime'] >= tmin and l.judgeLineMoveEvents[j]['startTime'] <= tmax then
                    local startOverlap = (l.judgeLineMoveEvents[j]['startTime'] == tmin and epseq(l.judgeLineMoveEvents[j]['start'], startValue[1]) and epseq(l.judgeLineMoveEvents[j]['start2'], startValue[2]))
                    local endOverlap = (l.judgeLineMoveEvents[j]['endTime'] == tmax and epseq(l.judgeLineMoveEvents[j]['start'], endValue[1]) and epseq(l.judgeLineMoveEvents[j]['start2'], endValue[2]))
                    if not(startOverlap) and not(endOverlap) then
                        error("Cannot add animation because other nodes exist")
                    else
                        if startOverlap then
                            createStartNode = false
                            if tmin < startTime then
                                l.judgeLineMoveEvents[j]['easeType'] = 13
                                l.judgeLineMoveEvents[j]['easeType2'] = 13
                            else
                                l.judgeLineMoveEvents[j]['easeType'] = easeType
                                l.judgeLineMoveEvents[j]['easeType2'] = easeType
                            end
                        end
                        if endOverlap then
                            createEndNode = false
                            l.judgeLineMoveEvents[j]['easeType'] = 13
                            l.judgeLineMoveEvents[j]['easeType2'] = 13
                        end
                    end
                end
            end
            if resetDelay and resetDelay > 0 then
                if not(resetSwitch) then resetSwitch = {1, 1} end
                -- Create invisible node to make the line invisible before
                if resetSwitch[1] then
                    if createStartNode then
                        l.judgeLineDisappearEvents[#l.judgeLineDisappearEvents+1] = {
                            ['startTime']  = tmin,
                            ['endTime']    = 0,
                            ['start']      = 0,
                            ['end']        = 0,
                            ['start2']     = 0,
                            ['end2']       = 0,
                            ['easeType']   = 13,
                            ['easeType2']  = 13,
                            ['useEndNode'] = false
                        }
                    else
                        createStartNode = true
                    end
                end
                if resetSwitch[2] then
                    if createEndNode then
                        -- Hide the line once again after resetDelay
                        l.judgeLineDisappearEvents[#l.judgeLineDisappearEvents+1] = {
                            ['startTime']  = tmax,
                            ['endTime']    = 0,
                            ['start']      = 0,
                            ['end']        = 0,
                            ['start2']     = 0,
                            ['end2']       = 0,
                            ['easeType']   = 13,
                            ['easeType2']  = 13,
                            ['useEndNode'] = false
                        }
                    else
                        createEndNode = true
                    end
                end
            end
            if createStartNode then
                -- Create node 1
                l.judgeLineMoveEvents[#l.judgeLineMoveEvents+1] = {
                    ['startTime']  = startTime,
                    ['endTime']    = 0,
                    ['start']      = startValue[1],
                    ['end']        = endValue[1],
                    ['start2']     = startValue[2],
                    ['end2']       = endValue[2],
                    ['easeType']   = easeType,
                    ['easeType2']  = easeType,
                    ['useEndNode'] = false
                }
            end
            if createEndNode then
                -- Create node 2
                l.judgeLineMoveEvents[#l.judgeLineMoveEvents+1] = {
                    ['startTime']  = endTime,
                    ['endTime']    = 0,
                    ['start']      = endValue[1],
                    ['end']        = endValue[1],
                    ['start2']     = endValue[2],
                    ['end2']       = endValue[2],
                    ['easeType']   = 13,
                    ['easeType2']  = 13,
                    ['useEndNode'] = false
                }
            end
            table.sort(l.judgeLineMoveEvents, function(a, b) return a.startTime < b.startTime end)
        elseif animationType == 3 or animationType == "rotate" then
            -- Check if the whole place is empty
            local tmin = math.max(0, startTime - (resetDelay or 0))
            local tmax = endTime + (resetDelay or 0)
            local createStartNode, createEndNode = true, true
            for j = 1, #l.judgeLineRotateEvents do
                if l.judgeLineRotateEvents[j]['startTime'] >= tmin and l.judgeLineRotateEvents[j]['startTime'] <= tmax then
                    local startOverlap = (l.judgeLineRotateEvents[j]['startTime'] == tmin and l.judgeLineRotateEvents[j]['start'] == startValue)
                    local endOverlap = (l.judgeLineRotateEvents[j]['endTime'] == tmax and l.judgeLineRotateEvents[j]['start'] == endValue)
                    if not(startOverlap) and not(endOverlap) then
                        error("Cannot add animation because other nodes exist")
                    else
                        if startOverlap then
                            createStartNode = false
                            if tmin < startTime then
                                l.judgeLineRotateEvents[j]['easeType'] = 13
                            else
                                l.judgeLineRotateEvents[j]['easeType'] = easeType
                            end
                        end
                        if endOverlap then
                            createEndNode = false
                            l.judgeLineRotateEvents[j]['easeType'] = 13
                        end
                    end
                end
            end
            if resetDelay and resetDelay > 0 then
                if not(resetSwitch) then resetSwitch = {1, 1} end
                -- Create invisible node to make the line invisible before
                if resetSwitch[1] then
                    if createStartNode then
                        l.judgeLineDisappearEvents[#l.judgeLineDisappearEvents+1] = {
                            ['startTime']  = tmin,
                            ['endTime']    = 0,
                            ['start']      = 0,
                            ['end']        = 0,
                            ['start2']     = 0,
                            ['end2']       = 0,
                            ['easeType']   = 13,
                            ['easeType2']  = 0,
                            ['useEndNode'] = false
                        }
                    else
                        createStartNode = true
                    end
                end
                if resetSwitch[2] then
                    if createEndNode then
                        -- Hide the line once again after resetDelay
                        l.judgeLineDisappearEvents[#l.judgeLineDisappearEvents+1] = {
                            ['startTime']  = tmax,
                            ['endTime']    = 0,
                            ['start']      = 0,
                            ['end']        = 0,
                            ['start2']     = 0,
                            ['end2']       = 0,
                            ['easeType']   = 13,
                            ['easeType2']  = 0,
                            ['useEndNode'] = false
                        }
                    else
                        createEndNode = true
                    end
                end
            end
            if createStartNode then
                -- Create node 1
                l.judgeLineRotateEvents[#l.judgeLineRotateEvents+1] = {
                    ['startTime']  = startTime,
                    ['endTime']    = 0,
                    ['start']      = startValue,
                    ['end']        = 0,
                    ['start2']     = 0,
                    ['end2']       = 0,
                    ['easeType']   = easeType,
                    ['easeType2']  = 0,
                    ['useEndNode'] = false
                }
            end
            if createEndNode then
                -- Create node 2
                l.judgeLineRotateEvents[#l.judgeLineRotateEvents+1] = {
                    ['startTime']  = endTime,
                    ['endTime']    = 0,
                    ['start']      = endValue,
                    ['end']        = 0,
                    ['start2']     = 0,
                    ['end2']       = 0,
                    ['easeType']   = 13,
                    ['easeType2']  = 0,
                    ['useEndNode'] = false
                }
            end
            table.sort(l.judgeLineRotateEvents, function(a, b) return a.startTime < b.startTime end)
        else
            error("Argument 'animationType' must be either 1, 2, 3, 'alpha', 'move' or 'rotate'")
        end
    else
        error("The line does not exist, or is not a vanity line")
    end
end

function Animation.functions.removeNodes(chart, lineId, animationType, startTime, endTime)
    local l = chart.data.judgeLineList[lineId]
    assert(l, "The line does not exist")
    if animationType == 1 or animationType == "alpha" then
        local count = 0
        for i = #l.judgeLineDisappearEvents, 1, -1 do
            local nodeTime = l.judgeLineDisappearEvents[i]['startTime']
            if nodeTime >= startTime and nodeTime <= endTime then
                table.remove(l.judgeLineDisappearEvents, i)
                count = count + 1
            end
        end
        print("Removed "..count.." animations")
    elseif animationType == 2 or animationType == "move" then
        local count = 0
        for i = #l.judgeLineMoveEvents, 1, -1 do
            local nodeTime = l.judgeLineMoveEvents[i]['startTime']
            if nodeTime >= startTime and nodeTime <= endTime then
                table.remove(l.judgeLineMoveEvents, i)
                count = count + 1
            end
        end
        print("Removed "..count.." animations")
    elseif animationType == 3 or animationType == "rotate" then
        local count = 0
        for i = #l.judgeLineRotateEvents, 1, -1 do
            local nodeTime = l.judgeLineRotateEvents[i]['startTime']
            if nodeTime >= startTime and nodeTime <= endTime then
                table.remove(l.judgeLineRotateEvents, i)
                count = count + 1
            end
        end
        print("Removed "..count.." animations")
    end
end

-- Documented
function Animation.functions.autoAddAnim(chart, animationType, startTime, endTime, startValue, endValue, easeType, resetDelay, resetSwitch)
    for i = 1, #chart.data.judgeLineList do
        if chart.data.judgeLineList[i]['vanity'] then
            local isSuccess = pcall(function()
                Animation.functions.addAnim(chart, i, animationType, startTime, endTime, startValue, endValue, easeType, resetDelay, resetSwitch)
            end)
            if isSuccess then
                print("Animation added on line "..i)
                return i
            else
                -- print(string.format("Attempted to add animation on line %d but failed. Retrying...", i))
            end
        end
    end
    print(string.format("All attempts failed, creating new vanity line"))
    Animation.functions.addVanityLine(chart, chart.data.judgeLineList[1]['bpm'])
    local isSuccess = pcall(function()
        Animation.functions.addAnim(chart, #chart.data.judgeLineList, animationType, startTime, endTime, startValue, endValue, easeType, resetDelay, resetSwitch)
    end)
    if isSuccess then
        print("Animation added on the new line")
        return #chart.data.judgeLineList
    else
        error("Failed to add animation, please check your syntax")
    end

end

-- Documented
function Animation.functions.nodeExist(chart, lineId, animationType, startTime, endTime)
    local l = chart.data.judgeLineList[lineId]
    if l then
        if animationType == 1 or animationType == "alpha" then
            for j = 1, #l.judgeLineDisappearEvents do
                if l.judgeLineDisappearEvents[j]['startTime'] >= startTime and l.judgeLineDisappearEvents[j]['startTime'] <= endTime then
                    return true
                end
            end
            return false
        elseif animationType == 2 or animationType == "move" then
            for j = 1, #l.judgeLineMoveEvents do
                if l.judgeLineMoveEvents[j]['startTime'] >= startTime and l.judgeLineMoveEvents[j]['startTime'] <= endTime then
                    return true
                end
            end
            return false
        elseif animationType == 3 or animationType == "rotate" then
            for j = 1, #l.judgeLineRotateEvents do
                if l.judgeLineRotateEvents[j]['startTime'] >= startTime and l.judgeLineRotateEvents[j]['startTime'] <= endTime then
                    return true
                end
            end
            return false
        end
    else
        error("The line does not exist")
    end
end

return Animation
