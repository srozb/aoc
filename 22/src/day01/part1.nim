import strformat, strutils
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

nb.filename = fmt"../../html/{DOCNAME}.html"
nbSave
