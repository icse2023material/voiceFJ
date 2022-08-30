module PairOfVFJ where

import VoiceFJ 
-- Initially: 
vprogram = VProgram ([Just(Left Hole)]) Nothing
-- 1. define class a 
--  => VClassDeclaration (Just (Right (VClassName (VName "A")))) (Just (Left Hole)) Nothing
vprogram1 = VProgram ([Just(Right (VClassDeclaration (Just (Right (VClassName (VName "A")))) (Just (Left Hole)) Nothing))]) Nothing

-- 2. extends object 
vprogram2 = VProgram ([Just(Right (VClassDeclaration (Just (Right (VClassName (VName "A")))) (Just (Right (VExtendName (VName "Object")))) (Just (Left Hole))))]) Nothing

-- 3. define constructor => VConstructor (Just (Right (VTypeName (VName "B")))) (Just (Left Hole)) Nothing
vprogram3 = VProgram ([Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [Just (Left Hole)] Nothing))) 
         [Nothing])
      ))))]) 
    Nothing

-- 4. move next        
vprogram4 = VProgram ([Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Left Hole))))) 
         [Nothing])
      ))))]) 
    Nothing

-- 5. define super   => VSuper (Just (Left Hole))
vprogram5 = VProgram ([Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper [Just (Left Hole)]))) [Nothing])))))) 
         [Nothing])
      ))))]) 
    Nothing

-- 6. move next => 
vprogram6 = VProgram ([Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [Just (Left Hole)])))))) 
         [Nothing])
      ))))]) 
    Nothing

-- 7. move next
vprogram7 = VProgram ([Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [Just (Left Hole)])
      ))))]) 
    Nothing

-- 8. move next
vprogram8 = VProgram ([Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), Just (Left Hole)]) 
    Nothing

-- 9. define class b
--  => VClassDeclaration (Just (Right (VClassName (VName "B")))) (Just (Left Hole)) Nothing
vprogram9 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration (Just (Right (VClassName (VName "B")))) (Just (Left Hole)) Nothing))
 ]) 
  Nothing

-- 10. extend object
vprogram10 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration (Just (Right (VClassName (VName "B")))) (Just (Right (VExtendName (VName "Object")))) (Just (Left Hole))))
 ]) 
  Nothing

-- 11. define constructor
-- VConstructor (Just (Right (VTypeName (VName "B")))) [Just (Left Hole)] Nothing
vprogram11 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [Just (Left Hole)] Nothing))) 
        [])))))
 ]) 
  Nothing
-- 12. move next
vprogram12 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Left Hole))))) 
        [])))))
 ]) 
  Nothing
-- 13. define super
-- VSuper [Just (Left Hole)]
vprogram13 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper [Just (Left Hole)]))) [])))))) 
        [])))))
 ]) 
  Nothing

-- 14. move next
vprogram14 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [Just (Left Hole)])))))) 
        [])))))
 ]) 
  Nothing


-- 15. move next
vprogram15 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        [Just (Left Hole)])))))
 ]) 
  Nothing


-- 16. move next
vprogram16 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Left Hole)
 ]) 
 Nothing

-- 17. define class pair
--  => VClassDeclaration (Just (Right (VClassName (VName "Pair")))) (Just (Left Hole)) Nothing
vprogram17 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (VClassDeclaration (Just (Right (VClassName (VName "Pair")))) (Just (Left Hole)) Nothing))
 ]) 
 Nothing

-- 18. extends object
vprogram18 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Left Hole))
  ))
 ]) 
 Nothing

-- 19. define field first
-- VFieldDeclaration (Just (Left Hole)) (Just (Right (VVariableName (VName "first"))))
vprogram19 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody [Just (Right (VFieldDeclaration (Just (Left Hole)) (Just (Right (VVariableName (VName "first"))))))] Nothing [])))
  ))
 ]) 
 Nothing
-- 20. type object
vprogram20 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), Just (Left Hole)] Nothing [])))
  ))
 ]) 
 Nothing
-- 21 define field second
vprogram21 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Left Hole)) (Just (Right (VVariableName (VName "first"))))))] 
      Nothing 
      []
    )))
  ))
 ]) 
 Nothing

 -- 22 type object
vprogram22 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))),
       Just (Left Hole)
       ] 
      Nothing 
      []
    )))
  ))
 ]) 
 Nothing

 -- 23. move next ?
 -- 23. define constructor
