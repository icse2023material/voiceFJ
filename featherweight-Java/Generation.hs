module Generation where 

import VoiceFJ
import VCommand
import Debug.Trace

type ShallCreateNewHole = Bool

initial :: VProgram
initial = VProgram [Just (Left Hole)] Nothing

type VProgramHole = VProgram

run :: [Command] -> VProgram
run cs = runSeq cs initial

runSingle :: Command -> VProgram -> VProgram
runSingle = generate

runSeq :: [Command] -> VProgram -> VProgram
runSeq [] vProgram =  vProgram
runSeq (c: cs) vProgram = 
  let vProgram' = generate c vProgram
  in runSeq cs vProgram'

generate :: Command -> VProgram -> VProgram
generate command vProgram = 
  let vProgramHole = findHole vProgram
  in generateVProgram command vProgram vProgramHole
  -- in generateVProgram command vProgram (trace ("vProgramHole:\n" ++ show vProgramHole) vProgramHole)

generateVProgram :: Command -> VProgram -> VProgramHole -> VProgram
generateVProgram command vProgram vProgramHole = 
  case (vProgram, vProgramHole) of
    (VProgram vClassDecls vExpr, VProgram vClassDeclsHole Nothing) ->
      let (vClassDeclsNew, shallCreateNewHole) = generateVClassDecls command vClassDecls vClassDeclsHole 
      in if shallCreateNewHole
        then VProgram vClassDeclsNew (Just (Left Hole))
        else VProgram vClassDeclsNew vExpr
    (VProgram vClassDecls vExpr, VProgram [] vExprHole) -> 
      let (vExprNew, shallCreateNewHole) = generateVExpr command vExpr vExprHole
      in VProgram vClassDecls vExprNew

generateVClassDecls :: Command -> [VNode VClassDeclaration] -> [VNode VClassDeclaration] -> ([VNode VClassDeclaration], ShallCreateNewHole)
generateVClassDecls command@(ClassDef _) vClassDecls vClassDeclsHole =
  case (vClassDecls, vClassDeclsHole) of
    ([Just (Left Hole)], [Just (Left Hole)]) -> 
      let (vClassDeclNew, _) = generateVClassDecl command (Just (Left Hole)) (Just (Left Hole))
      in ([vClassDeclNew], False)
    ((vClassDeclHead: vClassDeclRest), (Nothing: vClassDeclsRestHole)) ->
      let (vClassDeclRestNew, _) = generateVClassDecls command vClassDeclRest vClassDeclsRestHole
      in ((vClassDeclHead: vClassDeclRestNew), False)
generateVClassDecls command@(Extend extendName) vClassDecls vClassDeclsHole =
  case (vClassDecls, vClassDeclsHole) of
    ([Just (Right (VClassDeclaration vClassName _ Nothing))], [Just (Right (VClassDeclaration Nothing (Just (Left Hole)) Nothing))]) -> 
      let vClassDeclNew = (Just (Right (VClassDeclaration vClassName (Just (Right (VExtendName (VName extendName)))) (Just (Left Hole)))))
      in ([vClassDeclNew], False)
    ((vClassDeclHead: vClassDeclRest), (Nothing: vClassDeclsRestHole)) ->
      let (vClassDeclRestNew, _) = generateVClassDecls command vClassDeclRest vClassDeclsRestHole
      in ((vClassDeclHead: vClassDeclRestNew), False)
generateVClassDecls command@(FieldDef _) vClassDecls vClassDeclsHole =
  case (vClassDecls, vClassDeclsHole) of
    ([Just (Right (VClassDeclaration vClassName vExtendName vClassBody))], [Just (Right (VClassDeclaration Nothing Nothing vClassBodyHole))]) -> 
      let (vClassBodyNew, _) = generateVClassBody command vClassBody vClassBodyHole
      in ([Just (Right (VClassDeclaration vClassName vExtendName vClassBodyNew))], False)
    ((vClassDeclHead: vClassDeclRest), (Nothing: vClassDeclsRestHole)) ->
      let (vClassDeclRestNew, _) = generateVClassDecls command vClassDeclRest vClassDeclsRestHole
      in ((vClassDeclHead: vClassDeclRestNew), False)    
generateVClassDecls command@(TypeDef _) vClassDecls vClassDeclsHole =
  case (vClassDecls, vClassDeclsHole) of
    ([Just (Right (VClassDeclaration vClassName vExtendName vClassBody))], [Just (Right (VClassDeclaration Nothing Nothing vClassBodyHole))]) -> 
      let (vClassBodyNew, _) = generateVClassBody command vClassBody vClassBodyHole
      in ([Just (Right (VClassDeclaration vClassName vExtendName vClassBodyNew))], False)
    ((vClassDeclHead: vClassDeclRest), (Nothing: vClassDeclsRestHole)) ->
      let (vClassDeclRestNew, _) = generateVClassDecls command vClassDeclRest vClassDeclsRestHole
      in ((vClassDeclHead: vClassDeclRestNew), False)    
generateVClassDecls ConstructorDef vClassDecls vClassDeclsHole =
  case (vClassDecls, vClassDeclsHole) of
    ([Just (Right (VClassDeclaration vClassName vExtendName vClassBody))], [Just (Right (VClassDeclaration Nothing Nothing vClassBodyHole))]) -> 
      let (vClassBodyNew, _) = generateVClassBody (ConstructorDefHelper (getClassName vClassName) ) vClassBody vClassBodyHole -- new constructor
      in ([Just (Right (VClassDeclaration vClassName vExtendName vClassBodyNew))], False)
    ((vClassDeclHead: vClassDeclRest), (Nothing: vClassDeclsRestHole)) ->
      let (vClassDeclRestNew, _) = generateVClassDecls ConstructorDef vClassDeclRest vClassDeclsRestHole
      in ((vClassDeclHead: vClassDeclRestNew), False)  

generateVClassDecls CallSuper vClassDecls vClassDeclsHole =
  case (vClassDecls, vClassDeclsHole) of
    ([Just (Right (VClassDeclaration vClassName vExtendName vClassBody))], [Just (Right (VClassDeclaration Nothing Nothing vClassBodyHole))]) -> 
      let (vClassBodyNew, _) = generateVClassBody CallSuper vClassBody vClassBodyHole
      in ([Just (Right (VClassDeclaration vClassName vExtendName vClassBodyNew))], False)
    ((vClassDeclHead: vClassDeclRest), (Nothing: vClassDeclsRestHole)) ->
      let (vClassDeclRestNew, _) = generateVClassDecls CallSuper vClassDeclRest vClassDeclsRestHole
      in ((vClassDeclHead: vClassDeclRestNew), False)    
generateVClassDecls command@(ParameterDef _) vClassDecls vClassDeclsHole =
  case (vClassDecls, vClassDeclsHole) of
    ([Just (Right (VClassDeclaration vClassName vExtendName vClassBody))], [Just (Right (VClassDeclaration Nothing Nothing vClassBodyHole))]) -> 
      let (vClassBodyNew, _) = generateVClassBody command vClassBody vClassBodyHole
      in ([Just (Right (VClassDeclaration vClassName vExtendName vClassBodyNew))], False)
    ((vClassDeclHead: vClassDeclRest), (Nothing: vClassDeclsRestHole)) ->
      let (vClassDeclRestNew, _) = generateVClassDecls command vClassDeclRest vClassDeclsRestHole
      in ((vClassDeclHead: vClassDeclRestNew), False)  
generateVClassDecls command@(Variable _) vClassDecls vClassDeclsHole =
  case (vClassDecls, vClassDeclsHole) of
    ([Just (Right (VClassDeclaration vClassName vExtendName vClassBody))], [Just (Right (VClassDeclaration Nothing Nothing vClassBodyHole))]) -> 
      let (vClassBodyNew, _) = generateVClassBody command vClassBody vClassBodyHole
      in ([Just (Right (VClassDeclaration vClassName vExtendName vClassBodyNew))], False)
    ((vClassDeclHead: vClassDeclRest), (Nothing: vClassDeclsRestHole)) ->
      let (vClassDeclRestNew, _) = generateVClassDecls command vClassDeclRest vClassDeclsRestHole
      in ((vClassDeclHead: vClassDeclRestNew), False)  
