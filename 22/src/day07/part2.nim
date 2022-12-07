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
    TARGET_SZ = 30_000_000

  type 
    Entry = ref object
      parent: Entry
      size: Natural

  var
    answer: Natural
    cwd = Entry()
    level: int
    dirSizes: seq[int]

  proc goUp(e: var Entry) = 
    cwd.parent.size.inc cwd.size
    dirSizes.add cwd.size
    cwd = cwd.parent
    level.dec

  for l in "input.txt".lines:
    var
      size: int
      item: string
    if l.scanf("$$ cd $+", item):
      if item == "..": cwd.goUp
      else:
        level.inc
        cwd = Entry(parent: cwd)
    elif l.scanf("$i $w", size, item): cwd.size.inc size
  while level > 0: cwd.goUp

  let spaceNeeded = abs(CAPACITY - TARGET_SZ - cwd.size)
  dirSizes.sort()
  for d in dirSizes:
    answer = d
    if d > spaceNeeded: break

nbText: fmt"""
Answer is: **{answer}**
"""

nb.filename = fmt"../../html/{DOCNAME}.html"
nbSave
