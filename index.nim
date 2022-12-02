import strformat, strutils, sequtils
import os
import nimib

const 
  TITLE = "Advent of Code"

let paths = toSeq(walkPattern("2*/html/d*p*.html"))

proc asTable(s: seq[string], year = ""): string =
  var day: int
  result = fmt"## 20{year:02}" & "\n\n"
  result.add fmt"| day | solutions |" & '\n'
  result.add "|----------|----------|\n"
  for i in 0..<s.len:
    if not s[i].startsWith(year): continue
    if i mod 2 == 0:
      day.inc
      result.add fmt"| {day} | [input]({year}/src/day{i+1:02}/input.txt) [part 1]({s[i]})"
      if i == s.len - 1: result.add " |\n"
    elif i < s.len: 
      result.add fmt" [part 2]({s[i]})"
      result.add " |\n"

nbInit

nb.title = TITLE

nbText: fmt"""
# {TITLE}

{paths.asTable("21")}
{paths.asTable("22")}

"""

nb.filename = "index.html"
nbSave
