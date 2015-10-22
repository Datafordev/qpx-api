{-# LANGUAGE OverloadedStrings #-}

module ResponseParserTests where

import           Data.Aeson
import           Data.String.Conversions
import           Distribution.TestSuite
import           QPX.API.Response

makeTest :: String -> IO Progress -> Test
makeTest name' run' = Test testInstance
  where testInstance = TestInstance
            { run = run'
            , name = name'
            , tags = []
            , options = []
            , setOption = \_ _ -> Right testInstance
            }

tests :: IO [Test]
tests = return [
                 makeTest "CabinTypeParseTest" testCabinType
               , makeTest "FlightParseTest" testFlight
               , makeTest "LegParseTest" testLeg
               , makeTest "SegmentParseTest" testSegment
               , makeTest "SliceParseTest" testSlice
               , makeTest "TripOptionParseTest" testTripOption
               , makeTest "ResponseParseTest" testResponse
               , makeTest "MinResponseParseTest" testMinResponse
               ]

testCabinType :: IO Progress
testCabinType = do
  flightFixture <- readFile "test-fixtures/cabin_type.json"
  let flights = decode (cs flightFixture) :: Maybe [CabinType]
  return $ Finished $
        if flights == Just [Coach, PremiumCoach, Business, First]
          then Pass
          else Fail "Parsing Flights failed"

testFlight :: IO Progress
testFlight = do
  flightFixture <- readFile "test-fixtures/flights.json"
  let flights = decode (cs flightFixture) :: Maybe [Flight]
  return $ Finished $ case flights of
          Just _ -> Pass
          _ -> Fail "Parsing Flights failed"

testLeg :: IO Progress
testLeg = do
  legFixture <- readFile "test-fixtures/legs.json"
  let legss = decode (cs legFixture) :: Maybe [Leg]
  return $ Finished $ case legss of
          Just _ -> Pass
          _ -> Fail "Parsing Legs failed"

testSegment :: IO Progress
testSegment = do
  segmentFixture <- readFile "test-fixtures/segments.json"
  let segments' = decode (cs segmentFixture) :: Maybe [Segment]
  return $ Finished $ case segments' of
          Just _ -> Pass
          _ -> Fail "Parsing Segments failed"

testSlice :: IO Progress
testSlice = do
  sliceFixture <- readFile "test-fixtures/slices.json"
  let slices' = decode (cs sliceFixture) :: Maybe [Slice]
  return $ Finished $ case slices' of
          Just _ -> Pass
          _ -> Fail "Parsing Slices failed"

testTripOption :: IO Progress
testTripOption = do
  tripOptionFixture <- readFile "test-fixtures/trip_options.json"
  let tripOptions' = decode (cs tripOptionFixture) :: Maybe [TripOption]
  return $ Finished $ case tripOptions' of
          Just _ -> Pass
          _ -> Fail "Parsing TripOptions failed"

testResponse :: IO Progress
testResponse = do
  testResponseFixture <- readFile "test-fixtures/example_response.json"
  let response' = decode (cs testResponseFixture) :: Maybe Response
  return $ Finished $ case response' of
          Just _ -> Pass
          _ -> Fail "Parsing Response failed"

testMinResponse :: IO Progress
testMinResponse = do
  testResponseFixture <- readFile "test-fixtures/example_response.min.json"
  let response' = decode (cs testResponseFixture) :: Maybe Response
  return $ Finished $ case response' of
          Just _ -> Pass
          _ -> Fail "Parsing Minified Response failed"
