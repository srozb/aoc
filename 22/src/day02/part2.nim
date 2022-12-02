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

  var answer: int

  proc parseShape(strShape: string): Shape =
    case strShape.strip.toLower
    of "a": return rock
    of "b": return papper
    of "c": return scissors
    else:
      raise newException(OSError, "Unable to parse: " & strShape)

  proc parseOutcome(expOutcome: string): Outcome =
    case expOutcome.strip.toLower
    of "x": return lose
    of "y": return draw
    of "z": return win
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

  proc newRound(strThem, expOutcome: string): GameRound =
    result.them = parseShape(strThem)
    result.outcome = parseOutcome(expOutcome)
    result.us = pickForUs(result.them, result.outcome)

  func score(g: GameRound): int =
    case g.us
    of rock: result.inc 
    of papper: result.inc 2
    of scissors: result.inc 3
    if g.outcome == win: result.inc 6
    elif g.outcome == draw: result.inc 3

  for l in "input.txt".lines:
    if l.len != 3:
      continue
    let round = newRound(l.splitWhitespace[0], l.splitWhitespace[1])
    answer.inc(round.score)

nbText: fmt"""
Answer is: **{answer}**
"""

nb.filename = fmt"../../html/{DOCNAME}.html"
nbSave
