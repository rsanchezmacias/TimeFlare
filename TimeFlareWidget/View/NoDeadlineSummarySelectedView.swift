//
//  NoDeadlineSummarySelectedView.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/7/23.
//

import SwiftUI

struct NoDeadlineSummarySelectedView: View {
    var body: some View {
        VStack(spacing: 4) {
            Text("No selected deadline")
                .font(.subheadline)
            Text("Please select a deadline to quickly glance at a countdown for the deadline.")
                .font(.caption)
        }
    }
}

#Preview {
    NoDeadlineSummarySelectedView()
}
