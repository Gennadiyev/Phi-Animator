local json = require("libs.json")

local chartReader = {}

function chartReader:load(filePath)
    local f = io.open(filePath, "r")
    if f then
        local c = f:read("*a")
        local isSuccessful, c = pcall(function() return json.decode(c) end)
        assert(isSuccessful, "The chart is not a valid json file")
        local chart = {}
        chart.data = c
        if c.formatVersion ~= 2 then
            print("Be careful, you are loading an unsupported chart format: "..c.formatVersion)
        end
        chart.path = filePath
        chart.utils = {}
        setmetatable(chart, {
            __tostring = function(chart)
                local str = ""
                for k, v in pairs(chart) do
                    if type(v) == "function" then
                        str = str .. k .. ", "
                    end
                end
                if #str > 2 then
                    str = str:sub(1, -3)
                end
                return string.format("------\nChart:\n\tData=<ChartData FormatVersion=%d, NoteCount=%d, LineCount=%d>\n\tPath=%s\n\tUtils=[%s]\n------",
                    chart.data.formatVersion,
                    chart.data.numOfNotes,
                    #chart.data.judgeLineList,
                    chart.path,
                    str
                )
            end
        })
        function chart:save(path)
            if not(path) and self.path then path = self.path:sub(1, -6).."_"..tostring(os.time())..".json" end
            assert(path, "Path not specified")
            local f = io.open(path, "w+")
            f:write(json.encode(chart.data))
            f:close()
            print("Chart saved at "..path)
        end
        function chart:loadModule(module)
            if module.__kunedit then
                for funcName, func in pairs(module.functions) do
                    chart[funcName] = func
                end
            else
                error("Cannot load module")
            end
        end
        print("Chart loaded")
        return chart
    else
        error("The file does not exist")
    end
end

return chartReader
