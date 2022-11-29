import strutils
import sequtils

var 
  increased: int
  fixedStack = newSeq[int](4)

proc push(self: var seq, newItem: int) =
  self.add(newItem)
  self.delete(0)

proc isIncreasing(self: var seq): bool =
  result = self[0] + self[1] + self[2] < self[1] + self[2] + self[3]

for l in "input.txt".lines:
  fixedStack.push(l.parseInt)
  if fixedStack[0] == 0:
    continue  # loop until whole stack is filled with measurments
  if fixedStack.isIncreasing:
    increased.inc

echo "Answer is: " & $increased