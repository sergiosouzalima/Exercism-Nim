
import tables
import strutils

func transformToTable(word: string): Table[char, int] =
  var tablePangram = initTable[char, int]()
  for e in word: tablePangram[e.toLowerAscii] = 0
  return tablePangram

func isAnagram(word: string, candidate: string): bool =
  var tableWord = transformToTable(word)
  var tableCandidate = transformToTable(candidate)
  var lowerElement: char
  for e in word:
    lowerElement = e.toLowerAscii
    tableWord[lowerElement] = tableWord[lowerElement] + 1
  for e in candidate:
    lowerElement = e.toLowerAscii
    tableCandidate[lowerElement] = tableCandidate[lowerElement] + 1
  for e in word:
    lowerElement = e.toLowerAscii
    if not tableCandidate.hasKey(lowerElement): return false
    if tableWord[lowerElement] != tableCandidate[lowerElement]: return false
  return true

proc detectAnagrams*(word: string, seqCandidates: seq[string]): seq[string] =
  var seqResult: seq[string]
  var validCandidate: bool
  for e in seqCandidates:
    validCandidate = true
    if e.toLowerAscii == word.toLowerAscii: validCandidate = false
    if e.len != word.len: validCandidate = false
    if validCandidate:
      if not isAnagram(word, e): validCandidate = false
      if validCandidate: seqResult.add e
  return seqResult
