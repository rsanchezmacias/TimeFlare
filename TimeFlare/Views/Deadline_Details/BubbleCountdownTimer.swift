//
//  BubbleCountdownTimer.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/15/23.
//

import SwiftUI

struct BubbleCountdownTimer: View {
    
    var date: Date
    
    @State private var timerItems: [DateItem] = []
    @State private var dayAndYearItems: [DateItem] = []
    let bubbleSize: CGFloat
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 16) {
                ForEach(timerItems) { item in
                    BubbleDateComponentView(item: item, diameter: bubbleSize)
                    
                    if item.component == .seconds || item.component == .minutes {
                        Text(":")
                            .foregroundStyle(Color.metal)
                            .font(.system(size: 28, weight: .bold))
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                if !dayAndYearItems.isEmpty {
                    Text("and")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(Color.metal)
                }
                HStack(spacing: 8) {
                    ForEach(dayAndYearItems) { item in
                        HStack(spacing: 0) {
                            Text("\(item.value) \(item.noun)")
                            
                            if dayAndYearItems.count > 1 && item.component == .days {
                                Text(", ")
                            }
                        }
                    }
                    .font(.system(size: 16, weight: .semibold))
                }
            }
        }
        .onAppear(perform: {
            refresh()
        })
        .onReceive(timer, perform: { _ in
            refresh()
        })
        
    }
    
    private func refresh() {
        timerItems = []
        dayAndYearItems = []
        updateDateComponents()
    }
    
    private func updateDateComponents() {
        let dateComponents = DateUtil.orderedDateComponents(
            Date.now,
            to: date,
            components: [.seconds, .minutes, .hours, .days, .years],
            filterMissingComponents: true
        )
        
        for component in DateComponent.timerComponents {
            timerItems.append(DateItem(
                value: dateComponents[component] ?? .zero,
                component: component
            ))
        }
        
        for component in [DateComponent.days, DateComponent.years] {
            if let value = dateComponents[component] {
                dayAndYearItems.append(DateItem(value: value, component: component))
            }
        }
    }

}

#Preview {
    // 72000000 + 453
    // 64 + 3545 + 82800
    // 64 + 3545 + 82800 + 31536000
    
    BubbleCountdownTimer(date: Date(timeIntervalSinceNow: 72000000 + 453), bubbleSize: 70)
}
