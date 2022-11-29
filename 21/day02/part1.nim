import strutils

type
  Position = tuple
    x: int
    y: int

var
  pos: Position

proc move(self: var Position, command: string) =
  let
    comSplit = command.splitWhitespace
    direction = comSplit[0]
    offset = comSplit[1].parseInt
  if direction == "forward":
    self.x.inc offset
  elif direction == "up":
    self.y.dec offset
  elif direction == "down":
    self.y.inc offset
  else:
    raise newException(ValueError, "Unable to parse command.")

proc multiply(self: Position): int =
  result = self.x * self.y

for l in "input.txt".lines:
  pos.move(l)
echo "Answer is: " & $pos.multiply