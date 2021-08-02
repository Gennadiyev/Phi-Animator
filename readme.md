# Phi-Animator

This script is a utility script for designing Phigros charts, meant to be used by Phigros chart designers.

To maximize the use of this script, you may need to be familiar with basics Lua syntax.

The project has [module support](#Module), so it's easy to make your own animation utilities and plug-to-use on your chart.

## Usage

```lua
-- Load the chart reader
local chartReader = require("chartreader")
-- Load the module
local animation = require("animation")
-- Parse the chart using chartReader
local chart = chartReader:load("Chart_HD.json")

-- Allow this chart to use the module
chart:loadModule(animation)

-- Design the chart with your creativity!

-- Save the chart
-- chart:save()
--[[
    This will create another chart file under the same directory as the original chart. The new file will be named with timestamp appended to the original name.
]]
-- Save as the chart
chart:save("Chart_IN.json")
--[[
    This will create another chart file under the same directory as the original chart. The new file will be named with timestamp appended to the original name.
]]
```

## Module `Animation`

(Omitted)

## Module

The whole project is coded to be module-supportive. Before you dive in, these are the summary of each file in the repository:

- `main.lua` is the driver script
- `chartreader.lua` is a chart parser script
- `json.lua` is a JSON utility script
- `lerp.lua` is a simple implementation of Phigros chart's easing types
- **`animator.lua` is a module**

**To develop a module, you should be familiar with Phigredit chart format.**

First, create a file for your module with `.lua` suffix. (e.g. `foo.lua`)

Then, create an table with `__kunedit` and fill out the meta information. *(This marks the class a module file that can be used by the editor system)*

```lua
YourModuleName = {
    __kunedit = {
        version = 1,
        author = "Kunologist",
        description = "Basic animation utilities"
    }
}
```

Finally in `YourModuleName.functions`, define the functions you'd like to create. Note that the first argument **must be the `chart`**, otherwise the behavior of the script can be undefined.

Remember to `return` your module, and import it in `main.lua`.

```lua
-- In foo.lua
return YourModuleName
```

A simple example to use your plugin:

```lua
-- In main.lua
local myModule = require("foo")
-- Load the chart
local chart = chartReader.load("Chart_EZ.json")
-- Use the module on the chart
chart:loadModule(myModule)
-- Call your functions
chart:yourFunctionName(yourArgument)
```
