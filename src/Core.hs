module Core where

-- copy in the "getting started" code
-- is the remainder zero?
divides :: Integer -> Integer -> Bool
divides d n = rem n d == 0

-- least prime divisor maybe?
ld :: Integer -> Integer
ld = ldf 2

{- 1.
  -}
ldf :: Integer -> Integer -> Integer
ldf k n
    | divides k n = k
    | k ^ 2 > n = n
    | otherwise = ldf (k + 1) n

-- checks if an Integer is prime
prime0 :: Integer -> Bool
prime0 n
    | n < 1 = error "not a positive integer"
    | n == 1 = False
    | otherwise = ld n == n

mnmInt :: [Int] -> Int
mnmInt [] = error "empty list"
mnmInt [x] = x
mnmInt (x : xs) = min x (mnmInt xs)

min' :: Int -> Int -> Int
min' x y
    | x <= y = x
    | otherwise = y

average :: [Int] -> Rational
average [] = error "empty list"
average xs = toRational (sum xs) / toRational (length xs)

sum' :: [Int] -> Int
sum' [] = 0
sum' (x : xs) = x + sum' xs

length' :: [a] -> Int
length' [] = 0
length' (x : xs) = 1 + length' xs

prefix :: String -> String -> Bool
prefix [] ys = True
prefix (x : xs) [] = False
prefix (x : xs) (y : ys) = (x == y) && prefix xs ys

factors :: Integer -> [Integer]
factors n
    | n < 1 = error "argument not positive"
    | n == 1 = []
    | otherwise = p : factors (div n p)
  where
    p = ld n

primes0 :: [Integer]
primes0 = filter prime0 [2 ..]

ldp :: Integer -> Integer
ldp n = ldpf primes1 n

ldpf :: [Integer] -> Integer -> Integer
ldpf (p : ps) n
    | rem n p == 0 = p
    | p ^ 2 > n = n
    | otherwise = ldpf ps n

primes1 :: [Integer]
primes1 = 2 : filter prime [3 ..]

prime :: Integer -> Bool
prime n
    | n < 1 = error "not a positive integer"
    | n == 1 = False
    | otherwise = ldp n == n

a = 3
b = 4
f :: Integer -> Integer -> Integer
f x y = x ^ 2 + y ^ 2

g :: Integer -> Integer
g 0 = 1
g x = 2 * g (x - 1)

h1 :: Integer -> Integer
h1 0 = 0
h1 x = 2 * (h1 x)

h2 :: Integer -> Integer
h2 0 = 0
h2 x = h2 (x + 1)

-- exercise 1.9 define a function for the max of a list of integers
-- use the predefined function `max`

maximum' :: (Ord a, Integral a) => [a] -> a
maximum' = foldr1 max

-- exercise 1.10 define removeFst to remove the first occurrence of an integer from a list of integers
removeFst :: Integer -> [Integer] -> [Integer]
removeFst remove_me [] = []
removeFst remove_me (x : xs) = if x == remove_me then xs else x : removeFst remove_me xs

-- exercise 1.13 write a function `count` to count the number of a character in a string

count :: Char -> String -> Int
count c str = length $ filter (== c) str

blowup'' :: String -> String
blowup'' str = worker str 1
  where
    worker [] _ = []
    worker (c : cs) n = take n (repeat c) ++ worker cs (n + 1)

blowup' :: String -> String
blowup' str = mconcat $ zipWith dupN str [1 ..]
  where
    dupN c n = replicate n c

-- code golf!
blowup :: String -> String
blowup str = mconcat $ zipWith replicate [1 ..] str

-- exercise 1.15 write ~srtString :: [String] -> [String]~ that sorts a list of strings in alphabetical order
-- we follow the pattern given above
-- define

minString :: [String] -> String
minString = minimum

-- originally:
-- minString :: [String] -> String
-- minString strs = foldr1 min strs

srtString :: [String] -> [String]
srtString [] = [] -- empty string is sorted
srtString xs = m : srtString (removeFst' m xs)
  where
    m = minString xs

mnm :: (Ord a) => [a] -> a
mnm [] = error "empty list"
mnm [x] = x
mnm (x : xs) = min x (mnm xs)

removeFst' :: (Eq a) => a -> [a] -> [a]
removeFst' remove_me [] = []
removeFst' remove_me (x : xs) = if x == remove_me then xs else x : removeFst' remove_me xs

substring :: String -> String -> Bool
substring [] _ = False
substring allx@(x : xs) ys = allx `prefix` ys || substring xs ys

-- ok, what's better than substring above?

substring' :: (Eq b) => [b] -> [b] -> Bool
substring' xs ys = and $ zipWith (==) xs ys

lengths :: [[a]] -> [Int]
lengths = map length

sumLengths = sum . lengths
