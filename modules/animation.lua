local json = require("libs.json")

local Animation = {
    __kunedit = {
        version = 1,
        author = "Kunologist",
        description = "Basic animation utilities."
    },
    functions = {}
}

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

function Animation.functions.addNode(chart, lineId, animationType, startTime, startValue, easeType)
    local l = chart.data.judgeLineList[lineId]
    if l then
        if animationType == 1 or animationType == "alpha" then
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
    else
    
    end

end

function Animation.functions.autoMarkVanity(chart)
    for i = 1, #chart.data.judgeLineList do
        local thisLine = chart.data.judgeLineList[i]
        if thisLine.numOfNotes == 0 then
            thisLine.vanity = true
            print("Marked line ".. i .. " as vanity line")
        end
    end
end

function Animation.functions.isVanityLine(chart, lineId)
    if chart.data.judgeLineList[lineId] and #chart.data.judgeLineList[lineId].numOfNotes == 0 then
        return true
    else
        return false
    end
end

function Animation.functions.addAnim(chart, lineId, animationType, startTime, endTime, startValue, endValue, easeType, resetDelay, resetSwitch)
    if chart.data.judgeLineList[lineId] and chart.data.judgeLineList[lineId].vanity then
        local l = chart.data.judgeLineList[lineId]
        if animationType == 1 or animationType == "alpha" then
            -- Check if the whole place is empty
            local tmin = math.max(0, startTime - (resetDelay or 0))
            local tmax = endTime + (resetDelay or 0)
            for j = 1, #l.judgeLineDisappearEvents do
                if l.judgeLineDisappearEvents[j]['startTime'] >= tmin and l.judgeLineDisappearEvents[j]['startTime'] <= tmax then
                    error("Cannot add animation because other nodes exist")
                end
            end
            if resetDelay and resetDelay > 0 then
                if not(resetSwitch) then resetSwitch = {1, 1} end
                -- Create invisible node to make the line invisible before
                if resetSwitch[1] then
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
                end
                if resetSwitch[2] then
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
                end
            end
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
            table.sort(l.judgeLineDisappearEvents, function(a, b) return a.startTime < b.startTime end)
        elseif animationType == 2 or animationType == "move" then
            -- Check if the whole place is empty
            local tmin = math.max(0, startTime - (resetDelay or 0))
            local tmax = endTime + (resetDelay or 0)
            for j = 1, #l.judgeLineMoveEvents do
                if l.judgeLineMoveEvents[j]['startTime'] >= tmin and l.judgeLineMoveEvents[j]['startTime'] <= tmax then
                    error("Cannot add animation because other nodes exist")
                end
            end
            if resetDelay and resetDelay > 0 then
                if not(resetSwitch) then resetSwitch = {1, 1} end
                -- Create invisible node to make the line invisible before
                if resetSwitch[1] then
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
                end
                if resetSwitch[2] then
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
                end
            end
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
            table.sort(l.judgeLineMoveEvents, function(a, b) return a.startTime < b.startTime end)
        elseif animationType == 3 or animationType == "rotate" then
            -- Check if the whole place is empty
            local tmin = math.max(0, startTime - (resetDelay or 0))
            local tmax = endTime + (resetDelay or 0)
            for j = 1, #l.judgeLineRotateEvents do
                if l.judgeLineRotateEvents[j]['startTime'] >= tmin and l.judgeLineRotateEvents[j]['startTime'] <= tmax then
                    error("Cannot add animation because other nodes exist")
                end
            end
            if resetDelay and resetDelay > 0 then
                if not(resetSwitch) then resetSwitch = {1, 1} end
                -- Create invisible node to make the line invisible before
                if resetSwitch[1] then
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
                end
                if resetSwitch[2] then
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
                end
            end
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
            table.sort(l.judgeLineRotateEvents, function(a, b) return a.startTime < b.startTime end)
        else
            error("Argument 'animationType' must be either 1, 2, 3, 'alpha', 'move' or 'rotate'")
        end
    else
        error("The line does not exist, or is not a vanity line")
    end
end

function Animation.functions.autoAddAnim(chart, animationType, startTime, endTime, startValue, endValue, easeType, resetDelay)
    for i = 1, #chart.data.judgeLineList do
        if chart.data.judgeLineList[i]['vanity'] then
            local isSuccess = pcall(function()
                Animation.functions.addAnim(chart, i, animationType, startTime, endTime, startValue, endValue, easeType, resetDelay)
            end)
            if isSuccess then
                print("Animation added on line "..i)
                return
            else
                -- print(string.format("Attempted to add animation on line %d but failed. Retrying...", i))
            end
        end
    end
    print(string.format("All attempts failed, creating new vanity line"))
    Animation.functions.addVanityLine(chart, chart.data.judgeLineList[1]['bpm'])
    local isSuccess = pcall(function()
        Animation.functions.addAnim(chart, #chart.data.judgeLineList, animationType, startTime, endTime, startValue, endValue, easeType, resetDelay)
    end)
    if isSuccess then
        print("Animation added on a new line")
        return
    else
        error("Failed to add animation, please check your syntax")
    end

end

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
