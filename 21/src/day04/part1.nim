import strutils
import strformat
import nimib

const 
  DAY = 4
  PART = 1
  DOCNAME = fmt"d{DAY:02}p{PART}"

nbInit
nb.title = DOCNAME

nbText: fmt"""
# Day {DAY:02} part {PART}
"""

nbCode:
  type
    Rows = array[5, int]
    BingoCard = array[5, Rows]
    CardSeq = seq[BingoCard]

  iterator rowItems(a: BingoCard, row_num: int): int {.inline.} =
    var i = 0
    let L = a[row_num].len
    while i < L:
      yield a[row_num][i]
      inc i

  iterator colItems(a: BingoCard, col_num: int): int {.inline.} =
    var i = 0
    let L = a.len
    while i < L:
      yield a[i][col_num]
      inc i

  proc newCard(data: string): BingoCard =
    var rows = data.splitLines
    for i, l in rows:
      var cols = l.splitWhitespace
      for j, value in cols:
        result[i][j] = value.parseInt

  proc parseNumbers*(numLine: string): seq[int] =
    for n in numLine.split(","):
      result.add(parseInt(n))

  proc `$`(self: BingoCard): string =
    for col in self:
      result.add(join(col, "|") & "\n")

  proc hit(self: var BingoCard, number: int): BingoCard {.inline.} =
    result = self
    for i, row in self:
      for j, num in row:
        if num == number:
          self[i][j] = 0
          return self
      
  proc score(self: BingoCard): int {.inline.} =
    for row in self:
      for val in row:
        result.inc(val)

  proc wins(self: BingoCard): bool {.inline.} =
    result = false
    for i in 0..<self.len:
      var valSum = 0
      for field in self.rowItems(i):
        valSum.inc(field)
      if valSum == 0:
        return true
      valSum = 0
      for field in self.colItems(i):
        valSum.inc(field)
      if valSum == 0:
        return true
      
  proc hit(self: var CardSeq, number: int) =
    for i in 0..<self.len:
      var card = self[i]
      self[i] = card.hit(number)

  proc readCards*(fn: File): CardSeq = 
    while true:
      var buf: string
      try:
        discard fn.readLine
        buf = ""
        for _ in 0..4:
          buf.add(fn.readLine & "\n")
        var card = newCard(buf)
        result.add(card)
      except EOFError:
        break

  proc playGame*(cards: var CardSeq, numbers: seq[int]): int =
    for n in numbers:    
      cards.hit(n)
      for i, card in cards:
        if card.wins:
          return (card.score * n)

  var fn = open("input.txt")
  let numbers = parseNumbers(fn.readLine)
  var cards = readCards(fn)

nbText: fmt"""
Answer is: **{cards.playGame(numbers)}**
"""

nb.filename = fmt"../../html/{DOCNAME}.html"
nbSave
