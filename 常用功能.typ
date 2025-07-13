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
  align(center, text(fill: rgb("bf6a6a"), content.body, size: 1.8em))
}

#show heading.where(depth: 2): content => {
  pagebreak()
  align(center, text(fill: rgb("d08770"), content.body, size: 1.7em))
}

#show heading.where(depth: 3): content => {
  align(center, text(fill: rgb("#ab9364"), content.body, size: 1.6em))
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

// 下面开始正文

#v(1fr)

#align(center, context [
  #set text(size: zh(0))
  常用功能速成练习])

#v(1fr)

#pagebreak()

= 说明

下面演示自动标题标号的效果。

== 标题

=== hao

==== hao

===== hao

====== hao

目前的字体目录使用环境变量实现，之后更换电脑需要配置 `TYPST_FONT_PATHS` 环境变量。

== 如何练习

目前对 Typst 的学习还非常粗浅。我需要多使用自省函数，了解一些功能的确切用法。

#repr([*加粗*])

#repr([== 二级标题])

想要自定义标题的显示样式，就要从标题的代码入手。

#heading([测试标题])

#pagebreak()

= 对齐

#align(center)[我是临时居中]

#par(lorem(20))

#pagebreak()

= 表格

== 单位

`fr` 是一个神奇的单位，用于表示空间分配，在表格列宽上会有良好的体现。

#table(
  columns: (1fr, 2fr, 1fr),
  table.header([表头 1], [表头 2], [表头 3]),
  lorem(3), lorem(6), lorem(8),
  lorem(7), lorem(7), lorem(9),
)

#pagebreak()

= 图片

使用 #image("基础教程-排版1/图片目录/极光.jpg") #no-indent 来插入图片，这看起来会导致图片后面的文本被强制换行，并新起一段。我自己定义了一个 `no-indent` 的变量来实现这个效果。

#pagebreak()

= 代码块

现在是导入了美化样式的代码块。

```py
def function(string):
    print(f"Hello, {string}!")

if __name__ == "__main__":
    function("world!")
```

#pagebreak()

= 图形

`figure` 可以把几乎任何部分转为图形。

#figure(image("基础教程-排版1/图片目录/测试图片.png"), caption: "这是一张测试图片")

值得注意的是，如果不将文档语言设置为中文，显示的就不是“图 1”，而是“Figure 1”。

#figure(
  table(
    columns: (1fr, 2fr, 1fr),
    table.header([表头 1], [表头 2], [表头 3]),
    lorem(3), lorem(6), lorem(8),
    lorem(7), lorem(7), lorem(9),
  ),
  caption: "这是一张测试表格",
)

#figure(
  ```py
  def function(string):
      print(f"Hello, {string}!")

  if __name__ == "__main__":
      function("world!")
  ```,
  caption: "这是一段代码",
)

根据上面的测试，我注意到，放入 `figure` 的内容总是居中的，对于表格中的内容尤其明显，但是经过 `codly` 美化的代码并没有出现这样的问题，我猜想是有类似继承和覆盖的机制。

另外，标号应该是自动计算 #footnote[这里用来测试脚注]的。

#figure(
  ```c
  #include <stdio.h>
  int main() {
      printf("Hello, world!\n");
      return 0;
  ```,
  caption: "这是一段 C 语言代码",
)

这里默认显示为“代码 2”，而我没有做任何修改。

#pagebreak()

#heading(numbering: none)[参考文献]

是用了某些方法，使该标题没有编号了。

主要参考了 Typst 中文社区。
