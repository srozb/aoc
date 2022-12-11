import strformat, strutils, algorithm, sequtils
import nimib

const 
  DAY = 11
  PART = 1
  DOCNAME = fmt"d{DAY:02}p{PART}"

nbInit
nb.title = DOCNAME

nbText: fmt"""
# Day {DAY:02} part {PART}
"""

nbCode:
  const ROUNDS = 20

  type
    Monkey = ref object
      items: seq[Natural]
      riskOp: proc(risk: Natural): Natural
      divisor, passTrue, passFalse, inspectCount: Natural

  var
    monkeys = newSeq[Monkey]()
    answer: Natural

  proc inspectItems(m: var Monkey) =
    m.items.apply(m.riskOp)
    for item in m.items:
      m.inspectCount.inc
      let targetMonkey = if item mod m.divisor == 0: m.passTrue else: m.passFalse
      monkeys[targetMonkey].items.add item
    m.items = @[]

  proc newMonkey(s: string): Monkey =
    result = Monkey()
    var attrs = s.splitLines
    while attrs.len > 0:
      var a = attrs.pop.split(':')
      case a[0]
      of "  Starting items":
        a[1] = a[1].replace(" ", "")
        for i in a[1].split(','): result.items.add i.parseInt
      of "  Operation":
        let parsed = a[1].rsplit(' ', 2)
        if parsed[1] == "*" and parsed[2] == "old":
          result.riskOp = proc(risk: Natural): Natural = risk * risk div 3
        elif parsed[1] == "*":
          result.riskOp = proc(risk: Natural): Natural = 
            (risk * parsed[2].parseInt) div 3
        elif parsed[1] == "+" and parsed[2] == "old":
          result.riskOp = proc(risk: Natural): Natural = 2 * risk div 3
        elif parsed[1] == "+":
          result.riskOp = proc(risk: Natural): Natural = 
            (risk + parsed[2].parseInt) div 3
      of "  Test":
        result.divisor = a[1].rsplit(' ', 1)[1].parseInt
      of "    If true":
        result.passTrue = a[1].rsplit(' ', 1)[1].parseInt
      of "    If false":
        result.passFalse = a[1].rsplit(' ', 1)[1].parseInt
      else: discard

  for m in "input.txt".readFile().split("\n\n"):
    monkeys.add newMonkey(m)

  for _ in 0..<ROUNDS:
    for i in 0..<monkeys.len:
      if monkeys[i].items.len > 0: monkeys[i].inspectItems()

  var inspectCounts = newSeq[Natural](monkeys.len)
  for i in 0..<monkeys.len: inspectCounts[i] = monkeys[i].inspectCount
  inspectCounts.sort(Descending)
  answer = inspectCounts[0] * inspectCounts[1]


nbText: fmt"""
Answer is: **{answer}**
"""

nb.filename = fmt"../../html/{DOCNAME}.html"
nbSave
