{-# LANGUAGE DataKinds, KindSignatures, TypeFamilies, TypeOperators #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE LambdaCase          #-}
{-# LANGUAGE BangPatterns #-}

module Main where

import Torch.Core.Tensor.Dim
import Torch.Core.Tensor.Static.Double
import Torch.Core.Tensor.Static.DoubleMath
import Torch.Core.Tensor.Static.DoubleRandom

import Data.Singletons
import Data.Singletons.Prelude
import Data.Singletons.TypeLits

{- Simple FF neural network, statically typed version, based on JL's example -}

type SW = StaticWeights
type SN = StaticNetwork

data StaticWeights (i :: Nat) (o :: Nat) = SW {
  biases :: TDS '[o],
  nodes :: TDS '[o, i]
  } deriving (Show)

mkW :: (KnownNatDim i, KnownNatDim o) => SW i o
mkW = SW b n
  where (b, n) = (tds_new, tds_new)

data StaticNetwork :: Nat -> [Nat] -> Nat -> * where
  O :: (KnownNatDim i, KnownNatDim o) =>
       SW i o -> SN i '[] o
  (:~) :: (KnownNatDim h, KnownNatDim i, KnownNatDim o) =>
          SW i h -> SN h hs o -> SN i (h ': hs) o

infixr 5 :~

dispW :: (KnownNatDim o, KnownNatDim i) => StaticWeights i o -> IO ()
dispW w = do
  putStrLn "\nBiases:"
  tds_p (biases w)
  putStrLn "\nWeights:"
  tds_p (nodes w)

dispN :: SN h hs c -> IO ()
dispN (O w) = dispW w
dispN (w :~ n') = putStrLn "\nCurrent Layer ::::" >> dispW w >> dispN n'

randomWeights :: (KnownNatDim i, KnownNatDim o) => IO (SW i o)
randomWeights = do
  gen <- newRNG
  b <- tds_uniform gen (-1.0) (1.0)
  w <- tds_uniform gen (-1.0) (1.0)
  pure SW { biases = b, nodes = w }

randomNet :: forall i hs o. (KnownNatDim i, SingI hs, KnownNatDim o) => IO (SN i hs o)
randomNet = go (sing :: Sing hs)
  where go :: forall h hs'. KnownNatDim h => Sing hs' -> IO (SN h hs' o)
        go = \case
          SNil ->
            O <$> randomWeights
          SNat `SCons` ss ->
            (:~) <$> randomWeights <*> go ss

runLayer :: (KnownNatDim i, KnownNatDim o) => SW i o -> TDS '[i] -> TDS '[o]
runLayer sw v = tds_addmv 1.0 wB 1.0 wN v -- v are the inputs
  where wB = biases sw
        wN = nodes sw

runNet :: (KnownNatDim i, KnownNatDim o) => SN i hs o -> TDS '[i] -> TDS '[o]
runNet (O w) v = tds_sigmoid (runLayer w v)
runNet (w :~ n') v = let v' = tds_sigmoid (runLayer w v) in runNet n' v'

ih :: StaticWeights 10 7
hh :: StaticWeights  7 4
ho :: StaticWeights  4 2
ih = mkW
hh = mkW
ho = mkW

net1 :: SN 4 '[] 2
net1 = O ho
net2 :: SN 7 '[4] 2
net2 = hh :~ O ho
net3 :: SN 10 '[7,4] 2
net3 = ih :~ hh :~ O ho

main :: IO ()
main = do
  putStrLn "\n=========\nNETWORK 1\n========="
  n1 <- (randomNet :: IO (SN 4 '[] 2))
  dispN n1

  putStrLn "\nNETWORK 1 Forward prop result:"
  tds_p $ runNet n1 (tds_init 1.0 :: TDS '[4])

  putStrLn "\n=========\nNETWORK 2\n========="
  n2  <- randomNet :: IO (SN 4 '[3, 2] 2)
  dispN n2

  putStrLn "\nNETWORK 2 Forward prop result:"
  tds_p $ runNet n2 (tds_init 1.0 :: TDS '[4])

  putStrLn "Done"
