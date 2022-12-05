import strformat, strutils, os
import nimib

const 
  TITLE = "Advent of Code"

proc byYear(year: Natural): string =
  let yearStr = ($year)[2..3]
  result = fmt"## {year}" & "\n\n"
  result.add fmt"| day | solutions |" & '\n'
  result.add "|----------|----------|\n"
  for day in 1..25:
    let
      inFile = fmt"{yearStr}/src/day{day:02}/input.txt"
      pOneFile = fmt"{yearStr}/html/d{day:02}p1.html"
      pTwoFile = fmt"{yearStr}/html/d{day:02}p2.html"
    if not inFile.fileExists: break
    result.add fmt"| {day} | [input]({inFile}) "
    if pOneFile.fileExists: result.add fmt"[part1]({pOneFile}) "
    else: echo $pOneFile
    if pTwoFile.fileExists: result.add fmt"[part2]({pTwoFile}) "
    result.add "|\n"

nbInit

nb.title = TITLE

nbText: fmt"""
# {TITLE}

{2022.byYear}
{2021.byYear}

"""

nb.filename = "index.html"
nbSave
