import strutils
import strformat
import nimib

const 
  DAY = 8
  PART = 1
  DOCNAME = fmt"d{DAY:02}p{PART}"

nbInit
nb.title = DOCNAME

nbText: fmt"""
# Day {DAY:02} part {PART}
"""

nbCode:
  var digits: int

  for l in "input.txt".lines:
    for digit in l.split('|')[1].splitWhitespace:
      if digit.len in [2, 3, 4, 7]:
        digits.inc

nbText: fmt"""
Answer is: **{digits}**
"""

nb.filename = fmt"../../html/{DOCNAME}.html"
nbSave