vprogram23 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first"))))))
       ] 
      (Just (Right (VConstructor (Just (Right (VTypeName (VName "Pair")))) [Just (Left Hole)] Nothing)))
      []
    )))
  ))
 ]) 
 Nothing

 -- 24. define parameter first
vprogram24 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first"))))))
       ] 
      (Just (Right (VConstructor (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VParameter (Just (Left Hole)) (Just (Right (VVariableName (VName "first"))))))] Nothing)))
      []
    )))
  ))
 ]) 
 Nothing

-- 25. type object
vprogram25 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first"))))))
       ] 
      (Just (Right (VConstructor (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), Just (Left Hole)] Nothing)))
      []
    )))
  ))
 ]) 
 Nothing

 -- 26. define parameter second 
vprogram26 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first"))))))
       ] 
      (Just (Right (VConstructor (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), Just (Right (VParameter (Just (Left Hole)) (Just (Right (VVariableName (VName "second"))))))] Nothing)))
      []
    )))
  ))
 ]) 
 Nothing
 -- 27. type object
vprogram27 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first"))))))
       ] 
      (Just (Right (VConstructor (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "second")))))), Just (Left Hole)] Nothing)))
      []
    )))
  ))
 ]) 
 Nothing
 -- 28. move next
vprogram28 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first"))))))
       ] 
      (Just (Right (VConstructor (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "second"))))))] (Just (Left Hole)))))
      []
    )))
  ))
 ]) 
 Nothing

-- 29. define super
-- VSuper [Just (Left Hole)]
vprogram29 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first"))))))
       ] 
      (Just (Right (VConstructor (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "second"))))))] (Just (Right (VConstructorBody (Just (Right (VSuper [Just (Left Hole)]))) []))))))
      []
    )))
  ))
 ]) 
 Nothing

-- 30. move next
vprogram30 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first"))))))
       ] 
      (Just (Right (VConstructor (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "second"))))))] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [Just (Left Hole)]))))))
      []
    )))
  ))
 ]) 
 Nothing

-- 31. assignment statement
vprogram31 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first"))))))
       ] 
      (Just (Right (VConstructor (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "second"))))))] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [Just (Right (VFieldAssignment (Just (Left Hole)) Nothing))]))))))
      []
    )))
  ))
 ]) 
 Nothing

-- 32. variable first
-- VVariable (Just (Right (VVariableName (VName "first"))))
vprogram32 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first"))))))
       ] 
      (Just (Right (VConstructor (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "second"))))))] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))) (Just (Left Hole))))]))))))
      []
    )))
  ))
 ]) 
 Nothing
-- 33. variable first
vprogram33 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first"))))))
       ] 
      (Just (Right (VConstructor (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "second"))))))] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))))), Just (Left Hole)]))))))
      []
    )))
  ))
 ]) 
 Nothing
-- 34. field assignment
vprogram34 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first"))))))
       ] 
      (Just (Right (VConstructor (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "second"))))))] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))))), 
      Just (Right (VFieldAssignment (Just (Left Hole)) Nothing))]))))))
      []
    )))
  ))
 ]) 
 Nothing
 -- 35. variable second
vprogram35 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first"))))))
       ] 
      (Just (Right (VConstructor (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "second"))))))] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))))), 
      Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "second"))))))) (Just (Left Hole))))]))))))
      []
    )))
  ))
 ]) 
 Nothing
-- 36. variable second
vprogram36 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first"))))))
       ] 
      (Just (Right (VConstructor (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "second"))))))] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))))), 
      Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "second"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "second"))))))))), Just (Left Hole)]))))))
      []
    )))
  ))
 ]) 
 Nothing

 -- 37. move next
vprogram37 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first"))))))
       ] 
      (Just (Right (VConstructor (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "second"))))))] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))))), 
      Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "second"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "second")))))))))]))))))
      [Just (Left Hole)]
    )))
  ))
 ]) 
 Nothing

-- 38. define method swap object
-- VMethodDeclaration (Just (Left Hole)) (Just (Right (VMethodName (VName "swapObject")))) Nothing Nothing
vprogram38 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first"))))))
       ] 
      (Just (Right (VConstructor (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "second"))))))] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))))), 
      Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "second"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "second")))))))))]))))))
      [Just (Right (VMethodDeclaration (Just (Left Hole)) (Just (Right (VMethodName (VName "swapObject")))) [] Nothing))]
    )))
  ))
 ]) 
 Nothing

