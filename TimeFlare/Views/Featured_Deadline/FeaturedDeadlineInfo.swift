//
//  FeaturedDeadlineInfo.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/5/23.
//

import SwiftUI

struct FeaturedDeadlineInfo: View {
    
    var deadline: Deadline
    
    private var gradient: LinearGradient {
        .linearGradient(
            Gradient(colors: [.black.opacity(0.9), .black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .top
        )
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                gradient
                HStack(spacing: 24, content: {
                    VStack(alignment: .leading, spacing: 4, content: {
                        Text(deadline.title)
                            .font(.headline)
                            .lineLimit(0)
                        Text(deadline.endDate, format: .dateTime)
                            .font(.subheadline)
                        if let body = deadline.body {
                            Text(body)
                                .font(.caption)
                                .lineLimit(2)
                                .padding(.top, 4)
                        }
                    })
                    .padding(.leading, 16)
                    
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 2)
                        .padding([.top, .bottom])
                    
                    CountdownDateTimer(endDate: deadline.endDate)
                        .font(.system(size: 14))
                        .frame(width: min(geometry.size.width * 0.40, 80))
                        .padding(.trailing, 16)
                })
                .bold()
                .frame(width: geometry.size.width)
                .foregroundStyle(Color.white)
                .background(Color.black.opacity(0.3))
            }
        }
    }
    
}

#Preview {
    let manager = DeadlineManager(container: SampleDeadline.sampleDeadlineContainer)
    return FeaturedDeadlineInfo(deadline: SampleDeadline.sampleDeadlines[0])
        .environmentObject(manager)
}
