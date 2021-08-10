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

## 谱面解析器 `ChartReader`

## 插件 `Animation`

### 综述

这一插件的开发目的是为了让其他插件的开发更加容易。它包含了动画命令的基本实现。

在开始使用之前，请牢记：**本插件范围内，所有 `lineId`（判定线编号）都从 `1` 开始。也就是说，Phigredit 所示的编号需要 `+1` 之后就是本插件使用的编号。（这是因为 Lua 的数组下标从 `1` 开始。）**

本插件会尽力保证不与原谱面发生冲突：**原谱面中存在的动画节点如果可能与即将添加的动画发生时间冲突，那么添加会失败。**

在插件 Animation 中，引入了一个重要的概念：装饰线。简单地说，如果一根判定线上没有 Note，那么它就可以被认定为是装饰线。该插件内大多数函数都会在添加动画前确保该线属于装饰线。当然，你也可以手动强行设置某根判定线是装饰线。具体方法见下文。

被标记为装饰线的判定线具有 `vanity` 属性，值为 `true`。

### 新建装饰线

`Animation.functions.addVanityLine(chart, bpm)`

这会在谱面中添加一根新的空判定线，并且会被标记为装饰线。

| 参数 | 类型 | 含义 | 是否必须 |
| :-:  | :-:  | :-:  | :-: |
| `chart` | `Chart` | 被操作的目标谱面 | 是 |
| `bpm` | `number` | 新建判定线的 BPM | 是 |

### 自动标记判定线

`Animation.functions.autoMarkVanity(chart)`

这会将现有目标谱面的所有无 Note 判定线标记为装饰线。

| 参数 | 类型 | 含义 | 是否必须 |
| :-:  | :-:  | :-:  | :-: |
| `chart` | `Chart` | 被操作的目标谱面 | 是 |

### 强制标记装饰线

`Animation.functions.markVanity(chart, lineId)`

将谱面的第 `lineId` 根判定线强行标记为装饰线，即使它存在 Note(s)。

| 参数 | 类型 | 含义 | 是否必须 |
| :-:  | :-:  | :-:  | :-: |
| `chart` | `Chart` | 被操作的目标谱面 | 是 |
| `lineId` | `number` | 目标判定线的编号（`Phigredit 编号 + 1`） | 是 |

### 添加节点

`Animation.functions.addNode(chart, lineId, animationType, startTime, startValue, easeType)`

为谱面的第 `lineId` 根判定线添加一个指定动画类型的节点。

> 目前不支持 `useEndNode`。

| 参数 | 类型 | 含义 | 是否必须 |
| :-:  | :-:  | :-:  | :-: |
| `chart` | `Chart` | 被操作的目标谱面 | 是 |
| `lineId` | `number` | 目标判定线的编号（`Phigredit 编号 + 1`） | 是 |
| `animationType` | `number` / `string` | [动画类型](docs/animtype.md) | 是 |
| `startTime` | `number` | 节点时间 | 是 |
| `startValue` | `number` / `table` | [节点数值](docs/animparam.md) | 是 |
| `easeType` | `number` / `string` | [节点缓动类型](docs/easetype.md) | 是 |

### 添加动画事件

`Animation.functions.addAnim(chart, lineId, animationType, startTime, endTime, startValue, endValue, easeType, resetDelay, resetSwitch)`

> 该函数尝试复刻旧版本 Phigros Editor 的命令行。但是由于关键帧机制，引入了额外的 `resetDelay` 和 `resetSwitch` 确保动画稳定性。

为谱面的第 `lineId` 根判定线添加指定类型的指定动画事件，需要指定初末状态。另外提供可选的 `resetDelay` 和 `resetSwitch` 参数确保不与其他动画冲突。

> 目前不支持 `useEndNode`。