-- 39. type pair
vprogram39 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first"))))))
       ] 
      (Just (Right (VConstructor (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "second"))))))] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))))), 
      Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "second"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "second")))))))))]))))))
      [Just (Right (VMethodDeclaration (Just (Right (VTypeName (VName "Pair")))) (Just (Right (VMethodName (VName "swapObject")))) [Just (Left Hole)] Nothing))]
    )))
  ))
 ]) 
 Nothing
-- 40. move next
vprogram40 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first"))))))
       ] 
      (Just (Right (VConstructor (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "second"))))))] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))))), 
      Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "second"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "second")))))))))]))))))
      [Just (Right (VMethodDeclaration (Just (Right (VTypeName (VName "Pair")))) (Just (Right (VMethodName (VName "swapObject")))) [] (Just (Left Hole))))]
    )))
  ))
 ]) 
 Nothing

-- 41. new instance pair
vprogram41 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first"))))))
       ] 
      (Just (Right (VConstructor (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "second"))))))] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))))), 
      Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "second"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "second")))))))))]))))))
      [Just (Right (VMethodDeclaration (Just (Right (VTypeName (VName "Pair")))) (Just (Right (VMethodName (VName "swapObject")))) [] (Just (Right (VMethodBody (Just (Right (VInstanceExpr (Just (Right (VTypeName (VName "Pair")))) [Just (Left Hole)]))))))))]
    )))
  ))
 ]) 
 Nothing

-- 42. field access expression
vprogram42 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first"))))))
       ] 
      (Just (Right (VConstructor (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "second"))))))] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))))), 
      Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "second"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "second")))))))))]))))))
      [Just (Right (VMethodDeclaration (Just (Right (VTypeName (VName "Pair")))) (Just (Right (VMethodName (VName "swapObject")))) [] (Just (Right (VMethodBody (Just (Right (VInstanceExpr (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VFieldAccessExpr (Just (Left Hole)) Nothing))]))))))))]
    )))
  ))
 ]) 
 Nothing

-- 43. variable this
vprogram43 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first"))))))
       ] 
      (Just (Right (VConstructor (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "second"))))))] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))))), 
      Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "second"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "second")))))))))]))))))
      [Just (Right (VMethodDeclaration (Just (Right (VTypeName (VName "Pair")))) (Just (Right (VMethodName (VName "swapObject")))) [] (Just (Right (VMethodBody (Just (Right (VInstanceExpr (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VFieldAccessExpr (Just (Right (VVariableExpr (Just (Right (VVariable (Just (Right (VVariableName (VName "this")))))))))) (Just (Left Hole))))]))))))))]
    )))
  ))
 ]) 
 Nothing

-- 44. variable second
vprogram44 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first"))))))
       ] 
      (Just (Right (VConstructor (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "second"))))))] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))))), 
      Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "second"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "second")))))))))]))))))
      [Just (Right (VMethodDeclaration (Just (Right (VTypeName (VName "Pair")))) (Just (Right (VMethodName (VName "swapObject")))) [] (Just (Right (VMethodBody (Just (Right (VInstanceExpr (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VFieldAccessExpr (Just (Right (VVariableExpr (Just (Right (VVariable (Just (Right (VVariableName (VName "this")))))))))) (Just (Right (VFieldName (VName "second")))))), (Just (Left Hole))]))))))))]
    )))
  ))
 ]) 
 Nothing
-- 45. field access expression
vprogram45 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first"))))))
       ] 
      (Just (Right (VConstructor (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "second"))))))] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))))), 
      Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "second"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "second")))))))))]))))))
      [Just (Right (VMethodDeclaration (Just (Right (VTypeName (VName "Pair")))) (Just (Right (VMethodName (VName "swapObject")))) [] (Just (Right (VMethodBody (Just (Right (VInstanceExpr (Just (Right (VTypeName (VName "Pair")))) 
        [Just (Right (VFieldAccessExpr (Just (Right (VVariableExpr (Just (Right (VVariable (Just (Right (VVariableName (VName "this")))))))))) (Just (Right (VFieldName (VName "second")))))), 
        (Just (Right (VFieldAccessExpr (Just (Left Hole)) Nothing)))]))))))))]
    )))
  ))
 ]) 
 Nothing