generateVClassDecls FieldAssignment vClassDecls vClassDeclsHole =
  case (vClassDecls, vClassDeclsHole) of
    ([Just (Right (VClassDeclaration vClassName vExtendName vClassBody))], [Just (Right (VClassDeclaration Nothing Nothing vClassBodyHole))]) -> 
      let (vClassBodyNew, _) = generateVClassBody FieldAssignment vClassBody vClassBodyHole
      in ([Just (Right (VClassDeclaration vClassName vExtendName vClassBodyNew))], False)
    ((vClassDeclHead: vClassDeclRest), (Nothing: vClassDeclsRestHole)) ->
      let (vClassDeclRestNew, _) = generateVClassDecls FieldAssignment vClassDeclRest vClassDeclsRestHole
      in ((vClassDeclHead: vClassDeclRestNew), False)  
generateVClassDecls command@(MethodDef _) vClassDecls vClassDeclsHole =
  case (vClassDecls, vClassDeclsHole) of
    ([Just (Right (VClassDeclaration vClassName vExtendName vClassBody))], [Just (Right (VClassDeclaration Nothing Nothing vClassBodyHole))]) -> 
      let (vClassBodyNew, _) = generateVClassBody command vClassBody vClassBodyHole
      in ([Just (Right (VClassDeclaration vClassName vExtendName vClassBodyNew))], False)
    ((vClassDeclHead: vClassDeclRest), (Nothing: vClassDeclsRestHole)) ->
      let (vClassDeclRestNew, _) = generateVClassDecls command vClassDeclRest vClassDeclsRestHole
      in ((vClassDeclHead: vClassDeclRestNew), False)   
generateVClassDecls MoveNext vClassDecls vClassDeclsHole =
  case (vClassDecls, vClassDeclsHole) of
    (_, [Just (Left Hole)]) -> ([], True)
    ([Just (Right (VClassDeclaration vClassName vExtendName vClassBody))], [Just (Right (VClassDeclaration Nothing Nothing vClassBodyHole))]) -> 
      let (vClassBodyNew, shallCreateNewHole) = generateVClassBody MoveNext vClassBody vClassBodyHole
      in ([Just (Right (VClassDeclaration vClassName vExtendName vClassBodyNew))], shallCreateNewHole)
    ((vClassDeclHead: vClassDeclRest), (Nothing: vClassDeclsRestHole)) ->
      let (vClassDeclRestNew, shallCreateNewHole) = generateVClassDecls MoveNext vClassDeclRest vClassDeclsRestHole
      in ((vClassDeclHead: vClassDeclRestNew), shallCreateNewHole)    
    (_, [Just (Right (VClassDeclaration _ _ _))]) -> undefined
generateVClassDecls command@MethodCallExpr vClassDecls vClassDeclsHole =
  generateVClassDeclsForExpr command vClassDecls vClassDeclsHole
generateVClassDecls command@(NewInstanceExpr _) vClassDecls vClassDeclsHole =
  generateVClassDeclsForExpr command vClassDecls vClassDeclsHole
generateVClassDecls command@FieldAccessExpr vClassDecls vClassDeclsHole =
  generateVClassDeclsForExpr command vClassDecls vClassDeclsHole
generateVClassDecls command@ConversionExpr vClassDecls vClassDeclsHole =
  generateVClassDeclsForExpr command vClassDecls vClassDeclsHole
generateVClassDecls command@(NameCommand _) vClassDecls vClassDeclsHole =
  generateVClassDeclsForExpr command vClassDecls vClassDeclsHole
generateVClassDecls command@(CallMethod _) vClassDecls vClassDeclsHole =
  generateVClassDeclsForExpr command vClassDecls vClassDeclsHole



generateVClassDeclsForExpr :: Command -> [VNode VClassDeclaration] -> [VNode VClassDeclaration] -> ([VNode VClassDeclaration], ShallCreateNewHole)
generateVClassDeclsForExpr command vClassDecls vClassDeclsHole =
  case (vClassDecls, vClassDeclsHole) of
    ([Just (Right (VClassDeclaration vClassName vExtendName vClassBody))], [Just (Right (VClassDeclaration Nothing Nothing vClassBodyHole))]) -> 
      let (vClassBodyNew, shallCreateNewHole) = generateVClassBody command vClassBody vClassBodyHole
      in if shallCreateNewHole
        then ([Just (Right (VClassDeclaration vClassName vExtendName vClassBodyNew)), Just (Left Hole)], False)
        else ([Just (Right (VClassDeclaration vClassName vExtendName vClassBodyNew))], False)
    ((vClassDeclHead: vClassDeclRest), (Nothing: vClassDeclsRestHole)) ->
      let (vClassDeclRestNew, _) = generateVClassDecls command vClassDeclRest vClassDeclsRestHole
      in ((vClassDeclHead: vClassDeclRestNew), False)  

getClassName :: VNode VClassName -> String
getClassName Nothing = ""
getClassName (Just (Right (VClassName (VName name)))) = name
getClassName (Just (Left Hole)) = ""


generateVClassDecl :: Command -> VNode VClassDeclaration -> VNode VClassDeclaration -> (VNode VClassDeclaration, ShallCreateNewHole)
generateVClassDecl command@(ClassDef className) _ _ = 
  let vClassDecl = VClassDeclaration (Just (Right (VClassName (VName className)))) (Just (Left Hole)) Nothing
  in (Just (Right vClassDecl), False)

generateVClassBody :: Command -> VNode VClassBody -> VNode VClassBody -> (VNode VClassBody, ShallCreateNewHole)
generateVClassBody command@(FieldDef _) vClassBody vClassBodyHole = 
  case (vClassBody, vClassBodyHole) of 
    (Just (Left Hole), Just (Left Hole)) -> 
      let vFieldDecl = generateFieldDecl command 
      in (Just (Right (VClassBody [Just (Right vFieldDecl)] Nothing [])), False)
    (Just (Right (VClassBody vFieldDecls vConstructor vMethodDecls)), Just (Right (VClassBody vFieldDeclsHole Nothing []))) ->
      let (vFieldDeclsNew, _) = generateVFieldDecls command vFieldDecls vFieldDeclsHole
      in ((Just (Right (VClassBody vFieldDeclsNew vConstructor vMethodDecls))), False)
generateVClassBody command@(TypeDef _) vClassBody vClassBodyHole = 
  case (vClassBody, vClassBodyHole) of 
    (Just (Right (VClassBody vFieldDecls vConstructor vMethodDecls)), Just (Right (VClassBody vFieldDeclsHole Nothing []))) ->
      let (vFieldDeclsNew, _) = generateVFieldDecls command vFieldDecls vFieldDeclsHole
      in ((Just (Right (VClassBody vFieldDeclsNew vConstructor vMethodDecls))), False)
    (Just (Right (VClassBody vFieldDecls vConstructor vMethodDecls)), Just (Right (VClassBody [] vConstructorHole []))) -> 
      let (vConstructorNew, _) = generateVConstructor command vConstructor vConstructorHole
      in ((Just (Right (VClassBody vFieldDecls vConstructorNew vMethodDecls))), False)
    (Just (Right (VClassBody vFieldDecls vConstructor vMethodDecls)), Just (Right (VClassBody [] Nothing vMethodDeclsHole))) -> 
      let (vMethodDeclsNew, shallCreateNewHole) = generateVMethodDecls command vMethodDecls vMethodDeclsHole
      in (Just (Right (VClassBody vFieldDecls vConstructor vMethodDeclsNew)), shallCreateNewHole)
generateVClassBody (ConstructorDefHelper name) vClassBody vClassBodyHole = 
   case (vClassBody, vClassBodyHole) of 
    (Just (Right (VClassBody vFieldDecls vConstructor vMethodDecls)), Just (Right (VClassBody [] (Just (Left Hole)) []))) ->
      let vConstructorNew = Just (Right (VConstructor (Just (Right (VTypeName (VName name)))) [(Just (Left Hole))] Nothing)) 
      in ((Just (Right (VClassBody vFieldDecls vConstructorNew vMethodDecls))), False)
generateVClassBody MoveNext vClassBody vClassBodyHole = 
  case (vClassBody, vClassBodyHole) of 
    (Just (Right (VClassBody vFieldDecls vConstructor vMethodDecls)), Just (Right (VClassBody vFieldDeclsHole Nothing []))) ->
      let (vFieldDeclsNew, shallCreateNewHole) = generateVFieldDecls MoveNext vFieldDecls vFieldDeclsHole
      in if shallCreateNewHole
        then ((Just (Right (VClassBody vFieldDeclsNew (Just (Left Hole)) vMethodDecls))), False)
        else ((Just (Right (VClassBody vFieldDeclsNew vConstructor vMethodDecls))), False)
    (Just (Right (VClassBody vFieldDecls vConstructor vMethodDecls)), Just (Right (VClassBody [] Nothing vMethodDeclsHole))) ->
      let (vMethodDeclsNew, shallCreateNewHole) = generateVMethodDecls MoveNext vMethodDecls vMethodDeclsHole
      in ((Just (Right (VClassBody vFieldDecls vConstructor vMethodDeclsNew))), shallCreateNewHole)
    (Just (Right (VClassBody vFieldDecls vConstructor vMethodDecls)), Just (Right (VClassBody [] vConstructorHole []))) ->
      let (vConstructorNew, shallCreateNewHole) = generateVConstructor MoveNext vConstructor vConstructorHole
      in if shallCreateNewHole
        then (Just (Right (VClassBody vFieldDecls vConstructorNew [Just (Left Hole)])), False)
        else (Just (Right (VClassBody vFieldDecls vConstructorNew vMethodDecls)), False)
    (_, Just (Right (VClassBody _ _ _))) -> undefined
