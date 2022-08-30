module Text2Command where
import VCommand
import qualified Data.String as Str

translate :: String -> Command 
translate str = 
  let 
    words = Str.words str
  in case words of 
    (first: rest) -> 
      case first of 
        "define" -> case rest of 
          (rfirst:rrest) -> 
            case rfirst of
              "class" -> ClassDef (unwords rrest)
              "field" -> FieldDef (unwords rrest)
              "method" -> MethodDef (unwords rrest)
              "constructor" -> ConstructorDef
              "parameter" -> ParameterDef (unwords rrest)
        "extends" -> Extend (unwords rest)
        "type" -> TypeDef (unwords rest)
        "field" -> if head rest == "assignment"
          then FieldAssignment
          else FieldAccessExpr
        "method" -> MethodCallExpr
        "conversion" -> ConversionExpr
        "call" -> if head rest == "super"
          then CallSuper
          else CallMethod (unwords rest)
        "new" -> NewInstanceExpr (unwords (tail rest))
        "variable" -> Variable (unwords rest)
        "name" -> NameCommand (unwords rest)
        "move" -> MoveNext

  
