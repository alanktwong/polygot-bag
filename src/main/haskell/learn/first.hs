-- my first snippet of haskell code
-- @author awong
-- @see http://learnyouahaskell.com/
-- 

add a b = a + b

doubleMe x = x + x

doubleUs x y = doubleMe x + doubleMe y

doubleSmallNumber x = if x > 100
                      then x
                      else doubleMe x

doubleSmallNumber' x = (doubleSmallNumber x) + 1

conanO'Brien = "It's a me, Conan O'Brien"

-- From "Types and Typeclasses" chapter 
-- common Haskell types: Int, Integer, Float, Double, Bool, Char, String, [], ()
-- common typeclasses: Eq, Ord, Show, Read, Enum, Bounded, Num, Integral, Floating

boomBangs :: [Int] -> [String]
boomBangs xs = [ if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]

removeNonUppercase :: [Char] -> [Char]
removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]

addThree :: Int -> Int -> Int -> Int
addThree x y z = x + y + z

-- From "Syntax in Functions" chapter 

lucky :: (Integral a) => a -> String  
lucky 7 = "LUCKY NUMBER SEVEN!"  
lucky x = "Sorry, you're out of luck, pal!"

sayMe :: (Integral a) => a -> String  
sayMe 1 = "One!"  
sayMe 2 = "Two!"  
sayMe 3 = "Three!"  
sayMe 4 = "Four!"  
sayMe 5 = "Five!"  
sayMe x = "Not between 1 and 5"

-- factorial defined using pattern matching & recursively
factorial :: (Integral a) => a -> a  
factorial 0 = 1  
factorial n = n * factorial (n - 1)


charName :: Char -> String  
charName 'a' = "Alpha"  
charName 'b' = "Bravo"  
charName 'c' = "Charlie"
charName x = "does not compute"

addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a)  
addVectors (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)

tell :: (Show a) => [a] -> String  
tell [] = "The list is empty"  
tell (x:[]) = "The list has one element: " ++ show x  
tell (x:y:[]) = "The list has two elements: " ++ show x ++ " and " ++ show y  
tell (x:y:_) = "This list is long. The first two elements are: " ++ show x ++ " and " ++ show y


myLength :: (Num b) => [a] -> b  
myLength [] = 0  
myLength (_:xs) = 1 + myLength xs

mySum :: (Num a) => [a] -> a  
mySum [] = 0  
mySum (x:xs) = x + mySum xs

capital :: String -> String  
capital "" = "Empty string, whoops!"  
capital all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x]


bmiTell :: (RealFloat a) => a -> a -> String  
bmiTell weight height  
    | bmi <= skinny = "You're underweight, you emo, you!"  
    | bmi <= normal = "You're supposedly normal. Pffft, I bet you're ugly!"  
    | bmi <= fat    = "You're fat! Lose some weight, fatty!"  
    | otherwise     = "You're a whale, congratulations!"  
    where bmi = weight / height ^ 2  
          skinny = 18.5  
          normal = 25.0  
          fat = 30.0

cylinder :: (RealFloat a) => a -> a -> a  
cylinder r h = 
    let sideArea = 2 * pi * r * h  
        topArea = pi * r ^2 
    in  sideArea + 2 * topArea

