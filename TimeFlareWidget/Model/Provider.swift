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
        // Date to show expired deadline
        let reloadTimelineDate = DateUtil.getCountdownDate(for: configuration.deadline?.endDate ?? Date.now) ?? Date.now
        
        var expiredDeadlineCopy = configuration.deadline
        expiredDeadlineCopy?.isExpired = true
        
        let countdownEntry = DeadlineCountdownEntry(date: Date.now, deadlineSummary: configuration.deadline)
        let expiredEntry = DeadlineCountdownEntry(date: reloadTimelineDate, deadlineSummary: expiredDeadlineCopy)
        
        return Timeline(entries: [countdownEntry, expiredEntry], policy: .never)
    }
    
}
