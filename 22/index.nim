import strformat, strutils
import std/sequtils
import os
import nimib

let paths = toSeq(walkPattern("html/d*p*.html"))

proc asTable(s: seq[string], title = ""): string =
  var day: int
  result = fmt"| day | solutions |" & '\n'
  result.add "|----------|----------|\n"
  for i in 0..<s.len:
    if i mod 2 == 0:
      day.inc
      result.add fmt"| {day} | [input](src/day{i+1:02}/input.txt) [part 1]({s[i]})"
      if i == s.len - 1: result.add " |\n"
    elif i < s.len: 
      result.add fmt" [part 2]({s[i]})"
      result.add " |\n"

nbInit

nb.title = "AOC 2022 Index"

nbText: fmt"""
# AOC 2022

{paths.asTable("solutions")}
"""

nb.filename = "index.html"
nbSave
