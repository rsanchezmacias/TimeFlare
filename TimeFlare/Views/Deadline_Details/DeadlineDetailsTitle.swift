//
//  DeadlineDetailsTitle.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/5/23.
//

import SwiftUI

struct DeadlineDetailsTitle: View {
        
    var deadline: Deadline
    var starAction: Thunk
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(deadline.title)
                    .font(.system(size: 18, weight: .bold))
                Spacer()
                Button {
                    starAction()
                } label: {
                    Label(
                        "Set as featured deadline",
                        systemImage: deadline.featured ? "star.fill" : "star"
                    )
                    .labelStyle(.iconOnly)
                    .foregroundStyle(Color.yellow)
                }
                .frame(width: 44)
            }
            Text(deadline.endDate, format: .dateTime)
                .font(.system(size: 12, weight: .semibold))
        }
    }
    
}

#Preview {
    let manager = DeadlineManager(container: SampleDeadline.sampleDeadlineContainer)
    return DeadlineDetailsTitle(deadline: SampleDeadline.sampleDeadlines[0], starAction: {})
        .environmentObject(manager)
}
