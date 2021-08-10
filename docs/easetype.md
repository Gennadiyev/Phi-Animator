# 缓动类型

类型为 `string` 或 `number`，表示动画或节点缓动的类型。

在 `libs/lerp.lua` 文件内有如下对应表：

```lua
{
	linear = 0,
	inSine = 1,
	outSine = 2,
	inOutSine = 3,
	inCubic = 4,
	outCubic = 5,
	inOutCubic = 6,
	inQuint = 7,
	outQuint = 8,
	inOutQuint = 9,
	inCirc = 10,
	outCirc = 11,
	inOutCirc = 12,
	zero = 13,
	one = 14
}
```

可以随时查阅缓动类型。例如，可以使用 `"outSine"`（字符串）或者 `2`（数值）来表示 Phigredit 的 `Ease out sine` 缓动类型。

> 建议使用字符串格式保证代码可读性。
