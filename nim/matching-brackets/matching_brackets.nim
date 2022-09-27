import tables
import std/sequtils

func isEven(number: int): bool =
  return (number.abs.mod 2) == 0

func clean(brackets, initialBrackets, endBrackets: string):string =
  for e in brackets:
    if e in (initialBrackets&endBrackets):
      result = result & e

func paredBracket(carac: char):char =
  var tableInitialBracket: Table[char, char]
  tableInitialBracket['}'] = '{'
  tableInitialBracket[']'] = '['
  tableInitialBracket[')'] = '('
  return tableInitialBracket[carac]

func exists(cleanBrackets: string, brackets: string):bool =
  var counter: int = 0
  for e in cleanBrackets:
    if e in brackets: counter += 1
  return counter > 0

proc isPaired*(brackets: string): bool =
  let initialBrackets = "{[("
  let endBrackets = "}])"
  var cleanBrackets: string = ""
  var seqBrackets: seq[char]
  var bracketToPare: char
  var bracketIndex, bracketIndexToDelete: int
  var pairedBracketFound, inexpectedBracketFound: bool
  var endBracketFound: bool
  var curChar: char

  cleanBrackets = brackets.clean(initialBrackets, endBrackets) # keep only brackets in cleanBrackets

  if cleanBrackets.len == 0: return true # return true, if no brackets detected

  if not cleanBrackets.len.isEven: return false # return false if cleanBrackets is unbalanced

  if not cleanBrackets.exists initialBrackets: return false # there must be at least one initial bracket

  if not cleanBrackets.exists endBrackets: return false # there must be at least one end bracket

  seqBrackets = cleanBrackets.toSeq

  pairedBracketFound = true
  while seqBrackets.len > 0 and pairedBracketFound:
    bracketIndex = 0
    endBracketFound = false
    ## Looking for an end bracket...
    while not endBracketFound and bracketIndex <= seqBrackets.len:
      curChar = seqBrackets[bracketIndex]
      endBracketFound = curChar in endBrackets
      if endBracketFound:
        bracketToPare = paredBracket(curChar)
        bracketIndexToDelete = bracketIndex
      else:
        bracketIndex += 1

    if not endBracketFound: return false

    ## Looking for an initial bracket...
    pairedBracketFound = false
    inexpectedBracketFound = false
    while not pairedBracketFound and bracketIndex > 0 and not inexpectedBracketFound:
      bracketIndex -= 1
      curChar = seqBrackets[bracketIndex]
      pairedBracketFound = curChar == bracketToPare
      inexpectedBracketFound = curChar in initialBrackets and not pairedBracketFound
      if pairedBracketFound:
        seqBrackets.delete(bracketIndexToDelete)
        seqBrackets.delete(bracketIndex)

  return seqBrackets.len == 0