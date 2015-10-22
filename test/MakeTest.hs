module MakeTest where

import           Distribution.TestSuite

makeTest :: String -> IO Progress -> Test
makeTest name' run' = Test testInstance
  where testInstance = TestInstance
            { run = run'
            , name = name'
            , tags = []
            , options = []
            , setOption = \_ _ -> Right testInstance
            }
