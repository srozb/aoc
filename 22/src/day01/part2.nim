import strformat, strutils
import nimib
import std/algorithm

const DOCNAME = "d01p2"

when defined(mdOutput):
  nbInitMd
else:
  nbInit

nb.title = DOCNAME

nbText: """
# Day 01 part 2
"""

nbCode:
  type
    Snacks = seq[Natural]

  proc sum(s: Snacks): Natural =
    for c in s:
      result.inc c

  var s: Snacks
  var sums: seq[Natural]

  for l in "input.txt".lines:
    if l == "":
      sums.add s.sum
      s = @[]
      continue
    s.add l.parseInt

  sums.sort(Descending)

when defined(mdOutput):
  nb.filename = fmt"../../{DOCNAME}.md"
else:
  nb.filename = fmt"../../{DOCNAME}.html"

nbText: fmt"""
Result is: {sums[0] + sums[1] + sums[2]}
"""

nbSave

