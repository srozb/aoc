import strutils

const
  INTERNAL_PEROID = 8
  PEROID = 6
  DAYS = 256

var 
  lFish: array[9, int]

proc fillInitial(state: var array[9, int]) =
  let initialState = "input.txt".readFile
  for lf in initialState.split(","):
    state[lf.parseInt].inc

proc predictDays(self: var array[9, int], days: int) =
  for day in 0..<days:
    var newBorns = self[0]
    for fish in 1..<self.len:
      self[fish-1] = self[fish] 
    self[INTERNAL_PEROID] = newBorns
    self[PEROID].inc(newBorns)

proc sumAll(self: var array[9, int]): int =
  for i in 0..<self.len:
    result += self[i]

lFish.fillInitial
lFish.predictDays(DAYS)

echo "Answer is: " & $lFish.sumAll