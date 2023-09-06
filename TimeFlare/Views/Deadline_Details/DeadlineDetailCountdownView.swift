//
//  DeadlineDetailCountdownView.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/5/23.
//

import SwiftUI

struct DeadlineDetailCountdownView: View {
    
    var deadline: Deadline
    
    var body: some View {
        
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                if deadline.endDate > Date.now {
                    Text("Time left in deadline")
                        .font(.system(size: 16, weight: .bold))
                    CountdownDateTimer(endDate: deadline.endDate)
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                } else {
                    VStack {
                        HStack {
                            Image(systemName: "exclamationmark.circle")
                            Text("This deadline ended")
                        }
                        .fontWeight(.bold)
                        SnapshotDateView(endDate: deadline.endDate)
                        
                        (Text("ago on ") + Text(deadline.endDate, format: .dateTime).fontWeight(.bold))
                            .padding(.leading, 60)
                    }
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                    .foregroundColor(.red)
                }
            }
            .padding()
            Spacer()
        }
        .background(Color.gray.opacity(0.4))
        .clipShape(.rect(cornerRadius: 8))
        
    }
}

#Preview {
    let manager = DeadlineManager(container: SampleDeadline.sampleDeadlineContainer)
    return DeadlineDetailCountdownView(deadline: SampleDeadline.sampleDeadlines[2])
        .environmentObject(manager)
}
