-- Checks that the types of the old binder and the binder implicitly introduced by grouping are linked

{-# OPTIONS_GHC -XTransformListComp #-}

module ShouldCompile where

import List(inits)

foo :: [[[Int]]]
foo = [ x
      | x <- [1..10]
      , then group using inits
      , then group using inits
      ]