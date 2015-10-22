
module Tests where

import           Control.Monad          (liftM2)
import           Distribution.TestSuite
import qualified IntegrationTests
import qualified ResponseParserTests

tests :: IO [Test]
tests = ResponseParserTests.tests
  `concatM` IntegrationTests.tests

concatM :: Monad m => m [a] -> m [a] -> m [a]
concatM = liftM2 (++)
