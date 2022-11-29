import strutils

var digits: int

for l in "input.txt".lines:
  for digit in l.split('|')[1].splitWhitespace:
    if digit.len in [2, 3, 4, 7]:
      digits.inc

echo "The score is: " & $digits