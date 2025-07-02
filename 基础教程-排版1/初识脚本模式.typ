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

