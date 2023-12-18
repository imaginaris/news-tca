import Foundation
import ComposableArchitecture

struct UserDefaultHandleable {
    var data: (_ defaultName: String) -> Data?
    var set: (_ value: Any?, _ defaultName: String) -> Void
}

extension UserDefaultHandleable: DependencyKey {
    public static let liveValue = Self(data: { defaultName in
        UserDefaults.standard.data(forKey: defaultName)
    }, set: { value, defaultName in
        UserDefaults.standard.set(value, forKey: defaultName)
    })
}

extension DependencyValues {
    var userDefaults: UserDefaultHandleable {
        get { self[UserDefaultHandleable.self] }
        set { self[UserDefaultHandleable.self] = newValue }
    }
}
