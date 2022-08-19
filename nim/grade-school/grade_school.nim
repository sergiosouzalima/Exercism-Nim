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

func getStudentsOrdered(self: School): seq[Student] =
  var seqStudents = self.students
  seqStudents.sort(cmpByGradeName)
  return seqStudents

func roster*(self: School): seq[string] =
  return self.getStudentsOrdered.mapIt(it.name)

func grade*(self: School, grade: int): seq[string] =
  var seqFiltered = self.getStudentsOrdered.filterIt(it.grade == grade)
  return seqFiltered.mapIt(it.name)

func addStudent*(self: var School, name: string, grade: int) =
  var exists = self.students.anyIt(it.name == name)
  if exists: raise newException(ValueError, "Student already exists")
  var student = Student((name: name, grade: grade, orderedBy: $(grade,2) & name))
  self.students.add(student)