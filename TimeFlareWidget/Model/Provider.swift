//
//  Provider.swift
//  TimeFlareWidgetExtension
//
//  Created by Ricardo Sanchez-Macias on 9/6/23.
//

import SwiftUI
import WidgetKit

struct Provider: AppIntentTimelineProvider {
    
    func placeholder(in context: Context) -> DeadlineCountdownEntry {
        DeadlineCountdownEntry(date: Date(), deadlineSummary: DeadlineSummary.sampleDeadlineSummaries[0])
    }
    
    func snapshot(for configuration: TimeFlareWidgetConfigurationIntent, in context: Context) async -> DeadlineCountdownEntry {
        let entry = DeadlineCountdownEntry(date: Date(), deadlineSummary: DeadlineSummary.sampleDeadlineSummaries[0])
        return entry
    }
    
    func timeline(
        for configuration: TimeFlareWidgetConfigurationIntent,
        in context: Context
    ) async -> Timeline<DeadlineCountdownEntry> {
        let entry = DeadlineCountdownEntry(date: Date.now, deadlineSummary: configuration.deadline)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        
        return timeline
    }
    
}
