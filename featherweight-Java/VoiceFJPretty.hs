module VoiceFJPretty where

import VoiceFJ
import Text.PrettyPrint

prettyProgram :: VProgram -> Doc
prettyProgram (VProgram classDeclarations expr) = prettyClassDeclarations classDeclarations $+$ prettyExpr expr

prettyClassDeclarations :: [VNode VClassDeclaration] -> Doc
prettyClassDeclarations classDeclarations = vcat (map prettyClassDeclaration classDeclarations)

prettyClassDeclaration :: VNode VClassDeclaration -> Doc
prettyClassDeclaration Nothing = text ""
prettyClassDeclaration (Just (Left Hole)) = text "_"
prettyClassDeclaration (Just (Right (VClassDeclaration vClassName vExtendName vClassBody))) = 
  text "class" <+> prettyClassName vClassName 
  <+> text "extends" <+> prettyExtendName vExtendName 
  <+> lbrace $+$ nest 2 (prettyClassBody vClassBody) $+$ rbrace

prettyClassName :: VNode VClassName -> Doc
prettyClassName Nothing = text ""
prettyClassName (Just (Left Hole)) = text "_"
prettyClassName (Just (Right (VClassName (VName name)))) = text name

prettyExtendName :: VNode VExtendName -> Doc
prettyExtendName Nothing = text ""
prettyExtendName (Just (Left Hole)) = text "_"
prettyExtendName (Just (Right (VExtendName (VName name)))) = text name

prettyClassBody :: VNode VClassBody -> Doc
prettyClassBody Nothing = text ""
prettyClassBody (Just (Left Hole)) = text "_"
prettyClassBody (Just (Right (VClassBody vFieldDeclarations vConstructor vMethodDeclarations))) = 
  vcat (map prettyFieldDeclaration vFieldDeclarations) $+$
  prettyConstructor vConstructor $+$
  vcat (map prettyMethodDeclaration vMethodDeclarations)

prettyFieldDeclaration :: VNode VFieldDeclaration -> Doc
prettyFieldDeclaration Nothing = text ""
prettyFieldDeclaration (Just (Left Hole)) = text "_"
prettyFieldDeclaration (Just (Right (VFieldDeclaration vTypeName vVariableName))) = 
  prettyTypeName vTypeName <+> prettyVariableName vVariableName <> semi

prettyTypeName :: VNode VTypeName -> Doc
prettyTypeName Nothing = text ""
prettyTypeName (Just (Left Hole)) = text "_"
prettyTypeName (Just (Right (VTypeName (VName name)))) = text name

prettyVariableName :: VNode VVariableName -> Doc
prettyVariableName Nothing = text ""
prettyVariableName (Just (Left Hole)) = text "_"
prettyVariableName (Just (Right (VVariableName (VName name)))) = text name

prettyConstructor :: VNode VConstructor -> Doc
prettyConstructor Nothing = text ""
prettyConstructor (Just (Left Hole)) = text "_"
prettyConstructor (Just (Right (VConstructor vTypeName vParameters vConstructorBody))) = 
  prettyTypeName vTypeName <> lparen <> (foldr (\x y -> x <> comma <+> y) empty (map prettyParameter vParameters)) <> rparen <> lbrace
  $+$ nest 2 (prettyConstructorBody vConstructorBody)
  $+$ rbrace

prettyParameter :: VNode VParameter -> Doc
prettyParameter Nothing = text ""
prettyParameter (Just (Left Hole)) = text "_"
prettyParameter (Just (Right (VParameter vTypeName vVariableName))) = 
  prettyTypeName vTypeName <+> prettyVariableName vVariableName

prettyConstructorBody :: VNode VConstructorBody -> Doc
prettyConstructorBody Nothing = text ""
prettyConstructorBody (Just (Left Hole)) = text "_"
prettyConstructorBody (Just (Right (VConstructorBody vSuper vFieldAssignments))) = 
  prettySuper vSuper $+$ vcat (map prettyFieldAssignment vFieldAssignments)

