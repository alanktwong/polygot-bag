{-
From "Input and Output" chapter
@author awong
@see http://learnyouahaskell.com/input-and-output

How Haskell can be pure but have side-effects like data i/o
-}
main = do
    -- '<-' is Haskell's converse to return ... convert an I/O action to a pure value
    line <- getLine  
    if null line
        -- this is not your imperative language's return ... it converts a pure value to an I/O action
        then return ()  
        else do  
            putStrLn $ reverseWords line  
            main  
  
reverseWords :: String -> String  
reverseWords = unwords . map reverse . words