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
    
    @Environment(\.scenePhase) private var scenePhase
    @Injected(\.widgetUpdateManager) private var widgetUpdateManager
    
    let deadlineManager: DeadlineManager
    
    init() {
        deadlineManager = DeadlineManager()
    }
    
    var body: some Scene {
        WindowGroup {
            MainContentView()
        }
        .environmentObject(deadlineManager)
        .onChange(of: scenePhase) { _, currentScenePhase in
            if currentScenePhase == .background {
                widgetUpdateManager.updateWidgetContentIfNeeded()
            }
        }
    }
    
}
