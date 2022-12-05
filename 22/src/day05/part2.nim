import strformat, strutils
import std/strscans
import nimib

const 
  DAY = 5
  PART = 2
  DOCNAME = fmt"d{DAY:02}p{PART}"

nbInit
nb.title = DOCNAME

nbText: fmt"""
# Day {DAY:02} part {PART}
"""

nbCode:
  type
    Stacks = seq[seq[char]]

  var stacks: Stacks
  while stacks.len <= 9: stacks.add @[]

  proc `$`(stacks: Stacks): string =
    for stack in stacks:
      if stack.len > 0: result.add stack[stack.len-1]

  proc move(num: var int, src, dst: int) =
    for _ in 0..<num: stacks[stacks.len-1].add stacks[src-1].pop
    while stacks[stacks.len-1].len > 0:
      stacks[dst-1].add stacks[stacks.len-1].pop

  proc parseState(line: string) =
    for i in 0..<line.len:
      if line[i].isUpperAscii:
        stacks[(i-1) div 4].insert(line[i])

  for l in "input.txt".lines:
    var src, dst, num: int
    if not l.startsWith("move"): l.parseState
    if scanf(l, "move $i from $i to $i", num, src, dst): move(num, src, dst)

nbText: fmt"""
Answer is: **{stacks}**
"""

nb.filename = fmt"../../html/{DOCNAME}.html"
nbSave
