-- Reference: https://github.com/vincenthz/language-java/blob/master/Language/Java/Syntax.hs

data CompilationUnit = CompilationUnit (Maybe PackageDecl) [ImportDecl] [TypeDecl] {- PackageDecl?; [ImportDecl]; [TypeDecl] -}
  deriving Show

newtype PackageDecl = PackageDecl NameChain {- define package; NameChain  -}
  deriving Show

data ImportDecl 
  = ImportDeclNonStatic NameChain {- import package; NameChain -}
  | ImportStatic NameChain {- import static package; NameChain -}
  deriving Show

data TypeDecl
    = ClassTypeDecl ClassDecl {- ClassDecl -}
    | InterfaceTypeDecl InterfaceDecl {- InterfaceDecl -}
  deriving Show

data ClassDecl
    = ClassDecl [Modifier] ClassName [TypeParam] (Maybe ExtendType) [ImplementType] ClassBody {- define class ClassName; [Modifier]; [TypeParam];ExtendType?; [ImplementType]; ClassBody -}
    -- | EnumDecl [Modifier] Ident                             [RefType] EnumBody
  deriving Show

data Modifier
    = Public {- public -}
    | Private {- private -}
    | Protected {- protected -}
    | Abstract {- abstract -}
    | Final {- final -}
    | Static {- static -}
    | StrictFP {-strict floating point -}
    | Transient {- transient -}
    | Volatile {- volatile -}
    | Native {- native -}
    | Annotation Annotation {- -}
    | Synchronized_ {- synchronized -}

type ClassName = Ident {- Ident -}
type TypeName = Ident {- Ident -}
data Ident = Ident String {- words -}
    deriving Show
-- data TypeParam = TypeParam Ident [RefType] {- type Ident; [RefType] -}
data TypeParam = TypeParam Ident {- type Ident; -}
  deriving Show

type ExtendType = RefType  {- RefType -}
type ImplementType = RefType {- RefType-}

newtype ClassBody = ClassBody [Decl] {- [Decl] -}
  deriving Show

-- data EnumBody = EnumBody [EnumConstant] [Decl]
--   deriving Show

-- data EnumConstant = EnumConstant Ident [Argument] (Maybe ClassBody)
--   deriving Show

-- data InterfaceDecl
--     = InterfaceDecl InterfaceKind [Modifier] Ident [TypeParam] [RefType] InterfaceBody
--   deriving Show

-- data InterfaceKind = InterfaceNormal | InterfaceAnnotation
--   deriving Show

-- newtype InterfaceBody
--     = InterfaceBody [MemberDecl]
--   deriving

data Decl
    = MemberDecl MemberDecl {- MemberDecl -}
    -- | InitDecl Bool Block
  deriving Show

data MemberDecl
    = FieldDecl [Modifier] Type VarDeclId (Maybe VarInit) {- define variable VarDeclId; [Modifier]; Type; VarInit? -}
    | MethodDecl [Modifier] [TypeParam] MethodReturnType MethodName [FormalParam] [MethodExceptionType] (Maybe Exp) MethodBody {- define method MethodName; [Modifier]; MethodReturnType; [FormalParam]; [MethodExceptionType]; Exp?; MethodBody -}
    -- | A constructor is used in the creation of an object that is an instance of a class.
    | ConstructorDecl [Modifier] [TypeParam] Ident [FormalParam] [ExceptionType] ConstructorBody
    -- | A member class is a class whose declaration is directly enclosed in another class or interface declaration.
    | MemberClassDecl ClassDecl
    -- | A member interface is an interface whose declaration is directly enclosed in another class or interface declaration.
    | MemberInterfaceDecl InterfaceDecl
  deriving Show

data VarDeclId
    = VarId Ident {- Ident -}
    -- | VarDeclArray VarDeclId
    -- ^ Multi-dimensional arrays are represented by nested applications of 'VarDeclArray'.
  deriving Show

data VarInit
    = InitExp Exp {- Exp -}
    | InitArray ArrayInit {- ArrayInit -}
  deriving Show

type MethodReturnType Type {- Type -}
type MethodExceptionType = ExceptionType {- ExceptionType -}
type MethodName = Ident {- Ident -}

data FormalParam = FormalParam [Modifier] Type VarDeclId {- define parameter VarDeclId; [Modifier]; Type -}

newtype MethodBody = MethodBody Block {- Block -}
  deriving Show

data ConstructorBody = ConstructorBody (Maybe ExplConstrInv) [BlockStmt]

