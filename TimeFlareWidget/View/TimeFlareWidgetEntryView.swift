//
//  TimeFlareWidgetEntryView.swift
//  TimeFlareWidgetExtension
//
//  Created by Ricardo Sanchez-Macias on 9/6/23.
//

import SwiftUI

struct TimeFlareWidgetEntryView : View {
    
    var entry: Provider.Entry
    
    var body: some View {
        if let deadlineSummary = entry.deadlineSummary {
            VStack(alignment: .center, spacing: 4) {
                Text(deadlineSummary.title)
                    .font(.headline)
                Text(deadlineSummary.endDate, style: .timer)
                    .font(.caption)
                Text(deadlineSummary.endDate, format: .dateTime)
                    .font(.subheadline)
            }
        } else {
            VStack(spacing: 4) {
                Text("No selected deadline")
                    .font(.subheadline)
                Text("Please select a deadline to quickly glance at a countdown for the deadline.")
                    .font(.caption)
            }
        }
    }
}

#Preview {
    TimeFlareWidgetEntryView(entry: SimpleEntry(date: Date(), deadlineSummary: DeadlineSummary.sampleDeadlineSummaries[0]))
}
