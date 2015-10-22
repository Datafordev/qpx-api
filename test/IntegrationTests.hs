{-# LANGUAGE OverloadedStrings #-}

module IntegrationTests where

import           Control.Monad          (liftM)
import           Data.Time.Calendar     (Day, addDays)
import           Data.Time.Clock        (getCurrentTime, utctDay)
import           Distribution.TestSuite
import           MakeTest
import           QPX.API
import qualified QPX.API.Request        as Req

testApiKey :: IO String
testApiKey = readFile "test-fixtures/api-key"

tests :: IO [Test]
tests = return [ makeTest "IntegrationTest" testResponse ]

testResponse :: IO Progress
testResponse = do
  tomorrow <- liftM (addDays 1 . utctDay) getCurrentTime
  let request' = dummyRequest tomorrow
  apiKey <- testApiKey
  response' <- searchFlights apiKey request'
  return $ Finished $ case response' of
          Right _ -> Pass
          _ -> Fail "Fetching Flights failed"

dummyRequest :: Day -> Req.Request
dummyRequest day = Req.Request [slice] passengers 50 False Nothing Nothing
  where slice = Req.Slice "MUC" "SFO" day Nothing Nothing Nothing Nothing Nothing Nothing Nothing
        passengers = Req.PassengerList 1 0 0 0 0
