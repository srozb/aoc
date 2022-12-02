import strutils
import algorithm
import strformat
import nimib

const 
  DAY = 9
  PART = 2
  DOCNAME = fmt"d{DAY:02}p{PART}"

nbInit
nb.title = DOCNAME

nbText: fmt"""
# Day {DAY:02} part {PART}
"""

nbCode:
  const 
    CAVEW = 100
    CAVEH = 100

  type
    Heightmap = array[CAVEW, array[CAVEH, int]]

  var
    cave: Heightmap
    biggestBasins = newSeq[int](4)
    score = 1

  proc readFile(fn: string) =
    var j: int
    for line in fn.lines:
      for i in 0..<line.len:
        cave[i][j] = ($line[i]).parseInt
      j.inc

  proc `$`(x: Heightmap): string =
    for j in 0..<CAVEH:
      for i in 0..<CAVEW:
        result.add($(x[i][j]))
      result.add('\n')

  proc fillBasin(x: var Heightmap, i, j: int): int =
    x[i][j] = 9
    result.inc
    if i+1 < CAVEW and x[i+1][j] < 9:
      result.inc(x.fillBasin(i+1, j))
    if j+1 < CAVEH and x[i][j+1] < 9:
      result.inc(x.fillBasin(i, j+1))
    if i>0 and x[i-1][j] < 9:
      result.inc(x.fillBasin(i-1, j))
    if j>0 and x[i][j-1] < 9:
      result.inc(x.fillBasin(i, j-1))

  readFile("input.txt")

  for j in 0..<CAVEH:
      for i in 0..<CAVEW:
        if cave[i][j] < 9:
          var bSize = cave.fillBasin(i, j)
          biggestBasins[0] = bSize
          biggestBasins = biggestBasins.sorted

  for bSize in biggestBasins[1..3]:
    score *= bSize

nbText: fmt"""
Answer is: **{score}**
"""

nb.filename = fmt"../../html/{DOCNAME}.html"
nbSave