-- | An explicit constructor invocation invokes another constructor of the
--   same class, or a constructor of the direct superclass, which may
--   be qualified to explicitly specify the newly created object's immediately
--   enclosing instance.
data ExplConstrInv
    = ThisInvoke             [RefType] [Argument]
    | SuperInvoke            [RefType] [Argument]
    | PrimarySuperInvoke Exp [RefType] [Argument]

-- block to add {}.
data Block = Block [BlockStmt] {- block; [BlockStmt] -}
  deriving Show

data BlockStmt
    = BlockStmt Stmt {- Stmt -}
    -- | LocalClass ClassDecl {- ClassDecl -}
    -- | LocalVars [Modifier] Type [VarDecl]
  deriving Show

data Stmt
    = StmtBlock Block {- Block -}
    | IfThenElse Exp Stmt Stmt {- define if; Expr; Stmt; Stmt -}
    | While Exp Stmt {- define while; Exp; Stmt -}
    | BasicFor (Maybe ForInit) (Maybe Exp) (Maybe [Exp]) Stmt {- define for; ForInit?; Exp?; [Exp]?; Stmt -}
    | EnhancedFor [Modifier] Type Ident Exp Stmt {- define enhanced for; variable Ident; Type; Expr; Stmt -}
    | ExpStmt Exp {- Exp -}
    | Switch Exp [SwitchBlock] {- define switch; [SwitchBlock] -}
    | Break (Maybe Ident) {- break; -}
    | Continue (Maybe Ident) {- continue -}
    | Return (Maybe Exp) {- return expression; Exp? -}
    | Throw Exp {- throws; Exp -}
    | Try Block [Catch] (Maybe Block) {- define try catch; Block; [Catch]; Block? -}
  deriving Show

data Catch = Catch FormalParam Block {- FormalParam; Block -}
  deriving Show

data SwitchBlock
    = SwitchBlock SwitchLabel [BlockStmt] {- SwitchLabel; [BlockStmt] -}
  deriving Show

data SwitchLabel
    = SwitchCase Exp {- Exp -}
    | Default {- default -}
  deriving Show

data ForInit
    = ForLocalVars [Modifier] Type [VarDecl] {- Type; [VarDecl]-}
    -- | ForInitExps [Exp]
  deriving Show

data VarDecl
    = VarDecl VarDeclId (Maybe VarInit) {- define variable VarDeclId; VarInit? -}

type ExceptionType = RefType {- RefType -}
type Argument = Exp {- Exp -}

data Exp
    = Lit Literal {- Literal -}
    -- | ClassLit (Maybe Type) {- Type? -}
    -- | This {- this -}
    -- | ThisClass Name {-field access expression; Name -}
    | InstanceCreation [TypeArgument] TypeDeclSpecifier [Argument] (Maybe ClassBody) {- new instance TypeDeclSpecifier; [TypeArgument]; [Argument]; ClassBody? -}
    -- | QualInstanceCreation Exp [TypeArgument] Ident [Argument] (Maybe ClassBody)
    -- | ArrayCreate Type [Exp] Int
    -- | ArrayCreateInit Type Int ArrayInit
    | FieldAccess FieldAccess {- FieldAccess -}
    | MethodInv MethodInvocation {- MethodInvocation -}
    | ArrayAccess ArrayIndex {- -}
{-    | ArrayAccess Exp Exp -- Should this be made into a datatype, for consistency and use with Lhs? -}
    -- | An expression name, e.g. a variable.
    | ExpName Name {- Name -}
    | PostIncrement Exp {- post increment expression; Exp -}
    | PostDecrement Exp {- post decrement expression; Exp -}
    | PreIncrement  Exp {- pre increment expression; Exp -}
    | PreDecrement  Exp {- pre decrement expression; Exp -}
    | PrePlus  Exp {- pre plus expression; Exp -}
    | PreMinus Exp {- pre minus expression; Exp -}
    -- | Unary bitwise complementation: note that, in all cases, @~x@ equals @(-x)-1@.
    | PreBitCompl Exp
    | PreNot Exp {- pre not expression; Exp -}
    | Cast  Type Exp {- cast expression; Type; Exp -}
    | BinOp Exp Op Exp {- expression OP expression; Exp; Exp -}
    | Cond Exp Exp Exp {- conditional expression; Exp; Exp; Exp -}
    | Assign Lhs AssignOp Exp {- assignment expression; Lhs; Exp -}
    | Lambda LambdaParams LambdaExpression {- lambda expression; LambdaParams; LambdaExpression -}
    -- | Method reference
    | MethodRef Name Ident
  deriving Show

-- | The left-hand side of an assignment expression. This operand may be a named variable, such as a local
--   variable or a field of the current object or class, or it may be a computed variable, as can result from
--   a field access or an array access.
data Lhs
    = NameLhs Name          -- ^ Assign to a variable
    | FieldLhs FieldAccess  -- ^ Assign through a field access
    | ArrayLhs ArrayIndex   -- ^ Assign to an array
  deriving Show

