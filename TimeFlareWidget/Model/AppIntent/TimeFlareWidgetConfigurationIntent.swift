//
//  TimeFlareWidgetConfigurationIntent.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/6/23.
//

import AppIntents

struct TimeFlareWidgetConfigurationIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Select Deadline"
    static var description = IntentDescription("Selects a deadline to display a countdown for.")
    
    @Parameter(title: "Deadline")
    var deadline: DeadlineSummary?
}
