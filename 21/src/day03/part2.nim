import sequtils
import strutils
import strformat
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
    inputData = newSeq[string]()
    position = 0

  for l in "input.txt".lines:
    inputData.add(l)

  proc findValue(position: var int, valMatch: string, inputData: seq[string]): seq[string] =
    var 
      ones, zeros: int
      matcher: char
      data = inputData
    if data.len == 1:
      position = 0
      return data
    for d in data:
      if d[position] == '1':
        ones.inc
      else:
        zeros.inc
    if valMatch == "more":
      if ones >= zeros:
        matcher = '1'
      else:
        matcher = '0'
    else:
      if ones < zeros:
        matcher = '1'
      else:
        matcher = '0'
    data.keepItIf(it[position] == matcher)
    position.inc
    result = findValue(position, valMatch, data)

  var oxygen = fromBin[int](findValue(position, "more", inputData)[0])
  var co2 = fromBin[int](findValue(position, "less", inputData)[0])

nbText: fmt"""
Answer is: **{oxygen * co2}**
"""

nb.filename = fmt"../../html/{DOCNAME}.html"
nbSave