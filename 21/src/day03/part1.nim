import strutils
import bitops
import strformat
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
  var
    records: int
    score: array[12, int]
    gamma: int
    epsilon: int

  proc getGamma(score: array[12, int]): int =
    var gammaAscii: string
    for s in score.items:
      if records div 2 - s > 0:
        gammaAscii.add("1")
      else:
        gammaAscii.add("0")
    result = fromBin[int](gammaAscii)

  for l in "input.txt".lines:
    records.inc
    for i in 0..<l.len:
      if l[i] == '1':
        score[i].inc

  gamma = score.getGamma
  epsilon = gamma.flipMasked(0b1111_1111_1111)

nbText: fmt"""
Answer is: **{gamma * epsilon}**
"""

nb.filename = fmt"../../html/{DOCNAME}.html"
nbSave