
module Tests where

import           Distribution.TestSuite
import qualified ResponseParserTests

tests :: IO [Test]
tests = ResponseParserTests.tests
