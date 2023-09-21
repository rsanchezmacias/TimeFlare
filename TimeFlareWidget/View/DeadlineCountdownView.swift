//
//  DeadlineCountdownView.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/7/23.
//

import SwiftUI

struct DeadlineCountdownView: View {
    
    let countdownDate: Date
    
    var body: some View {
        Text(countdownDate, style: .timer)
            .font(.system(size: 28))
            .foregroundStyle(Color.white)
            .minimumScaleFactor(0.8)
            .bold()
    }
}
