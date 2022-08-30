module VoiceFJ where 

data Hole = Hole 
  deriving Show
type VNode a = Maybe (Either Hole a)
data VProgram = VProgram [VNode VClassDeclaration] (VNode VExpr) 
  deriving Show
data VClassDeclaration = VClassDeclaration (VNode VClassName) (VNode VExtendName) (VNode VClassBody) 
  deriving Show
data VClassBody = VClassBody [VNode VFieldDeclaration] (VNode VConstructor) [VNode VMethodDeclaration]
  deriving Show
data VFieldDeclaration = VFieldDeclaration (VNode VTypeName) (VNode VVariableName)
  deriving Show
data VConstructor = VConstructor (VNode VTypeName) [VNode VParameter] (VNode VConstructorBody)
  deriving Show
data VParameter = VParameter (VNode VTypeName) (VNode VVariableName)
  deriving Show
data VConstructorBody = VConstructorBody (VNode VSuper) [VNode VFieldAssignment]
  deriving Show
data VSuper = VSuper [VNode VArgument]
  deriving Show
data VArgument = VArgument (VNode VVariable)
  deriving Show
data VVariable = VVariable (VNode VVariableName)
  deriving Show
data VFieldAssignment = VFieldAssignment (VNode VVariable) (VNode VVariable)
  deriving Show
data VMethodDeclaration = VMethodDeclaration (VNode VTypeName) (VNode VMethodName) [VNode VParameter] (VNode VMethodBody)
  deriving Show
data VMethodName = VMethodName VName
  deriving Show
data VMethodBody = VMethodBody (VNode VExpr)
  deriving Show
data VExpr = VVariableExpr (VNode VVariable)
           | VFieldAccessExpr (VNode VExpr) (VNode VFieldName)
           | VMethodCallExpr (VNode VExpr) (VNode VMethodName) [VNode VExpr]
           | VInstanceExpr (VNode VTypeName) [VNode VExpr]
           | VConversionExpr (VNode VTypeName) (VNode VExpr)
  deriving Show
data VFieldName = VFieldName VName
  deriving Show
data VClassName = VClassName VName 
  deriving Show
data VExtendName = VExtendName VName
  deriving Show
data VTypeName = VTypeName VName
  deriving Show
data VVariableName = VVariableName VName
  deriving Show
data VName = VName String
  deriving Show