import strutils

type
  Node = tuple
    name: string
    big: bool
  Edge = tuple
    a: Node
    b: Node
  Graph = ref object
    nodes: seq[Node]
    edges: seq[Edge]

proc newGraph(): Graph =
  result = new Graph

proc newNode(name: string): Node =
  var n: Node
  n = (name, name[0].isUpperAscii)

proc newEdge(a, b: string): Edge =
  var e: Edge
  e = (newNode(a), newNode(b))

proc newEdge(unp: string): Edge =
  let 
    parsed = unp.split('-')
    a = parsed[0]
    b = parsed[1]
  var e: Edge
  echo a, b
  e = (newNode(a), newNode(b))

proc add(g: var Graph, e: Edge) = 
  discard

proc add(g: var Graph, n: Node) = 
  discard

var g = newGraph()

for l in "test.txt".lines:
  g.add(newEdge(l))