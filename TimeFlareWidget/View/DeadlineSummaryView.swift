//
//  DeadlineSummaryView.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/7/23.
//

import SwiftUI

struct DeadlineSummaryView: View {
    
    let summary: DeadlineSummary
    let associatedEntry: DeadlineCountdownEntry
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 4) {
            
            DeadlineSummaryHeadlineView(
                title: summary.title,
                deadlineDate: summary.endDate
            )
            
            Spacer()
            
            DeadlineSummaryBodyView(deadlineEntry: associatedEntry)
            
            Spacer()
            
        }
        
    }
    
}
