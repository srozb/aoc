import strformat, strutils
import nimib

const 
  DAY = 2
  PART = 1
  DOCNAME = fmt"d{DAY:02}p{PART}"

nbInit
nb.title = DOCNAME

nbText: fmt"""
# Day {DAY:02} part {PART}
"""

nbCode:
  type
    Shape = enum
      rock, papper, scissors
    GameRound = object
      them, us: Shape

  var answer: Natural

  proc parse(strShape: char): Shape =
    case strShape
    of 'A', 'X': return rock
    of 'B', 'Y': return papper
    of 'C', 'Z': return scissors
    else:
      raise newException(OSError, "Unable to parse: " & strShape)

  proc newRound(strThem, strUs: char): GameRound =
    result.them = parse(strThem)
    result.us = parse(strUs)

  func isWon(g: GameRound): bool =
    (g.them == rock and g.us == papper or
      g.them == papper and g.us == scissors or
      g.them == scissors and g.us == rock)

  func isDraw(g: GameRound): bool =
    g.them == g.us

  func score(g: GameRound): Natural =
    case g.us
    of rock: result.inc 
    of papper: result.inc 2
    of scissors: result.inc 3
    if g.isWon: result.inc 6
    elif g.isDraw: result.inc 3

  for l in "input.txt".lines:
    if l.len != 3:
      continue
    let round = newRound(l[0], l[2])
    answer.inc(round.score)

nbText: fmt"""
Answer is: **{answer}**
"""

nb.filename = fmt"../../html/{DOCNAME}.html"
nbSave
