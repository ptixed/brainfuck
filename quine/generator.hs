import Data.Char

main = generate >>= putStrLn

generate = readFile "quine.bf" >>= return . concat . map convert . reverse . filter (`elem` "[]<>+-.,")

convert x = let v = (ord x) - 26 in 
  ">" 
  ++ replicate (rem v 16) '+' 
  ++ ">" 
  ++ replicate (div v 16 )'+'
  