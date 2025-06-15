//
//  DeadlineSummary.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/6/23.
//

import Foundation
import AppIntents

struct DeadlineSummary: AppEntity, Codable {

    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Deadline"
    static var defaultQuery = DeadlineSummaryEntityQuery()
    
    let id: UUID
    let title: String
    let description: String?
    
    /// The actual end date for the deadline
    let endDate: Date
    
    /// Date used to display countdown on widget. It is used to help display a dynamic timer on the widget
    var startingDate: Date
    
    init(id: UUID, title: String, description: String?, endDate: Date) {
        self.id = id
        self.title = title
        self.description = description
        self.endDate = endDate
        self.startingDate = Date.now
    }
    
    var deepLinkURL: URL {
        return DeepLink.showURL(deadlineId: id)
    }
    
    var isExpired: Bool = false
    
    var displayRepresentation: DisplayRepresentation {
        return DisplayRepresentation(title: "\(title)")
    }
    
    static let sampleDeadlineSummaries: [DeadlineSummary] = [
        DeadlineSummary(
            id: UUID(),
            title: "Project Deadline",
            description: "Complete the quarterly project presentation",
            endDate: Date(timeIntervalSinceNow: 604800) // 7 days
        ),
        DeadlineSummary(
            id: UUID(),
            title: "Conference Registration",
            description: "Register for the annual developer conference",
            endDate: Date(timeIntervalSinceNow: 86400) // 1 day
        ),
        DeadlineSummary(
            id: UUID(),
            title: "Assignment Due",
            description: "Submit final assignment for course completion",
            endDate: Date(timeIntervalSinceNow: 259200) // 3 days
        ),
        DeadlineSummary(
            id: UUID(),
            title: "Vacation Planning",
            description: "Book flights and accommodations for summer trip",
            endDate: Date(timeIntervalSinceNow: 1209600) // 14 days
        )
    ]
    
}
