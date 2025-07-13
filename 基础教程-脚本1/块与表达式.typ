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
  fill: rgb("#FAFAFA"),
)

#let no-indent = h(-2em)

#show strong: content => {
  show regex("\p{Hani}"): it => box(place(text("·", size: 1em), dx: 0.4em, dy: 0.75em) + it)
  content.body
}

#show heading.where(depth: 1): content => {
  align(center, text(fill: rgb("#c25050"), content.body, size: 1.8em))
}

#show heading.where(depth: 2): content => {
  pagebreak()
  align(center, text(fill: rgb("#c36f56"), content.body, size: 1.7em))
}

#show heading.where(depth: 3): content => {
  align(center, text(fill: rgb("#f9be48"), content.body, size: 1.6em))
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

= 块与表达式

Typst 的编译流畅大致分为 4 个阶段，解析、求值、排版和导出。中文教程中第一段的内容极难理解，暂且不论。

== 表达式

Typst 中绝大部分的语法结构都可以视为表达式。可用的表达式大致分为 5 类，分别是：

1. 代数运算表达式
+ 逻辑比较表达式
+ 逻辑运算表达式
+ 赋值表达式
+ 项

=== 代数运算表达式

整数和浮点数可以混合运算，浮点数遵循 IEEE 754 标准。

#(1 + 2, 1.0 - 2, 55 * 2.3)

0.1 + 0.2 的结果是 #(0.1 + 0.2)，在意料之中。

除了数字运算，字符串、数组也支持加法和乘法，在 JavaScript 和 Python 中也有类似的功能。

#("你好" * 8)

#((1,) * 7)

对于字典，只支持加法操作。如果出现了重复的键值对，则右侧的会覆盖左侧的。

#((a: 1) + (g: 2) + (a: 3))

=== 逻辑比较表达式

比较关系和其他编程语言并无不同。主要是 > < == <= >= != 这几种。不推荐整数和小数直接比较，这会出现一些问题，即浮点数陷阱。浮点数比较恐怕要指定精度。下面给出一个 0.1 + 0.2 == 0.3 的示例：

#(0.1 + 0.2 == 0.3)

字符串、数组、字典也是可以比较的，鉴于从理解上要使用偏序关系等概念，且目前想不出什么应用方面，暂以浏览为主。

=== 逻辑运算表达式

包含“且”，“或”，“非”，即 `and` `or` `not`。

和标准的逻辑并无不同，无需深入学习。

=== 赋值表达式

即使用 `let` 赋初值，以及使用 = 改变值。

#let a = 1

#type(a)

#(a = "Hello")

#type(a)

可见，值的类型也是随着值改变的，这一点和 JavaScript、Python 有一致性。

+= -= 等符号也可以使用。

=== 代码块

此处的代码块并不是排版上的代码块，而是 Typst 执行逻辑上的代码块，用花括号来包裹。代码块的内部有语句的概念，不同的语句既可以通过换行来分隔，也可以用分号来分隔，这是等价的。

== 可折叠的值

Typst 按照控制流顺序执行代码，将所有结果“折叠”成一个值。这是很抽象的，下面从例子入手。

#{
  "Hello"
  ", "
  "world!"
} 这里使用了花括号，开始执行“折叠”。

#{
  let hello = "Hello"
  let space = " "
  let world = "world"
  hello
  space
  world
  let ds = "Destroy"
  space
  ds
  space
  world
}

变量声明的结果为 none，所以这个值不会体现在折叠中。

#type(let a = 0)

#type(none)

#type(type(none))

对于 none，目前仍然是比较模糊。

#none

#8

可见，不能单纯地从数字类型的角度判断。

再深刻体会 Typst 按照控制流顺序执行代码，将所有结果“折叠”成一个值。

但是，布尔值、整数、浮点数等，并不支持折叠操作。

不论如何，此部分内容都太过抽象，我暂时无法理解。

但是，此部分即将涉及到 Typst 脚本的核心。

=== 内容折叠

这就是 Typst 脚本的核心。

#{
  [==== 生活在树上]
  [现代社会]
  [海德格尔]
}

这也就涉及到了上述内容的语法糖。所谓语法糖，就是同一事物的更简便的书写方法。上述内容和下面的是等价的。

#[
  ==== 生活在树上
  现代社会
  海德格尔
]

由于 Typst 默认是以标记模式开始解释我们撰写的文档，所以，以上内容又和以下内容等价。

==== 生活在树上

现代社会
海德格尔

（事实上，由于 Typst 的 bug，在此模式下换行，常常会引入一个空格，所以，是不完全一致的）

=== none 类型和 if 语句

默认情况下，Typst 按照流执行我们的代码。和其他编程语言类似，Typst 也可以引入控制结构。比如接下来要介绍的 if 语句。

#if (1 == 3) { "你好" } else { "这是 else 块里面的内容" }

Typst 同样支持 else if，所以层级可以自行设计。

`#if (1 == 3) {"hao"}` 是否会报错？因为表达式不为真，所以接下来的代码块是不会执行的，返回了一个 none。我们可以用自省函数看到这一点。

#repr(if (1 > 3) { "不要！" })

这里清晰地展示出了一个 none。

下面来仿照编写一段简单的程序，用来实现一些功能。

#let 查成分(成分数组) = {
  "是个"
  if "A" in 成分数组 or "C" in 成分数组 or "G" in 成分数组 { "萌萌" }
  if "T" in 成分数组 { "工具" }
  "人"
}

#查成分(())

#查成分(("A", "G", "T"))

下面再来仿照写出斐波那契函数。

#let fib(n) = if (n <= 1) { n } else {
  fib(n - 1) + fib(n - 2)
}

#fib(1)

#fib(2)

#fib(50)

很有趣，递归就如此实现了。

=== while 语句。

while 语句用于循环结构。

#let i = 0

#while i <= 10 {
  "你好"
  i += 2
}

=== for 语句

#for i in range(10) { (i,) }