-- 46. variable this
vprogram46 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first"))))))
       ] 
      (Just (Right (VConstructor (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "second"))))))] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))))), 
      Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "second"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "second")))))))))]))))))
      [Just (Right (VMethodDeclaration (Just (Right (VTypeName (VName "Pair")))) (Just (Right (VMethodName (VName "swapObject")))) [] (Just (Right (VMethodBody (Just (Right (VInstanceExpr (Just (Right (VTypeName (VName "Pair")))) 
        [Just (Right (VFieldAccessExpr (Just (Right (VVariableExpr (Just (Right (VVariable (Just (Right (VVariableName (VName "this")))))))))) (Just (Right (VFieldName (VName "second")))))), 
        (Just (Right (VFieldAccessExpr (Just (Right (VVariableExpr (Just (Right (VVariable (Just (Right (VVariableName (VName "this")))))))))) (Just (Left Hole)))))]))))))))]
    )))
  ))
 ]) 
 Nothing
-- 47. variable first
vprogram47 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first"))))))
       ] 
      (Just (Right (VConstructor (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "second"))))))] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))))), 
      Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "second"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "second")))))))))]))))))
      [Just (Right (VMethodDeclaration (Just (Right (VTypeName (VName "Pair")))) (Just (Right (VMethodName (VName "swapObject")))) [] (Just (Right (VMethodBody (Just (Right (VInstanceExpr (Just (Right (VTypeName (VName "Pair")))) 
        [Just (Right (VFieldAccessExpr (Just (Right (VVariableExpr (Just (Right (VVariable (Just (Right (VVariableName (VName "this")))))))))) (Just (Right (VFieldName (VName "second")))))), 
        (Just (Right (VFieldAccessExpr (Just (Right (VVariableExpr (Just (Right (VVariable (Just (Right (VVariableName (VName "this")))))))))) (Just (Right (VFieldName (VName ("first"))))))))])))))))),
       Just (Left Hole)
      ]
    )))
  ))
 ]) 
 Nothing
-- 48. move next
vprogram48 = VProgram ([
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first"))))))
       ] 
      (Just (Right (VConstructor (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "second"))))))] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))))), 
      Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "second"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "second")))))))))]))))))
      [Just (Right (VMethodDeclaration (Just (Right (VTypeName (VName "Pair")))) (Just (Right (VMethodName (VName "swapObject")))) [] (Just (Right (VMethodBody (Just (Right (VInstanceExpr (Just (Right (VTypeName (VName "Pair")))) 
        [Just (Right (VFieldAccessExpr (Just (Right (VVariableExpr (Just (Right (VVariable (Just (Right (VVariableName (VName "this")))))))))) (Just (Right (VFieldName (VName "second")))))), 
        (Just (Right (VFieldAccessExpr (Just (Right (VVariableExpr (Just (Right (VVariable (Just (Right (VVariableName (VName "this")))))))))) (Just (Right (VFieldName (VName ("first"))))))))]))))))))
      ]
    )))
  )),
  Just (Left Hole)
 ]) 
 Nothing
-- 49. move next
vprogram49 = VProgram [
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first"))))))
       ] 
      (Just (Right (VConstructor (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "second"))))))] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))))), 
      Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "second"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "second")))))))))]))))))
      [Just (Right (VMethodDeclaration (Just (Right (VTypeName (VName "Pair")))) (Just (Right (VMethodName (VName "swapObject")))) [] (Just (Right (VMethodBody (Just (Right (VInstanceExpr (Just (Right (VTypeName (VName "Pair")))) 
        [Just (Right (VFieldAccessExpr (Just (Right (VVariableExpr (Just (Right (VVariable (Just (Right (VVariableName (VName "this")))))))))) (Just (Right (VFieldName (VName "second")))))), 
        (Just (Right (VFieldAccessExpr (Just (Right (VVariableExpr (Just (Right (VVariable (Just (Right (VVariableName (VName "this")))))))))) (Just (Right (VFieldName (VName ("first"))))))))]))))))))
      ]
    )))
  ))
 ] 
 (Just (Left Hole))

