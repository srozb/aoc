import strscans

type
  Ocean = array[1000, array[1000, int]]
  Line = tuple
    xa: int
    ya: int
    xb: int
    yb: int

var
  hydroLine: Line
  ocean: Ocean

proc newLine(lineStr: string): Line =
  var xa,ya,xb,yb: int
  discard scanf(lineStr, "$i,$i -> $i,$i", xa, ya, xb, yb)
  hydroLine = (xa: xa, ya: ya, xb: xb, yb: yb)
  result = hydroLine

proc markLine(self: var Ocean, l: Line) =
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
        result.inc

for l in "input.txt".lines:
  var parsedLine = newLine(l)
  ocean.markLine(parsedLine)

echo "Answer is: " & $ocean.countScore