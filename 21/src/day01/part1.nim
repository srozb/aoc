import strutils
import strformat
import nimib

const 
  DAY = 1
  PART = 1
  DOCNAME = fmt"d{DAY:02}p{PART}"

nbInit
nb.title = DOCNAME

nbText: fmt"""
# Day {DAY:02} part {PART}
"""

nbCode:
  var 
    curVal, prevVal, increased: int

  for l in "input.txt".lines:
    if prevVal == 0:
      prevVal = l.parseInt
      continue
    curVal = l.parseInt
    if curVal > prevVal:
      increased.inc
    prevVal = curVal

nbText: fmt"""
Answer is: **{increased}**
"""

nb.filename = fmt"../../html/{DOCNAME}.html"
nbSave