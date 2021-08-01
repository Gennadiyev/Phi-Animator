local json = require("json")

local animation = {
    __kunedit = {
        version = 1,
        author = "Kunologist",
        description = "Basic animation utilities"
    },
    functions = {}
}

animation.functions.addVanityLine = function(chart, bpm)
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

function animation.functions.autoMarkVanity(chart)
    for i = 1, #chart.data.judgeLineList do
        local thisLine = chart.data.judgeLineList[i]
        if thisLine.numOfNotes == 0 and #thisLine.speedEvents == 0
          and #thisLine.judgeLineMoveEvents == 0 and #thisLine.judgeLineDisappearEvents == 0
          and #thisLine.judgeLineRotateEvents == 0 then
            thisLine.vanity = true
            print("Marked line ".. i .. " as vanity line")
        end
    end
end

function animation.functions.addAnim(chart, lineId, animType, startTime, endTime, startValue, endValue, easeType, resetDelay)
    if chart.data.judgeLineList[lineId] and chart.data.judgeLineList[lineId].vanity then
        local l = chart.data.judgeLineList[lineId]
        if animType == 1 or animType == "alpha" then
            -- Check if the whole place is empty
            local tmin = math.max(0, startTime - resetDelay)
            local tmax = startTime + resetDelay
            for j = 1, #l.judgeLineDisappearEvents do
                if l.judgeLineDisappearEvents[j]['startTime'] >= tmin and l.judgeLineDisappearEvents[j]['startTime'] <= tmax then
                    error("Cannot add animation because other nodes exist") 
                end
            end
            -- Create invisible node to make the line invisible before
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
                ['startTime']  = startTime,
                ['endTime']    = 0,
                ['start']      = startValue,
                ['end']        = 0,
                ['start2']     = 0,
                ['end2']       = 0,
                ['easeType']   = 14,
                ['easeType2']  = 0,
                ['useEndNode'] = false
            }
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
            table.sort(l.judgeLineDisappearEvents, function(a, b) return a.startTime < b.startTime end)
        elseif animType == 2 or animType == "move" then
            --[[
                {
                    "startTime": 0.0,
                    "endTime": 0.0,
                    "start": 0.5,
                    "end": 0.5,
                    "start2": 0.5999999642372131,
                    "end2": 0.5999999642372131,
                    "easeType": 4,
                    "easeType2": 4,
                    "useEndNode": false
                },
            ]]
            -- Check if the whole place is empty
            local tmin = math.max(0, startTime - resetDelay)
            local tmax = startTime + resetDelay
            for j = 1, #l.judgeLineMoveEvents do
                if l.judgeLineMoveEvents[j]['startTime'] >= tmin and l.judgeLineMoveEvents[j]['startTime'] <= tmax then
                    error("Cannot add animation because other nodes exist") 
                end
            end
            -- Create invisible node to make the line invisible before
            l.judgeLineMoveEvents[#l.judgeLineMoveEvents+1] = {
                ['startTime']  = tmin,
                ['endTime']    = 0,
                ['start']      = 0.5,
                ['end']        = 0.5,
                ['start2']     = 0.5,
                ['end2']       = 0.5,
                ['easeType']   = 13,
                ['easeType2']  = 13,
                ['useEndNode'] = false
            }
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
                ['startTime']  = startTime,
                ['endTime']    = 0,
                ['start']      = endValue[1],
                ['end']        = endValue[1],
                ['start2']     = endValue[2],
                ['end2']       = endValue[2],
                ['easeType']   = 14,
                ['easeType2']  = 14,
                ['useEndNode'] = false
            }
            -- Hide the line once again after resetDelay
            l.judgeLineMoveEvents[#l.judgeLineMoveEvents+1] = {
                ['startTime']  = tmax,
                ['endTime']    = 0,
                ['start']      = 0.5,
                ['end']        = 0.5,
                ['start2']     = 0.5,
                ['end2']       = 0.5,
                ['easeType']   = 13,
                ['easeType2']  = 13,
                ['useEndNode'] = false
            }
            table.sort(l.judgeLineMoveEvents, function(a, b) return a.startTime < b.startTime end)
        elseif animType == 3 or animType == "rotate" then
            -- Check if the whole place is empty
            local tmin = math.max(0, startTime - resetDelay)
            local tmax = startTime + resetDelay
            for j = 1, #l.judgeLineRotateEvents do
                if l.judgeLineRotateEvents[j]['startTime'] >= tmin and l.judgeLineRotateEvents[j]['startTime'] <= tmax then
                    error("Cannot add animation because other nodes exist.") 
                end
            end
            -- Create invisible node to make the line invisible before
            l.judgeLineRotateEvents[#l.judgeLineRotateEvents+1] = {
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
                ['startTime']  = startTime,
                ['endTime']    = 0,
                ['start']      = startValue,
                ['end']        = 0,
                ['start2']     = 0,
                ['end2']       = 0,
                ['easeType']   = 14,
                ['easeType2']  = 0,
                ['useEndNode'] = false
            }
            -- Hide the line once again after resetDelay
            l.judgeLineRotateEvents[#l.judgeLineRotateEvents+1] = {
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
            table.sort(l.judgeLineRotateEvents, function(a, b) return a.startTime < b.startTime end)
        else
            error("Argument 'animType' not understood")
        end
    else
        error("The line does not exist, or is not a vanity line")
    end
end

function animation.functions.autoAddAnim(chart, animType, startTime, endTime, startValue, endValue, easeType, resetDelay)
    for i = 1, #chart.data.judgeLineList do
        if chart.data.judgeLineList[i]['vanity'] then
            local isSuccess = pcall(function()
                animation.functions.addAnim(chart, i, animType, startTime, endTime, startValue, endValue, easeType, resetDelay)
            end)
            if isSuccess then
                print("Succeeded")
                return
            else
                print(string.format("Attempted to add animation on line %d but failed. Retrying...", i))
            end
        end
    end
    print(string.format("All attempts failed, creating new vanity line"))
    animation.functions.addVanityLine(chart, chart.data.judgeLineList[1]['bpm'])
    local isSuccess = pcall(function()
        animation.functions.addAnim(chart, #chart.data.judgeLineList, animType, startTime, endTime, startValue, endValue, easeType, resetDelay)
    end)
    if isSuccess then
        print("Succeeded")
        return
    else
        error("Failed")
    end

end

return animation
