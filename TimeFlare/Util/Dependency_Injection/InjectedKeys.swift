//
//  InjectedKeys.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/7/23.
//

import Foundation

private struct DeadlineStorageKey: InjectionKey {
    static var currentValue: DeadlineStorageProtocol = DeadlineStorage()
}

extension InjectedValues {
    var deadlineStorage: DeadlineStorageProtocol {
        get { Self[DeadlineStorageKey.self] }
        set { Self[DeadlineStorageKey.self] = newValue }
    }
}
