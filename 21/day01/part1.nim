import strutils

var 
  curVal, prevVal, increased: int

for l in "input.txt".lines:
  if prevVal == 0:
    prevVal = l.parseInt
    continue
  curVal = l.parseInt
  if curVal > prevVal:
    increased.inc
  prevVal = curVal

echo "Answer is: " & $increased