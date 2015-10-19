{-# LANGUAGE FlexibleContexts  #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}

module QPX.API.Request.Slice where

import           Control.Lens              (makeLenses, (^.))
import           Data.Aeson                (ToJSON, object, toJSON, (.=))
import           Data.Time.Calendar        (Day)
import           QPX.API.Request.Alliance
import           QPX.API.Request.Internal
import           QPX.API.Request.TimeRange
import           QPX.API.Types.CabinType

data Slice = Slice { _origin                 :: String
                   , _destination            :: String
                   , _date                   :: Day
                   , _maxStops               :: Maybe Int
                   , _preferredCabin         :: Maybe CabinType
                   , _permittedDepartureTime :: Maybe TimeRange
                   , _alliance               :: Maybe Alliance
                   , _permittedCarriers      :: Maybe [String]
                   , _prohibitedCarriers     :: Maybe [String]
                   , _maxConnectionDuration  :: Maybe Int
                   }
makeLenses ''Slice

instance ToJSON Slice where
  toJSON slice = object $
                      [ "origin"      .= (slice ^. origin)
                      , "destination" .= (slice ^. destination)
                      , "date"  .= (slice ^. date)
                      ]
                      ++ optionalPair "maxStops" (slice ^. maxStops)
                      ++ optionalPair "preferredCabin" (slice ^. preferredCabin)
                      ++ optionalPair "permittedDepartureTime" (slice ^. permittedDepartureTime)
                      ++ optionalPair "alliance" (slice ^. alliance)
                      ++ optionalPair "permittedCarrier" (slice ^. permittedCarriers)
                      ++ optionalPair "prohibitedCarrier" (slice ^. prohibitedCarriers)
                      ++ optionalPair "maxConnectionDuration" (slice ^. maxConnectionDuration)
