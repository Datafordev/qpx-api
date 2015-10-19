{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}

module QPX.API.Response.TripOption where

import           Control.Lens              (makeLenses)
import           Control.Monad             (mzero)
import           Data.Aeson                (FromJSON, Value (Object), parseJSON,
                                            (.:))
import           QPX.API.Response.Currency
import           QPX.API.Response.Slice

-- TODO: Integrate pricing
data TripOption = TripOption { _saleTotal :: Currency
                             , _slices    :: [Slice]
                             } deriving (Show)

makeLenses ''TripOption

instance FromJSON TripOption where
    parseJSON (Object v) = TripOption <$>
                           v .: "saleTotal" <*>
                           v .: "slice"
    parseJSON _          = mzero
