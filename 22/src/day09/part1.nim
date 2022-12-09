import strformat, strutils, sets, math
import std/strscans
import nimib

const 
  DAY = 9
  PART = 1
  DOCNAME = fmt"d{DAY:02}p{PART}"

nbInit
nb.title = DOCNAME

nbText: fmt"""
# Day {DAY:02} part {PART}
"""

nbCode:
  type
    Vec2i = tuple
      x, y: int

  var
    head, tail: Vec2i
    posVisited: HashSet[Vec2i]

  func dist(a, b: Vec2i): float =
    sqrt(((a.x - b.x) ^ 2  + (a.y - b.y) ^ 2).float)

  func `-`(a, b: Vec2i): Vec2i =
    result.x = a.x - b.x
    result.y = a.y - b.y
    if result.x < -1: result.x = -1
    if result.x > 1: result.x = 1
    if result.y < -1: result.y = -1
    if result.y > 1: result.y = 1

  func `+=`(a: var Vec2i, b: Vec2i) = 
    a.x = a.x + b.x
    a.y = a.y + b.y

  proc update(tail: var Vec2i, head: Vec2i) =
    if dist(tail, head) < 1.5: return
    tail += head - tail
    posVisited.incl tail

  proc move(head: var Vec2i, i, j: int) =
    var 
      x = i
      y = j
    while x != 0 or y != 0:
      if x > 0:
        head.x.inc
        x.dec
      elif x < 0:
        head.x.dec
        x.inc
      elif y > 0:
        head.y.inc
        y.dec
      elif y < 0:
        head.y.dec
        y.inc
      tail.update(head)

  posVisited.incl tail  # Add the beggining position (0,0)

  for line in "input.txt".lines:
    var steps: int
    if scanf(line, "L $i", steps): head.move(-steps, 0)
    elif scanf(line, "R $i", steps): head.move(steps, 0)
    elif scanf(line, "U $i", steps): head.move(0, steps)
    elif scanf(line, "D $i", steps): head.move(0, -steps)

nbText: fmt"""
Answer is: **{posVisited.len}**
"""

nb.filename = fmt"../../html/{DOCNAME}.html"
nbSave
