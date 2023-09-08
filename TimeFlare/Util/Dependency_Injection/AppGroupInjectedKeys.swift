//
//  AppGroupInjectedKeys.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/7/23.
//

import Foundation

private struct DeadlineSummaryFileServiceKey: InjectionKey {
    static var currentValue: DeadlineSummaryFileServiceProtocol = DeadlineSummaryFileService()
}

extension InjectedValues {
    var deadlineSummaryFileService: DeadlineSummaryFileServiceProtocol {
        get { Self[DeadlineSummaryFileServiceKey.self] }
        set { Self[DeadlineSummaryFileServiceKey.self] = newValue }
    }
}
