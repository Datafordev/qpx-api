# qpx-api

[![CI Status](http://img.shields.io/travis/timbodeit/qpx-api?style=flat)](https://travis-ci.org/timbodeit/qpx-api)

qpx-api is a simple Haskell wrapper around Googles QPX Express flight search API.

## Requirements

qpx-api depends on changes in the aeson library that have not yet been merged.  
For more information see pull request [bos/aeson#302](https://github.com/bos/aeson/pull/302).  
To use qpx-api, aeson must be installed from [timbodeit/aeson](https://github.com/timbodeit/aeson).

To run the IntegrationTests, you need to obtain an API Key from the
[QPX Express website](https://developers.google.com/qpx-express/).
Create a `test-fixtures/api-key` file that contains your API Key.

## Author

The Library is written and maintained by Tim Bodeit, [github@timbodeit.com](mailto:github@timbodeit.com).

## License

SwiftPipes is available under the MIT license. See the LICENSE file for more info.
