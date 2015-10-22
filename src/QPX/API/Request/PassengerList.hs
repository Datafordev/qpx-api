{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}

module QPX.API.Request.PassengerList where

import           Control.Lens (makeLenses, (^.))
import           Data.Aeson   (ToJSON, object, toJSON, (.=))

data PassengerList = PassengerList { _adultCount        :: Int
                                   , _infantInLapCount  :: Int
                                   , _infantInSeatCount :: Int
                                   , _childCount        :: Int
                                   , _seniorCount       :: Int
                                   } deriving (Show)

makeLenses ''PassengerList

instance ToJSON PassengerList where
  toJSON list = object [ "adultCount"        .= (list ^. adultCount)
                       , "infantInLapCount"  .= (list ^. infantInLapCount)
                       , "infantInSeatCount" .= (list ^. infantInSeatCount)
                       , "childCount"        .= (list ^. childCount)
                       , "seniorCount"       .= (list ^. seniorCount)
                       ]
