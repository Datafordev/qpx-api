{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}

module QPX.API.Response.Segment where

import           Control.Lens            (makeLenses)
import           Control.Monad           (mzero)
import           Data.Aeson              (FromJSON, Value (Object), parseJSON,
                                          (.:), (.:?))
import           QPX.API.Response.Flight
import           QPX.API.Response.Leg
import           QPX.API.Types.CabinType

data Segment = Segment { _segmentDuration     :: Int
                       , _flight              :: Flight
                       , _cabin               :: CabinType
                       , _bookingCode         :: String
                       , _bookingCodeCount    :: Int
                       , _marriedSegmentGroup :: String
                       , _legs                :: [Leg]
                       , _connectionDuration  :: Maybe Int
                       } deriving (Show)

makeLenses ''Segment

instance FromJSON Segment where
    parseJSON (Object v) = Segment <$>
                           v .: "duration" <*>
                           v .: "flight" <*>
                           v .: "cabin" <*>
                           v .: "bookingCode" <*>
                           v .: "bookingCodeCount" <*>
                           v .: "marriedSegmentGroup" <*>
                           v .: "leg" <*>
                           v .:? "connectionDuration"
    parseJSON _          = mzero
