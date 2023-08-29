//
//  SampleDeadline.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/28/23.
//

import Foundation
import SwiftData

@MainActor
class SampleDeadline {
    
    static var sampleDeadlines: [Deadline] {
        let sampleImageURL: URL = Bundle.main.url(forResource: "uc_merced_seal.png", withExtension: nil)!
        let sampleImageData: Data? = try? Data(contentsOf: sampleImageURL)
        
        return [
            Deadline(
                title: "CSE 150 Project",
                body: "Work on a deadlock preventation algorithm",
                endDate: Date.now + TimeInterval(3600),
                creationDate: Date.now,
                imageData: sampleImageData
            ),
            Deadline(
                title: "CSE 111 Project",
                body: "Work on a web application with a simple DB that supports CRUD operations",
                endDate: Date.now + TimeInterval(3600),
                creationDate: Date.now,
                imageData: sampleImageData
            )
        ]
    }
    
    static var sampleDeadlineContainer: ModelContainer {
        do {
            let container = try ModelContainer(for: Deadline.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
            
            for deadline in SampleDeadline.sampleDeadlines {
                container.mainContext.insert(deadline)
            }
            
            return container
        } catch {
            fatalError("Failed to create deadline sample container")
        }
    }
    
}