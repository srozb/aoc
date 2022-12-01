import strformat, strutils
import nimib

const DOCNAME = "d01p1"

nbInit
nb.title = DOCNAME

nbText: """
# Day 01 part 1
"""

nbCode:
  type
    Snacks = seq[int]

  proc sum(s: Snacks): int =
    for c in s:
      result.inc c

  var s: Snacks
  var highest = 0

  for l in "input.txt".lines:
    if l == "":
      highest = max(highest, s.sum)
      s = @[]
      continue
    s.add l.parseInt

nbText: fmt"""
Answer is: **{highest}**
"""

nb.filename = fmt"../../{DOCNAME}.html"
nbSave
