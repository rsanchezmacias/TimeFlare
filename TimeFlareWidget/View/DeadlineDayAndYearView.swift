//
//  DeadlineDayAndYearView.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/7/23.
//

import SwiftUI

struct DeadlineDayAndYearView: View {
    
    var day: Int?
    var year: Int? 
    
    var body: some View {
        if let day = day, let year = year, day > 0 && year > 0 {
            (Text("\(day) \(day.noun(singular: "day", plural: "days")), ") +
            Text("\(year) \(year.noun(singular: "year", plural: "years"))"))
        } else if let day = day, day > 0 {
            Text("\(day) \(day.noun(singular: "day", plural: "days"))")
        } else if let year = year, year > 0 {
            Text("\(year) \(year.noun(singular: "year", plural: "years"))")
        }
    }
}

#Preview {
    DeadlineDayAndYearView()
}
