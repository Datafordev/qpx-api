{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}

module QPX.API.Response.Currency where

import           Control.Lens            (makeLenses)
import           Control.Monad           (mzero)
import           Data.Aeson              (FromJSON, Value (String), parseJSON)
import           Data.Char               (isLetter)
import           Data.String.Conversions (cs)

data Currency = Currency { _currency :: String
                         , _amount   :: Float
                         }

makeLenses ''Currency

instance Show Currency where
  show (Currency c a) = c ++ " " ++ show a

instance FromJSON Currency where
    parseJSON (String s) = return $ Currency currency' amount'
      where currency' = takeWhile isLetter $ cs s
            amount'   = read $ dropWhile isLetter $ cs s
    parseJSON _ = mzero
