//
//  CountdownTimer.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/30/23.
//

import SwiftUI

struct CountdownDateTimer: View {
    
    var endDate: Date
    
    @State var secondsText: String?
    @State var minutesText: String?
    @State var hoursText: String?
    @State var daysText: String?
    @State var yearsText: String?
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(alignment: .leading) {
            if let secondsText {
                Text(secondsText)
            }
            
            if let minutesText {
                Text(minutesText)
            }
            
            if let hoursText {
                Text(hoursText)
            }
            
            if let daysText {
                Text(daysText)
            }
            
            if let yearsText {
                Text(yearsText)
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
        let formattedDateComponets = DateUtil.formattedDateComponentsFrom(
            Date.now,
            to: endDate,
            components: [.seconds, .minutes, .hours, .days, .years],
            filterMissingComponents: true
        )
        
        secondsText = formattedDateComponets[.seconds]
        minutesText = formattedDateComponets[.minutes]
        hoursText = formattedDateComponets[.hours]
        daysText = formattedDateComponets[.days]
        yearsText = formattedDateComponets[.years]
    }
}

#Preview {
    CountdownDateTimer(endDate: Date.now + TimeInterval(75650000))
}
