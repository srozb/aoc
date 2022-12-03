import os
import osproc
import strutils

for targetFile in walkPattern("2*/src/day*/part*.nim"):
  let
    wDir = targetFile.rsplit('/', 1)[0]
    fn = targetFile.rsplit('/', 1)[1]
  discard execCmdEx("nim r --hints:off " & fn, workingDir=wDir)

