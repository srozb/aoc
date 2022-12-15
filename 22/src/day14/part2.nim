import strformat, strutils, sequtils, strscans
import nimib

const 
  DAY = 14
  PART = 2
  DOCNAME = fmt"d{DAY:02}p{PART}"

nbInit
nb.title = DOCNAME

nbText: fmt"""
# Day {DAY:02} part {PART}
"""

nbCode:
  const MAPLEN = 1000

  type
    Point = tuple
      x,y: int
    GridType = enum
      Air, Rock, Sand
    Map = array[MAPLEN, array[MAPLEN, GridType]]
  
  var
    answer, leftHeap, rightHeap, floorLevel: Natural

  proc newPoint(s: string): Point = assert scanf(s, "$i,$i", result.x, result.y)

  proc isStanding(heap: var Natural, y: Natural): bool =
    let h = MAPLEN - y
    if heap > (h-1) * h div 2: return true
    heap.inc

  proc dropSand(m: var Map): bool =
    result = true
    var 
      s: Point = (500, 0)
      i = 0
    if m[s.x][s.y] == Sand: return false
    while true:
      if s.y+i == floorLevel: 
        m[s.x][s.y+i-1] = Rock
        return true
      if m[s.x][s.y+i] == Air: 
        i.inc
        continue
      if m[s.x][s.y+i] in {Rock, Sand}:
        if s.x == 0:
          if leftHeap.isStanding(s.y+i): m[s.x][s.y+i-1] = Rock
          return true
        elif s.x == MAPLEN-1:
          if rightHeap.isStanding(s.y+i): m[s.x][s.y+i-1] = Rock
          return true
        if m[s.x-1][s.y+i] == Air: 
          s.x.dec
        elif m[s.x+1][s.y+i] == Air: 
          s.x.inc
        else: 
          m[s.x][s.y+i-1] = Sand
          return true

  proc createRockLine(map: var Map, a, b: Point) =
    floorLevel = max(floorLevel, max(a.y+2, b.y+2))
    if a.x < b.x:
      for x in a.x..b.x: map[x][a.y] = Rock
    elif a.x > b.x:
      for x in b.x..a.x: map[x][a.y] = Rock
    elif a.y < b.y:
      for y in a.y..b.y: map[a.x][y] = Rock
    elif a.y > b.y:
      for y in b.y..a.y: map[a.x][y] = Rock

  proc createRocks(map: var Map, points: var seq[string]) =
    var
      rockStart = newPoint(points.pop)
      rockEnd = newPoint(points.pop)
    map.createRockLine(rockStart, rockEnd)
    while points.len > 0:
      rockStart = rockEnd
      rockEnd = newPoint(points.pop)
      map.createRockLine(rockStart, rockEnd)

  proc loadMap(): Map =
    for line in "input.txt".lines:
      var points = line.split(" -> ")
      result.createRocks(points)
        
  var map = loadMap()
  while map.dropSand: answer.inc

nbText: fmt"""
Answer is: **{answer}**
"""

nb.filename = fmt"../../html/{DOCNAME}.html"
nbSave
