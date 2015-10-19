module QPX.API.Request.Internal where

import           Data.Aeson (ToJSON, Value (), toJSON)
import           Data.Text  (Text)

optionalPair :: ToJSON a => Text -> Maybe a -> [(Text, Value)]
optionalPair key = maybe [] (\value -> [(key, toJSON value)])
