//
//  FeaturedDeadlineInfo.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/5/23.
//

import SwiftUI

struct FeaturedDeadlineInfo: View {
    
    var deadline: Deadline
    
    @State private var isExpired: Bool = false
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private var gradient: LinearGradient {
        .linearGradient(
            Gradient(colors: [.black.opacity(0.9), .black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .top
        )
    }
    
    init(deadline: Deadline) {
        self.deadline = deadline
        isExpired = deadline.endDate <= Date.now
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
                    
                    if !isExpired {
                        CountdownDateTimer(endDate: deadline.endDate)
                            .font(.system(size: 14))
                            .frame(width: min(geometry.size.width * 0.40, 80))
                            .padding(.trailing, 16)
                    } else {
                        Text("Deadline is over.")
                            .font(.system(size: 14))
                            .frame(width: min(geometry.size.width * 0.40, 80))
                    }
                    
                })
                .bold()
                .frame(width: geometry.size.width)
                .foregroundStyle(Color.white)
                .background(Color.black.opacity(0.3))
            }
        }
        .onReceive(timer) { _ in
            checkIfTimerIsExpired()
        }
        .onAppear {
            checkIfTimerIsExpired()
        }
    }
    
    private func checkIfTimerIsExpired() {
        isExpired = deadline.endDate <= Date.now + 3
        
        if isExpired {
            timer.upstream.connect().cancel()
        } else {
            timer = Timer.publish(
                every: deadline.endDate.timeIntervalSinceNow - 1,
                on: .main,
                in: .common
            ).autoconnect()
        }
    }
    
}

#Preview {
    let manager = DeadlineManager(container: SampleDeadline.sampleDeadlineContainer)
    return FeaturedDeadlineInfo(deadline: SampleDeadline.sampleDeadlines[5])
        .environmentObject(manager)
}
