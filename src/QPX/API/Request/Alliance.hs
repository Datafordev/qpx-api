{-# LANGUAGE OverloadedStrings #-}

module QPX.API.Request.Alliance where

import           Data.Aeson (ToJSON, Value (String), toJSON)

data Alliance = Oneworld | SkyTeam | StarAlliance deriving (Show)

instance ToJSON Alliance where
  toJSON Oneworld     = String "ONEWORLD"
  toJSON SkyTeam      = String "SKYTEAM"
  toJSON StarAlliance = String "STAR"
