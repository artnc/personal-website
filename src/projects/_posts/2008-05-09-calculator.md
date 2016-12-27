---
description: My very first non-trivial program.
h1: Calculator Blackjack and Simon
layout: default
pagetitle: Calculator Blackjack and Simon
---
Here are the first two programs I ever wrote. Before discovering "real" computer programming, I used to be pretty big into the graphing calculator scene.

Blackjack features a text UI, betting over multiple rounds, player high score, basic input validation, automatic ace lowering, and three turn options. Simon is a clone of the classic memory game with programmatically drawn graphics and gradually increasing tempo.

<p class="text-centered">
  <img src="/img/calculator-blackjack.gif">
  &nbsp;
  <img src="/img/calculator-simon.gif">
</p>

Programming on a graphing calculator is funny business; it's like writing assembly by hand in a language that has nowhere near the performance of real assembly. Some fun facts about TI-BASIC:

- Source code is very non-ASCII and has no indentation or braces. All keywords and math functions are single tokens that must be selected from menus.

- Numeric variable names can be any English letter or &theta;. Who needs more than 27 anyway? Additionally, ten string variables are available.

- Everything is global scope. Not only throughout the program, but also across the whole calculator.

- Trailing quotes, parentheses, and brackets are optional.

- Procedural only. The closest thing to a subroutine involves setting a flag variable and having the program call itself.

- Sleep/wait is achieved with an empty `For` loop. Note that this isn't used during Simon's loading screen; the GIF above actually portrays the maximum drawing speed.

- `Goto`.


On the upside, math support is excellent.

Below are the source and binary files for both programs. You can transfer the binaries to a calculator using link software like TI-Connect or TiLP, or you can just load them into an emulator like TilEm or Wabbitemu. Or I guess you could type the source into your calc if you're feeling masochistic. Let's say they're released under the <a id="calculator-licenselink" href="#">MIT license.</a>

<div id="calculator-license" class="hidden">
<pre>
Copyright (C) 2008 Art Chaidarun

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
</pre>
</div>

## [BLKJACK.8Xp](/files/BLKJACK.8Xp)

```text
::
:ClrDraw
:PlotsOff
:FnOff
:AxesOff
:ClrHome
:Disp "BLACKJACK 1.0","By Art Chaidarun
:Pause "5/9/08
:ClrHome
:ClrDraw
:Input "PLAYER'S NAME?  ",Str1
:Menu("PICK A LEVEL","EASY",31,"EASIER",32,"PATHETIC",33
:Lbl 31
:13→V
:Goto 7
:Lbl 32
:12→V
:Goto 7
:Lbl 33
:11→V
:Goto 7
:Lbl 7
:(2V-16)2→M
:ClrHome
:Disp "MONEY:
:Pause M
:Lbl 8
:ClrHome
:DelVar ADelVar RDelVar TDelVar GWhile G<V
:G+randInt(2,10→G
:End
:Input "BET:",B
:abs(int(B)→B
:If B>M
:Then
:M→B:Disp "TOO HIGH, BET:":Pause B
:End
:DelVar DClrHome
:Lbl 4
:R+1→R:Menu(Str1,"HIT",1,"STAND",2,"DOUBLE DOWN",3,"EXIT",0
:Lbl 1
:randInt(1,13→C
:If C=1
:Then
:A+1→A
:Pause "               A"
:End
:If C=11
:Then
:Pause "               J"
:End
:If C=12
:Then
:Pause "               Q"
:End
:If C=13
:Then
:Pause "               K"
:End
:If C≤10 and C≠1
:Then
:Pause C
:End
:If C>10
:Then
:10→C
:End
:If C=1
:Then
:11→C
:End
:C+T→T
:If D=1
:Then
:Disp "YOUR NEW BET IS:":Pause B:Goto 2
:End
:If T<21
:Then
:Goto 4
:End
:If T>21 and A>0
:Then
:A-1→A
:T-10→T
:Text(28,6,"THE ACE'S VALUE IS NOW 1."
:Pause
:ClrDraw
:Goto 4
:Else
:Goto 2
:End
:Lbl 3
:1→D:2*B→B:Goto 1
:Lbl 2
:Disp "YOU GOT":If A≠0 and T>21:Then:Disp T-10:Else:Disp T:End
:Disp "CALC GOT":Pause G
:If (T<21 and (T>G xor G>21)) xor (T=21 and G≠21 and R>2
:Then
:M+B→M:Pause "YOU WIN. TOTAL:"
:End
:If T=21 and G≠21 and R=2
:Then
:M+3B/2→M:Pause "BLACKJACK! TOTAL"
:End
:If T≤21 and T=G
:Then
:Pause "PUSH. TOTAL:"
:End
:If T>21 and A=0
:Then
:M-B→M:Pause "BUST. TOTAL:"
:End
:If T<G and G≤21
:Then
:M-B→M:Pause "YOU LOSE. TOTAL:"
:End
:Pause M
:0→A
:Lbl 9
:If M≤0
:Then
:Text(29,13,"BANKRUPT. GAME OVER."
:Pause
:Menu("NEW GAME?","SAME PLAYER",7,"NEW PLAYER",15,"EXIT",0
:End
:Menu("KEEP PLAYING?","YES",8,"NO",0,"HIGH SCORE",10
:Lbl 15
:prgmBLKJKB1
:Lbl 10
:ClrHome
:Disp Str0
:Pause θ
:ClrHome
:Goto 9
:Lbl 0
:ClrHome
:If M>θ
:Then
:Disp "NEW HIGH SCORE!":M→θ:Str1→Str0:Pause θ
:End
:ClrHome:ClrDraw:AxesOn
:FnOn
:"
```

