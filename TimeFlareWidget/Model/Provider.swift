//
//  Provider.swift
//  TimeFlareWidgetExtension
//
//  Created by Ricardo Sanchez-Macias on 9/6/23.
//

import SwiftUI
import WidgetKit

struct Provider: AppIntentTimelineProvider {
    
    private static let dayTimeInterval: Double = 86400
    
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
        
        let endDate = configuration.deadline?.endDate ?? Date.now
        let days = Calendar.current.dateComponents([.day], from: Date.now, to: endDate).day ?? 0
        
        // Date to reload second entry after countdown timer is done. WidgetKit takes snapshots of our widget view,
        // so we must rely on SwiftUI views that support dynamic content, such as Text with a date format.
        // The reload date is just the current date + the second, minute, and hour components of the deadline end date
        let reloadDate = DateUtil.getCountdownDate(for: endDate) ?? Date.now
        
        // The last entry of the timeline
        var expiredDeadlineCopy = configuration.deadline
        expiredDeadlineCopy?.isExpired = true
        
        // MARK: - Timeline calculation
        
        let startingEntry = DeadlineCountdownEntry(date: Date.now, deadlineSummary: configuration.deadline)
        var entries: [DeadlineCountdownEntry] = [startingEntry]
        
        (0...days).forEach { day in
            var nextEntry: DeadlineCountdownEntry
            let entryDate = reloadDate + (Self.dayTimeInterval * Double(day))
            
            if day == days {
                // The last entry must be the expired deadline
                nextEntry = DeadlineCountdownEntry(
                    date: entryDate,
                    deadlineSummary: expiredDeadlineCopy
                )
            } else {
                // Create a deadline summary with startingDate set to when this entry becomes active
                // This ensures the countdown date calculation is always relative to the entry's activation time
                var continuingDeadline = configuration.deadline
                continuingDeadline?.startingDate = entryDate
                
                nextEntry = DeadlineCountdownEntry(
                    date: entryDate,
                    deadlineSummary: continuingDeadline
                )
            }
            entries.append(nextEntry)
        }
        
        return Timeline(entries: entries, policy: .never)
    }
    
}
