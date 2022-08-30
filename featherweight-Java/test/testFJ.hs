import FJ

expr = VariableExpr (Variable (VariableName (Name "A")))

constructorBody = ConstructorBody (Super []) []

constructor = Constructor (TypeName (Name "A")) [] constructorBody

classBody = ClassBody [] constructor []

classDeclarations = [ClassDeclaration (ClassName (Name "A")) (ExtendName (Name "Object")) classBody]

program = Program classDeclarations expr

{-
define class a
extends object
define constructor
move next
define super
move next
move next  
move next  
variable a
-}
