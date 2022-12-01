import strformat, strutils
import nimib
import std/algorithm

const DOCNAME = "d01p2"

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

nbText: fmt"""
Answer is: **{sums[0] + sums[1] + sums[2]}**
"""

nb.filename = fmt"../../{DOCNAME}.html"
nbSave
