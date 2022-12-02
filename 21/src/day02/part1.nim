import strutils
import strformat
import nimib

const 
  DAY = 2
  PART = 1
  DOCNAME = fmt"d{DAY:02}p{PART}"

nbInit
nb.title = DOCNAME

nbText: fmt"""
# Day {DAY:02} part {PART}
"""

nbCode:
  type
    Position = tuple
      x: int
      y: int

  var
    pos: Position

  proc move(self: var Position, command: string) =
    let
      comSplit = command.splitWhitespace
      direction = comSplit[0]
      offset = comSplit[1].parseInt
    if direction == "forward":
      self.x.inc offset
    elif direction == "up":
      self.y.dec offset
    elif direction == "down":
      self.y.inc offset
    else:
      raise newException(ValueError, "Unable to parse command.")

  proc multiply(self: Position): int =
    result = self.x * self.y

  for l in "input.txt".lines:
    pos.move(l)

nbText: fmt"""
Answer is: **{pos.multiply}**
"""

nb.filename = fmt"../../html/{DOCNAME}.html"
nbSave