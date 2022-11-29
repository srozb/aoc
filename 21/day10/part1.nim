const 
  OPENS = "([{<"
  CLOSES = ")]}>"

var score: int

proc addScoredChar(s: var int, c: char) {.inline.} =
  case c
  of ')':
    s.inc 3
  of ']':
    s.inc 57
  of '}':
    s.inc 1197
  of '>':
    s.inc 25137
  else:
    return

for line in "input.txt".lines:
  var stack = newSeq[char]()
  for ch in line:
    if ch in OPENS:
      stack.add(ch)
    elif OPENS.find(stack.pop) != CLOSES.find(ch):
      score.addScoredChar(ch)
      break

echo "The score is: " & $score