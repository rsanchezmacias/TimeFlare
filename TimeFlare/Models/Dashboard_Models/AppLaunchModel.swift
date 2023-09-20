//
//  AppLaunchModel.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/19/23.
//

import Foundation

class AppLaunchModel {
    
    @UserDefaultsValue(key: .hasSeenApp, defaultValue: false)
    private(set) var hasSeenAppBefore: Bool
    
    func setUserHasLaunchedTheApplication() {
        hasSeenAppBefore = true
    }
    
}
