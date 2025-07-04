#set text(font: "Microsoft YaHei", size: 14pt)

= 常量与变量

自省函数的概念，虽然没太看懂。

== 类型的自省函数

#type(1)

#type([一段内容])

#(1 == 1)

#(type("x") == type("y"))

#type("x")

#type(str)

“类型的类型是类型”（str 的类型是 type）

#type(true)

#type(true == true)

== 求值函数 `eval`

`eval` 函数接受一个字符串，将其当作代码执行。

#eval("1 + 1")

#type(eval("1 + 1"))

#eval("[一段内容]")

#type(eval("[一段内容]"))

`eval` 函数的#highlight()[解释模式]可以修改，这是通过参数实现的。

#eval("[一段内容]", mode: "code")

#eval("[一段内容]", mode: "markup") // 这是以标记模式解释内容

== 基本字面量

- 空字面量
- 布尔字面量
- 整数字面量
- 浮点数字面量
- 字符串字面量

`repr` 函数接受任意值，返回其代码表示。

#repr(1)

#repr([一段内容])

#repr("一段内容")

#repr([*好*])

#repr((0, 1).find((_) => false))

#repr((0, 1).find((_) => true))

看不懂啊，这什么意思......

看不懂啊，这什么意思……

看起来渲染效果是一致的。

#type(none == type(none))

#type(none)

#(none == type(none))

#type(none)

#type(type(none))

假设 #false 是布尔字面量。

一般来说，不推荐直接使用布尔值。当代码中出现逻辑判断时，自然就会出现布尔值。

#(1 < 2)

1 < 2 的结果是 #(1 < 2)

#(-1)

// #-1 是无法解析的，因为 Typst 不允许 # 后面直接跟随连字符。

使用括号，可以使进入脚本模式时，Typst 轻松解析任何值。

#(-2.99 + 7)

可以使用十进制、八进制、十六进制、二进制，但是在被解释是，都会转为十进制。例如：

#(-0o10)

在 Typst 中，整数的有效范围是 $-2^63$ 到 $2^63-1$，这与 `long` 的范围一致。

#(0.11)

#(.11)

#(2.)

也可以使用指数表示法。

#(1.2e4)

内置有一系列特殊值。

$inf$ = #calc.inf

$pi$ = #calc.pi

$e$ = #calc.e

诸如此类，这都是浮点数。

再来看看字符串字面量。

字符串字面量由英文双引号包裹，强制采用 UTF-8 编码。

#"Hello, world!"

#"支持任何语言"

有一些字符无法直接存在于双引号中，这时，有类似转义的语法。

#"Hello, \"wor\nld\"!"

可以直接嵌入 Unicode 字符。

#"我爱吃面\u{2665}"

可以使用 `repr` 函数来获取字符串的代码表示。

#repr("Hello, world!")

#repr(```python print()
return

```.text)

=== 类型转换

