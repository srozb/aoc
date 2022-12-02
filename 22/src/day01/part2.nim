import strformat, strutils
import nimib
import std/algorithm

const 
  DAY = 1
  PART = 2
  DOCNAME = fmt"d{DAY:02}p{PART}"

nbInit
nb.title = DOCNAME

nbText: fmt"""
# Day {DAY:02} part {PART}
"""

nbCode:
  type
    Snacks = seq[Natural]

  func sum(s: Snacks): Natural =
    for c in s:
      result.inc c

  var
    s: Snacks
    sums: seq[Natural]

  for l in "input.txt".lines:
    if l == "":
      sums.add s.sum
      s = @[]
      continue
    s.add l.parseInt

  sums.sort(Descending)

  let answer = sums[0] + sums[1] + sums[2]

nbText: fmt"""
Answer is: **{answer}**
"""

nb.filename = fmt"../../html/{DOCNAME}.html"
nbSave
