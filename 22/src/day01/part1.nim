import strformat, strutils
import nimib

const DOCNAME = "d01p1"

when defined(mdOutput):
  nbInitMd
else:
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

when defined(mdOutput):
  nb.filename = fmt"../../{DOCNAME}.md"
else:
  nb.filename = fmt"../../{DOCNAME}.html"

nbText: fmt"""
Result is: {highest}
"""

nbSave

