import strutils

const 
  CAVEW = 100
  CAVEH = 100

type
  Heightmap = array[CAVEW, array[CAVEH, int]]

var
  cave: Heightmap

proc readFile(fn: string) =
  var j: int
  for line in fn.lines:
    for i in 0..<line.len:
      cave[i][j] = ($line[i]).parseInt
    j.inc

proc isLowPoint(hm: Heightmap, x, y: int): bool =
  let me = hm[x][y]
  if x>0 and hm[x-1][y] <= me:
    return false
  elif x+1<CAVEW and hm[x+1][y] <= me:
    return false
  elif y>0 and hm[x][y-1] <= me:
    return false
  elif y+1<CAVEH and hm[x][y+1] <= me:
    return false
  return true

proc `$`(x: Heightmap): string =
  for j in 0..<CAVEH:
    for i in 0..<CAVEW:
      if x.isLowPoint(i,j):
        result.add("X")
      else:
        result.add($(x[i][j]))
    result.add('\n')

proc countScore(x: Heightmap): int =
  for j in 0..<CAVEH:
    for i in 0..<CAVEW:
      if x.isLowPoint(i,j):
        result.inc(x[i][j] + 1) 

readFile("input.txt")
echo "The score is: " & $cave.countScore

