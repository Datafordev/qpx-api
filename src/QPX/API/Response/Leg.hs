{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}

module QPX.API.Response.Leg where

import           Control.Lens  (makeLenses)
import           Control.Monad (mzero)
import           Data.Aeson    (FromJSON, Value (Object), parseJSON, (.:),
                                (.:?))
import           Data.Time     (ZonedTime)

-- TODO: Add additional optional fields
data Leg = Leg { _aircraft            :: String
               , _arrivalTime         :: ZonedTime
               , _departureTime       :: ZonedTime
               , _origin              :: String
               , _destination         :: String
               , _originTerminal      :: Maybe String
               , _destinationTerminal :: Maybe String
               , _legDuration         :: Int
               , _mileage             :: Int
               , _meal                :: Maybe String
               , _secure              :: Maybe Bool
               } deriving (Show)

makeLenses ''Leg

instance FromJSON Leg where
    parseJSON (Object v) = Leg <$>
                           v .: "aircraft" <*>
                           v .: "arrivalTime" <*>
                           v .: "departureTime" <*>
                           v .: "origin" <*>
                           v .: "destination" <*>
                           v .:? "originTerminal" <*>
                           v .:? "destinationTerminal" <*>
                           v .: "duration" <*>
                           v .: "mileage"  <*>
                           v .:? "meal" <*>
                           v .:? "secure"
    parseJSON _ = mzero
