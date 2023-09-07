//
//  DeadlineSummaryHeadlineView.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/7/23.
//

import SwiftUI
import WidgetKit

struct DeadlineSummaryHeadlineView: View {
    
    let title: String
    let deadlineDate: Date
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 14))
                Text(deadlineDate, format: .dateTime)
                    .font(.system(size: 10))
            }
            .lineLimit(0)
            .bold()
            .foregroundStyle(Color.white)
        }
    }
}