prettySuper :: VNode VSuper -> Doc
prettySuper Nothing = text ""
prettySuper (Just (Left Hole)) = text "_"
prettySuper (Just (Right (VSuper vArguments))) = text "super" <> lparen <> (foldr (\x y -> x <> comma <+> y) empty (map prettyArgument vArguments)) <> rparen <> semi

prettyArgument :: VNode VArgument -> Doc
prettyArgument Nothing = text ""
prettyArgument (Just (Left Hole)) = text "_"
prettyArgument (Just (Right (VArgument vVariable))) = prettyVariable vVariable

prettyFieldAssignment :: VNode VFieldAssignment -> Doc
prettyFieldAssignment Nothing = text ""
prettyFieldAssignment (Just (Left Hole)) = text "_"
prettyFieldAssignment (Just (Right (VFieldAssignment vLeft vRight))) = 
  text "this" <> text "." <> prettyVariable vLeft <+> equals <+> prettyVariable vRight <> semi

prettyVariable :: VNode VVariable -> Doc
prettyVariable Nothing = text ""
prettyVariable (Just (Left Hole)) = text "_"
prettyVariable (Just (Right (VVariable Nothing))) = text ""
prettyVariable (Just (Right (VVariable (Just (Left Hole))))) = text "_"
prettyVariable (Just (Right (VVariable (Just (Right (VVariableName (VName name))))))) = text name

prettyMethodDeclaration :: VNode VMethodDeclaration -> Doc
prettyMethodDeclaration Nothing = text ""
prettyMethodDeclaration (Just (Left Hole)) = text "_"
prettyMethodDeclaration (Just (Right (VMethodDeclaration vTypeName vMethodName vParameters vMethodBody))) = 
  prettyTypeName vTypeName <+> prettyMethodName vMethodName <> lparen <> (foldr (\x y -> x <> comma <+> y) empty (map prettyParameter vParameters)) <> rparen <> lbrace
  $+$ nest 2 (prettyMethodBody vMethodBody)
  $+$ rbrace

prettyMethodName :: VNode VMethodName -> Doc
prettyMethodName Nothing = text ""
prettyMethodName (Just (Left Hole)) = text "_"
prettyMethodName (Just (Right (VMethodName (VName name)))) = text name

prettyMethodBody :: VNode VMethodBody -> Doc
prettyMethodBody Nothing = text ""
prettyMethodBody (Just (Left Hole)) = text "_"
prettyMethodBody (Just (Right (VMethodBody vvExpr))) = text "return" <+> prettyExpr vvExpr <> semi

prettyExpr :: VNode VExpr -> Doc
prettyExpr Nothing = text ""
prettyExpr (Just (Left Hole)) = text "_"
prettyExpr (Just (Right vExpr)) = prettyVExpr vExpr

prettyVExpr :: VExpr -> Doc
prettyVExpr (VVariableExpr vVariable) = prettyVariable vVariable
prettyVExpr (VFieldAccessExpr vvExpr vField) = prettyExpr vvExpr <> text "." <> prettyField vField
prettyVExpr (VMethodCallExpr vvExpr vMethodName vvExprs) = 
  prettyExpr vvExpr <> text "." <>
  prettyMethodName vMethodName <> lparen <> (foldr (\x y -> x <> comma <+> y) empty (map prettyExpr vvExprs))  <> rparen
prettyVExpr (VInstanceExpr vTypeName vvExprs) = 
  text "new" <+> prettyTypeName vTypeName <> lparen <> (foldr (\x y -> x <> comma <+> y) empty (map prettyExpr vvExprs))  <> rparen
prettyVExpr (VConversionExpr vTypeName vvExpr) = lparen <> prettyTypeName vTypeName <> rparen <> prettyExpr vvExpr

prettyField :: VNode VFieldName -> Doc
prettyField Nothing = text ""
prettyField (Just (Left Hole)) = text "_"
prettyField (Just (Right (VFieldName (VName name)))) = text name

