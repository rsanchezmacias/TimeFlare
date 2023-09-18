//
//  CountdownTimer.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/30/23.
//

import SwiftUI

struct CountdownDateTimer: View {
    
    var endDate: Date
    
    @State private var seconds: Int?
    @State private var minutes: Int?
    @State private var hours: Int?
    @State private var days: Int?
    @State private var years: Int?
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(alignment: .leading) {
            if let seconds = seconds {
                Text("\(seconds) ") + 
                Text(DateComponent.getNounForDateComponent(.seconds, value: seconds))
            }
            
            if let minutes = minutes {
                Text("\(minutes) ") + 
                Text(DateComponent.getNounForDateComponent(.minutes, value: minutes))
            }
            
            if let hours = hours {
                Text("\(hours) ") + 
                Text(DateComponent.getNounForDateComponent(.hours, value: hours))
            }
            
            if let days = days {
                Text("\(days) ") + 
                Text(DateComponent.getNounForDateComponent(.days, value: days))
            }
            
            if let years = years {
                Text("\(years) ") + 
                Text(DateComponent.getNounForDateComponent(.years, value: years))
            }
        }
        .onReceive(timer, perform: { _ in
            onTimerFired()
        })
        .onAppear(perform: {
            onTimerFired()
        })
    }
    
    private func onTimerFired() {
        let dateComponents = DateUtil.orderedDateComponents(
            Date.now,
            to: endDate,
            components: [.seconds, .minutes, .hours, .days, .years],
            filterMissingComponents: true
        )
        
        seconds = dateComponents[.seconds]
        minutes = dateComponents[.minutes]
        hours = dateComponents[.hours]
        days = dateComponents[.days]
        years = dateComponents[.years]
    }
}

#Preview {
    CountdownDateTimer(endDate: Date.now + TimeInterval(75650000))
}
