
import tables
import strutils

func isLowerCaseLetter(c: char): bool =
  const aLowerAscCode = 97
  const zLowerAscCode = 122
  return aLowerAscCode <= ord(c) and ord(c) <= zLowerAscCode

func isUpperCaseLetter(c: char): bool =
  const aUpperAscCode = 65
  const zUpperAscCode = 90
  return aUpperAscCode <= ord(c) and ord(c) <= zUpperAscCode

func isAllowedPunctuation(c: char): bool =
  return c in chr(34) & ". _1234567890"

func detectAllLetters(phrase: string, tablePangram: Table[char, int]): Table[char, int] =
  var tbmTablePangram = tablePangram
  var toLowerChar: char
  for c in phrase:
    toLowerChar = c.toLowerAscii
    if tablePangram.hasKey(toLowerChar): tbmTablePangram[toLowerChar] = 1
  return tbmTablePangram

func allLettersPresent(tablePangram: Table[char, int]): bool =
  var s = 0
  for e, _ in tablePangram: s = s + tablePangram[e]
  return s == 26

func normalizeCapitalLetters(phrase: string):string =
  var normalizedPhrase = ""
  var currentChar: char
  for i in 0 .. phrase.len-1:
    currentChar = phrase[i]
    if isUpperCaseLetter(phrase[i]) and (phrase[i-1] in chr(34) & ' '):
      currentChar = phrase[i].toLowerAscii
    normalizedPhrase = normalizedPhrase & currentChar
  return normalizedPhrase

func isAllowedChar(phrase: string):bool =
  var normalPhrase = normalizeCapitalLetters(phrase)
  for c in normalPhrase:
    if isLowerCaseLetter(c) or isAllowedPunctuation(c): return true
  return false

func fillTablePangram(): Table[char, int] =
  const aLowerAscCode = 97
  const zLowerAscCode = 122
  var tablePangram = initTable[char, int]()
  for e in aLowerAscCode .. zLowerAscCode: tablePangram[char(e)] = 0
  return tablePangram

proc isPangram*(phrase: string):bool =
  var tablePangram = initTable[char, int]()
  tablePangram = fillTablePangram()

  if phrase.len == 0: return false

  if not isAllowedChar(phrase): return false

  tablePangram = detectAllLetters(phrase, tablePangram)

  return allLettersPresent(tablePangram)