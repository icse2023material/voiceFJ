module FJ where

data Program = Program [ClassDeclaration] Expr  {- [ClassDeclaration]; Expr -}
  deriving Show

data ClassDeclaration = ClassDeclaration ClassName ExtendName ClassBody  {- define class ClassName; extends ExtendName; ClassBody -}
  deriving Show

data ClassBody = ClassBody [FieldDeclaration] Constructor [MethodDeclaration]  {- [FieldDeclaration]; Constructor; [MethodDeclaration] -}
  deriving Show

data FieldDeclaration = FieldDeclaration TypeName VariableName  {- define field VariableName; type TypeName -}
  deriving Show

data Constructor = Constructor TypeName [Parameter] ConstructorBody  {- define constructor; [Parameter]; ConstructorBody -}
  deriving Show

data Parameter = Parameter TypeName VariableName  {- define parameter VariableName; type TypeName -}
  deriving Show

data ConstructorBody = ConstructorBody Super [FieldAssignment]  {- Super; [FieldAssignment] -}
  deriving Show

data Super = Super [Argument]  {- call super; [Argument] -}
  deriving Show
  
data Argument = Argument Variable  {- Variable -}
  deriving Show

data FieldAssignment = FieldAssignment VariableName FieldName Variable  {- field assignment; name FieldName; Variable -}
  deriving Show

data MethodDeclaration = MethodDeclaration TypeName MethodName [Parameter] MethodBody  {- define method MethodName; type TypeName; [Parameter]; MethodBody -}
  deriving Show

data MethodBody = MethodBody Expr  {- Expr -}
  deriving Show

data Expr = VariableExpr Variable {- Variable -}
         | FieldAccessExpr Expr FieldName {- field access expression; Expr; name FieldName -}
         | MethodCallExpr Expr MethodName [Expr] {- method call expression; Expr; call MethodName; [Expr] -}
         | InstanceExpr TypeName [Expr] {- new instance TypeName; [Expr] -}
         | ConversionExpr TypeName Expr {- conversion expression; type TypeName; Expr -}
  deriving Show

data Variable = Variable VariableName  {- variable VariableName -}
  deriving Show

data TypeName = TypeName Name  {- Name -}
  deriving Show

data ClassName = ClassName Name  {- Name -}
  deriving Show

data ExtendName = ExtendName Name  {- Name -}
  deriving Show

data FieldName = FieldName Name  {- Name -}
  deriving Show

data MethodName = MethodName Name  {- Name -}
  deriving Show

data VariableName = VariableName Name {- Name -}
  deriving Show

data Name = Name String  {- words -}
  deriving Show
