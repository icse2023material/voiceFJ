module VCommand where

data Command = ClassDef String 
             | Extend String
             | FieldDef String
             | TypeDef String
             | MoveNext
             | ConstructorDef
             | ConstructorDefHelper String
             | CallSuper
             | MethodDef String
             | ParameterDef String
             | FieldAssignment 
             | FieldAccessExpr
             | MethodCallExpr
             | CallMethod String
             | ConversionExpr
             | NewInstanceExpr String
             | Variable String
             | NameCommand String
    deriving Show