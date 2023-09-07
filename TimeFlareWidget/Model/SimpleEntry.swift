//
//  SimpleEntry.swift
//  TimeFlareWidgetExtension
//
//  Created by Ricardo Sanchez-Macias on 9/6/23.
//

import WidgetKit
import SwiftUI

struct SimpleEntry: TimelineEntry {
    
    let date: Date
    let deadlineSummary: DeadlineSummary?
    
    init(date: Date, deadlineSummary: DeadlineSummary?) {
        self.date = date
        self.deadlineSummary = deadlineSummary
    }
    
}
