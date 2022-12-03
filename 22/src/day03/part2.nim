import strformat, strutils, sets
import nimib

const 
  DAY = 3
  PART = 2
  DOCNAME = fmt"d{DAY:02}p{PART}"

nbInit
nb.title = DOCNAME

nbText: fmt"""
# Day {DAY:02} part {PART}
"""

nbCode:
  var 
    answer: Natural
    elfGroup: seq[string]

  proc countPri(c: char): Natural =
    if c.ord >= 'a'.ord and c.ord <= 'z'.ord: result.inc c.ord - 'a'.ord + 1
    elif c.ord >= 'A'.ord and c.ord <= 'Z'.ord: result.inc c.ord - 38

  proc score(): Natural =
    var chars = toHashSet(elfGroup.pop)
    while elfGroup.len > 0: chars = chars * toHashSet(elfGroup.pop)
    result = countPri(chars.pop())

  for l in "input.txt".lines:
    elfGroup.add(l)
    if elfGroup.len == 3: answer.inc score()

nbText: fmt"""
Answer is: **{answer}**
"""

nb.filename = fmt"../../html/{DOCNAME}.html"
nbSave
