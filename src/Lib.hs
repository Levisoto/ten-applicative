module Lib where

import AParser
import Control.Applicative
import Data.Char

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
-- Problem 2
-- I need to implement a Applicative instance of Parser
instance Applicative Parser where
  pure f = Parser (\input -> Just (f,input))
  (Parser p) <*> (Parser q) = Parser (\input -> case p input of
                                                  Nothing -> Nothing
                                                  Just (x,y) -> first x <$> q y)
------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- Problem 3
-- I'll create some functions to test them and show their behavior
abParser :: Parser (Char, Char)
abParser = pure (\x y -> (x,y)) <*> char 'a' <*> char 'b'

abParser_ :: Parser ()
abParser_ = pure (\x y -> ()) <*> char 'a' <*> char 'b'

intPair :: Parser [Integer]
intPair = pure (\x _ y -> [x,y]) <*> posInt <*> char ' ' <*> posInt
------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- Problem 4
-- I need make a Alternative instance of Parser 
instance Alternative Parser where
  empty = Parser (\input -> Nothing)
  Parser p <|> Parser q = Parser (\input -> case p input of
                                            Nothing -> q input
                                            Just _ -> p input)
------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- Problem 5
-- I'll write the function to parsering int and Uppercase words 
intOrUppercase :: Parser ()
intOrUppercase = getInt <|> getUppercase
  where getInt = pure (\x -> ()) <*> posInt
        getUppercase = pure (\x -> ()) <*> (satisfy isUpper)
