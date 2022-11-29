import algorithm
import strutils

const 
  OPENS = "([{<"
  CLOSES = ")]}>"

var scoreSeq = newSeq[int]()

proc isValid(line: string): bool {.inline.} =
  result = true
  var stack = newSeq[char]()
  for ch in line:
    if ch in OPENS:
      stack.add(ch)
    elif OPENS.find(stack.pop) != CLOSES.find(ch):
      return false

proc addStack(s: var int, st: var seq[char]) =
  st.reverse
  while st.len > 0:
    s = s * 5
    case st.pop
    of ')':
       s.inc
    of ']':
      s.inc 2
    of '}':
      s.inc 3
    of '>':
      s.inc 4
    else:
      return

for line in "input.txt".lines:
  if not line.isValid:
    continue
  var 
    stack = newSeq[char]()
    completeStack = newSeq[char]()
    partialScore: int
  let rLine = line.reversed
  for ch in rLine:
    if ch in CLOSES:
      stack.add(ch)
    elif stack.len == 0:
      completeStack.add(CLOSES[OPENS.find(ch)])
    else:
      discard stack.pop
  partialScore.addStack completeStack
  scoreSeq.add(partialScore)
  
echo "The score is: " & $scoreSeq.sorted[scoreSeq.len div 2]
