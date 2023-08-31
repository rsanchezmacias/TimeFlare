//
//  InjectionKey.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/28/23.
//

import Foundation

public protocol InjectionKey {
    
    associatedtype Value
    
    static var currentValue: Self.Value { get set }
    
}

/// Provides access to the injected depencies
struct InjectedValues {
    
    /// Only used as an accessor to the computer properties of the injected dependencies. These will be declared
    /// within extensions of InjectedValues
    private static var current = InjectedValues()
    
    /// A static subscript for updating the `currentValue` of `InjectionKey`
    static subscript<K>(key: K.Type) -> K.Value where K: InjectionKey {
        get { key.currentValue }
        set { key.currentValue = newValue }
    }
    
    /// A static subscript access for updating and referencing dependencies directly
    static subscript<T>(_ keyPath: WritableKeyPath<InjectedValues, T>) -> T {
        get { current[keyPath: keyPath] }
        set { current[keyPath: keyPath] = newValue }
    }
}

/// The property wrapper below works closely with the `InjectedValues` struct above
@propertyWrapper
struct Injected<T> {
    
    let injectedValueKeyPath: WritableKeyPath<InjectedValues, T>
    
    var wrappedValue: T {
        get { InjectedValues[injectedValueKeyPath] }
        set { InjectedValues[injectedValueKeyPath] = newValue }
    }
    
    init(_ injectedValueKeyPath: WritableKeyPath<InjectedValues, T>) {
        self.injectedValueKeyPath = injectedValueKeyPath
    }
    
}

private struct DeadlineStorageKey: InjectionKey {
    static var currentValue: DeadlineStorageProtocol = DeadlineStorage()
}

extension InjectedValues {
    var deadlineStorage: DeadlineStorageProtocol {
        get { Self[DeadlineStorageKey.self] }
        set { Self[DeadlineStorageKey.self] = newValue }
    }
}