generateVClassBody CallSuper vClassBody vClassBodyHole = 
  case (vClassBody, vClassBodyHole) of 
    (Just (Right (VClassBody vFieldDecls vConstructor vMethodDecls)), Just (Right (VClassBody [] vConstructorHole []))) ->
      let (vConstructorNew, shallCreateNewHole) = generateVConstructor CallSuper vConstructor vConstructorHole
      in if shallCreateNewHole
        then ((Just (Right (VClassBody vFieldDecls vConstructorNew [Just (Left Hole)]))), False) 
        else ((Just (Right (VClassBody vFieldDecls vConstructorNew vMethodDecls))), False) 
generateVClassBody command@(ParameterDef _) vClassBody vClassBodyHole = 
  case (vClassBody, vClassBodyHole) of 
    (Just (Right (VClassBody vFieldDecls vConstructor vMethodDecls)), Just (Right (VClassBody [] vConstructorHole []))) ->
      let (vConstructorNew, shallCreateNewHole) = generateVConstructor command vConstructor vConstructorHole
      in if shallCreateNewHole
        then (Just (Right (VClassBody vFieldDecls vConstructorNew [Just (Left Hole)])), False) 
        else (Just (Right (VClassBody vFieldDecls vConstructorNew vMethodDecls)), False)
    (Just (Right (VClassBody vFieldDecls vConstructor vMethodDecls)), Just (Right (VClassBody [] Nothing vMethodDeclsHole))) ->
      let (vMethodDeclsNew, shallCreateNewHole) = generateVMethodDecls command vMethodDecls vMethodDeclsHole 
      in (Just (Right (VClassBody vFieldDecls vConstructor vMethodDeclsNew)), False)
generateVClassBody command@(Variable _) vClassBody vClassBodyHole = 
  case (vClassBody, vClassBodyHole) of 
    (Just (Right (VClassBody vFieldDecls vConstructor vMethodDecls)), Just (Right (VClassBody [] vConstructorHole []))) ->
      let (vConstructorNew, shallCreateNewHole) = generateVConstructor command vConstructor vConstructorHole
      in if shallCreateNewHole
        then ((Just (Right (VClassBody vFieldDecls vConstructorNew [Just (Left Hole)]))), False) 
        else ((Just (Right (VClassBody vFieldDecls vConstructorNew vMethodDecls))), False)                 
    (Just (Right (VClassBody vFieldDecls vConstructor vMethodDecls)), Just (Right (VClassBody [] Nothing vMethodDeclsHole))) ->
      let (vMethodDeclsNew, shallCreateNewHole) = generateVMethodDecls command vMethodDecls vMethodDeclsHole
      in ((Just (Right (VClassBody vFieldDecls vConstructor vMethodDeclsNew))), shallCreateNewHole) 
generateVClassBody command@FieldAssignment vClassBody vClassBodyHole = 
  case (vClassBody, vClassBodyHole) of 
    (Just (Right (VClassBody vFieldDecls vConstructor vMethodDecls)), Just (Right (VClassBody [] vConstructorHole []))) ->
      let (vConstructorNew, shallCreateNewHole) = generateVConstructor command vConstructor vConstructorHole
      in if shallCreateNewHole
        then ((Just (Right (VClassBody vFieldDecls vConstructorNew [Just (Left Hole)]))), False) 
        else ((Just (Right (VClassBody vFieldDecls vConstructorNew vMethodDecls))), False)                 
generateVClassBody command@(MethodDef _) vClassBody vClassBodyHole = 
  case (vClassBody, vClassBodyHole) of 
    (Just (Right (VClassBody vFieldDecls vConstructor vMethodDecls)), Just (Right (VClassBody [] Nothing vMethodDeclsHole))) ->
      let (vMethodDeclsNew, _) = generateVMethodDecls command vMethodDecls vMethodDeclsHole
      in ((Just (Right (VClassBody vFieldDecls vConstructor vMethodDeclsNew))), False)                 
generateVClassBody command@MethodCallExpr vClassBody vClassBodyHole = 
  generateVClassBody' command vClassBody vClassBodyHole
generateVClassBody command@(NewInstanceExpr _) vClassBody vClassBodyHole = 
  generateVClassBody' command vClassBody vClassBodyHole
generateVClassBody command@FieldAccessExpr vClassBody vClassBodyHole = 
  generateVClassBody' command vClassBody vClassBodyHole
generateVClassBody command@ConversionExpr vClassBody vClassBodyHole = 
  generateVClassBody' command vClassBody vClassBodyHole
generateVClassBody command@(NameCommand _) vClassBody vClassBodyHole = 
  generateVClassBody' command vClassBody vClassBodyHole



generateVClassBody' command vClassBody vClassBodyHole = 
  case (vClassBody, vClassBodyHole) of 
    (Just (Right (VClassBody vFieldDecls vConstructor vMethodDecls)), Just (Right (VClassBody [] Nothing vMethodDeclsHole))) ->
      let (vMethodDeclsNew, _) = generateVMethodDecls command vMethodDecls vMethodDeclsHole
      in ((Just (Right (VClassBody vFieldDecls vConstructor vMethodDeclsNew))), False)                 

generateVFieldDecls :: Command -> [VNode VFieldDeclaration] -> [VNode VFieldDeclaration] -> ([VNode VFieldDeclaration], ShallCreateNewHole)
generateVFieldDecls command@(FieldDef fieldName) vFieldDecls vFieldDeclsHole =
  case (vFieldDecls, vFieldDeclsHole) of 
    ([Just (Left Hole)], [(Just (Left Hole))]) -> 
      let vFieldDecl = generateFieldDecl command
      in ([Just (Right vFieldDecl)], False)
    ((vFieldDeclFirst: vFieldDeclsRest), (Nothing: vFieldDeclsHoleRest)) ->
      let (vFieldDeclsRestNew, _) = generateVFieldDecls command vFieldDeclsRest vFieldDeclsHoleRest
      in ((vFieldDeclFirst: vFieldDeclsRestNew), False)
generateVFieldDecls command@(TypeDef typeName) vFieldDecls vFieldDeclsHole =
  case (vFieldDecls, vFieldDeclsHole) of 
    ([Just (Right (VFieldDeclaration (Just (Left Hole)) vVariableName))], [(Just (Right (VFieldDeclaration (Just (Left Hole)) Nothing)))]) -> 
      let vFieldDeclNew = VFieldDeclaration (Just (Right (VTypeName (VName typeName)))) vVariableName
      in ([Just (Right vFieldDeclNew), Just (Left Hole)], False)
    ((vFieldDeclFirst: vFieldDeclsRest), (Nothing: vFieldDeclsHoleRest)) ->
      let (vFieldDeclsRestNew, _) = generateVFieldDecls command vFieldDeclsRest vFieldDeclsHoleRest
      in ((vFieldDeclFirst: vFieldDeclsRestNew), False)
generateVFieldDecls MoveNext vFieldDecls vFieldDeclsHole =
  case (vFieldDecls, vFieldDeclsHole) of 
    (_,[Just (Left Hole)]) -> ([], True)
    ((vFieldDeclFirst: vFieldDeclsRest), (Nothing: vFieldDeclsHoleRest)) ->
      let (vFieldDeclsRestNew, shallCreateNewHole) = generateVFieldDecls MoveNext vFieldDeclsRest vFieldDeclsHoleRest
      in ((vFieldDeclFirst: vFieldDeclsRestNew), shallCreateNewHole)
    (_, [(Just (Right (VFieldDeclaration _ _)))]) ->  undefined

generateFieldDecl :: Command -> VFieldDeclaration
generateFieldDecl command@(FieldDef fieldName) = VFieldDeclaration (Just (Left Hole)) (Just (Right (VVariableName (VName fieldName))))


