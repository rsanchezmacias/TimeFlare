//
//  DeadlineRow.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/26/23.
//

import SwiftUI
import SwiftData

struct DeadlineRow: View {
    
    var deadline: Deadline
    
    var body: some View {
        HStack(alignment: .center, spacing: 16, content: {
            deadline.image?
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 70)
            
            VStack(alignment: .leading, spacing: 4, content: {
                Text(deadline.title)
                    .font(.headline)
                if let body = deadline.body {
                    Text(body)
                        .font(.subheadline)
                }
            })
            .lineLimit(0)
        })
    }
    
}

#Preview {
    let container = SampleDeadline.sampleDeadlineContainer
    
    return DeadlineRow(deadline: SampleDeadline.sampleDeadlines[0])
        .modelContainer(container)
}
