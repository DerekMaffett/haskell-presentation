-- Basic Program

main = putStrLn "Hello World!"






-- SLIDE

-- Basic Program

main = do
    putStrLn "Hello World!"
    putStrLn " And all that live in it!"






-- SLIDE

-- Types

main :: IO ()
main = do
    putStrLn "Hello World!"

myChar :: Char
myChar = 'a'

myString :: String
myString = "Hello"

myNumber :: Int
myNumber = 7

myList :: [Int]
myList = [1, 2, 3, 4, 5]

listOfChars :: [Char]
listOfChars = ['a', 'b', 'c']




-- SLIDE

data Person = Person
    { name :: String
    , bookCount :: Int
    }

-- Records are basically JS objects with built-in schemas
author :: Person
author = Person { name = "Astrid", bookCount = 183 }

main = do
    putStrLn (name author ++ bookCount author)

-- Language extentions are common here to avoid conflicts


-- SLIDE



phoneNumber :: Maybe String
phoneNumber = Just "18002218834"

missingPhoneNumber :: Maybe String
missingPhoneNumber = Nothing

main :: IO ()
main = do
    putStrLn (extractPhoneNumber phoneNumber)

extractPhoneNumber :: Maybe String -> String
extractPhoneNumber maybePhoneNumber = case maybePhoneNumber of
    Just phoneNumber -> phoneNumber
    Nothing          -> "Not Available"


-- SLIDE

-- Sum Types

data ApiError
    = NotFound
    | Timeout
    | InternalError String

data Payload = Payload
    { message :: String
    , thingsCount :: Int
    }

data ApiCallState
    = Loading
    | Success Payload
    | Failure ApiError

apiResult = Success (Payload { message = "Hello", thingsCount = 3 })

main = do
    putStrLn undefined

-- SLIDE

-- In JS -
--
-- {
--   type: "@@MAPS/RELOAD_REQUESTED"
-- }
--
-- {
--   type: "@@MAPS/POINT_SELECTED",
--   payload: {
--     lat: 30,
--     lng: 40
--   }
-- }
--
-- In Haskell - 

data MapEvents
    = ReloadRequested
    | PointSelected Int Int -- PointSelected Point

event1 = ReloadRequested
event2 = PointSelected 30 40

eventHandler event = case event of
    ReloadRequested       -> putStrLn "Reload!"
    PointSelected lat lng -> putStrLn ("Selected point latitude: " ++ show lat)

main = do
    eventHandler event2

-- SLIDE

-- Functions

main = do
    putStrLn (show example1)

-- const add = (a, b) => a + b
add :: Int -> Int -> Int
add a b = a + b

-- const addFive = a => add(5, a)
addFive :: Int -> Int
addFive = add 5
alternateAdd5 = (+ 5)

example1 = addFive 5 == 10


-- SLIDE

-- Good to Know

double = (* 2)
addFive = (+ 5)

main = do
    putStrLn (show (double (addFive (head [0]))))

-- SLIDE

-- Good to Know

double = (* 2)
addFive = (+ 5)

main = do
    showData [0]

showData = putShowable . doubleAndAddFive . head

putShowable = putStrLn . show

doubleAndAddFive = double . addFive

-- SLIDE

-- Good to know - $

main = do
    putStrLn show 5

-- SLIDE

-- Refactoring

main = do
    outputToTerminal myNumber
  where
    outputToTerminal output = putStrLn (show output)
    myNumber = 10

alternate =
    let outputToTerminal output = putStrLn (show output)
        myNumber = 10
    in  do
            outputToTerminal myNumber



-- SLIDE

-- The IO Monad -- What is it? Category theory? Formulas? A BURRITO????

import System.Environment (getArgs)

main = do
    args <- getArgs
    let arg = head args
    putStrLn arg
    putStrLn "Done!"



-- SLIDE

-- IO Monad == JS Promises and Async/Await*
--
-- const main = () => getArgs()
--   .then(args => {
--      const arg = args[0];
--      return putStrLn(arg).then(() => putStrLn("Done!"));
--   });
--
-- const async main = () => {
--   const args = await getArgs();
--   const arg = args[0];
--   await putStrLn(arg);
--   await putStrLn("Done!");
-- }

import System.Environment (getArgs)

main = do
    args <- getArgs
    let arg = head args
    putStrLn arg
    putStrLn "Done!"


-- SLIDE

-- Irrelevant things about Monads!

-- Lists, Maybes, Functions, and many other things are also instances of Monads

-- SLIDE

-- Irrelevant things about Monads!

-- Lists, Maybes, Functions, and many other things are also instances of Monads

-- Only IO matters

-- SLIDE

-- Irrelevant things about Monads!

-- Lists, Maybes, Eithers, Functions, Readers, Writers, and many other things are also instances of Monads

-- Only IO matters

-- >>= means .then()

-- SLIDE

-- Typeclasses

-- fn = case someData of
--            String -> implementation1
--            Int -> implementation2
--            HashMap -> implementation3

main = undefined

-- SLIDE

-- Typeclasses

main = putStrLn example1

-- Show instances can be turned into text

-- Implements show

example1 = show 10
example2 = show "Haskell"

-- SLIDE

-- Monoid instances are combinable. Texts, HashMaps, Lists, etc

-- Implements <>

main = putStrLn $ show example1

example1 = [1, 2, 3] ++ [4, 5, 6]
example2 = [1, 2, 3] <> [4, 5, 6]
example3 = "Hello " <> "World"


-- SLIDE

-- Functor instances contain data that can be changed

-- Implements fmap

import System.Environment (getArgs)
import Data.Char (toUpper)

main = putStrLn example1

double = (* 2)
example1 = map double [1, 2, 3] 
example2 = fmap double [1, 2, 3] -- fmap == "functor map"
example3 = toUpper <$> "uppercase this" -- <$> means fmap
example4 = head <$> getArgs -- get the args, but only the first


-- SLIDE

-- Applicative instances are extentions of Functors. 

-- Usually used when mapping needs get complicated.
-- Use if a library makes you, only as they show

-- Implements <*> 

main = undefined

-- A language extention treats these like monads


-- SLIDE

-- Monads we talked about

-- Implements >>= - which is the same as .then()

main = do
  putStrLn "Keep it simple..."

-- SLIDE

-- Guidelines for Typeclasses
--
-- 1. (Almost) never make your own
-- 2. Libraries often use them. Follow their API.
-- 3. Typeclasses can provide "magical" type coercing without undefined behavior

main = undefined
