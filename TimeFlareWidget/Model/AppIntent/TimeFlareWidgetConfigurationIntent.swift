//
//  TimeFlareWidgetConfigurationIntent.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/6/23.
//

import AppIntents

/// Configuration intent specifically for TimeFlare widget customization.
/// This intent allows users to select which deadline should be displayed in their widget.
/// This is NOT intended for use with Siri or Shortcuts - it's purely for widget configuration.
struct TimeFlareWidgetConfigurationIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Select Deadline"
    static var description = IntentDescription("Selects a deadline to display a countdown for in the TimeFlare widget.")
    
    @Parameter(title: "Deadline", description: "Choose which deadline to display in your widget")
    var deadline: DeadlineSummary?
}
