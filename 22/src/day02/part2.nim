import strformat, strutils
import nimib

const 
  DAY = 2
  PART = 2
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
    Outcome = enum
      win, draw, lose
    GameRound = object
      us, them: Shape
      outcome: Outcome

  var answer: Natural

  proc parseShape(strShape: char): Shape =
    case strShape
    of 'A': return rock
    of 'B': return papper
    of 'C': return scissors
    else:
      raise newException(OSError, "Unable to parse: " & strShape)

  proc parseOutcome(expOutcome: char): Outcome =
    case expOutcome
    of 'X': return lose
    of 'Y': return draw
    of 'Z': return win
    else:
      raise newException(OSError, "Unable to parse: " & expOutcome)

  proc whatWins(s: Shape): Shape = 
    case s
    of rock: return papper
    of papper: return scissors
    of scissors: return rock

  proc whatDraws(s: Shape): Shape = s

  proc whatLoses(s: Shape): Shape = 
    case s
    of rock: return scissors
    of papper: return rock
    of scissors: return papper

  proc pickForUs(them: Shape, expOutcome: Outcome): Shape =
    case expOutcome
    of win: return whatWins(them)
    of draw: return whatDraws(them)
    of lose: return whatLoses(them)

  proc newRound(strThem, expOutcome: char): GameRound =
    result.them = parseShape(strThem)
    result.outcome = parseOutcome(expOutcome)
    result.us = pickForUs(result.them, result.outcome)

  func score(g: GameRound): Natural =
    case g.us
    of rock: result.inc 
    of papper: result.inc 2
    of scissors: result.inc 3
    if g.outcome == win: result.inc 6
    elif g.outcome == draw: result.inc 3

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