-- 50. method call expression
vprogram50 = VProgram [
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first"))))))
       ] 
      (Just (Right (VConstructor (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "second"))))))] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))))), 
      Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "second"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "second")))))))))]))))))
      [Just (Right (VMethodDeclaration (Just (Right (VTypeName (VName "Pair")))) (Just (Right (VMethodName (VName "swapObject")))) [] (Just (Right (VMethodBody (Just (Right (VInstanceExpr (Just (Right (VTypeName (VName "Pair")))) 
        [Just (Right (VFieldAccessExpr (Just (Right (VVariableExpr (Just (Right (VVariable (Just (Right (VVariableName (VName "this")))))))))) (Just (Right (VFieldName (VName "second")))))), 
        (Just (Right (VFieldAccessExpr (Just (Right (VVariableExpr (Just (Right (VVariable (Just (Right (VVariableName (VName "this")))))))))) (Just (Right (VFieldName (VName ("first"))))))))]))))))))
      ]
    )))
  ))
 ] 
 (Just (Right (VMethodCallExpr (Just (Left Hole)) Nothing [])))
-- 51. new instance pair
vprogram51 = VProgram [
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first"))))))
       ] 
      (Just (Right (VConstructor (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "second"))))))] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))))), 
      Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "second"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "second")))))))))]))))))
      [Just (Right (VMethodDeclaration (Just (Right (VTypeName (VName "Pair")))) (Just (Right (VMethodName (VName "swapObject")))) [] (Just (Right (VMethodBody (Just (Right (VInstanceExpr (Just (Right (VTypeName (VName "Pair")))) 
        [Just (Right (VFieldAccessExpr (Just (Right (VVariableExpr (Just (Right (VVariable (Just (Right (VVariableName (VName "this")))))))))) (Just (Right (VFieldName (VName "second")))))), 
        (Just (Right (VFieldAccessExpr (Just (Right (VVariableExpr (Just (Right (VVariable (Just (Right (VVariableName (VName "this")))))))))) (Just (Right (VFieldName (VName ("first"))))))))]))))))))
      ]
    )))
  ))
 ] 
 (Just (Right (VMethodCallExpr (Just (Right (VInstanceExpr (Just (Right (VTypeName (VName "Pair")))) [Just (Left Hole)]))) Nothing [])))
-- 52. new instance a
vprogram52 = VProgram [
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first"))))))
       ] 
      (Just (Right (VConstructor (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "second"))))))] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))))), 
      Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "second"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "second")))))))))]))))))
      [Just (Right (VMethodDeclaration (Just (Right (VTypeName (VName "Pair")))) (Just (Right (VMethodName (VName "swapObject")))) [] (Just (Right (VMethodBody (Just (Right (VInstanceExpr (Just (Right (VTypeName (VName "Pair")))) 
        [Just (Right (VFieldAccessExpr (Just (Right (VVariableExpr (Just (Right (VVariable (Just (Right (VVariableName (VName "this")))))))))) (Just (Right (VFieldName (VName "second")))))), 
        (Just (Right (VFieldAccessExpr (Just (Right (VVariableExpr (Just (Right (VVariable (Just (Right (VVariableName (VName "this")))))))))) (Just (Right (VFieldName (VName ("first"))))))))]))))))))
      ]
    )))
  ))
 ] 
 (Just (Right (VMethodCallExpr 
   (Just (Right (VInstanceExpr 
      (Just (Right (VTypeName (VName "Pair")))) 
      [Just (Right (VInstanceExpr (Just (Right (VTypeName (VName "A")))) [Just (Left Hole)]))]))) 
   Nothing 
   []
 )))
-- 53. move next
vprogram53 = VProgram [
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first"))))))
       ] 
      (Just (Right (VConstructor (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "second"))))))] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))))), 
      Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "second"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "second")))))))))]))))))
      [Just (Right (VMethodDeclaration (Just (Right (VTypeName (VName "Pair")))) (Just (Right (VMethodName (VName "swapObject")))) [] (Just (Right (VMethodBody (Just (Right (VInstanceExpr (Just (Right (VTypeName (VName "Pair")))) 
        [Just (Right (VFieldAccessExpr (Just (Right (VVariableExpr (Just (Right (VVariable (Just (Right (VVariableName (VName "this")))))))))) (Just (Right (VFieldName (VName "second")))))), 
        (Just (Right (VFieldAccessExpr (Just (Right (VVariableExpr (Just (Right (VVariable (Just (Right (VVariableName (VName "this")))))))))) (Just (Right (VFieldName (VName ("first"))))))))]))))))))
      ]
    )))
  ))
 ] 
 (Just (Right (VMethodCallExpr 
   (Just (Right (VInstanceExpr 
      (Just (Right (VTypeName (VName "Pair")))) 
      [Just (Right (VInstanceExpr (Just (Right (VTypeName (VName "A")))) [])), Just (Left Hole)]))) 
   Nothing 
   []
 )))
