# MinimalNetworking
Introducing a minimal networking library tailored for quick demos and proof-of-concept projects! This lightweight solution streamlines the process of making network requests without the hassle of implementing a full-fledged network layer. With just a few lines of code, you can effortlessly integrate network functionality into your project, saving valuable time and effort. Whether you're showcasing a prototype or experimenting with a new idea, this simple and intuitive library provides the essential tools you need to interact with APIs and fetch data.

## Installation
Adding MinimalNetworking as a dependency is as easy as adding it to the dependencies value of your Package.swift or the Package list in Xcode.

```swift
dependencies: [
    .package(url: "git@github.com:GRGBISHOW/MinimalNetworking.git", .upToNextMajor(from: "0.0.1"))
]
```

## Usage
### Setup
Simple setup with just a implementation of baseurl, and thats it.

```swift
extension Requestable {
    static var host: MinimalNetworking.APIHostable {
        APIHost.development
    }
}

enum APIHost: APIHostable {
    case development
    var baseUrl: String {
        switch self {
        case .development:
            "https://pastebin.com/"
        }
    }
}
```

### API Contract implementation
Create enum to implement the contract and set you resuesttype, responsetype.

```swift
enum ProfileAPI: Requestable {
    typealias ResponseType = Profile
    typealias RequestType = EmptyRequest
    
    static var method: HTTPMethod { .get }
    
    static var path: String {
         "raw/fkAyNYGF"
    }
    
    struct Profile: Decodable {
        let id: String
        let name: String
    }
}
```
### Caller
Finally call it in viewmodel
```swift
func getProfile() {
        ProfileAPI.load()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] state in
                // handle completion
            }) { [weak self] data in
               // handle data
            }
            .store(in: &cancellable)
    }
```




