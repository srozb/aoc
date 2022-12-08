import strformat, strutils
import nimib

const 
  DAY = 8
  PART = 2
  DOCNAME = fmt"d{DAY:02}p{PART}"

nbInit
nb.title = DOCNAME

nbText: fmt"""
# Day {DAY:02} part {PART}
"""

nbCode:
  const 
    FOREST_SZ = 99

  type
    ForestMap = array[FOREST_SZ, array[FOREST_SZ, char]]

  var
    forest: ForestMap
    answer: Natural

  proc isEdge(x, y: Natural): bool {.inline.} =
    x == 0 or x == FOREST_SZ-1 or y == 0 or y == FOREST_SZ-1

  proc scenicScore(x, y: Natural): Natural =
    result = 1
    for i in countdown(x-1, 0): 
      if forest[i][y] >= forest[x][y] or isEdge(i, y): 
        result *= x-i
        break
    for i in x+1..<FOREST_SZ: 
      if forest[i][y] >= forest[x][y] or isEdge(i, y): 
        result *= i-x
        break
    for i in countdown(y-1, 0): 
      if forest[x][i] >= forest[x][y] or isEdge(x, i): 
        result *= y-i
        break
    for i in y+1..<FOREST_SZ:
      if forest[x][i] >= forest[x][y] or isEdge(x, i): 
        result *= i-y
        break
    
  proc readFile() =
    var lIdx: Natural
    for line in "input.txt".lines:
      for col in 0..<line.len:
        forest[lIdx][col] = line[col]
      lIdx.inc

  readFile()

  for x in 0..<FOREST_SZ:
    for y in 0..<FOREST_SZ:
      answer = max(answer, scenicScore(x,y))

nbText: fmt"""
Answer is: **{answer}**
"""

nb.filename = fmt"../../html/{DOCNAME}.html"
nbSave
