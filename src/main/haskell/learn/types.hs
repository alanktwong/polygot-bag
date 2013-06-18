-- From "Types and Typeclasses" chapter 
-- @author awong
-- @see http://learnyouahaskell.com/types-and-typeclasses

-- common Haskell types: Int, Integer, Float, Double, Bool, Char, String, [], ()
-- common typeclasses: Eq, Ord, Show, Read, Enum, Bounded, Num, Integral, Floating

boomBangs :: [Int] -> [String]
boomBangs xs = [ if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]

removeNonUppercase :: [Char] -> [Char]
removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]

addThree :: Int -> Int -> Int -> Int
addThree x y z = x + y + z