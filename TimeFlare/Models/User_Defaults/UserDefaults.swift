//
//  UserDefaults.swift
//  TimeFlare
//
//  Source: https://www.avanderlee.com/swift/property-wrappers/
//

import Foundation

enum UserDefaultsKey: String {
    
    case hasSeenApp = "has_seen_app"
    case sortByPreference = "sort_by_preferenc"
    
}

@propertyWrapper
struct UserDefaultsValue<T> {
    
    let key: UserDefaultsKey
    let value: T
    let defaultValue: T
    
    private let userDefaults = UserDefaults.standard
    
    init(key: UserDefaultsKey, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
        self.value = defaultValue
    }
    
    var wrappedValue: T {
        get {
            return (userDefaults.object(forKey: key.rawValue) as? T) ?? defaultValue
        }
        set {
            userDefaults.setValue(newValue, forKey: key.rawValue)
        }
    }
    
}
