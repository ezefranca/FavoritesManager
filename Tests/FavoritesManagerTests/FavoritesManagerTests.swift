import XCTest
@testable import FavoritesManager
class FavoritesManagerMock<T: Codable & Equatable>: FavoritesManagerProtocol {
    var favorites: [T] = []

    func isFavorite(_ element: T) -> Bool {
        return favorites.contains(element)
    }

    func save(_ element: T) {
        if !favorites.contains(element) {
            favorites.append(element)
        }
    }

    func remove(_ element: T) {
        favorites.removeAll { $0 == element }
    }

    func removeAll() {
        favorites.removeAll()
    }

    func getAll() -> [T] {
        return favorites
    }
}

final class FavoritesManagerTests: XCTestCase {
    func testSave() {
        let mock = FavoritesManagerMock<String>()
        let element = "Test"
        mock.save(element)
        XCTAssertTrue(mock.favorites.contains(element))
    }

    func testSaveDuplicate() {
        let mock = FavoritesManagerMock<String>()
        let element = "Test"
        mock.save(element)
        mock.save(element)
        XCTAssertEqual(mock.favorites.count, 1)
    }

    func testRemove() {
        let mock = FavoritesManagerMock<String>()
        let element = "Test"
        mock.save(element)
        mock.remove(element)
        XCTAssertFalse(mock.favorites.contains(element))
    }

    func testRemoveAll() {
        let mock = FavoritesManagerMock<String>()
        let element = "Test"
        mock.save(element)
        mock.removeAll()
        XCTAssertTrue(mock.favorites.isEmpty)
    }

    func testGetAll() {
        let mock = FavoritesManagerMock<String>()
        let element1 = "Test1"
        let element2 = "Test2"
        mock.save(element1)
        mock.save(element2)
        XCTAssertEqual(mock.getAll(), [element1, element2])
    }

    func testIsFavorite() {
        let mock = FavoritesManagerMock<String>()
        let element = "Test"
        XCTAssertFalse(mock.isFavorite(element))
        mock.save(element)
        XCTAssertTrue(mock.isFavorite(element))
    }
}

