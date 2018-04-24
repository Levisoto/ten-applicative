module Lib where

import AParser

someFunc :: IO ()
someFunc = putStrLn "someFunc"


-- Problem 1
-- I need to implement a Functor instance of the Parser
--hint: function First
first :: (a -> b) -> (a,c) -> (b,c)
first f (a,c) = (f a,c)

instance Functor Parser where
  fmap f (Parser p) = Parser (fmap (first f).p)

  -- fmap f (Parser p) = Parser (\input -> case (p input) of
  --                                               Just (x,xs) -> Just (f x, xs)
  --                                               Nothing -> Nothing
  --                            )
------------------------------------------------------------------------------
------------------------------------------------------------------------------
  --
  --
