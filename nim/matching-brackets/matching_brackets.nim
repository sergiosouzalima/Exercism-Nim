
func isEven(number: int): bool =
  return (number.abs.mod 2) == 0

proc isPaired*(stringOfbrackets: string): bool =
  ##var brackets: int = 0
  ##var curlies: int = 0
  ##var parens: int = 0
  var brackets: string = ""
  var curlies: string = ""
  var parens: string = ""

  if stringOfbrackets == "": return true

  for e in stringOfbrackets:
    if e == '[':
      brackets = "OPEN"
    if e == '{':
      curlies = "OPEN"
    if e == '(':
      parens = "OPEN"
    if e == ']':
      if brackets == "CLOSED": brackets = "OPEN"
      else: brackets = "CLOSED"
    if e == '}':
      if curlies == "CLOSED": curlies = "OPEN"
      else: curlies = "CLOSED"
    if e == ')':
      if parens == "CLOSED": parens = "OPEN"
      else: parens = "CLOSED"

  return (brackets == "CLOSED" or brackets == "") and
        (curlies == "CLOSED" or curlies == "") and
        (parens == "CLOSED" or parens == "")
