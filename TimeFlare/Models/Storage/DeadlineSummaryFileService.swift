//
//  DeadlineSummaryFileService.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/7/23.
//

import Foundation

protocol DeadlineSummaryFileServiceProtocol {
    func write(summaries: [DeadlineSummary])
    func read() -> [DeadlineSummary]
}

class DeadlineSummaryFileService: DeadlineSummaryFileServiceProtocol {
    
    private let filename = "deadline_summaries.json"
    private let jsonEncoder = JSONEncoder()
    private let jsonDecoder = JSONDecoder()
    
    private var filePathURL: URL {
        return AppGroup.facts.containerURL.appendingPathComponent(filename)
    }
    
    func write(summaries: [DeadlineSummary]) {
        do {
            let encodedSummariesData = try? jsonEncoder.encode(summaries)
            
            if let data = encodedSummariesData {
                try data.write(to: filePathURL)
            }
        } catch {
            print("[DeadlineSummaryFileService] Failed to write deadline summaries to shared file")
        }
    }
    
    func read() -> [DeadlineSummary] {
        do {
            guard let summaryData = try? Data(contentsOf: filePathURL) else {
                return []
            }
            
            return try jsonDecoder.decode([DeadlineSummary].self, from: summaryData)
        } catch {
            print("[DeadlineSummaryFileService] Failed to read deadline summaries")
            return []
        }
    }
    
}