| 参数 | 类型 | 含义 | 是否必须 |
| :-:  | :-:  | :-:  | :-: |
| `chart` | `Chart` | 被操作的目标谱面 | 是 |
| `lineId` | `number` | 目标判定线的编号（`Phigredit 编号 + 1`） | 是 |
| `animationType` | `number` / `string` | [动画类型](docs/animtype.md) | 是 |
| `startTime` | `number` | 动画开始时间 | 是 |
| `endTime` | `number` | 动画结束事件 | 是 |
| `startValue` | `number` / `table` | [动画开始时参数数值](docs/animparam.md) | 是 |
| `endValue` | `number` / `table` | [动画结束时参数数值](docs/animparam.md) | 是 |
| `easeType` | `number` / `string` | [节点缓动类型](docs/easetype.md) | 是 |
| `resetDelay` | `number` | 额外添加不可见事件的前后延迟 | 否，若不提供则不添加 |
| `resetSwitch` | `table` of `boolean` | 是否添加前置节点和后置节点的开关 | 否，若不提供但 `resetDelay` 提供则默认前后都添加 |

`resetSwitch` 为一个长度为 2 的布尔数组，第一项为 `true` 则添加前置节点，若第二项为 `true` 则添加后置节点。

如果不明白 `resetDelay` 和 `resetSwitch`，可以这么理解：它可以保证动画开始前后判定线变为不可见状态。它可以确保添加新动画时不会“穿帮”，例如在判定线可见时移动位置等。

### 添加动画事件，但是我不关心添加在何处

例如你要创建一个判定线从下到上且渐隐的装饰动画。你不在乎它在哪一根判定线上被添加，只要是装饰线就都可以随意使用。此时你可以使用 `autoAddAnim` 帮你决定。

`Animation.functions.autoAddAnim(chart, animationType, startTime, endTime, startValue, endValue, easeType, resetDelay, resetSwitch)`

> 目前不支持 `useEndNode`。

| 参数 | 类型 | 含义 | 是否必须 |
| :-:  | :-:  | :-:  | :-: |
| `chart` | `Chart` | 被操作的目标谱面 | 是 |
| `animationType` | `number` / `string` | [动画类型](docs/animtype.md) | 是 |
| `startTime` | `number` | 动画开始时间 | 是 |
| `endTime` | `number` | 动画结束事件 | 是 |
| `startValue` | `number` / `table` | [动画开始时参数数值](docs/animparam.md) | 是 |
| `endValue` | `number` / `table` | [动画结束时参数数值](docs/animparam.md) | 是 |
| `easeType` | `number` / `string` | [节点缓动类型](docs/easetype.md) | 是 |
| `resetDelay` | `number` | 额外添加不可见事件的前后延迟 | 否，若不提供则不添加 |
| `resetSwitch` | `table` of `boolean` | 是否添加前置节点和后置节点的开关 | 否，若不提供但 `resetDelay` 提供则默认前后都添加 |

此时程序会自动选择一根无冲突的装饰线。如果所有现有判定线全部冲突，则会新建一根判定线。如果新建的判定线仍然无法添加动画，则会报错。

另外，本函数有一个返回值，类型为 `number`，表示动画被添加到的判定线编号。

### 检查是否有冲突

> 本函数主要目的为开放给其他插件调用。

`Animation.functions.nodeExist(chart, lineId, animationType, startTime, endTime)`

| 参数 | 类型 | 含义 | 是否必须 |
| :-:  | :-:  | :-:  | :-: |
| `chart` | `Chart` | 被操作的目标谱面 | 是 |
| `lineId` | `number` | 目标判定线的编号（`Phigredit 编号 + 1`） | 是 |
| `animationType` | `number` / `string` | [动画类型](docs/animtype.md) | 是 |
| `startTime` | `number` | 动画开始时间 | 是 |
| `endTime` | `number` | 动画结束事件 | 是 |

## 插件 `GlitchFlash`

有关 GlitchFlash 插件的使用说明正在编辑中。

## Developing your own module

请参阅英语版 `readme.md` 中的 Modules 章节。
