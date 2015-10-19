{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}

module QPX.API.Response (Response
                        , tripOptions
                        , module X
                        ) where

import           Control.Lens                (makeLenses)
import           Data.Aeson                  (FromJSON, Object, parseJSON, (.:))
import           Data.Aeson.Types            (Parser)
import           Data.Text                   (Text)
import           QPX.API.Response.Currency   as X
import           QPX.API.Response.Flight     as X
import           QPX.API.Response.Leg        as X
import           QPX.API.Response.Segment    as X
import           QPX.API.Response.Slice      as X
import           QPX.API.Response.TripOption as X
import           QPX.API.Types.CabinType     as X

-- TODO: Integrate data
data Response = Response { _tripOptions :: [TripOption] } deriving (Show)

makeLenses ''Response

instance FromJSON Response where
     parseJSON v = do
       tripOption <- parseJSON v >>= get "trips" >>= get "tripOption"

       return $ Response tripOption
       where
          get :: (FromJSON a) => Text -> Object -> Parser a
          get = flip (.:)
