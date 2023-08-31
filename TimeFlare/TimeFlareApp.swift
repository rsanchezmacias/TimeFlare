//
//  TimeFlareApp.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/25/23.
//

import SwiftUI
import SwiftData

@main
struct TimeFlareApp: App {
    
    var body: some Scene {
        WindowGroup {
            MainContentView()
        }
        .environmentObject(DeadlineManager())
    }
    
}
