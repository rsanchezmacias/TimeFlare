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
        }
    }
    
}

#Preview {
    let manager = DeadlineManager(container: SampleDeadline.sampleDeadlineContainer)
    return DeadlineDetailsTitle(deadline: SampleDeadline.sampleDeadlines[0], starAction: {})
        .environmentObject(manager)
}
