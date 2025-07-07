#import "@preview/pointless-size:0.1.1": zh // 引入中文字号转化

// 美化代码块
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#show: codly-init.with()
#codly(zebra-fill: none)

// 设定字体、文本语言、显示模式等
#set text(font: "Microsoft YaHei", size: zh(4), lang: "zh", region: "cn")
#set par(first-line-indent: (amount: 2em, all: true)) // 设置段落首行缩进 2 字符，强制启用所有，否则第一段不会缩进
#set page(
  header: context [
    #set align(center)
    #set text(size: 0.7em)
  ],
  footer: context [
    #set align(right)
    #set text(size: 0.7em)
    #counter(page).display(
      "1 / 1",
      both: true,
    )
  ],
  fill: rgb("#fdf8f1"),
)

#let no-indent = h(-2em)

#show strong: content => {
  show regex("\p{Hani}"): it => box(place(text("·", size: 1em), dx: 0.4em, dy: 0.75em) + it)
  content.body
}

#show heading.where(depth: 1): content => {
  align(center, text(fill: rgb("bf6a6a"), content.body, size: 1.8em))
}

#show heading.where(depth: 2): content => {
  pagebreak()
  align(center, text(fill: rgb("d08770"), content.body, size: 1.7em))
}

#show heading.where(depth: 3): content => {
  align(center, text(fill: rgb("ebcb8b"), content.body, size: 1.6em))
}

#show heading.where(depth: 4): content => {
  align(center, text(fill: rgb("a3be8c"), content.body, size: 1.5em))
}

#show heading.where(depth: 5): content => {
  align(center, text(fill: rgb("5e81ac"), content.body, size: 1.4em))
}

#show heading.where(depth: 6): content => {
  align(center, text(fill: rgb("b48ead"), content.body, size: 1.3em))
}


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

没什么好说的，和其他语言差不多。

=== 浮点数陷阱

#type(2)

#type(2.)

#(type(2.) == int)

#type(200000000000000000000)

当数字足够大时，类型将变为 `float`。

#(10 / 4)

#type(10 / 4)

Typst 默认执行标准除法。

== 变量声明

#let x = "Hello, world!"

#x

== 函数声明

#let f(x, y) = [两个值 #x 和 #y 相加的值是 #(x + y)]

#f(1, 2)

== 习题

1. 计算

#calc.pow(2, 32)

2. 输出诗句（用最多 17 个汉字输出 28 字的诗句）

#let x = [一]

#let y = [渔]

#(x)帆#(x)桨#(x)#(y)舟，#(x)个#(y)翁#(x)钓钩。

#(x)俯#(x)仰#(x)场笑，#(x)江明月#(x)江秋。

用了 16 个汉字。

3. 计算斐波那契数列

这个确实不会了，日后再看吧。

4. 矩阵输出

也有点难度，可能要用到变长参数。

目前是很难掌握的。我主要需要了解一些排版样式方面的内容，涉及脚本逻辑的可以往后靠。
