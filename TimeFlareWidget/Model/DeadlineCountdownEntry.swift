//
//  SimpleEntry.swift
//  TimeFlareWidgetExtension
//
//  Created by Ricardo Sanchez-Macias on 9/6/23.
//

import WidgetKit
import SwiftUI

struct DeadlineCountdownEntry: TimelineEntry {
    
    let date: Date
    let deadlineSummary: DeadlineSummary?
    
    var deepLink: URL {
        return deadlineSummary?.deepLinkURL ?? DeepLink.defaultURL
    }
    
    var countdownDate: Date? {
        getCountdownDate()
    }
    
    var daysInCountdown: Int? {
        getCountdownDays()
    }
    
    var yearsInCountdown: Int? {
        getCountdownYears()
    }
    
    init(date: Date, deadlineSummary: DeadlineSummary?) {
        self.date = date
        self.deadlineSummary = deadlineSummary
    }
    
}

// MARK: - Countdown helper functions

extension DeadlineCountdownEntry {
    
    private func getCountdownDate() -> Date? {
        guard let summary = deadlineSummary else { return nil }
        return DateUtil.getCountdownDate(for: summary.endDate)
    }
    
    private func getCountdownDays() -> Int? {
        guard let summary = deadlineSummary else { return nil }
        return Calendar.current.dateComponents([.day], from: Date.now, to: summary.endDate).day
    }
    
    private func getCountdownYears() -> Int? {
        guard let summary = deadlineSummary else { return nil }
        return Calendar.current.dateComponents([.year], from: Date.now, to: summary.endDate).year
    }
    
}
