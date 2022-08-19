import std/sequtils
import system/assertions
import algorithm

type
  Student* = tuple[name: string, grade: int, orderedBy: string]
  School* = object
    students*: seq[Student]

func cmpByGradeName(x, y: Student): int =
  if x.orderedBy < y.orderedBy: -1
  elif x.orderedBy == y.orderedBy: 0
  else: 1

func roster*(self: School): seq[string] =
  var seqOrdered = self.students
  seqOrdered.sort(cmpByGradeName)
  return seqOrdered.mapIt(it.name)

func grade*(self: School, grade: int): seq[string] =
  return self.students.mapIt(it.name)

func addStudent*(self: var School, name: string, grade: int) =
  var exists = self.students.anyIt(it.name == name)
  if exists: raise newException(ValueError, "Student already exists")
  var student = Student((name: name, grade: grade, orderedBy: $(grade,2) & name))
  self.students.add(student)


## sorted sequence
## https://nim-lang.org/docs/algorithm.html
## https://nim-lang.org/1.4.4/algorithm.html
## https://dev.to/sjuny/sort-string-in-nim-nm2