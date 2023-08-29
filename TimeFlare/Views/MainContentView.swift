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
    MainContentView()
        .modelContainer(SampleDeadline.sampleDeadlineContainer)
}
