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
