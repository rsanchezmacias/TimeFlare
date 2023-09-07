//
//  TimeFlareWidgetEntryView.swift
//  TimeFlareWidgetExtension
//
//  Created by Ricardo Sanchez-Macias on 9/6/23.
//

import SwiftUI
import WidgetKit

struct TimeFlareWidgetEntryView : View {
    
    var entry: Provider.Entry
    
    var body: some View {
        ZStack {
            if let deadlineSummary = entry.deadlineSummary {
                DeadlineSummaryView(
                    summary: deadlineSummary,
                    associatedEntry: entry
                )
            } else {
                NoDeadlineSummarySelectedView()
            }
        }
    }
    
}
