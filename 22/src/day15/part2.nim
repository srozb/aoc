import strformat, strutils, strscans
import nimib

const 
  DAY = 15
  PART = 2
  DOCNAME = fmt"d{DAY:02}p{PART}"

nbInit
nb.title = DOCNAME

nbText: fmt"""
# Day {DAY:02} part {PART}
"""

nbCode:
  const
    LIMIT = 4_000_000
  type
    Sensor = ref object
     x,y: int
     scanRange, overRange: Natural
  
  var
    answer: Natural
    sensors: seq[Sensor]
  
  iterator getBounds(s: Sensor): (int, int) =
    for i in 0..s.overRange:
      var bPoint = (s.x + i, s.y + s.overRange - i)
      if bPoint[0] > 0 and bPoint[1] >= 0: yield bPoint
      bPoint = (s.x + i, s.y - s.overRange + i)
      if bPoint[0] > 0 and bPoint[1] >= 0: yield bPoint
      bPoint = (s.x - i, s.y + s.overRange - i)
      if bPoint[0] > 0 and bPoint[1] >= 0: yield bPoint
      bPoint = (s.x - i, s.y - s.overRange + i)
      if bPoint[0] > 0 and bPoint[1] >= 0: yield bPoint

  proc isCovered(s: Sensor, p: (int, int)): bool =
    return abs(s.x - p[0]) + abs(s.y - p[1]) <= s.scanRange

  proc newSensor(x, y, bx, by: int): Sensor =
    result = new Sensor
    result.x = x
    result.y = y
    result.scanRange = abs(x - bx) + abs(y - by)
    result.overRange = result.scanRange + 1

  proc loadObjects(): seq[Sensor] =
    for line in "input.txt".lines:
      var sx, sy, bx, by: int
      if not scanf(line, "Sensor at x=$i, y=$i: closest beacon is at x=$i, y=$i", sx, sy, bx, by): continue
      result.add newSensor(sx, sy, bx, by)

  proc coveredExcept(p: (int, int), exceptId: Natural): bool =    
    for i in 0..sensors.len-1:
      if i == exceptId: continue
      if sensors[i].isCovered(p): return true

  proc bruteForce(): (int, int) =
    for i in 0..<sensors.len:
      for candidate in sensors[i].getBounds:
        if not candidate.coveredExcept(i): 
          if candidate[0] > LIMIT or candidate[1] > LIMIT: continue
          return candidate
        
  sensors = loadObjects()
  var beacon = bruteForce()
  answer = beacon[0] * 4_000_000 + beacon[1]

nbText: fmt"""
Answer is: **{answer}**
"""

nb.filename = fmt"../../html/{DOCNAME}.html"
nbSave
