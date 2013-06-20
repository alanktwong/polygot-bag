{-
From "Higher Order Functions" chapter
@author awong
@see http://learnyouahaskell.com/modules

-}

import Data.List  as List
import Data.Set   as Set
import qualified Data.Map as Map
import Data.Char  as Char
import Data.Maybe as Maybe

numUniques :: (Eq a) => [a] -> Int  
numUniques = length . nub


{-
phoneBook = [("betty","555-2938"),("bonnie","452-2928"),("patsy","493-2928"),("lucille","205-2928"),("wendy","939-8282"),("penny","853-2492")]  
-}

findKey' :: (Eq k) => k -> [(k,v)] -> Maybe v  
findKey' key [] = Nothing  
findKey' key ((k,v):xs) = if key == k  
                            then Just v  
                            else findKey' key xs


findKey :: (Eq k) => k -> [(k,v)] -> Maybe v  
findKey key = List.foldr (\(k,v) acc -> if key == k then Just v else acc) Nothing


