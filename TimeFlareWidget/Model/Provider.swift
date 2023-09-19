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
        
        // The deadline summary used for entries in between the second entry and the expired entry
        var continuingDeadline = configuration.deadline
        continuingDeadline?.startingDate = reloadDate + 1
        
        // MARK: - Timeline calculation
        
        let startingEntry = DeadlineCountdownEntry(date: Date.now, deadlineSummary: configuration.deadline)
        var entries: [DeadlineCountdownEntry] = [startingEntry]
        
        (0...days).forEach { day in
            var nextEntry: DeadlineCountdownEntry
            
            if day == days {
                // The last entry must be the expired deadline
                nextEntry = DeadlineCountdownEntry(
                    date: reloadDate + (Self.dayTimeInterval * Double(day)),
                    deadlineSummary: expiredDeadlineCopy
                )
            } else {
                // Any entry in between offsets the starting date by the seconds, minutes, and hours of the end date. We can leverage SwiftUI Text dynamic
                // content by following this approach.
                nextEntry = DeadlineCountdownEntry(
                    date: reloadDate + (Self.dayTimeInterval * Double(day)),
                    deadlineSummary: continuingDeadline
                )
            }
            entries.append(nextEntry)
        }
        
        return Timeline(entries: entries, policy: .never)
    }
    
}
