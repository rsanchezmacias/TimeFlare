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
            title: "Trip to GDL",
            description: "Trip to visit parents and wedding",
            endDate: Date(timeIntervalSinceNow: 4533)
        ),
        DeadlineSummary(
            id: UUID(),
            title: "First layoff wave",
            description: "Haren and Justin losing job this round",
            endDate: Date(timeIntervalSinceNow: 5)
        ),
        DeadlineSummary(
            id: UUID(),
            title: "Second layoff wave",
            description: "I am losing my job this round",
            endDate: Date(timeIntervalSinceNow: 18543)
        ),
        DeadlineSummary(
            id: UUID(),
            title: "First layoff wave",
            description: "Haren and Justin losing job this round",
            endDate: Date(timeIntervalSinceNow: -1)
        )
    ]
    
}