generateVMethodDecls :: Command -> [VNode VMethodDeclaration] -> [VNode VMethodDeclaration] -> ([VNode VMethodDeclaration], ShallCreateNewHole)
generateVMethodDecls command@(MethodDef name) vMethodDecls vMethodDeclsHole = 
  case (vMethodDecls, vMethodDeclsHole) of 
    (_,[Just (Left Hole)]) -> ([(Just (Right (VMethodDeclaration (Just (Left Hole)) (Just (Right (VMethodName (VName name)))) [] Nothing)))], False)
    ((v:vs),(Nothing:hs)) -> 
      let (vsNew, _) = generateVMethodDecls command vs hs
      in ((v:vsNew), False)
generateVMethodDecls command@(TypeDef name) vMethodDecls vMethodDeclsHole = 
  case (vMethodDecls, vMethodDeclsHole) of 
    ([(Just (Right (VMethodDeclaration _ vMethodName vParameters vMethodBody)))],[(Just (Right (VMethodDeclaration (Just (Left Hole)) Nothing [] Nothing)))]) -> ([(Just (Right (VMethodDeclaration (Just (Right (VTypeName (VName name)))) vMethodName [(Just (Left Hole))] vMethodBody)))], False)
    ([(Just (Right (VMethodDeclaration vTypeName vMethodName vParameters vMethodBody)))],[(Just (Right (VMethodDeclaration Nothing Nothing vParametersHole Nothing)))]) -> 
      let (vParametersNew, _) = generateVParameters command vParameters vParametersHole
      in ([(Just (Right (VMethodDeclaration vTypeName vMethodName vParametersNew vMethodBody)))], False) 
    ((v:vs),(Nothing:hs)) -> 
      let (vsNew, _) = generateVMethodDecls command vs hs
      in ((v:vsNew), False)
generateVMethodDecls command@(ParameterDef name) vMethodDecls vMethodDeclsHole = 
  case (vMethodDecls, vMethodDeclsHole) of 
    ([(Just (Right (VMethodDeclaration vTypeName vMethodName vParameters vMethodBody)))],[(Just (Right (VMethodDeclaration Nothing Nothing vParametersHole Nothing)))]) -> 
      let (vParametersNew, _) = generateVParameters command vParameters vParametersHole
      in ([(Just (Right (VMethodDeclaration vTypeName vMethodName vParametersNew vMethodBody)))], False)
    ((v:vs),(Nothing:hs)) -> 
      let (vsNew, _) = generateVMethodDecls command vs hs
      in ((v:vsNew), False)
generateVMethodDecls MoveNext vMethodDecls vMethodDeclsHole = 
  case (vMethodDecls, vMethodDeclsHole) of 
    (_,[Just (Left Hole)]) -> ([], True)
    ([Just (Right (VMethodDeclaration vTypeName vMethodName vParameters vMethodBody))], [Just (Right (VMethodDeclaration Nothing Nothing vParametersHole Nothing))]) -> 
      let (vParametersNew, shallCreateNewHole) = generateVParameters MoveNext vParameters vParametersHole
      in if shallCreateNewHole 
        then ([Just (Right (VMethodDeclaration vTypeName vMethodName vParametersNew (Just (Left Hole))))], False)
        else ([Just (Right (VMethodDeclaration vTypeName vMethodName vParametersNew vMethodBody))], False)
    ([Just (Right (VMethodDeclaration vTypeName vMethodName vParameters vMethodBody))], [(Just (Right (VMethodDeclaration Nothing Nothing [] vMethodBodyHole)))]) ->  
      let (vMethodBodyNew, shallCreateNewHole) = generateVMethodBody MoveNext vMethodBody vMethodBodyHole
      in  if shallCreateNewHole
        then ([Just (Right (VMethodDeclaration vTypeName vMethodName vParameters vMethodBodyNew)), (Just (Left Hole))], False)
        else 
        ([Just (Right (VMethodDeclaration vTypeName vMethodName vParameters vMethodBodyNew))], False)
    ((vMethodDeclFirst :vMethodDeclsRest), (Nothing: vMethodDeclsHoleRest)) -> 
      let (vMethodDeclsRestNew, shallCreateNewHole) = generateVMethodDecls MoveNext vMethodDeclsRest vMethodDeclsHoleRest
      in ((vMethodDeclFirst : vMethodDeclsRestNew), shallCreateNewHole)
generateVMethodDecls command@MethodCallExpr vMethodDecls vMethodDeclsHole = 
  generateVMethodDecls' command vMethodDecls vMethodDeclsHole
generateVMethodDecls command@(NewInstanceExpr _) vMethodDecls vMethodDeclsHole = 
  generateVMethodDecls' command vMethodDecls vMethodDeclsHole
generateVMethodDecls command@(Variable _) vMethodDecls vMethodDeclsHole = 
  generateVMethodDecls' command vMethodDecls vMethodDeclsHole
generateVMethodDecls command@FieldAccessExpr vMethodDecls vMethodDeclsHole = 
  generateVMethodDecls' command vMethodDecls vMethodDeclsHole
generateVMethodDecls command@ConversionExpr vMethodDecls vMethodDeclsHole = 
  generateVMethodDecls' command vMethodDecls vMethodDeclsHole
generateVMethodDecls command@(NameCommand _) vMethodDecls vMethodDeclsHole = 
  generateVMethodDecls' command vMethodDecls vMethodDeclsHole




generateVMethodDecls' :: Command -> [VNode VMethodDeclaration] -> [VNode VMethodDeclaration] -> ([VNode VMethodDeclaration], ShallCreateNewHole)
generateVMethodDecls' command vMethodDecls vMethodDeclsHole = 
  case (vMethodDecls, vMethodDeclsHole) of 
    ([(Just (Right (VMethodDeclaration vTypeName vMethodName vParameters vMethodBody)))],[(Just (Right (VMethodDeclaration Nothing Nothing [] vMethodBodyHole)))]) -> 
      let (vMethodBodyNew, shallCreateNewHole) = generateVMethodBody command vMethodBody vMethodBodyHole
      in if shallCreateNewHole
        then ([(Just (Right (VMethodDeclaration vTypeName vMethodName vParameters vMethodBodyNew))), Just (Left Hole)], False)
        else ([(Just (Right (VMethodDeclaration vTypeName vMethodName vParameters vMethodBodyNew)))], False)
    ((v:vs),(Nothing:hs)) -> 
      let (vsNew, _) = generateVMethodDecls' command vs hs
      in ((v:vsNew), False)

generateVConstructor :: Command -> VNode VConstructor -> VNode VConstructor -> (VNode VConstructor, ShallCreateNewHole)
generateVConstructor CallSuper vConstructor vConstructorHole = 
  case (vConstructor, vConstructorHole) of 
    (Just (Right (VConstructor vTypeName vParameters vConstructorBody)), Just (Right (VConstructor Nothing [] vConstructorBodyHole))) -> 
      let (vConstructorBodyNew, shallCreateNewHole) = generateVConstructorBody CallSuper vConstructorBody vConstructorBody
      in ((Just (Right (VConstructor vTypeName vParameters vConstructorBodyNew))), shallCreateNewHole)
generateVConstructor command@(ParameterDef _) vConstructor vConstructorHole = 
  case (vConstructor, vConstructorHole) of 
    (Just (Right (VConstructor vTypeName vParameters vConstructorBody)), Just (Right (VConstructor Nothing vParametersHole Nothing))) -> 
      let (vParametersNew, _) = generateVParameters command vParameters vParametersHole
      in  (Just (Right (VConstructor vTypeName vParametersNew vConstructorBody)), False)
generateVConstructor command@(TypeDef _) vConstructor vConstructorHole = 
  case (vConstructor, vConstructorHole) of 
    (Just (Right (VConstructor vTypeName vParameters vConstructorBody)), Just (Right (VConstructor Nothing vParametersHole Nothing))) -> 
      let (vParametersNew, _) = generateVParameters command vParameters vParametersHole
      in  (Just (Right (VConstructor vTypeName vParametersNew vConstructorBody)), False)
generateVConstructor MoveNext vConstructor vConstructorHole = 
  case (vConstructor, vConstructorHole) of 
    (Just (Right (VConstructor vTypeName vParameters vConstructorBody)), Just (Right (VConstructor Nothing vParametersHole Nothing))) -> 
      let (vParametersNew, shallCreateNewHole) = generateVParameters MoveNext vParameters vParametersHole
      in  if shallCreateNewHole
        then (Just (Right (VConstructor vTypeName vParametersNew (Just (Left Hole)))), False)
        else (Just (Right (VConstructor vTypeName vParametersNew vConstructorBody)), False)
    (Just (Right (VConstructor vTypeName vParameters vConstructorBody)), Just (Right (VConstructor Nothing [] vConstructorBodyHole))) -> 
      let (vConstructorBodyNew, shallCreateNewHole) = generateVConstructorBody MoveNext vConstructorBody vConstructorBodyHole
      in (Just (Right (VConstructor vTypeName vParameters vConstructorBodyNew)), shallCreateNewHole)
