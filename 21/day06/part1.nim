import strutils
import sequtils

const
  INTERNAL_PEROID = 8
  PEROID = 6
  DAYS = 80

var 
  lFish = newSeq[int]()

let initialState = "input.txt".readFile

proc resetPeroid[T](x: T): T =
  if x < 0:
    return PEROID
  return x

proc grow(lFish: var seq[int]) =
  lFish.apply(proc(x:int): int = x - 1)
  var newBornCount = lFish.count(-1)
  var newBorns = newSeqWith(newBornCount, INTERNAL_PEROID)
  lFish.apply(resetPeroid)
  lFish = lFish.concat(newBorns)

for lf in initialState.split(","):
  lFish.add(lf.parseInt)

for day in 0..<DAYS:
  lFish.grow  

echo "Answer is: " & $lFish.len