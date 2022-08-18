import std/sequtils
import system/assertions

type
  Student* = tuple[name: string, grade: int]
  School* = object
    students*: seq[Student]

proc roster*(self: School): seq[string] = return self.students.mapIt(it.name)

proc addStudent*(self: var School, name: string, grade: int) =
  var exists = self.students.anyIt(it.name == name) ## and it.grade == grade)
  if exists: raise newException(ValueError, "Student already exists")
  var student = Student((name: name, grade: grade))
  self.students.add(student)