-- 54. new instance b
vprogram54 = VProgram [
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first"))))))
       ] 
      (Just (Right (VConstructor (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "second"))))))] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))))), 
      Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "second"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "second")))))))))]))))))
      [Just (Right (VMethodDeclaration (Just (Right (VTypeName (VName "Pair")))) (Just (Right (VMethodName (VName "swapObject")))) [] (Just (Right (VMethodBody (Just (Right (VInstanceExpr (Just (Right (VTypeName (VName "Pair")))) 
        [Just (Right (VFieldAccessExpr (Just (Right (VVariableExpr (Just (Right (VVariable (Just (Right (VVariableName (VName "this")))))))))) (Just (Right (VFieldName (VName "second")))))), 
        (Just (Right (VFieldAccessExpr (Just (Right (VVariableExpr (Just (Right (VVariable (Just (Right (VVariableName (VName "this")))))))))) (Just (Right (VFieldName (VName ("first"))))))))]))))))))
      ]
    )))
  ))
 ] 
 (Just (Right (VMethodCallExpr 
   (Just (Right (VInstanceExpr 
      (Just (Right (VTypeName (VName "Pair")))) 
      [Just (Right (VInstanceExpr (Just (Right (VTypeName (VName "A")))) [])), 
       Just (Right (VInstanceExpr (Just (Right (VTypeName (VName "B")))) [Just (Left Hole)]))]))) 
   Nothing 
   []
 )))
-- 55. move next
vprogram55 = VProgram [
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first"))))))
       ] 
      (Just (Right (VConstructor (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "second"))))))] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))))), 
      Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "second"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "second")))))))))]))))))
      [Just (Right (VMethodDeclaration (Just (Right (VTypeName (VName "Pair")))) (Just (Right (VMethodName (VName "swapObject")))) [] (Just (Right (VMethodBody (Just (Right (VInstanceExpr (Just (Right (VTypeName (VName "Pair")))) 
        [Just (Right (VFieldAccessExpr (Just (Right (VVariableExpr (Just (Right (VVariable (Just (Right (VVariableName (VName "this")))))))))) (Just (Right (VFieldName (VName "second")))))), 
        (Just (Right (VFieldAccessExpr (Just (Right (VVariableExpr (Just (Right (VVariable (Just (Right (VVariableName (VName "this")))))))))) (Just (Right (VFieldName (VName ("first"))))))))]))))))))
      ]
    )))
  ))
 ] 
 (Just (Right (VMethodCallExpr 
   (Just (Right (VInstanceExpr 
      (Just (Right (VTypeName (VName "Pair")))) 
      [Just (Right (VInstanceExpr (Just (Right (VTypeName (VName "A")))) [])), 
       Just (Right (VInstanceExpr (Just (Right (VTypeName (VName "B")))) [])), Just (Left Hole)]))) 
   Nothing 
   []
 )))
-- 56. move next
vprogram56 = VProgram [
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first"))))))
       ] 
      (Just (Right (VConstructor (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "second"))))))] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))))), 
      Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "second"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "second")))))))))]))))))
      [Just (Right (VMethodDeclaration (Just (Right (VTypeName (VName "Pair")))) (Just (Right (VMethodName (VName "swapObject")))) [] (Just (Right (VMethodBody (Just (Right (VInstanceExpr (Just (Right (VTypeName (VName "Pair")))) 
        [Just (Right (VFieldAccessExpr (Just (Right (VVariableExpr (Just (Right (VVariable (Just (Right (VVariableName (VName "this")))))))))) (Just (Right (VFieldName (VName "second")))))), 
        (Just (Right (VFieldAccessExpr (Just (Right (VVariableExpr (Just (Right (VVariable (Just (Right (VVariableName (VName "this")))))))))) (Just (Right (VFieldName (VName ("first"))))))))]))))))))
      ]
    )))
  ))
 ] 
 (Just (Right (VMethodCallExpr 
   (Just (Right (VInstanceExpr 
      (Just (Right (VTypeName (VName "Pair")))) 
      [Just (Right (VInstanceExpr (Just (Right (VTypeName (VName "A")))) [])), 
       Just (Right (VInstanceExpr (Just (Right (VTypeName (VName "B")))) []))]))) 
   (Just (Left Hole)) 
   []
 )))
