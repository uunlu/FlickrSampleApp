#  README

This document is going to explain architectural decision taken in developing this sample app. 


# Structure

Flickr sample app  has a modular architecture. One of the pillars of it is creating independent units of code that can be tested in isolation. The project consists following modules from the lowest to highest order: 
- Entities
- NetworkServices
- Adapters
- FlickerSample

## Why Modules Are Used?

Using  modules in such a tiny app is an overengineering. However, the reason behing using modules is to showcase its benefits: 
1. Separation concerns, units are clearly cut. 
2. Isolated, independent units
3. Reusable code
4. Better parallel development 
5. Running unit test quicker by not need of attaching compiled file to Simulator every time unit tests run.

## Composition Root

The app dependency graph is created inside the CompositionRoot class. By that way, the code welcome future change requests by having one centralized place to inject dependencies. If we want to support offline data support, the only place we need to change is this central dependency injection. 
Also, flow of the app is controlled here which makes our views agnostic of navigation logic. 
https://blog.ploeh.dk/2011/07/28/CompositionRoot/

## TDD

The code is developed via test driven development. However, due to time constraint not a broad compassing test coverage is implemented.
Also, UI tests, integration tests and snapshot tests are not implemented for the same reason stated above.

## SwiftUI & Combine
The entire app is developed using Combine framework and UI of the app is built by SwiftUI. 
In a real life scenario, UI module can be the sole consumer of Combine and the rest of the app can communicate with closures to support older version of the app by just changing the UI. 

## What's Next?

1. A generic networking can be created.
2. Add more details to the photo details, with requesting user data. 
3. Adding more animations and better UI and UX
4. Implementing offline mode
5. Can using URLCache be better instead of NSCache?

```

