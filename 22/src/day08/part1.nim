import strformat, strutils
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
  const 
    FOREST_SZ = 99

  type
    ForestMap = array[FOREST_SZ, array[FOREST_SZ, Natural]]

  var
    forest: ForestMap
    answer: Natural

  proc isEdge(x, y: Natural): bool {.inline.} =
    x == 0 or x == FOREST_SZ-1 or y == 0 or y == FOREST_SZ-1

  proc isVisible(x, y: Natural): bool =
    if isEdge(x, y): return true
    for i in countdown(x-1, 0): 
      if forest[i][y] >= forest[x][y]: break
      if isEdge(i, y): return true
    for i in x+1..<FOREST_SZ: 
      if forest[i][y] >= forest[x][y]: break
      if isEdge(i, y): return true
    for i in countdown(y-1, 0): 
      if forest[x][i] >= forest[x][y]: break
      if isEdge(x, i): return true
    for i in y+1..<FOREST_SZ:
      if forest[x][i] >= forest[x][y]: break
      if isEdge(x, i): return true
    
  proc readFile() =
    var lIdx: Natural
    for line in "input.txt".lines:
      for col in 0..<line.len:
        forest[lIdx][col] = line[col].int - '0'.int  # to avoid str allocation
      lIdx.inc

  readFile()

  for x in 0..<FOREST_SZ:
    for y in 0..<FOREST_SZ:
      if isVisible(x, y): answer.inc

nbText: fmt"""
Answer is: **{answer}**
"""

nb.filename = fmt"../../html/{DOCNAME}.html"
nbSave
