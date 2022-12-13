import strformat, strutils, sets, std/deques
import nimib

const 
  DAY = 12
  PART = 2
  DOCNAME = fmt"d{DAY:02}p{PART}"

nbInit
nb.title = DOCNAME

nbText: fmt"""
# Day {DAY:02} part {PART}
"""

nbCode:
  const 
    XLEN = 101
    YLEN = 41

  type
    Position = tuple
      x, y: int
    Edge = tuple
      head, tail: Position
    HeightMap = array[XLEN, array[YLEN, char]]

  var
    hMap: HeightMap
    answer: Natural = Natural.high
    startPos, endPos: Position
    edges: Deque[Edge]

  proc `$`(p: Position): string = fmt"[{hMap[p.x][p.y]}]({p.x+1},{p.y+1})"
  proc `-`(a, b: Position): int = ord(hMap[a.x][a.y]) - ord(hMap[b.x][b.y])

  proc parent(p: Position): Position =
    for e in edges:
      if e.tail == p: return e.head
    raise newException(OSError, fmt"No parent for {p}. Node unreachable.")

  iterator neighbors(p: Position): Position =
    for i in [-1, 1]:
      if p.x+i >= 0 and p.x+i < XLEN:
        var neigh: Position = (p.x+i, p.y)
        if p - neigh <= 1: yield neigh
      if p.y+i >= 0 and p.y+i < YLEN:
        var neigh: Position = (p.x, p.y+i)
        if p - neigh <= 1: yield neigh

  proc readFile() =
    var y: Natural
    for line in "input.txt".lines:
      for x in 0..<line.len:
        hMap[x][y] = line[x]
        if line[x] == 'S': 
          startPos = (x, y)
          hMap[x][y] = 'a'
        if line[x] == 'E': 
          endPos = (x, y)
          hMap[x][y] = 'z'
      y.inc

  proc buildTree(root: Position) =
    var 
      queue: Deque[Position]
      visited: HashSet[Position]
    queue.addLast(root)
    while queue.len > 0:
      var head = queue.popFirst
      for tail in head.neighbors:
        if tail in visited: continue
        queue.addLast(tail)
        var e: Edge = (head, tail)
        edges.addLast(e)
        visited.incl tail
      visited.incl head

  proc countSteps(target: Position): Natural =
    var node = target
    while node != endPos:
      result.inc
      node = node.parent

  proc getTargets(): seq[Position] = 
    result = newSeq[Position]()
    for x in 0..<hMap.len:
      for y in 0..<hMap[x].len:
        if hMap[x][y] == 'a': 
          var p: Position = (x, y)
          result.add p

  readFile()
  
  buildTree(endPos)

  for t in getTargets():
    try:
      let steps = countSteps(t)
      answer = min(answer, steps)
    except OSError: continue
    

nbText: fmt"""
Answer is: **{answer}**
"""

nb.filename = fmt"../../html/{DOCNAME}.html"
nbSave