generateVConstructor command@(Variable _) vConstructor vConstructorHole = 
  case (vConstructor, vConstructorHole) of 
    (Just (Right (VConstructor vTypeName vParameters vConstructorBody)), Just (Right (VConstructor Nothing [] vConstructorBodyHole))) -> 
      let (vConstructorBodyNew, shallCreateNewHole) = generateVConstructorBody command vConstructorBody vConstructorBodyHole
      in ((Just (Right (VConstructor vTypeName vParameters vConstructorBodyNew))), shallCreateNewHole)
generateVConstructor command@FieldAssignment vConstructor vConstructorHole = 
  case (vConstructor, vConstructorHole) of 
    (Just (Right (VConstructor vTypeName vParameters vConstructorBody)), Just (Right (VConstructor Nothing [] vConstructorBodyHole))) -> 
      let (vConstructorBodyNew, shallCreateNewHole) = generateVConstructorBody command vConstructorBody vConstructorBodyHole
      in ((Just (Right (VConstructor vTypeName vParameters vConstructorBodyNew))), shallCreateNewHole)




generateVConstructorBody :: Command -> VNode VConstructorBody -> VNode VConstructorBody -> (VNode VConstructorBody, ShallCreateNewHole)
generateVConstructorBody CallSuper vConstructorBody vConstructorBodyHole = 
  case (vConstructorBody, vConstructorBodyHole) of 
    (_, (Just (Left Hole))) -> (Just (Right (VConstructorBody (Just (Right (VSuper [Just (Left Hole)]))) [])), False)
generateVConstructorBody command@(Variable _) vConstructorBody vConstructorBodyHole = 
  case (vConstructorBody, vConstructorBodyHole) of 
    ((Just (Right (VConstructorBody vSuper vFieldAssignments))), (Just (Right (VConstructorBody vSuperHole [])))) -> 
      let (vSuperNew, shallCreateNewHole) = generateVSuper command vSuper vSuperHole
      in if shallCreateNewHole
        then (Just (Right (VConstructorBody vSuperNew [Just (Left Hole)])), False)
        else (Just (Right (VConstructorBody vSuperNew vFieldAssignments)), False)
    ((Just (Right (VConstructorBody vSuper vFieldAssignments))), (Just (Right (VConstructorBody Nothing vFieldAssignmentsHole)))) -> 
      let (vFieldAssignmentsNew, _) = generateVFieldAssignments command vFieldAssignments vFieldAssignmentsHole
      in ((Just (Right (VConstructorBody vSuper vFieldAssignmentsNew))), False)
generateVConstructorBody MoveNext vConstructorBody vConstructorBodyHole =
  case (vConstructorBody, vConstructorBodyHole) of 
    ((Just (Right (VConstructorBody vSuper vFieldAssignments))), (Just (Right (VConstructorBody vSuperHole [])))) -> 
      let (vSuperNew, shallCreateNewHole) = generateVSuper MoveNext vSuper vSuperHole
      in if shallCreateNewHole
        then (Just (Right (VConstructorBody vSuperNew [Just (Left Hole)])), False)
        else (Just (Right (VConstructorBody vSuperNew vFieldAssignments)), False)
    ((Just (Right (VConstructorBody vSuper vFieldAssignments))), (Just (Right (VConstructorBody Nothing vFieldAssignmentsHole)))) -> 
      let (vFieldAssignmentsNew, shallCreateNewHole) = generateVFieldAssignments MoveNext vFieldAssignments vFieldAssignmentsHole
      in ((Just (Right (VConstructorBody vSuper vFieldAssignmentsNew))), shallCreateNewHole)
generateVConstructorBody command@FieldAssignment vConstructorBody vConstructorBodyHole =
  case (vConstructorBody, vConstructorBodyHole) of 
    ((Just (Right (VConstructorBody vSuper vFieldAssignments))), (Just (Right (VConstructorBody Nothing vFieldAssignmentsHole)))) -> 
      let (vFieldAssignmentNew, _) = generateVFieldAssignments command vFieldAssignments vFieldAssignmentsHole
      in ((Just (Right (VConstructorBody vSuper vFieldAssignmentNew))),False)

generateVParameters :: Command -> [VNode VParameter] -> [VNode VParameter] -> ([VNode VParameter], ShallCreateNewHole)
generateVParameters command@(ParameterDef name) vParameters vParametersHole =
  case (vParameters, vParametersHole) of 
    (_, [Just (Left Hole)]) -> ([Just (Right (VParameter (Just (Left Hole)) (Just (Right (VVariableName (VName name))))))], False)
    ((v:vs), (Nothing: vsh)) -> 
      let (vsNew, _) = generateVParameters command vs vsh
      in ((v:vsNew), False)
generateVParameters command@(TypeDef name) vParameters vParametersHole =
  case (vParameters, vParametersHole) of 
    ([Just (Right (VParameter _ vVariableName))], [Just (Right (VParameter (Just (Left Hole)) vVariableNameHole))]) ->
      ([Just (Right (VParameter (Just (Right (VTypeName (VName name)))) vVariableName)), Just (Left Hole)], False)
    ((v:vs), (Nothing: vsh)) -> 
      let (vsNew, _) = generateVParameters command vs vsh
      in ((v:vsNew), False)
generateVParameters MoveNext vParameters vParametersHole = 
  case (vParameters, vParametersHole) of 
      (_,[Just (Left Hole)]) -> ([], True)
      ((v:vs),(Nothing:vsh) ) -> 
        let (vsNew, shallCreateNewHole) = generateVParameters MoveNext vs vsh
        in ((v: vsNew), shallCreateNewHole)

generateVSuper :: Command -> VNode VSuper -> VNode VSuper -> (VNode VSuper, ShallCreateNewHole)
generateVSuper command@(Variable _) vSuper vSuperHole = 
  case (vSuper, vSuperHole) of 
    (Just (Right (VSuper vArguments)), Just (Right (VSuper vArgumentsHole))) -> 
      let (vArgumentsNew, _) = generateVArguments command vArguments vArgumentsHole
      in (Just (Right (VSuper vArgumentsNew)), False)
generateVSuper MoveNext vSuper vSuperHole = 
  case (vSuper, vSuperHole) of 
    (Just (Right (VSuper vArguments)), Just (Right (VSuper vArgumentsHole))) -> 
      let (vArgumentsNew, shallCreateNewHole) = generateVArguments MoveNext vArguments vArgumentsHole
      in (Just (Right (VSuper vArgumentsNew)), shallCreateNewHole)


generateVArguments :: Command -> [VNode VArgument] -> [VNode VArgument] -> ([VNode VArgument], ShallCreateNewHole)
generateVArguments command@(Variable name) vArguments vArgumentsHole = 
  case (vArguments, vArgumentsHole) of 
    (_, [Just (Left Hole)]) -> ([Just (Right (VArgument (Just (Right (VVariable (Just (Right (VVariableName (VName name))))))))), Just (Left Hole)], False)
    ((vArgument: vArgumentsRest), (Nothing: vArgsHoleRest)) -> 
      let (vArgumentsRestNew, _) = generateVArguments command vArgumentsRest vArgsHoleRest
      in ((vArgument :vArgumentsRestNew), False)
generateVArguments MoveNext vArguments vArgumentsHole = 
  case (vArguments, vArgumentsHole) of 
    (_, [Just (Left Hole)]) -> ([], True)
    ((v:vs), (Nothing: vsh)) -> 
      let (vsNew, shallCreateNewHole) = generateVArguments MoveNext vs vsh
      in ((v:vsNew), shallCreateNewHole)

generateVFieldAssignments :: Command -> [VNode VFieldAssignment] -> [VNode VFieldAssignment] -> ([VNode VFieldAssignment], ShallCreateNewHole)
generateVFieldAssignments FieldAssignment vFieldAssignments vFieldAssignmentsHole = 
  case (vFieldAssignments, vFieldAssignmentsHole) of 
    (_, [Just (Left Hole)]) -> ([Just (Right (VFieldAssignment (Just (Left Hole)) Nothing))], False)
    ((v:vs), (Nothing:hs)) -> 
      let (vsNew, _) = generateVFieldAssignments FieldAssignment vs hs
      in ((v:vsNew), False)
