import Data.Char
import Control.Arrow

main = readFile "quine.bf" >>= return . generate >>= putStrLn

generate = filter (`elem` "[]<>+-.,") >>> reverse >>> concatMap convert

convert x = let v = (ord x) - 26 in 
  ">" 
  ++ replicate (rem v 16) '+' 
  ++ ">" 
  ++ replicate (div v 16 )'+'
  