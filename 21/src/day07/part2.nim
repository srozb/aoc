import strutils
import strformat
import nimib

const 
  DAY = 7
  PART = 2
  DOCNAME = fmt"d{DAY:02}p{PART}"

nbInit
nb.title = DOCNAME

nbText: fmt"""
# Day {DAY:02} part {PART}
"""

nbCode:
  const MAX_SIZE = 2000

  var 
    submarines = newSeq[int]()
    pos_cost = int.high

  let initialState = "input.txt".readFile
  for item in initialState.split(","):
    submarines.add(item.parseInt)

  proc scoreMove(self: seq[int], pos: int): int =
    for sm in self:
      var length = ((sm - pos).abs).float
      result += ((length+1)*(length/2)).int

  for i in 0..<MAX_SIZE:
    var score = submarines.scoreMove(i)
    if score < pos_cost:
      pos_cost = score

nbText: fmt"""
Answer is: **{pos_cost}**
"""

nb.filename = fmt"../../html/{DOCNAME}.html"
nbSave