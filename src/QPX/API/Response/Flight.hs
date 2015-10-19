{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}

module QPX.API.Response.Flight where

import           Control.Lens  (makeLenses)
import           Control.Monad (mzero)
import           Data.Aeson    (FromJSON, Value (Object), parseJSON, (.:))

data Flight = Flight { _carrier :: String
                     , _number  :: String
                     } deriving (Show)

makeLenses ''Flight

instance FromJSON Flight where
    parseJSON (Object v) = Flight <$>
                           v .: "carrier" <*>
                           v .: "number"
    parseJSON _ = mzero
