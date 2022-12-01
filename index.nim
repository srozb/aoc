import strformat, strutils
import os
import nimib

const TITLE = "Advent of Code"

proc aocDirs(): string =
  for p in walkPattern("2*"):
    if p.dirExists:
      result.add fmt"* [20{p}]({p})" & '\n'

nbInit

nb.title = TITLE

nbText: fmt"""
# {TITLE}

{aocDirs()}
"""

nb.filename = "index.html"
nbSave
