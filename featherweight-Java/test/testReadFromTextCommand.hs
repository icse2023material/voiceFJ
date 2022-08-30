import System.IO
import Text2Command 
import Generation
import VoiceFJPretty

readDataFrom fileHandle vprogram = 
  do 
    isFileEnd <- hIsEOF fileHandle
    if isFileEnd 
      then return ()
      else do
        line <- hGetLine fileHandle
        putStrLn $ "command: " ++ line
        let vprogam1 = runSingle (translate line) vprogram
        putStrLn $ show vprogam1
        putStrLn $ show $ prettyProgram vprogam1
        getLine -- put Enter to continue
        readDataFrom fileHandle vprogam1

fileName = "test/pair/Pair.voiceFJ"

main = 
  do
    fileHandle <- openFile fileName ReadMode
    readDataFrom fileHandle initial