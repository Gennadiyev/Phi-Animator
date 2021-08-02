# Phi-Animator

**本脚本工具为 Phigros 谱师制作。**

如果需要很好地使用本脚本，你需要熟悉对 Lua 的基本语法。使用 Lua 语法，你可以轻易实现同一特效的重复、迭代甚至（伪）随机动画的功能。

本工程对插件（Module）开发非常友好，如果你能够熟练使用 Lua，可以很轻易地对你的设计想法原型进行实现。具体参见英文版 `readme.md` 的 Module 章节。

即将发布的 Phigros Animator 可视化编辑器将会允许 **围绕本核心开发的插件** 进行可视化即时呈现和编辑。

## 使用方法

### 安装和运行

你需要安装任何你喜欢的 Lua 版本，但是推荐安装 `LUA_VERSION >= 5.3` 的版本。

> 版本更新对于大多数功能影响不大，但是 `math.pow` （次幂）函数在最近的版本中被弃用（Deprecated）了，取而代之的是某些旧版本 Lua 不能使用的 `^` 运算符。

**安装：** 下载本 Repository。

**运行：** 执行 `lua main.lua`。

为了实现你自己的想法和创意，你需要直接编辑 `main.lua` 文件。一份示例的文件如下：

```lua
-- 引入谱面解析器
local chartReader = require("chartreader")
-- 引入插件（animation.lua 是自带插件）
local animation = require("animation")
-- 使用解析器解析文件，注意必须指定谱面文件名，而不是工程文件名
local chart = chartReader:load("D:\\Phigros\\MyCharts\\Chart_HD.json")

-- 对该载入的谱面加载插件
chart:loadModule(animation)

-- 使用插件对你的谱面进行修改

-- 保存谱面
-- chart:save()
--[[
    保存在原有目录下，命名中会附带时间戳。
]]
-- 谱面另存为
chart:save("D:\\Phigros\\MyCharts\\Chart_IN.json")
--[[
    保存在指定目录下。
]]
```

## 插件 `Animation`

有关 Animation 插件的使用说明正在编辑中。

## Module

请参阅英语版 `readme.md` 中的 Modules 章节。
