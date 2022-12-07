import strformat, strutils, strscans, algorithm
import nimib

const 
  DAY = 7
  PART = 2
  DOCNAME = fmt"d{DAY:02}p{PART}"

nbInit
nb.title = DOCNAME

nbText: fmt"""
# Day {DAY:02} part {PART}
"""

nbCode:
  const 
    CAPACITY = 70_000_000
    NEEDED = 30_000_000

  type 
    Entry = ref object
      parent: Entry
      size: Natural

  var
    answer: Natural
    cwd = Entry()
    level: Natural
    dirSizes: seq[Natural]

  proc goUp(e: var Entry) {.inline.} = 
    cwd.parent.size.inc cwd.size
    dirSizes.add cwd.size
    cwd = cwd.parent
    level.dec

  proc goDown(e: var Entry) {.inline.} =
    cwd = Entry(parent: cwd)
    level.inc

  for l in "input.txt".lines:
    var
      size: int
      item: string
    if l.scanf("$$ cd $+", item):
      if item == "..": cwd.goUp
      else: cwd.goDown
    elif l.scanf("$i $w", size, item): cwd.size.inc size

  while level > 0: cwd.goUp

  for d in dirSizes.sorted:
    answer = d
    if d > abs(CAPACITY - NEEDED - cwd.size): break

nbText: fmt"""
Answer is: **{answer}**
"""

nb.filename = fmt"../../html/{DOCNAME}.html"
nbSave
