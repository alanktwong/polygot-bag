{-
From "Input and Output" chapter
@author awong
@see http://learnyouahaskell.com/input-and-output

How Haskell can be pure but have side-effects like data i/o
-}


import Data.Char  
      
main = do  
    putStrLn "What's your first name?"  
    firstName <- getLine  
    putStrLn "What's your last name?"  
    lastName <- getLine  
    let bigFirstName = map toUpper firstName  
        bigLastName = map toUpper lastName  
    putStrLn $ "hey " ++ bigFirstName ++ " " ++ bigLastName ++ ", how are you?"