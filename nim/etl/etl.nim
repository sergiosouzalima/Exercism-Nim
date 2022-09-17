import tables
import strutils

func setTableNewLetters(): Table[char, int] =
  #[
    1 point: "A", "E", "I", "O", "U", "L", "N", "R", "S", "T",
    2 points: "D", "G",
    3 points: "B", "C", "M", "P",
    4 points: "F", "H", "V", "W", "Y",
    5 points: "K",
    8 points: "J", "X",
    10 points: "Q", "Z",
  ]#
  for e in "aeioulnrst": result[e]=1
  for e in "dg": result[e]=2
  for e in "bcmp": result[e]=3
  for e in "fhvwy": result[e]=4
  for e in "k": result[e]=5
  for e in "jx": result[e]=8
  for e in "qz": result[e]=10
  return result

proc transform*(tableOldLetters: Table[int, seq[char]]): Table[char, int] =
  var tableNewLetters = setTableNewLetters()
  for k, v in tableOldLetters:
    for k, v in v:
      result[v.toLowerAscii] = tableNewLetters[v.toLowerAscii]
  return result
