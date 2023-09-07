//
//  File.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/6/23.
//

import AppIntents

struct DeadlineSummaryEntityQuery: EntityQuery {
    
    func entities(for identifiers: [UUID]) async throws -> [DeadlineSummary] {
        return DeadlineSummary.sampleDeadlineSummaries.filter { summary in
            identifiers.contains(summary.id)
        }
    }
    
    func suggestedEntities() async throws -> [DeadlineSummary] {
        return DeadlineSummary.sampleDeadlineSummaries
    }
    
    func defaultResult() async -> DeadlineSummary? {
        return try? await suggestedEntities().first
    }
    
}
