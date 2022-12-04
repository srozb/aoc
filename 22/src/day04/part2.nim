import strformat, strutils, sets, sequtils
import std/strscans
import nimib

const 
  DAY = 4
  PART = 2
  DOCNAME = fmt"d{DAY:02}p{PART}"

nbInit
nb.title = DOCNAME

nbText: fmt"""
# Day {DAY:02} part {PART}
"""

nbCode:
  var answer: Natural

  func pairOverlaps(a, b: HashSet[int]): bool =
    return (a * b).len > 0

  proc fillSet(a,b: int): HashSet[int] =
    result = toHashSet(toSeq(a..b))

  for l in "input.txt".lines:
    var a,b,c,d: int
    if not scanf(l, "$i-$i,$i-$i", a,b,c,d): continue
    if pairOverlaps(fillSet(a, b), fillSet(c, d)): answer.inc

nbText: fmt"""
Answer is: **{answer}**
"""

nb.filename = fmt"../../html/{DOCNAME}.html"
nbSave
