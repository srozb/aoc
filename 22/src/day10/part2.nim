import strformat, strutils, std/strscans
import nimib

const 
  DAY = 10
  PART = 2
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
    SCREEN = array[6, array[40, bool]]

  var
    crtCpu = CPU(x: 1)
    scr: SCREEN

  proc pixelPos(): Natural =
    crtCpu.cycles mod 40

  proc spritePos(): seq[int] =
    result = newSeq[int](3)
    result[1] = crtCpu.x
    result[0] = result[1] - 1
    result[2] = result[1] + 1

  proc draw(cycles, spritePos: int) =
    scr[(cycles-1) div 40][cycles mod 40] = pixelPos() in spritePos()

  proc `$`(s: SCREEN): string =
    for row in 0..<s.len:
      for col in 0..<s[row].len:
        if s[row][col]: result.add "#"
        else: result.add "."
      result.add "\n"

  proc tick(cpu: var CPU) =
    draw(cpu.cycles, cpu.x)
    cpu.cycles.inc

  proc addx(cpu: var CPU, addVal: int) =
    for i in 0..<2: cpu.tick
    cpu.x.inc addVal

  for line in "input.txt".lines:
    var addVal: int
    if scanf(line, "addx $i", addVal): crtCpu.addx(addVal)
    elif "noop" in line: crtCpu.tick()

nbText: fmt"""
Answer is:
  ```
  {scr}
  ```
"""

nb.filename = fmt"../../html/{DOCNAME}.html"
nbSave
