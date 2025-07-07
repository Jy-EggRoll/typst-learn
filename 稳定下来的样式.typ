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
