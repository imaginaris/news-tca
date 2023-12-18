import ComposableArchitecture
import Foundation

// I couldn't use SwiftData because I don't own an iOS 17 device and my old Macbook can't run iOS 17 simulator :(
struct FavoriteManager {
    private enum Constants {
        static let storeKey = "saved_articles"
    }

    @Dependency(\.userDefaults) static var userDefaults

    var saveArticle: (_ article: NewsArticle) throws -> Void
    var deleteArticle: (_ article: NewsArticle) throws -> Void
    var getArticles: () -> IdentifiedArrayOf<NewsArticle>

    private static let jsonEncoder = JSONEncoder()
    private static var store = IdentifiedArrayOf<NewsArticle>()

    private static func initializeStore() -> Void {
        guard let data = userDefaults.data(Constants.storeKey),
              let decodedData = try? JSONDecoder().decode(IdentifiedArrayOf<NewsArticle>.self, from: data) else {
            return
        }

        store = decodedData
    }

    private static func serializeStore() throws -> Void {
        let encodedData = try jsonEncoder.encode(store)
        userDefaults.set(encodedData, Constants.storeKey)
    }
}

extension FavoriteManager: DependencyKey {
    static let liveValue: FavoriteManager = {
        let instance = Self(
            saveArticle: { article in
                store.insert(article, at: 0)
                try serializeStore()
            }, deleteArticle: { article in
                store.remove(article)
                try serializeStore()
            }, getArticles: {
                store
            }
        )
        Self.initializeStore()
        return instance
    }()
}

extension DependencyValues {
    var favoriteManager: FavoriteManager {
        get { self[FavoriteManager.self] }
        set { self[FavoriteManager.self] = newValue }
    }
}
