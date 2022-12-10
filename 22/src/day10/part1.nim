import strformat, strutils, std/strscans
import nimib

const 
  DAY = 10
  PART = 1
  DOCNAME = fmt"d{DAY:02}p{PART}"

nbInit
nb.title = DOCNAME

nbText: fmt"""
# Day {DAY:02} part {PART}
"""

nbCode:
  type
    CPU = ref object
      x, cycles: int

  var
    answer: int
    crtCpu = CPU(x: 1)

  proc tick(cpu: var CPU) =
    cpu.cycles.inc
    if (cpu.cycles - 20) mod 40 == 0: answer.inc cpu.cycles * cpu.x

  proc addx(cpu: var CPU, addVal: int) =
    for i in 0..<2: cpu.tick
    cpu.x.inc addVal

  for line in "input.txt".lines:
    var addVal: int
    if scanf(line, "addx $i", addVal): crtCpu.addx(addVal)
    elif "noop" in line: crtCpu.tick()

nbText: fmt"""
Answer is: **{answer}**
"""

nb.filename = fmt"../../html/{DOCNAME}.html"
nbSave
