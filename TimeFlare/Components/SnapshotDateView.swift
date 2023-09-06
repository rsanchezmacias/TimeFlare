//
//  SnapshotDateView.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/5/23.
//

import SwiftUI

struct SnapshotDateView: View {
    
    var endDate: Date
    
    @State private var secondsText: String?
    @State private var minutesText: String?
    @State private var hoursText: String?
    @State private var daysText: String?
    @State private var yearsText: String?
    
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
        .onAppear(perform: {
            update()
        })
    }
    
    func update() {
        let formattedDateComponets = DateUtil.formattedDateComponentsFrom(
            Date.now,
            to: endDate,
            components: [.seconds, .minutes, .hours, .days, .years],
            filterMissingComponents: true
        )
        
        withAnimation {
            secondsText = formattedDateComponets[.seconds]
            minutesText = formattedDateComponets[.minutes]
            hoursText = formattedDateComponets[.hours]
            daysText = formattedDateComponets[.days]
            yearsText = formattedDateComponets[.years]
        }
    }
    
}

#Preview {
    SnapshotDateView(endDate: Date.now + TimeInterval(75650000))
}
