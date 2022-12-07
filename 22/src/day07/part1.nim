import strformat, strutils, strscans
import nimib

const 
  DAY = 7
  PART = 1
  DOCNAME = fmt"d{DAY:02}p{PART}"

nbInit
nb.title = DOCNAME

nbText: fmt"""
# Day {DAY:02} part {PART}
"""

nbCode:
  type 
    Entry = ref object
      parent: Entry
      size: Natural

  var
    answer: Natural
    cwd = Entry()

  for l in "input.txt".lines:
    var
      size: int
      item: string
    if l.scanf("$$ cd $+", item):
      if item == "..":
        if cwd.size < 100000: answer.inc cwd.size 
        cwd.parent.size.inc cwd.size
        cwd = cwd.parent
      else:
        cwd = Entry(parent: cwd)
    elif l.scanf("$i $w", size, item): cwd.size.inc size

nbText: fmt"""
Answer is: **{answer}**
"""

nb.filename = fmt"../../html/{DOCNAME}.html"
nbSave
