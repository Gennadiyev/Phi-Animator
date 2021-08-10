local ChartMerge = {
    __kunedit = {
        version = 1,
        author = "Kunologist",
        description = "Merges the judgement lines of two charts"
    },
    functions = {}
}

function ChartMerge.functions.merge(baseChart, newChart, ignoreEmptyLines)
    for i = 1, #newChart.judgeLineList do
        local line = newChart.judgeLineList[i]
        if not(ignoreEmptyLines) or (line.numOfNotes > 0 or #line.judgeLineDisappearEvents > 0 or #line.judgeLineRotateEvents > 0 or line.judgeLineMoveEvents > 0) then
            baseChart.judgeLineList[#baseChart.judgeLineList+1] = newChart.judgeLineList[i]
        else
            -- ignoring this line
        end
    end
    return baseChart
end

return ChartMerge
