import strformat, strutils, strscans
import nimib

const 
  DAY = 15
  PART = 1
  DOCNAME = fmt"d{DAY:02}p{PART}"

nbInit
nb.title = DOCNAME

nbText: fmt"""
# Day {DAY:02} part {PART}
"""

nbCode:
  const
    SCAN_Y = 2000000
  type
    Dimension = tuple
      xmin, xmax, ymin, ymax: int
    Sensor = ref object
     x,y: int
     scanRange: Natural
    Beacon = ref object
      x, y: int
  
  var
    answer: Natural
    mapDimensions: Dimension
    beaconsFound: seq[Beacon]

  proc `notin`(coords: (int, int), beacons: seq[Beacon]): bool =
    result = true
    for b in beacons: 
      if b.x == coords[0] and b.y == coords[1]: return false

  proc Covers(s: Sensor, x, y: int): bool =
    return abs(s.x - x) + abs(s.y - y) <= s.scanRange

  proc newSensor(x, y, bx, by: int): Sensor =
    result = new Sensor
    result.x = x
    result.y = y
    result.scanRange = abs(x - bx) + abs(y - by)

  proc loadObjects(): seq[Sensor] =
    for line in "input.txt".lines:
      var sx, sy, bx, by: int
      if not scanf(line, "Sensor at x=$i, y=$i: closest beacon is at x=$i, y=$i", sx, sy, bx, by): continue
      mapDimensions.xmin = min(mapDimensions.xmin, min(sx, bx))
      mapDimensions.ymin = min(mapDimensions.ymin, min(sy, by))
      mapDimensions.xmax = max(mapDimensions.xmax, max(sx, bx))
      mapDimensions.ymax = max(mapDimensions.ymax, max(sy, by))
      beaconsFound.add Beacon(x: bx, y: by)
      result.add newSensor(sx, sy, bx, by)

  var sensors = loadObjects()

  for x in mapDimensions.xmin..mapDimensions.xmax:
    for s in sensors:
      if s.Covers(x, SCAN_Y) and (x, SCAN_Y) notin beaconsFound:
        answer.inc
        break

nbText: fmt"""
Answer is: **{answer}**
"""

nb.filename = fmt"../../html/{DOCNAME}.html"
nbSave