generateVFieldAssignments command@(Variable name) vFieldAssignments vFieldAssignmentsHole = 
  case (vFieldAssignments, vFieldAssignmentsHole) of 
    ([vFieldAssignment],[vFieldAssignmentHole]) -> 
      let (vFieldAssignmentNew, shallCreateNewHole) = generateVFieldAssignment command vFieldAssignment vFieldAssignmentHole
      in if shallCreateNewHole
        then ([vFieldAssignmentNew, Just (Left Hole)],False)
        else ([vFieldAssignmentNew],False)
    ((v:vs),(Nothing:hs)) -> 
      let (vsNew, _) = generateVFieldAssignments command vs hs
      in ((v:vsNew), False)
generateVFieldAssignments MoveNext vFieldAssignments vFieldAssignmentsHole = 
  case (vFieldAssignments, vFieldAssignmentsHole) of 
    (_, [Just (Left Hole)]) -> ([], True)
    ((v:vs),(Nothing: hs)) -> 
      let (vsNew, shallCreateNewHole) = generateVFieldAssignments MoveNext vs hs
      in ((v:vsNew), shallCreateNewHole)

generateVFieldAssignment :: Command -> VNode VFieldAssignment -> VNode VFieldAssignment -> (VNode VFieldAssignment, ShallCreateNewHole)
generateVFieldAssignment (Variable name) vFieldAssignment vFieldAssignmentHole = 
  case (vFieldAssignment, vFieldAssignmentHole) of 
    (_, Just (Right (VFieldAssignment (Just (Left Hole)) _))) -> ((Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName name))))))) (Just (Left Hole))))), False)
    (Just (Right (VFieldAssignment vLeft _)), Just (Right (VFieldAssignment Nothing (Just (Left Hole))))) -> ((Just (Right (VFieldAssignment vLeft (Just (Right (VVariable (Just (Right (VVariableName (VName name))))))) ))), True)

generateVMethodBody :: Command -> VNode VMethodBody -> VNode VMethodBody -> (VNode VMethodBody, ShallCreateNewHole)
generateVMethodBody command@MethodCallExpr vMethodBody vMethodBodyHole = 
  generateVMethodBody' command vMethodBody vMethodBodyHole
generateVMethodBody command@(NewInstanceExpr _) vMethodBody vMethodBodyHole = 
  generateVMethodBody' command vMethodBody vMethodBodyHole
generateVMethodBody command@(Variable _) vMethodBody vMethodBodyHole = 
  generateVMethodBody' command vMethodBody vMethodBodyHole
generateVMethodBody command@FieldAccessExpr vMethodBody vMethodBodyHole = 
  generateVMethodBody' command vMethodBody vMethodBodyHole
generateVMethodBody command@ConversionExpr vMethodBody vMethodBodyHole = 
  generateVMethodBody' command vMethodBody vMethodBodyHole
generateVMethodBody command@(NameCommand _) vMethodBody vMethodBodyHole = 
  generateVMethodBody' command vMethodBody vMethodBodyHole
generateVMethodBody command@MoveNext vMethodBody vMethodBodyHole = 
  generateVMethodBody' command vMethodBody vMethodBodyHole


generateVMethodBody' command vMethodBody vMethodBodyHole = 
  case (vMethodBody, vMethodBodyHole) of 
    (_, (Just (Left Hole))) -> 
      let (vExprNew, shallCreateNewHole) = generateVExpr command Nothing (Just (Left Hole))
      in (Just (Right (VMethodBody vExprNew)), shallCreateNewHole)
    ((Just (Right (VMethodBody vExpr))), (Just (Right (VMethodBody vExprHole)))) ->  
      let (vExprNew, shallCreateNewHole) = generateVExpr command vExpr vExprHole
      in (Just (Right (VMethodBody vExprNew)), shallCreateNewHole)
       
generateVExpr :: Command -> VNode VExpr -> VNode VExpr -> (VNode VExpr, ShallCreateNewHole)
generateVExpr command vExpr vExprHole = 
  case (vExpr, vExprHole) of 
    (_, Just (Left Hole)) -> 
      case command of 
        Variable name -> (Just (Right (VVariableExpr (Just (Right (VVariable (Just (Right (VVariableName (VName name))))))))), True)
        MethodCallExpr -> (Just (Right (VMethodCallExpr (Just (Left Hole)) Nothing [])), False)
        (NewInstanceExpr name) -> (Just (Right (VInstanceExpr (Just (Right (VTypeName (VName name)))) [(Just (Left Hole))])), False)
        FieldAccessExpr -> (Just (Right (VFieldAccessExpr (Just (Left Hole)) Nothing)), False)
        ConversionExpr -> (Just (Right (VConversionExpr (Just (Left Hole)) Nothing)), False)
    (Just (Right (VFieldAccessExpr vExpr vField)),Just (Right (VFieldAccessExpr vExprHole Nothing))) -> 
      let (vExprNew, shallCreateNewHole) = generateVExpr command vExpr vExprHole
      in if shallCreateNewHole
        then (Just (Right (VFieldAccessExpr vExprNew (Just (Left Hole)))),False)
        else (Just (Right (VFieldAccessExpr vExprNew vField)),False)
    (Just (Right (VFieldAccessExpr vExpr vField)),Just (Right (VFieldAccessExpr Nothing vFieldHole))) -> 
      case command of 
        (NameCommand name) ->(Just (Right (VFieldAccessExpr vExpr (Just (Right (VFieldName (VName name)))))), True)
    (Just (Right (VMethodCallExpr vExpr vMethodName vExprs)),Just (Right (VMethodCallExpr vExprHole Nothing [] ))) -> 
      let (vExprNew, shallCreateNewHole) = generateVExpr command vExpr vExprHole
      in if shallCreateNewHole
        then (Just (Right (VMethodCallExpr vExprNew (Just (Left Hole)) vExprs)), False)
        else (Just (Right (VMethodCallExpr vExprNew vMethodName vExprs)), False)
    (Just (Right (VMethodCallExpr vExpr vMethodName vExprs)),Just (Right (VMethodCallExpr Nothing vMethodNameHole [] ))) -> 
      case command of 
        CallMethod methodName ->  (Just (Right (VMethodCallExpr vExpr (Just (Right (VMethodName (VName methodName)))) [(Just (Left Hole))])), False)
    (Just (Right (VMethodCallExpr vExpr vMethodName vExprs)),Just (Right (VMethodCallExpr Nothing Nothing vExprsHole ))) -> 
      let (vExprsNew, shallCreateNewHole) = generateVExprs command vExprs vExprsHole
      in (Just (Right (VMethodCallExpr vExpr vMethodName vExprsNew)), shallCreateNewHole)
    (Just (Right (VInstanceExpr vTypeName vExprs)), Just (Right (VInstanceExpr Nothing vExprsHole))) ->
      let (vExprsNew, shallCreateNewHole) = generateVExprs command vExprs vExprsHole
      in (Just (Right (VInstanceExpr vTypeName vExprsNew)), shallCreateNewHole)
    (Just (Right (VConversionExpr vTypeName vExpr)),Just (Right (VConversionExpr (Just (Left Hole)) Nothing))) -> 
      case command of 
        (TypeDef name) -> (Just (Right (VConversionExpr (Just (Right (VTypeName (VName name)))) (Just (Left Hole)))), False)
    (Just (Right (VConversionExpr vTypeName vExpr)),Just (Right (VConversionExpr Nothing (Just (Left Hole))))) -> 
      let (vExprNew, shallCreateNewHole) = generateVExpr command vExpr vExprHole
      in (Just (Right (VConversionExpr vTypeName vExprNew)), shallCreateNewHole)

generateVExprs :: Command -> [VNode VExpr] -> [VNode VExpr] -> ([VNode VExpr], ShallCreateNewHole)
generateVExprs MoveNext vExprs vExprsHole = 
  case (vExprs, vExprsHole) of 
    (_, [(Just (Left Hole))]) -> ([], True)
    ([vExpr], [vExprHole@(Just (Right _))]) -> 
      let (vExprNew, shallCreateNewHole) = generateVExpr MoveNext vExpr vExprHole
      in if shallCreateNewHole
        then ([vExprNew, Just (Left Hole)], False)
        else ([vExprNew], False)
    ((v:vs), (Nothing:vsh)) -> 
      let (vsNew, shallCreateNewHole) = generateVExprs MoveNext vs vsh
      in ((v:vsNew), shallCreateNewHole)
