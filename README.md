# Favorites Manager [![Swift](https://github.com/ezefranca/FavoritesManager/actions/workflows/swift.yml/badge.svg?branch=main)](https://github.com/ezefranca/FavoritesManager/actions/workflows/swift.yml)

`FavoritesManager` is a Swift package that provides a simple way to manage a list of favorite items using iCloud. It uses `NSUbiquitousKeyValueStore` to store and synchronize data across devices.

## Installation

### Swift Package Manager

You can use Swift Package Manager to install `FavoritesManager` by adding it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/ezefranca/FavoritesManager.git", from: "1.0.0")
]
```
Or, add it to your project in Xcode:

- Click on File > Swift Packages > Add Package Dependency
- Enter the URL of the FavoritesManager repository: `https://github.com/ezefranca/FavoritesManager.git`
- Follow the instructions to complete the installation.

To use `NSUbiquitousKeyValueStore`, you need to enable iCloud for your app in the Apple Developer Portal and create an App ID with iCloud enabled.

Then, follow these steps:

Go to your project in Xcode.
- Select your target.
- Click on the "Signing & Capabilities" tab.
- Click the "+ Capability" button to add a new capability to your project.
- Search for "iCloud" and select it.
- Select the "Key-value storage" checkbox.
- Enter a unique identifier for your key-value store in the "iCloud Containers" section.
- Save your changes.

After completing these steps, your app should be able to access iCloud key-value storage.

<img width="656" alt="icloud" src="https://user-images.githubusercontent.com/3648336/220726907-6b99d591-1a02-4f73-953d-3a8d91e780f6.png">


# Usage

To use `FavoritesManager`, you need to create a struct or class that conforms to the `Codable` and `Equatable` protocols. You can then use it to save, remove, and retrieve favorite items. Here's a simple example of how you could use `FavoritesManager`:


```swift
import Foundation
import FavoritesManager

struct Person: Codable, Equatable {
    let name: String
    let age: Int
}

var manager = FavoritesManager<Person>()
let person1 = Person(name: "John", age: 25)
let person2 = Person(name: "Mary", age: 30)
let person3 = Person(name: "Alex", age: 35)
```

### Save a favorite element
```swift
manager.save(person1)
print(manager.favorites) // [Person(name: "John", age: 25)]
```

### Save another favorite element
```swift
manager.save(person2)
print(manager.favorites) // [Person(name: "John", age: 25), Person(name: "Mary", age: 30)]
```

### Try to save a duplicated element
```swift
manager.save(person1)
print(manager.favorites) // [Person(name: "John", age: 25), Person(name: "Mary", age: 30)]
```

### Check if an element is favorite
```swift
let isFavorite = manager.isFavorite(person1)
print(isFavorite) // true
```

### Get all favorite elements
```swift
let favorites = manager.getAll()
print(favorites) // [Person(name: "John", age: 25), Person(name: "Mary", age: 30)]
```

### Remove a favorite element
```swift
manager.remove(person1)
print(manager.favorites) // [Person(name: "Mary", age: 30)]
```

### Remove all favorite elements
```swift
manager.removeAll()
print(manager.favorites) // []
```

# Contributing

Contributions are very welcome! If you have an idea or a bug report, please open an issue or submit a pull request.

# License

`FavoritesManager` is available under the MIT license. See the LICENSE file for more info.