-- | Array access
data ArrayIndex = ArrayIndex Exp [Exp]    -- ^ Index into an array
  deriving Show

-- | A field access expression may access a field of an object or array, a reference to which is the value
--   of either an expression or the special keyword super.
data FieldAccess
    = PrimaryFieldAccess Exp Ident      -- ^ Accessing a field of an object or array computed from an expression.
    | SuperFieldAccess Ident            -- ^ Accessing a field of the superclass.
    | ClassFieldAccess Name Ident      {- class access expression; Name; Ident -}
  deriving Show


-- ¦ A lambda parameter can be a single parameter, or mulitple formal or mulitple inferred parameters
data LambdaParams
  = LambdaSingleParam Ident
  | LambdaFormalParams [FormalParam]
  | LambdaInferredParams [Ident]
    deriving Show

data LambdaExpression
    = LambdaExpression Exp {- Expression -}
    | LambdaBlock Block {- Block -}
  deriving Show


data MethodInvocation
    = MethodCall Name [Argument] {- call Name; [Argument] -}
    -- | PrimaryMethodCall Exp [RefType] Ident [Argument]
    -- | SuperMethodCall [RefType] Ident [Argument]
    -- | ClassMethodCall Name [RefType] Ident [Argument]
    -- | TypeMethodCall  Name [RefType] Ident [Argument]
  deriving Show

-- | An array initializer may be specified in a declaration, or as part of an array creation expression, creating an
--   array and providing some initial values
data ArrayInit
    = ArrayInit [VarInit]
  deriving Show

data Literal
    = Int Integer {- integer Ident -}
    -- | Word Integer
    | Float Double
    | Double Double
    | Boolean Bool
    | Char Char
    | String String {- string Ident -}
    | Null {- null -}
  deriving Show

-- | A binary infix operator.
data Op 
  = Mult {- times -}
  | Div {- divide -}
  | Rem 
  | Add {- plus -}
  | Sub {- minus -}
  | LShift | RShift | RRShift
  | LThan {- less than -}
  | GThan {- greater than -}
  | LThanE {- less equal -}
  | GThanE {- greater equal -}
  | Equal {- double equal -}
  | NotEq {- not equal -}
  | And {- double and -}
  | Or {- or -}
  | Xor | CAnd | COr
  deriving Show

-- | An assignment operator.
data AssignOp = EqualA | MultA | DivA | RemA | AddA | SubA
              | LShiftA | RShiftA | RRShiftA | AndA | XorA | OrA
  deriving Show


data Type
    = PrimType PrimType {- PrimType -}
    | RefType RefType {- RefType -}
  deriving Show

data RefType
    = ClassRefType ClassType {- ClassType -}
    {- | TypeVariable Ident -}
    -- | ArrayType Type
  deriving Show

-- | A class or interface type consists of a type declaration specifier,
--   optionally followed by type arguments (in which case it is a parameterized type).
data ClassType
    = ClassType ClassName [TypeArgument] {- type ClassName; [TypeArgument] -}
  deriving Show

data TypeArgument
    = Wildcard (Maybe WildcardBound) {- wild card -}
    | ActualType RefType {- RefType -}
  deriving Show

data TypeDeclSpecifier
    = TypeDeclSpecifier ClassType
    | TypeDeclSpecifierWithDiamond ClassType Ident Diamond
    | TypeDeclSpecifierUnqualifiedWithDiamond Ident Diamond
  deriving Show

data Diamond = Diamond
  deriving Show

-- | Wildcards may be given explicit bounds, either upper (@extends@) or lower (@super@) bounds.
data WildcardBound
    = ExtendsBound RefType
    | SuperBound RefType
  deriving Show

-- | A primitive type is predefined by the Java programming language and named by its reserved keyword.
data PrimType
    = BooleanT {- type boolean -}
    | ByteT {- type byte -}
    | ShortT {-type short -}
    | IntT {- type int -}
    | LongT {- type long -}
    | CharT {- type char -}
    | FloatT {- type float -}
    | DoubleT {- type double -}
  deriving Show


-- | A class is generic if it declares one or more type variables. These type variables are known
--   as the type parameters of the class.
data TypeParam = TypeParam Ident [RefType]
  deriving Show

-----------------------------------------------------------------------
-- Names and identifiers

-- | A single identifier.
data Ident = Ident String
    deriving Show

type Name = Ident {- name Ident -}

-- | A name chain, i.e. a period-separated list of identifiers.
data NameChain = NameChain [Ident] {- [Ident] -}
    deriving Show
