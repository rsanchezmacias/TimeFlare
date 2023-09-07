//
//  TimeFlareWidget.swift
//  TimeFlareWidget
//
//  Created by Ricardo Sanchez-Macias on 9/6/23.
//

import WidgetKit
import SwiftUI

struct TimeFlareWidget: Widget {
    let kind: String = "TimeFlareWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: TimeFlareWidgetConfigurationIntent.self,
            provider: Provider()) { entry in
                TimeFlareWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            }
            .configurationDisplayName("Deadline Countdown")
            .description("Display a countdown for your featured deadline. Simply switch the featured deadline to update the countdown.")
            .supportedFamilies([.systemSmall])
    }
    
}

#Preview(as: .systemSmall) {
    TimeFlareWidget()
} timeline: {
    SimpleEntry(date: Date(), deadlineSummary: DeadlineSummary.sampleDeadlineSummaries[0])
    SimpleEntry(date: Date(), deadlineSummary: DeadlineSummary.sampleDeadlineSummaries[0])
}
