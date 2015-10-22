{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}

module QPX.API.Request.TimeRange where

import           Control.Lens             (makeLenses, (^.))
import           Data.Aeson               (ToJSON, object, toJSON)
import           Data.Time.LocalTime      (TimeOfDay, todHour, todMin)
import           QPX.API.Request.Internal

data TimeRange = TimeRange { _earliestTime :: Maybe TimeOfDay
                           , _latestTime   :: Maybe TimeOfDay } deriving (Show)

makeLenses ''TimeRange

instance ToJSON TimeRange where
  toJSON timeRange = object $
         optionalPair "earliestTime" (fmap formatTime (timeRange ^. earliestTime))
      ++ optionalPair "latestTime" (fmap formatTime (timeRange ^. latestTime))
      where formatTime time = show (todHour time) ++ ":" ++ show (todMin time)
