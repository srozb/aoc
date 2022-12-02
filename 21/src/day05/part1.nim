import strscans
import strformat
import nimib

const 
  DAY = 5
  PART = 1
  DOCNAME = fmt"d{DAY:02}p{PART}"

nbInit
nb.title = DOCNAME

nbText: fmt"""
# Day {DAY:02} part {PART}
"""

nbCode:
  type
    Ocean = array[1000, array[1000, int]]
    Line = tuple
      xa, ya, xb, yb: int

  var
    hydroLine: Line
    ocean: Ocean

  proc newLine(lineStr: string): Line =
    var xa,ya,xb,yb: int
    discard scanf(lineStr, "$i,$i -> $i,$i", xa, ya, xb, yb)
    hydroLine = (xa: xa, ya: ya, xb: xb, yb: yb)
    result = hydroLine

  proc isOrto(self: Line): bool =
    result = self.xa == self.xb or self.ya == self.yb

  proc markLine(self: var Ocean, l: Line) =
    if not l.isOrto:
      return
    var
      curx = l.xa
      cury = l.ya
      vecx, vecy: int
    if l.xa < l.xb:
      vecx = 1
    elif l.xa > l.xb:
      vecx = -1
    if l.ya < l.yb:
      vecy = 1
    elif l.ya > l.yb:
      vecy = -1
    while true:
      self[curx][cury].inc
      if curx == l.xb and cury == l.yb:
        return
      else:
        curx.inc vecx
        cury.inc vecy

  proc countScore(self: Ocean): int =
    for i in 0..<ocean.len:
      for j in 0..<ocean[i].len:
        if ocean[i][j] > 1:
          result.inc 1

  for l in "input.txt".lines:
    var parsedLine = newLine(l)
    ocean.markLine(parsedLine)

nbText: fmt"""
Answer is: **{ocean.countScore}**
"""

nb.filename = fmt"../../html/{DOCNAME}.html"
nbSave
