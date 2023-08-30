//
//  InputDatePicker.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/29/23.
//

import SwiftUI

struct InputDatePicker: View {
    
    @Binding var date: Date
    var inDateRange: PartialRangeFrom<Date> = Date.now...
    var titleLabel: String = ""
    var subtitleLabel: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(titleLabel)
                .font(.headline)
            
            HStack {
                DatePicker(
                    subtitleLabel,
                    selection: $date,
                    in: inDateRange
                )
                .font(.system(size: 16))
            }
            
            Rectangle()
                .fill(.gray)
                .frame(height: 2)
        }
    }
    
}

#Preview {
    InputDatePicker(
        date: .constant(Date.now),
        titleLabel: "What is the date?",
        subtitleLabel: "Date:"
    )
    .padding()
}