-- 57. call swap object
vprogram57 = VProgram [
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first"))))))
       ] 
      (Just (Right (VConstructor (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "second"))))))] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))))), 
      Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "second"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "second")))))))))]))))))
      [Just (Right (VMethodDeclaration (Just (Right (VTypeName (VName "Pair")))) (Just (Right (VMethodName (VName "swapObject")))) [] (Just (Right (VMethodBody (Just (Right (VInstanceExpr (Just (Right (VTypeName (VName "Pair")))) 
        [Just (Right (VFieldAccessExpr (Just (Right (VVariableExpr (Just (Right (VVariable (Just (Right (VVariableName (VName "this")))))))))) (Just (Right (VFieldName (VName "second")))))), 
        (Just (Right (VFieldAccessExpr (Just (Right (VVariableExpr (Just (Right (VVariable (Just (Right (VVariableName (VName "this")))))))))) (Just (Right (VFieldName (VName ("first"))))))))]))))))))
      ]
    )))
  ))
 ] 
 (Just (Right (VMethodCallExpr 
   (Just (Right (VInstanceExpr 
      (Just (Right (VTypeName (VName "Pair")))) 
      [Just (Right (VInstanceExpr (Just (Right (VTypeName (VName "A")))) [])), 
       Just (Right (VInstanceExpr (Just (Right (VTypeName (VName "B")))) []))]))) 
   (Just (Right (VMethodName (VName "swapObject")))) 
   [Just (Left Hole)]
 )))
-- 58. move next
vprogram58 = VProgram [
 Just(Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "A")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
         [] 
         (Just (Right (VConstructor (Just (Right (VTypeName (VName "A")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
         [])
      )))), 
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "B")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (
      VClassBody 
        [] 
        (Just (Right (VConstructor (Just (Right (VTypeName (VName "B")))) [] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [])))))) 
        []))))),
 Just (Right (
  VClassDeclaration 
    (Just (Right (VClassName (VName "Pair")))) 
    (Just (Right (VExtendName (VName "Object")))) 
    (Just (Right (VClassBody 
      [Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), 
       Just (Right (VFieldDeclaration (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first"))))))
       ] 
      (Just (Right (VConstructor (Just (Right (VTypeName (VName "Pair")))) [Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "first")))))), Just (Right (VParameter (Just (Right (VTypeName (VName "Object")))) (Just (Right (VVariableName (VName "second"))))))] (Just (Right (VConstructorBody (Just (Right (VSuper []))) [Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "first"))))))))), 
      Just (Right (VFieldAssignment (Just (Right (VVariable (Just (Right (VVariableName (VName "second"))))))) (Just (Right (VVariable (Just (Right (VVariableName (VName "second")))))))))]))))))
      [Just (Right (VMethodDeclaration (Just (Right (VTypeName (VName "Pair")))) (Just (Right (VMethodName (VName "swapObject")))) [] (Just (Right (VMethodBody (Just (Right (VInstanceExpr (Just (Right (VTypeName (VName "Pair")))) 
        [Just (Right (VFieldAccessExpr (Just (Right (VVariableExpr (Just (Right (VVariable (Just (Right (VVariableName (VName "this")))))))))) (Just (Right (VFieldName (VName "second")))))), 
        (Just (Right (VFieldAccessExpr (Just (Right (VVariableExpr (Just (Right (VVariable (Just (Right (VVariableName (VName "this")))))))))) (Just (Right (VFieldName (VName ("first"))))))))]))))))))
      ]
    )))
  ))
 ] 
  (Just (Right (VMethodCallExpr 
   (Just (Right (VInstanceExpr 
      (Just (Right (VTypeName (VName "Pair")))) 
      [Just (Right (VInstanceExpr (Just (Right (VTypeName (VName "A")))) [])), 
       Just (Right (VInstanceExpr (Just (Right (VTypeName (VName "B")))) []))]))) 
   (Just (Right (VMethodName (VName "swapObject")))) 
   []
 )))
