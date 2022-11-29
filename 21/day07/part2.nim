import strutils

const MAX_SIZE = 2000

var 
  submarines = newSeq[int]()
  pos_cost = int.high

let initialState = "input.txt".readFile
for item in initialState.split(","):
  submarines.add(item.parseInt)

proc scoreMove(self: seq[int], pos: int): int =
  for sm in self:
    var length = ((sm - pos).abs).float
    result += ((length+1)*(length/2)).int

for i in 0..<MAX_SIZE:
  var score = submarines.scoreMove(i)
  if score < pos_cost:
    pos_cost = score

echo "Answer is: " & $pos_cost