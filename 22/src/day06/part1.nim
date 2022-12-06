import strformat, strutils, sets
import std/streams
import nimib

const 
  DAY = 6
  PART = 1
  DOCNAME = fmt"d{DAY:02}p{PART}"

nbInit
nb.title = DOCNAME

nbText: fmt"""
# Day {DAY:02} part {PART}
"""

nbCode:
  const BUFLEN = 4

  proc push(a: var array[BUFLEN, char], c: char) =
    if '\0' in a:
      a[a.find('\0')] = c
    else:
      for i in 0..<a.len-1: a[i] = a[i+1]
      a[a.len-1] = c

  proc isPacketStart(a: array[BUFLEN, char]): bool =
    result = not('\0' in a) and a.len == toHashSet(a).len

  var
    buffer: array[BUFLEN, char]
    fs = newFileStream("input.txt", fmRead)
    answer: Natural

  while not fs.atEnd:
    answer.inc
    buffer.push fs.readChar
    if buffer.isPacketStart: break


nbText: fmt"""
Answer is: **{answer}**
"""

nb.filename = fmt"../../html/{DOCNAME}.html"
nbSave
