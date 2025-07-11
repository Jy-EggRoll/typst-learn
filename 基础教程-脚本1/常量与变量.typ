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
    #set align(center)
    #set text(size: 0.7em)
    #counter(page).display(
      "第1页 / 共1页",
      both: true,
    )
  ],
  fill: rgb("#E1E1DB"),
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

Typst 非常快，不仅是因为其编译器和解释器非常高效，更是因为语言的特性适合缓存的优化。

本节将进一步学习 Typst 的特性，主要从常量和变量入手。

== 代码表示的自省函数

`#repr` 是一个「自省函数」（introspection function），可以帮你获得任意值的代码表示，很适合用来在调试代码的时候输出内容。

例如：

#repr([== 你好]) 是 ```#repr([== 你好])``` 的表示结果。

== 类型的自省函数

与 `#repr` 类似，一个特殊的函数 `#type` 可以获得任意值的「类型」（type）。所谓「类型」，就是这个值归属的分类。例如：

#type(1)

#type([一段内容])

#type(6.11)

#type("nihao")

#type(true)

#type(bool)

一个值只会属于一种类型，因此，类型是可以比较的。

#(int == int)

#(1 == 1)

#(type("x") == type("y"))

#type("x")

#type(str)

“类型的类型是类型”（str 的类型是 type，str 本身是一种类型）

#type(int)

#type(true == true)

#type(type(int))

可见，type 本身也是一种类型，目前先如此理解。

== 求值函数

`eval` 函数接受一个字符串（str 型），将其当作代码执行。目前，我并没有看出该函数有什么显著的作用。

#eval("1 + 1")

当直接向 `eval` 传入一个由 [] 包裹的内容时，将会报错。原因是，`eval` 是 content 型。

#type(eval("1 + 1"))

#eval("[一段内容]")

#type(eval("[一段内容]"))

`eval` 函数的#highlight()[解释模式]可以修改，这是通过参数实现的。

#eval("[一段内容]", mode: "code")

#eval("[一段内容]", mode: "markup") // 这是以标记模式解释内容

下面简单测试一下，当以标记模式解释内容时，会发生什么情况。

#eval("*强调*", mode: "markup")

我自行设定的 \*\* 样式被错误地渲染了，这可能是 eval 函数的一个问题。

我注意到，在给出的提示中，mode 参数还有 math 可以选择，不难理解，下面立即测试。

#eval("2^64", mode: "math")

成功了，完全是我预期的效果。

== 基本字面量

本小节我们将具体介绍所有基本字面量，这是脚本的“一加一”。其实在上一节，我们已经见过了一部分字面量，但皆凭直觉使用：1 不就是数字吗，那么在 Typst 中，它就是数字。（PS：与之相对，TeX 根本没有数字和字符串的概念。）

如果你学过 Python 等语言，那么这将对你来说不是问题。在Typst中，常用的字面量并不多，它们是：

1. 「空字面量」（none literal）
2. 「布尔字面量」（boolean literal）
3. 「整数字面量」（integer literal）
4. 「浮点数字面量」（floating-point literal）
5. 「字符串字面量」（string literal）

=== 空字面量

查找元素的例子目前太过高深，难以掌握，先从简单的例子入手。先来看看 none 的类型是什么？

#type(none)

该输出没有见过，这是什么？对该值再执行 type 检查。

#type(type(none))

可见，这是一种类型。none 值的类型是 type(none)，也就是 none 类型。可见，none 值和 none 类型不等价。我们对两个值进行简单的判断，输出如下。

#(none == type(none))

=== 布尔字面量

假设 #false 是布尔字面量。

一般来说，不推荐直接使用布尔值。当代码中出现逻辑判断时，自然就会出现布尔值。

#(1 < 2)

1 < 2 的结果是 #(1 < 2)

=== 整数字面量

#(66666)

#(-1)

`#-1` 是无法解析的，因为 Typst 不允许 `#` 后面直接跟随连字符。

使用括号，可以使进入脚本模式时，Typst 轻松解析任何值。

=== 浮点数字面量

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

=== 字符串字面量

再来看看字符串字面量。

字符串字面量由英文双引号包裹，强制采用 UTF-8 编码，因此不存在编码转化问题。

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

#repr(x)

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
