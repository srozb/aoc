import strformat, strutils, sequtils, algorithm
import nimib

const 
  DAY = 13
  PART = 2
  DOCNAME = fmt"d{DAY:02}p{PART}"

nbInit
nb.title = DOCNAME

nbText: fmt"""
# Day {DAY:02} part {PART}
"""

nbCode:
  var
    answer: Natural

  proc isNumber(s: string): bool {.inline.} =
    result = true
    for c in s:
      result = result and c.isDigit

  proc isEmptyList(s: string): bool = s.strip == "[]"

  proc isFullEnclosed(s: string): bool =  # might be buggy for '[]'
    if s[0] != '[' or s[s.len-1] != ']': return false
    var brCounter: int
    for i in 0..<s.len:
      if s[i] == '[': brCounter.inc
      elif s[i] == ']': brCounter.dec
      if brCounter == 0 and i != s.len-1: return false
    return true

  proc isNumSerie(s: string): bool = 
    return ',' in s and s[0..<s.find(',')-1].isNumber

  proc isListSerie(s: string): bool =
    if s[0] != '[': return false
    var brCounter: int
    for i in 0..<s.len:
      if s[i] == '[': brCounter.inc
      if brCounter == 0:
        return s[i] == ','
      elif s[i] == ']': brCounter.dec

  proc stripList(s: string): string = result = s[1..<s.len-1]

  proc ensureList(s: string): string {.inline.} =
    result = s
    if s.strip == "": return  # ignore empty stirngs
    if not s.isFullEnclosed: return '[' & s & ']'

  proc getFirstNumber(s: string): string = 
    if ',' notin s: return s
    s[0..<s.find(',')]
  
  proc getFirstList(s: string): string =
    if s[0] != '[': raise newException(OSError, "Unable to get List element")
    var brCounter: int
    for i in 0..<s.len:
      if s[i] == '[': brCounter.inc
      elif s[i] == ']': brCounter.dec
      if brCounter == 0: return s[1..<i]

  proc getFirstElement(s: string): string =
    if s[0] == '[': return s.getFirstList
    s.getFirstNumber

  proc discardFirstElement(s: string): string =
    if ',' notin s: return
    result = s[s.find(',')+1..<s.len]

  proc correctOrder(left, right: string): int =
    if left.strip == "": return -1
    if right.strip == "": return 1
    if left.isEmptyList:
      return -1
    if right.isEmptyList: 
      return 1
    if left.isNumber and right.isNumber:
      if left.parseInt < right.parseInt: return -1
      return 1
    if left.isNumSerie and right.isNumSerie:
      if left.getFirstNumber == right.getFirstNumber: 
        return correctOrder(left.discardFirstElement, right.discardFirstElement)
      if left.getFirstNumber.parseInt < right.getFirstNumber.parseInt:
        return -1
      return 1
    if left.isNumSerie and right.isNumber or left.isNumber and right.isNumSerie:
      if left.getFirstNumber == right.getFirstNumber:
        result = correctOrder(left.discardFirstElement, right.discardFirstElement)
        return result
      return correctOrder(left.getFirstNumber, right.getFirstNumber)
    if left.isListSerie and right.isListSerie:
      if left.getFirstElement == right.getFirstElement:
        return correctOrder(left.discardFirstElement, right.discardFirstElement)
      return correctOrder(left.getFirstElement, right.getFirstElement)
    if left.isListSerie xor right.isListSerie:
      return correctOrder(left.getFirstElement.ensureList, right.getFirstElement.ensureList)
    if left.isFullEnclosed and right.isFullEnclosed:
      return correctOrder(left.stripList, right.stripList)
    if left.isFullEnclosed xor right.isFullEnclosed:
      return correctOrder(left.ensureList, right.ensureList)

  var input = "input.txt".readFile.strip.split("\n").filterIt(it.len > 0)
  input.add @["[[2]]", "[[6]]"]

  input.sort(correctOrder)

  answer = (input.find("[[2]]")+1) * (input.find("[[6]]")+1)

nbText: fmt"""
Answer is: **{answer}**
"""

nb.filename = fmt"../../html/{DOCNAME}.html"
nbSave
