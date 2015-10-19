{-# LANGUAGE FlexibleContexts  #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}

-- TODO: This is probably not all the lenses
module QPX.API.Request ( Request(..)
                       , slice
                       , passengers
                       , solutions
                       , refundable
                       , maximumPrice
                       , saleCountry
                       , module X
                       ) where

import           Control.Lens                  (makeLenses, (^.))
import           Data.Aeson                    (ToJSON, object, toJSON, (.=))
import           Data.Scientific               (FPFormat (Fixed),
                                                formatScientific,
                                                fromFloatDigits)
import           QPX.API.Request.Alliance      as X
import           QPX.API.Request.Internal      as X
import           QPX.API.Request.PassengerList as X
import           QPX.API.Request.Slice         as X
import           QPX.API.Request.TimeRange     as X
import           QPX.API.Types.CabinType       as X

data Request = Request { _slice        :: [Slice]       -- The list of slices
                       , _passengers   :: PassengerList -- The list of passengers
                       , _solutions    :: Int           -- Number of solutions to return
                       , _refundable   :: Bool          -- Only search for refundable flights
                       , _maximumPrice :: Maybe Float   -- Optional: The maximum price of flights to return
                       , _saleCountry  :: Maybe String  -- Optional: The country of sale (e.g. US)
                       }

makeLenses ''Request

instance ToJSON Request where
  toJSON request = object [ "request" .= request' ]
    where request' = object $
                      [ "slice"      .= (request ^. slice)
                      , "passengers" .= (request ^. passengers)
                      , "solutions"  .= (request ^. solutions)
                      , "refundable" .= (request ^. refundable)
                      ]
                      ++ optionalPair "maximumPrice" (fmap formatPrice (request ^. maximumPrice))
                      ++ optionalPair "saleCountry" (request ^. saleCountry)
          formatPrice p = formatScientific Fixed (Just 2) $ fromFloatDigits p
