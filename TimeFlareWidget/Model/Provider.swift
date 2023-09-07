//
//  Provider.swift
//  TimeFlareWidgetExtension
//
//  Created by Ricardo Sanchez-Macias on 9/6/23.
//

import SwiftUI
import WidgetKit

struct Provider: AppIntentTimelineProvider {
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), deadlineSummary: DeadlineSummary.sampleDeadlineSummaries[0])
    }
    
    func snapshot(for configuration: TimeFlareWidgetConfigurationIntent, in context: Context) async -> SimpleEntry {
        let entry = SimpleEntry(date: Date(), deadlineSummary: DeadlineSummary.sampleDeadlineSummaries[0])
        return entry
    }
    
    func timeline(
        for configuration: TimeFlareWidgetConfigurationIntent,
        in context: Context
    ) async -> Timeline<SimpleEntry> {
        let entry = SimpleEntry(date: Date.now, deadlineSummary: configuration.deadline)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        
        return timeline
    }
    
}
