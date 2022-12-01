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

  func sum(s: Snacks): int =
    for c in s:
      result.inc c

  var
    s: Snacks
    answer: Natural

  for l in "input.txt".lines:
    if l == "":
      answer = max(answer, s.sum)
      s = @[]
      continue
    s.add l.parseInt

nbText: fmt"""
Answer is: **{answer}**
"""

nb.filename = fmt"../../{DOCNAME}.html"
nbSave
