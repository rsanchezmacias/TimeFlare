//
//  DeadlineDetailCountdownView.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/5/23.
//

import SwiftUI

struct DeadlineDetailCountdownView: View {
    
    var deadline: Deadline
    
    @State private var isExpired: Bool = false
    
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        HStack {
            VStack(alignment: .leading, spacing: 16) {
                if !isExpired {
                    Text("Time left..")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.metal)
                        .padding(.bottom, -4)
                    CenteredHStack {
                        BubbleCountdownTimer(date: deadline.endDate, bubbleSize: 70)
                    }
                    .padding(.bottom)
                } else {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "exclamationmark.circle")
                            Text("This deadline is over")
                        }
                        .font(.system(size: 18, weight: .bold))
                        .padding()
                        
                        (Text("It ended on ")
                         + Text(deadline.endDate, format: .dateTime)
                         + Text(". Feel free to delete it or edit the deadline date to add more time")
                            .fontWeight(.bold))
                        .padding(.bottom)
                        .padding([.leading, .trailing], 20)
                    }
                    .padding()
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.metal)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(.rect(cornerRadius: 8))
                }
            }
            
            Spacer()
        }
        .onAppear(perform: {
            checkIfTimerIsExpired()
        })
        .onReceive(timer) { _ in
            checkIfTimerIsExpired()
        }
        
    }
    
    private func checkIfTimerIsExpired() {
        withAnimation {
            isExpired = deadline.endDate <= Date.now
        }
        
        if isExpired {
            timer.upstream.connect().cancel()
        } else {
            timer = Timer.publish(
                every: deadline.endDate.timeIntervalSinceNow,
                on: .main,
                in: .common
            ).autoconnect()
        }
    }
    
}

#Preview {
    let manager = DeadlineManager(container: SampleDeadline.sampleDeadlineContainer)
    return DeadlineDetailCountdownView(deadline: SampleDeadline.sampleDeadlines[2])
        .environmentObject(manager)
}