generateVExprs command vExprs vExprsHole =
  case (vExprs, vExprsHole) of 
    ([vExpr], [vExprHole]) -> 
      let (vExprNew, shallCreateNewHole) = generateVExpr command vExpr vExprHole
      in if shallCreateNewHole
        then ([vExprNew, Just (Left Hole)], False)
        else ([vExprNew], False)
    ((vExpr:vExprRest), (Nothing:vExprHoleRest)) ->
      let (vExprRestNew, shallCreateNewHole) = generateVExprs command vExprRest vExprHoleRest
      in ((vExpr:vExprRestNew), shallCreateNewHole)

-- Compute an AST that indicate the path for hole node
findHole :: VProgram -> VProgram
findHole (VProgram vClassDecls vExpr) = 
  let vClassDeclsHole = findHoleInVClassDecls vClassDecls
      vExprHole = findHoleInVExpr vExpr
  in case vExprHole of
    Just _ -> VProgram [] vExprHole
    _ -> VProgram vClassDeclsHole Nothing

findHoleInVClassDecls :: [VNode VClassDeclaration] -> [VNode VClassDeclaration]
findHoleInVClassDecls [] = []
findHoleInVClassDecls (vc: vcs) = (findHoleInVClassDecl vc : findHoleInVClassDecls vcs)

findHoleInVClassDecl :: VNode VClassDeclaration -> VNode VClassDeclaration
findHoleInVClassDecl Nothing = Nothing
findHoleInVClassDecl (Just (Left Hole)) = Just (Left Hole)
findHoleInVClassDecl (Just (Right (VClassDeclaration vClassName vExtendName vClassBody))) = 
  let vClassNameHole = findHoleInVClassName vClassName
  in case vClassNameHole of
    Just _ -> (Just (Right (VClassDeclaration vClassNameHole Nothing Nothing)))
    Nothing -> 
      let vExtendNameHole = findHoleInVExtendName vExtendName
      in case vExtendNameHole of
        Just _ -> (Just (Right (VClassDeclaration Nothing vExtendNameHole Nothing)))
        Nothing -> 
          let vClassBodyHole = findHoleInVClassBody vClassBody
          in case vClassBodyHole of
            Just _ -> (Just (Right (VClassDeclaration Nothing Nothing vClassBodyHole)))
            Nothing -> Nothing

findHoleInVClassName :: VNode VClassName -> VNode VClassName
findHoleInVClassName (Just (Left Hole)) = Just (Left Hole)
findHoleInVClassName _ = Nothing

findHoleInVExtendName :: VNode VExtendName -> VNode VExtendName
findHoleInVExtendName (Just (Left Hole)) = Just (Left Hole)
findHoleInVExtendName _ = Nothing

findHoleInVClassBody :: VNode VClassBody -> VNode VClassBody
findHoleInVClassBody Nothing = Nothing
findHoleInVClassBody (Just (Left Hole)) = (Just (Left Hole))
findHoleInVClassBody (Just (Right (VClassBody vFieldDecls vConstructor vMethodDecls))) = 
  let vFieldDeclsHole = findHoleInVFieldDecls vFieldDecls
  in if isHoleInFieldDecls vFieldDeclsHole 
    then (Just (Right (VClassBody vFieldDeclsHole Nothing [])))
    else let vConstructorHole = findHoleInVConstructor vConstructor
      in case vConstructorHole of 
        Just _ -> (Just (Right (VClassBody [] vConstructorHole [])))
        _ -> let vMethodDeclsHole = findHoleInVMethodDecls vMethodDecls
             in if isHoleInMethodDecls vMethodDeclsHole
              then (Just (Right (VClassBody [] Nothing vMethodDeclsHole)))
              else Nothing

isHoleInFieldDecls :: [VNode VFieldDeclaration] -> Bool
isHoleInFieldDecls [] = False
isHoleInFieldDecls (v: vs) = 
  case v of 
    Nothing -> isHoleInFieldDecls vs
    Just _ -> True

isHoleInMethodDecls :: [VNode VMethodDeclaration] -> Bool
isHoleInMethodDecls [] = False
isHoleInMethodDecls (v: vs) = 
  case v of 
    Nothing -> isHoleInMethodDecls vs
    Just (Left Hole) -> True
    Just (Right (VMethodDeclaration _ _ _ _)) -> True

findHoleInVFieldDecls :: [VNode VFieldDeclaration] -> [VNode VFieldDeclaration] 
findHoleInVFieldDecls [] = []
findHoleInVFieldDecls (v:vs) = (findHoleInVFieldDecl v : findHoleInVFieldDecls vs)

findHoleInVFieldDecl:: VNode VFieldDeclaration -> VNode VFieldDeclaration
findHoleInVFieldDecl Nothing = Nothing
findHoleInVFieldDecl (Just (Left Hole)) = (Just (Left Hole))
findHoleInVFieldDecl (Just (Right (VFieldDeclaration vTypeName vVariableName))) =
  let vTypeNameHole = findHoleInVTypeName vTypeName
  in case vTypeNameHole of
    Just _ -> (Just (Right (VFieldDeclaration vTypeNameHole Nothing)))
    _ -> let vVariableNameHole = findHoleInVVariableName vVariableName
      in case vVariableNameHole of
        Just _ -> (Just (Right (VFieldDeclaration Nothing vVariableNameHole)))
        _ -> Nothing

findHoleInVTypeName :: VNode VTypeName -> VNode VTypeName
findHoleInVTypeName (Just (Left Hole)) = (Just (Left Hole))
findHoleInVTypeName _ = Nothing

findHoleInVVariableName :: VNode VVariableName -> VNode VVariableName
findHoleInVVariableName (Just (Left Hole)) = (Just (Left Hole))
findHoleInVVariableName _ = Nothing

findHoleInVConstructor :: VNode VConstructor ->  VNode VConstructor
findHoleInVConstructor Nothing = Nothing
findHoleInVConstructor (Just (Left Hole)) = (Just (Left Hole))
findHoleInVConstructor (Just (Right (VConstructor vTypeName vParameters vConstructorBody))) =
  let vTypeNameHole = findHoleInVTypeName vTypeName
  in case vTypeNameHole of
    Just _ -> (Just (Right (VConstructor vTypeNameHole [] Nothing)))
    _ -> 
      let vParametersHole = findHoleInVParameters vParameters
      in if isHoleInParameters vParametersHole
        then (Just (Right (VConstructor Nothing vParametersHole Nothing)))
        else 
          let vConstructorBodyHole = findHoleInVConstructorBody vConstructorBody
          in case vConstructorBodyHole of 
            Just _ -> (Just (Right (VConstructor Nothing [] vConstructorBodyHole)))
            _ -> Nothing

isHoleInParameters :: [VNode VParameter] -> Bool
isHoleInParameters [] = False
isHoleInParameters (v: vs) = 
  case v of
    Just _ -> True
    _ -> isHoleInParameters vs

findHoleInVParameters :: [VNode VParameter] -> [VNode VParameter]
findHoleInVParameters [] = []
findHoleInVParameters (v:vs) = (findHoleInVParameter v: findHoleInVParameters vs)

findHoleInVParameter :: VNode VParameter -> VNode VParameter
findHoleInVParameter Nothing = Nothing
findHoleInVParameter (Just (Left Hole)) = (Just (Left Hole))
findHoleInVParameter (Just (Right (VParameter vTypeName vVariableName))) = 
  let vTypeNameHole = findHoleInVTypeName vTypeName
  in case vTypeNameHole of
    Just _ -> (Just (Right (VParameter vTypeNameHole Nothing)))
    _ -> 
      let vVariableNameHole = findHoleInVVariableName vVariableName
      in case vVariableNameHole of
        Just _ -> (Just (Right (VParameter Nothing vVariableNameHole)))
        Nothing -> Nothing

findHoleInVConstructorBody :: VNode VConstructorBody -> VNode VConstructorBody
findHoleInVConstructorBody Nothing = Nothing
findHoleInVConstructorBody (Just (Left Hole)) = (Just (Left Hole))
findHoleInVConstructorBody (Just (Right (VConstructorBody vSuper vFieldAssignments))) = 
  let vSuperHole = findHoleInVSuper vSuper
  in case vSuperHole of
    Just _ -> (Just (Right (VConstructorBody vSuperHole [])))
    _ ->
      let vFieldAssignmentsHole = findHoleInVFieldAssignments vFieldAssignments
      in if isHoleInFieldAssignments vFieldAssignmentsHole
        then (Just (Right (VConstructorBody Nothing vFieldAssignmentsHole)))
        else Nothing

isHoleInFieldAssignments :: [VNode VFieldAssignment] -> Bool
isHoleInFieldAssignments [] = False
isHoleInFieldAssignments (v: vs) = 
  case v of 
    Just _ -> True
    _ -> isHoleInFieldAssignments vs

