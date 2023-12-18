# News reader

This in an app that reads news provided by https://newsapi.org/.  
It's written in Swift 5.9 using The Composable Architecture.

## Requirements
Xcode 15 & iOS 16.4+

## Setup

The project can be run by simply opening `.xcodeproj` file.

### Api key
To set a new key for newsapi.org API:
1. Create `.env` file in following format with your api key value.
```bash
NewsApiKey=<api-key>
```
1. Install Arkana Keys by executing `brew install arkana` in Terminal.
1. Navigate to project's root directory in Terminal and run `arkana`.

## Known issues
* The news detail view transition triggered from selected source news list does not work. There's some issue with presenting multiple Navigation Stacks in SwiftUI/TCA that I do not understand.