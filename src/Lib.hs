module Lib where

import AParser

someFunc :: IO ()
someFunc = putStrLn "someFunc"


-- Problem 1
-- I need to implement a Functor instance of the Parser
instance Functor (Parser a) where
  fmap f (Parser a) = 
  
