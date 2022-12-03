import strformat, strutils, sets
import nimib

const 
  DAY = 3
  PART = 1
  DOCNAME = fmt"d{DAY:02}p{PART}"

nbInit
nb.title = DOCNAME

nbText: fmt"""
# Day {DAY:02} part {PART}
"""

nbCode:
  var answer: Natural

  proc score(chars: HashSet[char]): Natural =
    for c in chars:
      if c.ord >= 'a'.ord and c.ord <= 'z'.ord: result.inc c.ord - 'a'.ord + 1
      elif c.ord >= 'A'.ord and c.ord <= 'Z'.ord: result.inc c.ord - 38

  for l in "input.txt".lines:
    answer.inc score(
      toHashSet(l[0..<l.len div 2]) * 
      toHashSet(l[l.len div 2..<l.len])
    )

nbText: fmt"""
Answer is: **{answer}**
"""

nb.filename = fmt"../../html/{DOCNAME}.html"
nbSave
