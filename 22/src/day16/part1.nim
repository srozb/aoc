import strformat, strutils, strscans, std/tables
import nimib

const 
  DAY = 16
  PART = 1
  DOCNAME = fmt"d{DAY:02}p{PART}"

nbInit
nb.title = DOCNAME

nbText: fmt"""
# Day {DAY:02} part {PART}
"""

nbCode:
  type
    State = object
      curRoom: string
      time, score: Natural
      valvesOpened: seq[string]

  var
    answer: Natural
    options = initTable[string, seq[string]]()  # map all possible ways
    flowRate = initTable[string, int]()  # map room to flow rate

  proc evalId(s: State): string = fmt"{s.time}{s.curRoom}"

  proc loadObjects() =
    for line in "input.txt".lines:
      var 
        roomName, leadsTo: string
        rate: int
      if scanf(line, "Valve $w has flow rate=$i; tunnels lead to valves $+", roomName, rate, leadsTo):
        options[roomName] = leadsTo.split(", ")
        if rate > 0: flowRate[roomName] = rate  # store only non-zero flow rates
      elif scanf(line, "Valve $w has flow rate=$i; tunnel leads to valve $+", roomName, rate, leadsTo):
        options[roomName] = @[leadsTo]
        if rate > 0: flowRate[roomName] = rate  # store only non-zero flow rates

  proc countScore(s: State): Natural =
    for v in s.valvesOpened:
      result.inc flowRate[v]

  proc openValve(s: State): State =
    result = State(curRoom: s.curRoom, time: s.time + 1, score: s.score, valvesOpened: s.valvesOpened)
    result.valvesOpened.add s.curRoom
    result.score.inc s.countScore

  proc travelTo(s: State, newRoom: string): State =
    result = State(curRoom: newRoom, time: s.time + 1, score: s.score, valvesOpened: s.valvesOpened)
    result.score.inc s.countScore

  proc simulate() =
    var 
      states = @[State(curRoom: "AA", time: 1)]
      evaluated = initTable[string, int]()    

    while states.len > 0:
      let state = states.pop
      if state.evalId in evaluated and evaluated[state.evalId] >= state.score: continue
      evaluated[state.evalId] = state.score
      if state.time == 30:  # Time's up.
        answer = max(answer, state.score + state.countScore())
        continue
      if state.curRoom in flowRate and state.curRoom notin state.valvesOpened:
        states.add state.openValve
      for nextRoom in options[state.curRoom]:
        states.add state.travelTo(nextRoom)

  loadObjects()  
  simulate()

nbText: fmt"""
Answer is: **{answer}**
"""

nb.filename = fmt"../../html/{DOCNAME}.html"
nbSave
