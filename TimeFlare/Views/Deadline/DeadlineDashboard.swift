//
//  SwiftUIView.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/28/23.
//

import SwiftUI
import SwiftData

struct DeadlineDashboard: View {
    
    @Query var deadlines: [Deadline]
    
    var body: some View {
        NavigationView(content: {
            List {
                ForEach(deadlines) { deadline in
                    DeadlineRow(deadline: deadline)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                DashboardToolbar(addDeadlineContent: {
                    NewDeadlineForm()
                })
            }
        })
    }
}

#Preview {
    let container = SampleDeadline.sampleDeadlineContainer
    return DeadlineDashboard()
        .modelContainer(container)
}
