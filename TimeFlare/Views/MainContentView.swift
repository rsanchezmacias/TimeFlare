//
//  ContentView.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/25/23.
//

import SwiftUI

struct MainContentView: View {
    
    var body: some View {
        DeadlineDashboard()
    }
}

#Preview {
    let container = SampleDeadline.sampleDeadlineContainer
    let manager = DeadlineManager(container: container)
    return MainContentView()
        .environmentObject(manager)
}
