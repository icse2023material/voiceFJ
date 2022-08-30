import Generation
import VoiceFJPretty
import VCommand


classDef = generate (ClassDef "Pair") initial
extend = generate (Extend "Object") classDef
field = generate (FieldDef "first") extend
typeDef = generate (TypeDef "Object") field
fieldSecond = generate (FieldDef "second") typeDef
typeDefSecond = generate (TypeDef "Object") fieldSecond
moveNext = generate (MoveNext) typeDefSecond
constructor = generate ConstructorDef moveNext
parameterFirst = generate (ParameterDef "first") constructor
typeForParaFirst = generate (TypeDef "Object") parameterFirst
parameterSecond = generate (ParameterDef "second") typeForParaFirst

testFindHole0 = findHole initial
testFindHole1 = findHole classDef
testFindHole2 = findHole extend
testFindHole3 = findHole field
testFindHole4 = findHole typeDef

