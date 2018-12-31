---
description: My first non-trivial programs.
h1: Calculator Blackjack and Simon
layout: post
pagetitle: Calculator Blackjack and Simon
tags: ["personal"]
---
Here are the first two programs I ever wrote. Before discovering "real" computer programming, I used to be pretty big into the graphing calculator scene.

Blackjack features a text UI, betting over multiple rounds, player high score, basic input validation, automatic ace lowering, and three turn options. Simon is a clone of the classic memory game with programmatically drawn graphics and gradually increasing tempo.

<p class="text-centered">
  <img src="/img/calculator-blackjack.gif">
  &nbsp;
  <img src="/img/calculator-simon.gif">
</p>

Programming on a graphing calculator is funny business. It's like writing and optimizing assembly by hand in a language that has nowhere near the performance of real assembly. Some fun facts about TI-BASIC:

- Source code is very non-ASCII and has no indentation or braces. All keywords and standard library functions are single tokens that must be selected from menus. The screen size is 8x16 characters, so get used to scrolling.

- Numeric variable names can be any English letter or &theta;. Who needs more than 27 anyway? Additionally, ten string variables are available.

- All variables are globally scoped. Or rather, "universally" scoped---they're shared among all TI-BASIC programs on the calculator.

- Closing quotes, parentheses, and brackets are optional.

- Procedural only. The closest thing to a subroutine involves setting a flag variable and having the program call itself.

- Sleep/wait is achieved with an empty `For` loop. Want to sleep for about a second? Iterate somewhere between 60 and 300 times depending on calculator model. Note that this trick isn't used during Simon's loading screen; the GIF above portrays the maximum drawing speed.

- `Goto`.


On the upside, math support is excellent :)

Below is the source for Simon's input loop. The full source, binaries, and installation instructions for both programs are available on [GitHub](https://github.com/artnc/ti-basic).

```text
For(I,1,L
0
Repeat Ans
getKey
End
Ans→G
If G=11:Goto M
If G=15:Goto 0
If sum(G={24,25,26,34
Then
.2(11+(G=25)-(G=34)+10((G=26)-(G=24→K
If K≠L6(I
Then
Goto L
Else
2+iPart(K→X
2+10fPart(K→Y
Pt-On(X,Y,3
For(T,1,70
End
Pt-Off(X,Y,3
End
Else
I-1→I
End
End
End
```