findHoleInVSuper :: VNode VSuper -> VNode VSuper
findHoleInVSuper Nothing = Nothing
findHoleInVSuper (Just (Left Hole)) = (Just (Left Hole))
findHoleInVSuper (Just (Right (VSuper vArguments))) = 
  let vArgumentsHole = findHoleInVArguments vArguments
  in if isHoleInArguments vArgumentsHole
    then (Just (Right (VSuper vArgumentsHole)))
    else Nothing

isHoleInArguments :: [VNode VArgument] -> Bool
isHoleInArguments [] = False
isHoleInArguments (v :vs) = 
  case v of 
    Just _ -> True
    _ -> isHoleInArguments vs

findHoleInVArguments :: [VNode VArgument] -> [VNode VArgument]
findHoleInVArguments [] = []
findHoleInVArguments (v:vs) = (findHoleInVArgument v: findHoleInVArguments vs)

findHoleInVArgument :: VNode VArgument -> VNode VArgument
findHoleInVArgument Nothing = Nothing
findHoleInVArgument (Just (Left Hole)) = (Just (Left Hole))
findHoleInVArgument (Just (Right (VArgument _))) = Nothing
-- findHoleInVArgument (Just (Right (VArgument vVariable))) = 
--   let vVariableHole = findHoleInVVariable vVariable
--   in case vVariableHole of 
--     Just _ -> (Just (Right (VArgument vVariableHole)))
--     Nothing -> Nothing

findHoleInVVariable :: VNode VVariable -> VNode VVariable
findHoleInVVariable Nothing = Nothing
findHoleInVVariable (Just (Left Hole)) = (Just (Left Hole))
findHoleInVVariable (Just (Right (VVariable vVariableName))) = 
  let vVariableNameHole = findHoleInVVariableName vVariableName
  in case vVariableNameHole of
    Just _ -> (Just (Right (VVariable vVariableNameHole)))
    Nothing -> Nothing

findHoleInVFieldAssignments :: [VNode VFieldAssignment] -> [VNode VFieldAssignment]
findHoleInVFieldAssignments [] = []
findHoleInVFieldAssignments (v:vs) = (findHoleInVFieldAssignment v: findHoleInVFieldAssignments vs)


findHoleInVFieldAssignment :: VNode VFieldAssignment -> VNode VFieldAssignment
findHoleInVFieldAssignment Nothing = Nothing
findHoleInVFieldAssignment (Just (Left Hole)) = (Just (Left Hole))
findHoleInVFieldAssignment (Just (Right (VFieldAssignment vVariableLeft vVariableRight))) = 
  let vVariableLeftHole = findHoleInVVariable vVariableLeft
  in case vVariableLeftHole of 
    Just _ -> (Just (Right (VFieldAssignment vVariableLeftHole Nothing)))
    _ -> 
      let vVariableRightHole = findHoleInVVariable vVariableRight
      in case vVariableRightHole of 
        Just _ -> (Just (Right (VFieldAssignment Nothing vVariableRightHole)))
        _ -> Nothing


findHoleInVMethodDecls :: [VNode VMethodDeclaration] -> [VNode VMethodDeclaration]
findHoleInVMethodDecls [] = []
findHoleInVMethodDecls (v: vs) = (findHoleInVMethodDecl v : findHoleInVMethodDecls vs)

findHoleInVMethodDecl :: VNode VMethodDeclaration -> VNode VMethodDeclaration
findHoleInVMethodDecl Nothing = Nothing
findHoleInVMethodDecl (Just (Left Hole)) = (Just (Left Hole))
findHoleInVMethodDecl (Just (Right (VMethodDeclaration vTypeName vMethodName vParameters vMethodBody))) = 
  let vMethodNameHole = findHoleInVMethodName vMethodName
  in case vMethodNameHole of
    Just _ -> (Just (Right (VMethodDeclaration Nothing vMethodNameHole [] Nothing)))
    _ -> 
      let vTypeNameHole = findHoleInVTypeName vTypeName
      in case vTypeNameHole of 
        Just _ -> (Just (Right (VMethodDeclaration vTypeNameHole Nothing [] Nothing)))
        _ -> 
          let vParametersHole = findHoleInVParameters vParameters
          in if isHoleInParameters vParametersHole
            then (Just (Right (VMethodDeclaration Nothing Nothing vParametersHole Nothing)))
            else 
              let vMethodBodyHole = findHoleInVMethodBody vMethodBody
              in case vMethodBodyHole of 
                Just _ -> (Just (Right (VMethodDeclaration Nothing Nothing [] vMethodBodyHole)))
                Nothing -> Nothing

findHoleInVMethodName :: VNode VMethodName -> VNode VMethodName
findHoleInVMethodName (Just (Left Hole)) = (Just (Left Hole))
findHoleInVMethodName _ = Nothing

findHoleInVMethodBody :: VNode VMethodBody -> VNode VMethodBody
findHoleInVMethodBody  Nothing = Nothing
findHoleInVMethodBody (Just (Left Hole)) = (Just (Left Hole))
findHoleInVMethodBody (Just (Right (VMethodBody vExpr))) = 
  let vExprHole = findHoleInVExpr vExpr
  in case vExprHole of 
    Nothing -> Nothing
    _ -> (Just (Right (VMethodBody vExprHole)))

findHoleInVExpr :: VNode VExpr -> VNode VExpr
findHoleInVExpr Nothing = Nothing
findHoleInVExpr (Just (Left Hole)) = (Just (Left Hole))
findHoleInVExpr (Just (Right (VVariableExpr vVariable))) = 
  let vVariableHole = findHoleInVVariable vVariable
  in case vVariableHole of 
    Just _ -> Just (Right (VVariableExpr vVariableHole))
    _ -> Nothing
findHoleInVExpr (Just (Right (VFieldAccessExpr vExpr vField))) = 
  let vExprHole = findHoleInVExpr vExpr
  in case vExprHole of 
    Just _ -> (Just (Right (VFieldAccessExpr vExprHole Nothing)))
    _ -> 
      let vFieldHole = findHoleInVField vField
      in case vFieldHole of
        Just _ -> (Just (Right (VFieldAccessExpr Nothing vFieldHole)))
        _ -> Nothing
findHoleInVExpr (Just (Right (VMethodCallExpr vExpr vMethodName vExprs))) = 
  let vExprHole = findHoleInVExpr vExpr
  in case vExprHole of 
    Just _ -> (Just (Right (VMethodCallExpr vExprHole Nothing [])))
    _ -> 
      let vMethodNameHole = findHoleInVMethodName vMethodName
      in case vMethodNameHole of 
        Just _ -> (Just (Right (VMethodCallExpr Nothing vMethodNameHole [])))
        _ -> 
          let vExprsHole = findHoleInVExprs vExprs
          in if isHoleInExprs vExprsHole 
            then (Just (Right (VMethodCallExpr Nothing Nothing vExprsHole)))
            else Nothing

findHoleInVExpr (Just (Right (VInstanceExpr vTypeName vExprs))) = 
  let vTypeNameHole = findHoleInVTypeName vTypeName
  in case vTypeNameHole of 
    Just _ -> (Just (Right (VInstanceExpr vTypeNameHole [])))
    _ -> 
      let vExprsHole = findHoleInVExprs vExprs
      in if isHoleInExprs vExprsHole
        then (Just (Right (VInstanceExpr Nothing vExprsHole)))
        else Nothing
findHoleInVExpr (Just (Right (VConversionExpr vTypeName vExpr))) = 
  let vTypeNameHole = findHoleInVTypeName vTypeName
  in case vTypeNameHole of 
    Just _ -> (Just (Right (VConversionExpr vTypeName Nothing)))
    _ -> 
      let vExprHole = findHoleInVExpr vExpr
      in case vExprHole of 
        Just _ -> (Just (Right (VConversionExpr Nothing vExprHole)))
        _ -> Nothing

isHoleInExprs :: [VNode VExpr] -> Bool
isHoleInExprs [] = False
isHoleInExprs (v: vs) = 
  case v of 
    Just _ -> True
    _ -> isHoleInExprs vs

findHoleInVField :: VNode VFieldName -> VNode VFieldName
findHoleInVField (Just (Left Hole)) = (Just (Left Hole))
findHoleInVField _ = Nothing

findHoleInVExprs :: [VNode VExpr] -> [VNode VExpr]
findHoleInVExprs [] = []
findHoleInVExprs (v:vs) = (findHoleInVExpr v: findHoleInVExprs vs)