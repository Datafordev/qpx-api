{-# LANGUAGE OverloadedStrings #-}

module QPX.API.Types.CabinType where

import           Control.Monad (mzero)
import           Data.Aeson    (FromJSON, ToJSON, Value (..), parseJSON, toJSON)

data CabinType = Coach | PremiumCoach | Business | First deriving (Show, Eq)

instance ToJSON CabinType where
  toJSON Coach        = String "COACH"
  toJSON PremiumCoach = String "PREMIUM_COACH"
  toJSON Business     = String "BUSINESS"
  toJSON First        = String "FIRST"

instance FromJSON CabinType where
  parseJSON (String s) | s == "COACH" = return Coach
                       | s == "PREMIUM_COACH" = return PremiumCoach
                       | s == "BUSINESS" = return Business
                       | s == "FIRST" = return First
  parseJSON _  = mzero
