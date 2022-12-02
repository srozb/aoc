import std/setutils
import sequtils
import strutils
import strformat
import nimib

const 
  DAY = 8
  PART = 2
  DOCNAME = fmt"d{DAY:02}p{PART}"

nbInit
nb.title = DOCNAME

nbText: fmt"""
# Day {DAY:02} part {PART}
"""

nbCode:
  const fullSet = {'a'..'g'}
  var score: int

  type 
    DigitLine = enum
      unknown, up, leftup, rightup, leftdn, rightdn, down, semi
    Digit = set[DigitLine]
    LookupTable = array['a'..'g', DigitLine]

  proc getVal[T](self: set[T]): T =
    for i in self:
      return i

  proc `xor`(x, y: set[char]): set[char] =
    result = fullSet - (x * y)

  proc index(x: LookupTable, value: DigitLine): char =
    for i,j in x:
      if j == value:
        return i

  proc guess(self: var LookupTable, pats: seq[set[char]]) =
    var guessed: array[10, set[char]]
    for p in pats:  # easy to guess
      if p.len == 2:
        guessed[1] = p
      elif p.len == 3:
        guessed[7] = p
      elif p.len == 4:
        guessed[4] = p
      elif p.len == 7:
        guessed[8] = p
    self[(guessed[7] - guessed[4]).getVal] = up
    var twothreefive = pats.filterIt(it.len == 5)
    self[(twothreefive[0] * twothreefive[1] * twothreefive[2] * guessed[4]).getVal] = semi
    self[(twothreefive[0] * twothreefive[1] * twothreefive[2] - {self.index(up), self.index(semi)}).getVal] = down
    var sixandnine = pats.filterIt(it.len == 6 and it.contains(self.index(semi)))
    guessed[0] = pats.filterIt(it.len == 6 and not it.contains(self.index(semi)))[0]
    self[((sixandnine[0] xor sixandnine[1]) * guessed[1]).getVal] = rightup
    self[(guessed[1] - {self.index(rightup)}).getVal] = rightdn
    self[(guessed[4] - (guessed[1] + {self.index(semi)})).getVal] = leftup
    for i,j in self:
      if j == unknown:
        self[i] = leftdn
        break

  proc decode(enc: string, mapping: LookupTable): Digit =
    for ch in enc:
      let dl = mapping[ch]
      result.incl({dl})
    
  proc read(d: Digit): int =
    case d.len
    of 2:
      return 1
    of 3:
      return 7
    of 4:
      return 4
    of 7:
      return 8
    elif d == {up, rightup, semi, leftdn, down}:
      return 2
    elif d == {up, rightup, semi, rightdn, down}:
      return 3
    elif d == {up, leftup, semi, rightdn, down}:
      return 5
    elif d == {up, leftup, semi, rightdn, down, leftdn}:
      return 6
    elif d == {up, rightup, leftup, semi, rightdn, down}:
      return 9
    elif d == {up, leftup, rightup, leftdn, rightdn, down}:
      return 0

  for l in "input.txt".lines:
    var 
      myTable: LookupTable
      partialScore: int
      multiplier = 1000
    let
      buf = l.splitWhitespace
      patterns = buf[0..9]
      lineDigits = buf[11..14]
      patt_sets = patterns.mapIt(toSet(it))
    myTable.guess(patt_sets)
    for dig in lineDigits:
      let digitView = dig.decode(myTable)
      partialScore += (digitView.read * multiplier)
      multiplier = multiplier div 10
    score += partialScore

nbText: fmt"""
Answer is: **{score}**
"""

nb.filename = fmt"../../html/{DOCNAME}.html"
nbSave