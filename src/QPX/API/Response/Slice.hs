{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}

module QPX.API.Response.Slice where

import           Control.Lens             (makeLenses)
import           Control.Monad            (mzero)
import           Data.Aeson               (FromJSON, Value (Object), parseJSON,
                                           (.:))
import           QPX.API.Response.Segment

data Slice = Slice { _duration :: Int
                   , _segments :: [Segment]
                   } deriving (Show)

makeLenses ''Slice

instance FromJSON Slice where
    parseJSON (Object v) = Slice <$>
                           v .: "duration" <*>
                           v .: "segment"
    parseJSON _          = mzero
