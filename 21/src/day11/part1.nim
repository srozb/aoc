import strutils
import strformat
import nimib

const 
  DAY = 11
  PART = 1
  DOCNAME = fmt"d{DAY:02}p{PART}"

nbInit
nb.title = DOCNAME

nbText: fmt"""
# Day {DAY:02} part {PART}
"""

nbCode:
  const 
    CAVEW = 10
    CAVEH = 10
    DAYS = 100

  type
    Energymap = array[CAVEW, array[CAVEH, int]]

  var
    cave: Energymap
    flashes: int

  proc readFile(fn: string) =
    var j: int
    for line in fn.lines:
      for i in 0..<line.len:
        cave[i][j] = ($line[i]).parseInt
      j.inc

  proc inc(em: var Energymap) =
    for y in 0..<CAVEH:
      for x in 0..<CAVEW:
        em[x][y].inc

  proc flashOcto(em: var Energymap, x, y: int, increase=false) = 
    if em[x][y] == 0:
      return
    if increase:
      em[x][y].inc
    if em[x][y] < 10:
      return
    em[x][y] = 0
    flashes.inc
    if x-1 >= 0:
      em.flashOcto(x-1, y, true)
      if y-1 >= 0:
        em.flashOcto(x-1, y-1, true)
    if y-1 >= 0:
      em.flashOcto(x, y-1, true)
      if x+1 < CAVEW:
        em.flashOcto(x+1, y-1, true)
    if x+1 < CAVEW:
      em.flashOcto(x+1, y, true)
      if y+1 < CAVEH:
        em.flashOcto(x+1, y+1, true)
    if y+1 < CAVEH:
      em.flashOcto(x, y+1, true)
      if x-1 >= 0:
        em.flashOcto(x-1, y+1, true)

  proc flash(em: var Energymap) = 
    for y in 0..<CAVEH:
      for x in 0..<CAVEW:
        em.flashOcto(x, y)

  readFile("input.txt")

  for i in 1..DAYS:
    cave.inc
    cave.flash

nbText: fmt"""
Answer is: **{flashes}**
"""

nb.filename = fmt"../../html/{DOCNAME}.html"
nbSave