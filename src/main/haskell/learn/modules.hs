{-
From "Higher Order Functions" chapter
@author awong
@see http://learnyouahaskell.com/modules
-}

import Data.List
import Data.Set
import Data.Map
import Data.Char
import Data.Maybe

numUniques :: (Eq a) => [a] -> Int  
numUniques = length . nub


