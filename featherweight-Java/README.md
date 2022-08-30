## Syntax-directed Voice Programming for Featherweight Java
- `FJ.hs`: AST of Featherweight Java.
- `VoiceFJ.hs`: AST of Voice Featherweight Java.
- `VoiceFJ.voice`: generated Voice Featherweight Java language, command set.
- `VoiceFJPretty.hs`: pretty printer for Voice Featherweight Java AST.
- `testVFJPretty.hs`: load file in ghci, use `prettyProgram vprogram1` to `prettyProgram vprogram58` shows generation of `Pair.java` step by step.


## Test command
- `ghci -itest/pair test/testVFJPretty.hs`
- `ghci test/testGeneration.hs`
- `ghci test/testReadFromTextCommand.hs `: A step-by-step exmaple to construct `Pair.java` from a sequence of commands.