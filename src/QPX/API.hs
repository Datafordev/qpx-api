{-# LANGUAGE NamedFieldPuns    #-}
{-# LANGUAGE OverloadedStrings #-}

module QPX.API (searchFlights) where

import           Data.Aeson                (decode, encode)
import           Data.String.Conversions   (cs)
import qualified Network.HTTP.Client       as HTTP
import qualified Network.HTTP.Client.TLS   as HTTP (tlsManagerSettings)
import qualified Network.HTTP.Types.Status as HTTP (Status)
import           QPX.API.Request           (Request)
import           QPX.API.Response          (Response)

searchFlights :: String -> Request -> IO (Either HTTP.Status Response)
searchFlights apiKey request = do
  manager <- HTTP.newManager HTTP.tlsManagerSettings

  initialRequest <- HTTP.parseUrl apiUrl
  let authorizedRequest = HTTP.setQueryString [ ("key", Just (cs apiKey))
                                              , ("prettyPrint", Just "false")
                                              ] initialRequest
  let requestJSON = encode request
  let httpRequest = authorizedRequest { HTTP.method = "POST"
                                      , HTTP.requestHeaders = [("Content-Type", "application/json;charset=utf-8")]
                                      , HTTP.requestBody = HTTP.RequestBodyLBS requestJSON}

  response <- HTTP.httpLbs httpRequest manager

  --TODO: Check and allow non 200 status codes
  let responseBody = HTTP.responseBody response
  case decode responseBody :: Maybe Response of
    Just r -> return $ Right r
    _      -> return $ Left $ HTTP.responseStatus response

apiUrl :: String
apiUrl = "https://www.googleapis.com/qpxExpress/v1/trips/search"
