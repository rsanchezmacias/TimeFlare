//
//  DeadlineSummaryBodyView.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/7/23.
//

import SwiftUI

struct DeadlineSummaryBodyView: View {
    
    let deadlineEntry: DeadlineCountdownEntry
    
    var body: some View {
        if deadlineEntry.deadlineSummary?.isExpired == true {
            Text("Deadline is over! Navigate to expired deadlines to view it.")
                .multilineTextAlignment(.leading)
                .lineLimit(4)
                .font(.system(size: 12))
                .foregroundStyle(Color.white)
                .fontWeight(.semibold)
        } else {
            if let countdownDate = deadlineEntry.countdownDate {
                DeadlineCountdownView(countdownDate: countdownDate)
            }
            
            DeadlineDayAndYearView(
                day: deadlineEntry.daysInCountdown,
                year: deadlineEntry.yearsInCountdown
            )
            .foregroundStyle(Color.white)
            .font(.system(size: 12))
            .fontWeight(.semibold)
        }
    }
}
