import Foundation

/// A protocol defining methods for managing a list of favorite elements.
public protocol FavoritesManagerProtocol {
    /// The type of the elements that will be managed by this manager.
    associatedtype T: Codable & Equatable

    /// Adds an element to the list of favorites.
    ///
    /// - Parameters:
    ///   - element: The element to add.
    mutating func save(_ element: T)

    /// Removes an element from the list of favorites.
    ///
    /// - Parameters:
    ///   - element: The element to remove.
    mutating func remove(_ element: T)

    /// Removes all elements from the list of favorites.
    mutating func removeAll()

    /// Returns an array of all favorite elements.
    ///
    /// - Returns: An array of all favorite elements.
    func getAll() -> [T]

    /// Checks if an element is in the list of favorites.
    ///
    /// - Parameters:
    ///   - element: The element to check.
    ///
    /// - Returns: `true` if the element is in the list of favorites, `false` otherwise.
    func isFavorite(_ element: T) -> Bool
}

/// A concrete implementation of `FavoritesManagerProtocol` that stores favorites using `NSUbiquitousKeyValueStore`.
public struct FavoritesManager<T: Codable & Equatable>: FavoritesManagerProtocol {

    private let key: String

    private var favorites: [T] {
        get {
            guard let data = NSUbiquitousKeyValueStore.default.array(forKey: key) as? [Data] else {
                return []
            }

            let decoder = JSONDecoder()
            return data.compactMap { try? decoder.decode(T.self, from: $0) }
        }
        set {
            let encoder = JSONEncoder()
            let data = newValue.compactMap { try? encoder.encode($0) }
            NSUbiquitousKeyValueStore.default.set(data, forKey: key)
            NSUbiquitousKeyValueStore.default.synchronize()
        }
    }

    /// Creates a new `FavoritesManager`.
    ///
    /// - Parameters:
    ///   - key: The key to use for storing the favorites in `NSUbiquitousKeyValueStore`.
    public init(key: String) {
        self.key = key
    }

    public mutating func save(_ element: T) {
        var actual = favorites
        if !actual.contains(element) {
            actual.append(element)
            favorites = actual
        }
    }

    public mutating func remove(_ element: T) {
        favorites.removeAll(where: { $0 == element })
    }

    public mutating func removeAll() {
        favorites.removeAll()
    }

    public func getAll() -> [T] {
        return favorites
    }

    public func isFavorite(_ element: T) -> Bool {
        return favorites.contains(element)
    }
}
