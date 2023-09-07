//
//  File.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/6/23.
//

import AppIntents

struct DeadlineSummaryEntityQuery: EntityQuery {
    
    @Injected(\.deadlineSummaryFileService) private var fileService
    
    func entities(for identifiers: [UUID]) async throws -> [DeadlineSummary] {
        let summaries = fileService.read()
        return summaries.filter { summary in
            identifiers.contains(summary.id)
        }
    }
    
    func suggestedEntities() async throws -> [DeadlineSummary] {
        return fileService.read()
    }
    
    func defaultResult() async -> DeadlineSummary? {
        return try? await suggestedEntities().first
    }
    
}
