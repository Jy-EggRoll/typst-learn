#show strong: content => {
  show regex("\p{Hani}"): it => box(place(text("·", size: 1em), dx: 0.4em, dy: 0.75em) + it)
  content.body
}

#set text(font: "Microsoft YaHei", size: 14pt)

= 初识脚本模式

#strong[
  从前有座山
]

*从前有座山*

从前有座山

#(1024 * 768) 是一个常见的数。

#([== 一个二级标题] + strong[一段强调文本])

== 数学模式

行内数学公式：$E = sum_x$

行间数学公式：$ E = sum_x $

== 函数和函数调用

四的三次方是 #calc.pow(4, 3)。

特殊的语法：

#strong([第一种写法])

#strong()[第二种写法]

#strong[第三种写法]

#highlight[高亮一段内容]

#highlight(fill: orange)[具名传参]

#underline(offset: 0.2em)[下划线测试]

#overline()[上划线测试]

#strike()[删除线测试]

一种妙用：制作双下划线

#underline(offset: 0.35em, underline(offset: 0.2em, [双下划线]))

#underline(evade: false, offset: -0.1em, [现在线不会间断])

我好#sub[低]

我好#super[高]

#text(fill: red)[```py
  def function():
      pass
  ```]

#text(fill: blue, text(fill: red, [修改的是*无定义*部分，本文本被定义为红色，则不会再被覆盖为蓝色]))

高端的理解：样式链，之后可以再研究

#text(size: 12pt, [a word])#text(size: 24pt, [a word])

#text(size: 2em, [test])

#text(fill: rgb("526FFF"), [测试颜色])

#text(fill: color.hsl(200deg, 100%, 70%), [天依蓝])

#text(font: ("Noto Serif SC", "Microsoft YaHei"), [测试字体，采用了多级调节和回退特性])

#set text(fill: yellow)

此后，默认字体颜色就会被改为黄色

#set text(fill: black)

== 接下来是图像测试

#image("图片目录/测试图片.png", width: 20%)

#figure(image("图片目录/测试图片.png", width: 20%), caption: "这是描述文本")

#figure(```py print("Hello")```, caption: [用于打印 Hello 的代码])

== 行内盒子

这是一段话，我要插入一个图片了#box(image("图片目录/测试图片.png", width: 10%))我调整了基线，但是似乎发生了奇怪的现象。

好，但是现在输入起来就会有奇怪的水波，所以我回退了部分设置。

== 链接

#link("https://www.example.com")

值得注意的是，Typst 会自动识别 HTTPS 和 HTTP 链接。

https://www.example.com

可以为链接指定显示名。<a>

你将会看到#link("https://www.example.com", [这个])

这和#link("https://www.example.com")[这个]是等价的

其原理就在于函数调用时参数的位置，这是 Typst 的特性。

=== 内链

#link(<a>, [某个神秘的地方])

== 表格基础

#table(columns: 2, [第一个], [第二个], [第三个], [第四], align: center)

== 习题

1. 实现个性化 underline（用 underline 实现了 strike 的效果）

#underline([吾辈楷模], offset: -0.3em, evade: false)

2. 看不懂

3. #text(size: 1em, [走])#text(size: 1.5 * 1em, [走])#text(size: 1.5 * 1.5em, [走])#text(size: 1.5 * 1.5 * 1.5em, [走])

自此，基本知识已经基本掌握了，基本已经可以编写出比 Markdown 更加复杂的文档了。

此外，在预览时直接就可以看到分页效果，这超过我目前接触过的所有 Markdown 工具。