## [SIMON.8Xp](/files/SIMON.8Xp)

```text
::
:getKey
:0→M
:1→P
:{.2,2.4,4.2,2→L5
:ClrHome
:StoreGDB 1
:SetUpEditor L5,L6,SIMON
:If not(dim(∠SIMON:{0→SIMON
:FnOff :AxesOff:PlotsOff:GridOff
:Lbl M
:ZStandard
:104→Xmax
:72→Ymin
:ZInteger
:ClrDraw
:Text(1,0,33,"Simon
:Horizontal 8
:Text(10,2,"By Art Chaidarun
:Text(10,63,"v1.3:6/09
:Text(24,3,"ENTER: Begin
:Text(31,3,"D-PAD: Select
:Text(38,3,"CLEAR: Exit
:e^(∠SIMON(1
:Ans2→H
:Text(57,3,"High Score:
:Text(57,41,H
:While Ans≠105
:Repeat Ans
:getKey
:Text(1,0,90,"
:End
:If Ans=45:Goto 0
:End
:Lbl G
:ClrDraw
:ZDecimal
:If P
:Then
:Text(7,32,"Loading...
:DelVar L6
:For(θ,4.7,3,.1
:Vertical θ
:Vertical θ
:End
:For(θ,3,0,.1
:round(√(9-θ2),1→Z
:3.2
:Line(θ,Ans,θ,Z
:Line(θ,Ans,θ,Z
:Line(θ,Ans,θ,Z
:Line(θ,Ans,θ,Z
:End
:Shade(√(1-X2),√(1-X2),1,1
:Line(3,3,3,3
:Line(3,3,3,3
:Text(1,1," '222
:Text(0,1," LV:1
:Text(57,1," BACK
:Text(57,77," EXIT
:For(θ,32,62
:Text(7,θ,"
:For(T,1,3
:End
:End
:StorePic 1
:0→P
:Else
:RecallPic 1
:End
:79-4int(log(H
:For(θ,Ans,93
:Text(1,θ,"
:End
:Text(0,Ans," HI:
:Text(0,11+Ans,H
:If not(P
:Then
:For(T,1,E2
:End
:For(L,1,E3
:1500/(L+4→D
:For(θ,0,int(log(L
:Text(1,12+4θ,"2
:End
:Text(0,12,L
:L5(randInt(1,4→L6(L
:For(T,1,E2
:End
:For(θ,1,L
:2+iPart(L6(θ→X
:2+10fPart(L6(θ→Y
:For(T,1,D
:End
:Pt-On(X,Y,2
:For(T,1,3D
:End
:Pt-Off(X,Y,2
:End
:getKey
:For(I,1,L
:0
:Repeat Ans
:getKey
:End
:Ans→G
:If G=11:Goto M
:If G=15:Goto 0
:If sum(G={24,25,26,34
:Then
:.2(11+(G=25)-(G=34)+10((G=26)-(G=24→K
:If K≠L6(I
:Then
:Goto L
:Else
:2+iPart(K→X
:2+10fPart(K→Y
:Pt-On(X,Y,3
:For(T,1,70
:End
:Pt-Off(X,Y,3
:End
:Else
:I-1→I
:End
:End
:End
:Lbl L
:For(θ,4.4,4.4,.2
:4.4-abs(θ
:Line(Ans,θ,Ans,θ
:End
:Text(1,27,20,"
:Text(1,26,39,"
:Text(1,27,21,"GAME OVER
:Repeat sum(Ans={11,15,45,105
:Repeat Ans
:getKey
:End
:End
:If Ans=15 or Ans=45:Goto 0
:If L>H
:Then
:{ln(√(L→SIMON
:Output(3,5,"NEW HIGH
:Output(4,6,"SCORE!
:Pause
:End
:Goto M
:Lbl 0
:RecallGDB 1
:SetUpEditor
:ClrHome
:ClrList L5
:ClrList L6
:DelVar GDB1Output(8,16,"
```

<script type="text/javascript">
(function() {
  $("#calculator-licenselink").on("click", function(e) {
    $("#calculator-license").slideToggle();
    return false;
  });
})();
</script>
