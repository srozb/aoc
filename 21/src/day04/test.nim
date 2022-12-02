from part1 import parseNumbers,readCards,playGame
from part2 import playGame

var fn = open("input.txt")
let numbers = part1.parseNumbers(fn.readLine)
var cards = part1.readCards(fn)

doAssert part1.playGame(cards, numbers) == 32844
doAssert part2.playGame(cards, numbers) == 4920