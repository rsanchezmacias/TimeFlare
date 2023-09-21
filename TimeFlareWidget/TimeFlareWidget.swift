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
                ZStack {
                    TimeFlareWidgetEntryView(entry: entry)
                        .containerBackground(for: .widget) {
                            LinearGradient(
                                colors: [
                                    Color.charlotte,
                                    Color.darkBlue
                                ],
                                startPoint: .bottomTrailing,
                                endPoint: .topLeading
                            )
                        }
                }
            }
            .configurationDisplayName("Deadline Countdown")
            .description("Display a countdown for a deadline of your choice! Simply edit the widget to display a new countdown.")
            .supportedFamilies([.systemSmall])
    }
    
}

#Preview(as: .systemSmall) {
    TimeFlareWidget()
} timeline: {
    DeadlineCountdownEntry(date: Date(), deadlineSummary: DeadlineSummary.sampleDeadlineSummaries[1])
    DeadlineCountdownEntry(date: Date(), deadlineSummary: DeadlineSummary.sampleDeadlineSummaries[3])
}
